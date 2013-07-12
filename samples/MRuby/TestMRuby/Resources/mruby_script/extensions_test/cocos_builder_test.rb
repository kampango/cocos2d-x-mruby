require "mruby_script/test_base"
require "mruby_script/visible_rect"

class Cocos2d::Extension::CCBReader
  def each_callback
    # Callbacks
    names = getOwnerCallbackNames
    nodes = getOwnerCallbackNodes
    i = 0
    names.each do |name|
      node = nodes[i]
      yield name.to_sym, node
      i += 1
    end
  end

  def each_outlet
    # Callbacks
    names = getOwnerOutletNames
    nodes = getOwnerOutletNodes
    i = 0
    names.each do |name|
      node = nodes[i]
      yield name.getCString.to_sym, node
      i += 1
    end
  end

  def each_node_manager
    inner_nodes = getNodesWithAnimationManagers
    managers_for_nodes = getAnimationManagersForNodes
    i = 0
    inner_nodes.each do |inner_node|
      yield inner_node, managers_for_nodes[i]
      i += 1
    end
  end
end

class Cocos2d::Extension::CCBAnimationManager
  def each_callback
    # Callbacks
    names = getDocumentCallbackNames
    nodes = getDocumentCallbackNodes
    i = 0
    names.each do |name|
      node = nodes[i]
      sym = name.getCString.to_sym
      yield sym, node
      i += 1
    end
  end

  def each_outlet
    # Callbacks
    names = getDocumentOutletNames
    nodes = getDocumentOutletNodes
    i = 0
    names.each do |name|
      node = nodes[i]
      sym = name.getCString.to_sym
      yield sym, node
      i += 1
    end
  end
end

class CocosBuilderTest < TestBase
  include Cocos2d::Extension
  extend TestBaseExt
  self.supported = true

  module Controller
    include Cocos2d
    include Cocos2d::Extension

    module Factory
      @@klass_map = {}
      def self.register(name, klass)
        @@klass_map[name] = klass
      end
      def self.create(name)
        klass = @@klass_map[name]
        raise "unknown name!:'#{name}'" if klass.nil?
        klass.new
      end
    end

    def ccb_reader=(reader)
      @ccb_reader = reader
    end
    def ccb_reader
      @ccb_reader
    end

    def animation_manager=(manager)
      @animation_manager = manager
    end
    def animation_manager
      @animation_manager
    end

    def on_cleanup
      if @ccb_reader
        @ccb_reader.each_callback do |sym, node|
          unbind_callback(sym, node)
        end
        @ccb_reader.each_outlet do |sym, node|
          unbind_outlet(sym, node)
        end
        @ccb_reader = nil
      end
      if @animation_manager
        @animation_manager.each_callback do |sym, node|
          unbind_callback(sym, node)
        end
        @animation_manager.each_outlet do |sym, node|
          unbind_outlet(sym, node)
        end
        @animation_manager = nil
      end
    end

    def unbind_callback(sym, node)
      if node.kind_of? CCMenuItem
        node.unregisterScriptTapHandler()
      elsif node.kind_of? CCControlButton
        node.removeHandleOfControlEvent(CCControlEventTouchUpInside)
      end
    end

    def bind_callback(sym, node)
      if respond_to? sym
        #cclog("bind_callback:#{self}:#{sym}:#{node}")
        that = self
        proc = Proc.new { that.__send__(sym) }
        if node.kind_of? CCMenuItem
          node.registerScriptTapHandler(proc)
        elsif node.kind_of? CCControlButton
          node.addHandleOfControlEvent(proc, CCControlEventTouchUpInside)
        else
          cclog("WARNING:unknown node:#{node}:#{sym}")
        end
      else
        cclog("WARNING:unknown callback:#{self}:#{sym}")
      end
    end

    def outlets
      @outlets ||= {}
    end

    def unbind_outlet(val_sym, node)
      writer = "#{val_sym.to_s}=".to_sym
      __send__(writer, nil)
    end

    def bind_outlet(val_sym, node)
      cclog("bind_outlet:#{self}:#{val_sym}:#{node}")
      klass = self.class

      writer = "#{val_sym.to_s}=".to_sym
      has_writer = klass.method_defined? writer
      has_reader = klass.method_defined? val_sym

      if !has_writer && !has_reader
        klass.define_method(val_sym) {
          outlets[val_sym]
        }
        klass.define_method(writer) { |node|
          outlets[val_sym] = node
        }
      else
        raise "no writer found. #{self}:#{writer}" unless has_writer
        raise "no reader found. #{self}:#{val_sym}" unless has_reader
      end

      __send__(writer, node)
    end

    def create_layer_from_file(file_name)
      loader_library = CCNodeLoaderLibrary.sharedCCNodeLoaderLibrary
      reader = CCBReader.new(loader_library, nil, nil, nil) #XXX TODO:
      root_controller = self
      layer = reader.readNodeGraphFromFile(file_name, root_controller)
      p "layer:#{layer}"

      owner = reader.getOwner
      if root_controller != owner
        raise "not reach here!:#{root_controller}:#{owner}"
      end

      root_controller.ccb_reader = reader

      # Callbacks
      reader.each_callback do |sym, node|
        root_controller.bind_callback(sym, node)
      end

      # Variables
      reader.each_outlet do |sym, node|
        root_controller.bind_outlet(sym, node)
      end

      reader.each_node_manager do |inner_node, manager|
        cclog("inner_node:#{inner_node}:manager:#{manager}")
        unless manager.respond_to? :getDocumentControllerName
          cclog("XXX:#{manager}")
          i += 1
          next
        end

        name = manager.getDocumentControllerName
        #cclog("controller_name:#{name}")
        next if name.nil? #|| name.empty?

        controller = Factory.create(name)
        #cclog("controller:#{controller}")
        next if controller.nil?

        controller.animation_manager = manager

        inner_node.registerScriptHandler(Proc.new {|tag|
                                           if tag == kCCNodeOnCleanup
                                             p "#{__LINE__}:inner_node:kCCNodeOnCleanup:#{inner_node}"
                                             controller.on_cleanup
                                             inner_node.unregisterScriptHandler
                                           end
                                         })


        # Callbacks
        manager.each_callback do |sym, node|
          controller.bind_callback(sym, node)
        end

        # Variables
        manager.each_outlet do |sym, node|
          controller.bind_outlet(sym, node)
        end

        cbs = manager.getKeyframeCallbacks
        cbs.each do |cb|
          callback_combine = cb.getCString
          info = callback_combine.split(":")
          cb_type = info[0].to_i
          cb_name = info[1].to_sym
          proc = nil
          if cb_type == 1
            unless controller.respond_to? cb_name
              cclog("unknown method #{cb_name}:#{controller}")
            else
              proc = Proc.new {controller.__send__(cb_name)}
            end
          elsif cb_type == 2
            unless owner.respond_to? cb_name
              cclog("unknown method #{cb_name}:#{owner}")
            else
              proc = Proc.new {owner.__send__(cb_name)}
            end
          end
          manager.setCallFunc(CCCallFunc.create(proc), callback_combine) if proc
        end

        seq_id = manager.getAutoPlaySequenceId
        manager.runAnimationsForSequenceIdTweenDuration(seq_id, 0) if seq_id != -1
      end

      if respond_to? :mTestTitleLabelTTF
        fns = file_name.split("/")
        fns.shift
        mTestTitleLabelTTF.setString(fns.join("/"))
      end
      layer
    end
  end

  class HelloCocosBuilderLayerController < CCLayer
    include Controller

    def mTestTitleLabelTTF
      @label
    end
    def mTestTitleLabelTTF=(label)
      @label = label
    end
    def on_cleanup
      super
      @label = nil
    end

    def push_layer(layer)
      scene = CCScene.create
      scene.addChild(layer)
      scene.addChild(ExtensionsTest.create_back_menu_item)
      CCDirector.sharedDirector.pushScene(CCTransitionFade.create(0.5, scene, ccc3(0, 0, 0)))
    end

    def onMenuTestClicked
      cclog("CCBMenuTest")
      layer = create_layer_from_file("cocosbuilderRes/ccb/ccb/TestMenus.ccbi")
      push_layer(layer)
    end

    def onSpriteTestClicked
      cclog("CCBSpriteTest")
      layer = create_layer_from_file("cocosbuilderRes/ccb/ccb/TestSprites.ccbi")
      push_layer(layer)
    end
    def onButtonTestClicked
      cclog("CCBButtonTest")
      layer = create_layer_from_file("cocosbuilderRes/ccb/ccb/TestButtons.ccbi")
      push_layer(layer)
    end
    def onAnimationsTestClicked
      cclog("CCBAnimationsTest")
      layer = create_layer_from_file("cocosbuilderRes/ccb/ccb/TestAnimations.ccbi")
      push_layer(layer)
    end
    def onParticleSystemTestClicked
      cclog("CCBParticleSystemTest")
      layer = create_layer_from_file("cocosbuilderRes/ccb/ccb/TestParticleSystems.ccbi")
      push_layer(layer)
    end
    def onScrollViewTestClicked
      cclog("CCBScrollViewTest")
      layer = create_layer_from_file("cocosbuilderRes/ccb/ccb/TestScrollViews.ccbi")
      push_layer(layer)
    end
    def onTimelineCallbackSoundClicked
      cclog("CCBTimelineCallbackSoundTest")
      layer = create_layer_from_file("cocosbuilderRes/ccb/ccb/TestTimelineCallback.ccbi")
      push_layer(layer)
    end
  end

  class TestHeaderLayerController < CCLayer
    include Controller

    def onBackClicked
      CCDirector.sharedDirector.popScene
    end
  end

  class TestMenusLayerController < CCLayer
    include Controller

    def onMenuItemAClicked
      cclog("MenuItemA")
      mMenuItemStatusLabelBMFont.setString("Menu Item A clicked.")
    end

    def onMenuItemBClicked
      cclog("MenuItemB")
      mMenuItemStatusLabelBMFont.setString("Menu Item B clicked.")
    end

    define_method("pressedC:".to_sym) { |*args|
      cclog("pressedC:")
      label.setString("Menu Item C clicked.")
    }
  end

  class TestSpritesLayerController < CCLayer
    include Controller
  end

  class TestButtonsLayerController < CCLayer
    include Controller
    def onCCControlButtonClicked(*args)
      cclog("CCControlButton:#{args}")
      mCCControlEventLabel.setString("receive no params.")
    end
  end

  class TestAnimationsLayerController < CCLayer
    include Controller

    def run_animation(name)
      animation_manager.runAnimationsForSequenceNamedTweenDuration(name, 0.3)
    end

    def onCCControlButtonIdleClicked
      run_animation("Idle")
    end
    def onCCControlButtonWaveClicked
      run_animation("Wave")
    end
    def onCCControlButtonJumpClicked
      run_animation("Jump")
    end
    def onCCControlButtonFunkyClicked
      run_animation("Funky")
    end
  end

  class TestParticleSystemsLayerController < CCLayer
    include Controller
  end
  class TestScrollViewsLayerController < CCLayer
    include Controller
  end
  class TestTimelineLayerController < CCLayer
    include Controller

    def onCallback1
      helloLabel.runAction(CCRotateBy.create(1, 360))
      helloLabel.setString("Callback 1")
    end
    def onCallback2
      helloLabel.runAction(CCRotateBy.create(2, 360))
      helloLabel.setString("Callback 2")
    end
  end

  class HelloCocosBuilder < CCLayer
    include Controller

    def initialize
      super
      Controller::Factory.register("", HelloCocosBuilderLayerController)
      Controller::Factory.register("HelloCocosBuilderLayer", HelloCocosBuilderLayerController)
      Controller::Factory.register("TestHeaderLayer", TestHeaderLayerController)
      Controller::Factory.register("TestMenusLayer", TestMenusLayerController)
      Controller::Factory.register("TestSpritesLayer", TestSpritesLayerController)
      Controller::Factory.register("TestButtonsLayer", TestButtonsLayerController)
      Controller::Factory.register("TestAnimationsLayer", TestAnimationsLayerController)
      Controller::Factory.register("TestParticleSystemsLayer", TestParticleSystemsLayerController)
      Controller::Factory.register("TestScrollViewsLayer", TestScrollViewsLayerController)
      Controller::Factory.register("TestTimelineLayer", TestTimelineLayerController)

      loader_library = CCNodeLoaderLibrary.sharedCCNodeLoaderLibrary
      loader = CCLayerLoader.loader()
      loader_library.registerCCNodeLoader("", loader)
      loader_library.registerCCNodeLoader("HelloCocosBuilderLayer", loader)
      loader_library.registerCCNodeLoader("TestHeaderLayer", loader)
      loader_library.registerCCNodeLoader("TestMenusLayer", loader)
      loader_library.registerCCNodeLoader("TestSpritesLayer", loader)
      loader_library.registerCCNodeLoader("TestButtonsLayer", loader)
      loader_library.registerCCNodeLoader("TestAnimationsLayer", loader)
      loader_library.registerCCNodeLoader("TestParticleSystemsLayer", loader)
      loader_library.registerCCNodeLoader("TestScrollViewsLayer", loader)
      loader_library.registerCCNodeLoader("TestTimelineLayer", loader)
    end
  end

  def create
    scene = CCScene.new
    layer = HelloCocosBuilder.new.create_layer_from_file("cocosbuilderRes/ccb/HelloCocosBuilder.ccbi")
    scene.addChild(layer)
    scene.addChild(ExtensionsTest.create_back_menu_item)
    scene
  end
end
