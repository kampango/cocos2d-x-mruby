require "mruby_script/test_base"
require "mruby_script/visible_rect"
require "mruby_script/ccgl_program_constant"

class ArmatureTest < TestBase
  extend TestBaseExt
  include Cocos2d::Extension
  self.supported = true

  class ArmatureTestBase
    include Cocos2d
    include Cocos2d::Extension
    include CCTypeHelper
    include CCGLProgramConstant

    def title
      "No title"
    end

    def subtitle
      ""
    end

    def init_with_layer(layer)

      label = CCLabelTTF.create(self.title, "Arial", 18)
        .setPosition(ccp(VisibleRect.center.x, VisibleRect.top.y - 30))
        .setColor(ccc3(0, 0, 0))
      layer.addChild(label, 1, 10000)

      unless self.subtitle.empty?
        l = CCLabelTTF.create(self.subtitle, "Arial", 18)
          .setPosition(ccp(VisibleRect.center.x, VisibleRect.top.y - 60))
          .setColor(ccc3(0, 0, 0))
        layer.addChild(l, 1, 10001)
      end

      layer.setShaderProgram(CCShaderCache.sharedShaderCache.programForKey(kCCShader_PositionTextureColor))

      layer
    end

    def create(layer = nil)
      layer = CCLayer.create if layer.nil?
      init_with_layer(layer)
      layer
    end
  end

  class TestDragonBones20 < ArmatureTestBase
    def init_with_layer(layer)
      super(layer)

      armature = CCArmature.create("Dragon")
      armature.getAnimation.playByIndex(1, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
        .setAnimationScale(0.4)
      armature.setPosition(VisibleRect.center.x, VisibleRect.center.y * 0.3)
        .setScale(0.6)

      layer.addChild(armature)
      layer
    end

    def title
      "Test Export From DragonBones version 2.0"
    end
  end

  class TestCSWithSkeleton < ArmatureTestBase
    def init_with_layer(layer)
      super(layer)
      
      armature = CCArmature.create("Cowboy")
      armature.getAnimation.playByIndex(0, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
      armature
        .setScale(0.2)
        .setPosition(VisibleRect.center.x, VisibleRect.center.y)

      layer.addChild(armature)
    end

    def title
      "Test Export From CocoStudio With Skeleton Effect"
    end
  end

  class TestCSWithoutSkeleton < ArmatureTestBase
    def init_with_layer(layer)
      super(layer)
      
      armature = CCArmature.create("TestBone")
      armature.getAnimation.playByIndex(0, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
      armature
        .setAnchorPoint(ccp(0.5, -0.1))
        .setScale(0.2)
        .setPosition(VisibleRect.center.x, VisibleRect.center.y - 100)

      layer.addChild(armature)
    end

    def title
      "Test Export From CocoStudio Without Skeleton Effect"
    end
  end

  class TestPerformance < ArmatureTestBase
    def initialize
      super
      @armature_count = @frames = @times = @last_times = 0
      @generated = false
    end

    def add_armature(armature)
      @armature_count += 1
      @layer.addChild(armature, @armature_count)
    end

    def update(delta)
      @frames += 1
      @times += delta

      return unless @frames / @times > 58

      armature = CCArmature.new
      armature.init("Knight_f/Knight")
      armature.getAnimation.playByIndex(0, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
      armature.setPosition(50 + @armature_count * 2, 150)
        .setScale(0.6)
      add_armature(armature)

      label = @layer.getChildByTag(10001)
      label.setString("#{self.subtitle} #{@armature_count}")
    end

    def node_event_handler(tag)
      if tag == kCCNodeOnEnter
        that = self
        scheduler = CCDirector.sharedDirector().getScheduler()
        @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.update(dt)}, 0, false)
      elsif tag == kCCNodeOnExit
        CCDirector.sharedDirector().getScheduler()
          .unscheduleScriptEntry(@entry)
        @layer.unregisterScriptHandler
      end
    end

    def init_with_layer(layer)
      super(layer)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.node_event_handler(tag)})

      @armature_count = @frames = @times = @last_times = 0
      @generated = false

      @layer = layer
      @layer
    end

    def title
      "Test Performance"
    end

    def subtitle
      "Current CCArmature Count : "
    end
  end

  class TestChangeZorder < ArmatureTestBase

    def initialize
      super
      @cur_tag = 0
    end

    def change_zorder(delta)
      node = @layer.getChildByTag(@cur_tag)
      node.setZOrder(CCRANDOM_0_1() * 3)
      @cur_tag += 1
      @cur_tag %= 3
    end

    def on_exit
      CCDirector.sharedDirector().getScheduler()
        .unscheduleScriptEntry(@entry)
    end

    def on_enter
      @cur_tag = 0
      [["Knight_f/Knight", 0.6],
       ["TestBone", 0.24],
       ["Dragon", 0.6],
      ].each do |info|
        armature = CCArmature.create(info[0])
        armature.getAnimation.playByIndex(0, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
        armature.setPosition(ccp(VisibleRect.center.x, VisibleRect.center.y - 100))
          .setScale(info[1])
        @layer.addChild(armature, @cur_tag, @cur_tag)
        @cur_tag += 1
      end

      that = self
      scheduler = CCDirector.sharedDirector().getScheduler()
      @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.change_zorder(dt)}, 1, false)
      @cur_tag = 0
    end

    def title
      "Test Change ZOrder Of Different CCArmature"
    end

    def init_with_layer(layer)
      super(layer)
      that = self
      layer.registerScriptHandler(Proc.new{|tag|
                                    case tag
                                    when Cocos2d::kCCNodeOnEnter
                                      that.on_enter
                                    when Cocos2d::kCCNodeOnExit
                                      that.on_exit
                                    when Cocos2d::kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end})
      @layer = layer
      @layer
    end
  end

  class TestAnimationEvent < ArmatureTestBase

    def node_event_handler(tag)
      case tag
      when kCCNodeOnEnter
        armature = CCArmature.create("Cowboy")
        armature.getAnimation.play("Fire", -1, -1, -1, TWEEN_EASING_MAX) #TODO
        armature
          .setScaleX(-0.24)
          .setScale(0.24)
          .setPosition(ccp(VisibleRect.center.x + 50, VisibleRect.left.y))

        # TODO:
        #armature.getAnimation.MovementEventSignal.connect(self, :animationEvent)
        @layer.addChild(armature)
      end
    end

    def init_with_layer(layer)
      super(layer)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.node_event_handler(tag)})
      @layer = layer
      @layer
    end

    def title
      "Test CCArmature Animation Event"
    end

    def subtitle
      "NOT SUPPORTED!"
    end
  end

  class TestParticleDisplay < ArmatureTestBase
    def init_with_layer(layer)
      super(layer)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.node_event_handler(tag)})
      @layer = layer
      @layer
    end

    def node_event_handler(tag)
      if tag == kCCNodeOnEnter
        @layer.setTouchEnabled(true)

        @animationID = 0

        armature = @armature = CCArmature.create("robot")
        armature.getAnimation().playByIndex(0, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
        armature.setPosition(VisibleRect.center())
        armature.setScale(0.48)
        @layer.addChild(armature)

        displayData = CCParticleDisplayData.new
        displayData.setParam("Particles/SmallSun.plist")

        bone = CCBone.create("p1")
        bone.addDisplay(displayData, 0)
        bone.changeDisplayByIndex(0, true)
        bone.setIgnoreMovementBoneData(true)
        bone.setZOrder(100)
        bone.setScale(1.2)
        armature.addBone(bone, "bady-a3")

        bone = CCBone.create("p2")
        bone.addDisplay(displayData, 0)
        bone.changeDisplayByIndex(0, true)
        bone.setIgnoreMovementBoneData(true)
        bone.setZOrder(100)
        bone.setScale(1.2)
        armature.addBone(bone, "bady-a30")

        that = self
        @layer.registerScriptTouchHandler(Proc.new {|event, x, y|
                                            if event == CCTOUCHBEGAN
                                              that.ccTouchBegan(x, y)
                                            end},
                                          false, -1, false)
      end
    end

    def title
      "Test Particle Display"
    end

    def subtitle
      "Touch to change animation"
    end

    def ccTouchBegan(x, y)
      @animationID += 1
      @animationID %= @armature.getAnimation().getMovementCount()
      @armature.getAnimation().playByIndex(@animationID, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
      false
    end
  end

  class TestUseMultiplePicture < ArmatureTestBase
    def init_with_layer(layer)
      super(layer)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.node_event_handler(tag)})
      @layer = layer
      @layer
    end

    def node_event_handler(tag)
      if tag == kCCNodeOnEnter
        @layer.setTouchEnabled(true)

        @displayIndex = 0

        armature = @armature = CCArmature.create("Knight_f/Knight")
        armature.getAnimation().playByIndex(0, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
        armature.setPosition(ccp(VisibleRect.left().x+70, VisibleRect.left().y))
        armature.setScale(1.2)
        @layer.addChild(armature)

        weapon = ["weapon_f-sword.png", "weapon_f-sword2.png", "weapon_f-sword3.png", "weapon_f-sword4.png", "weapon_f-sword5.png", "weapon_f-knife.png", "weapon_f-hammer.png"]

        displayData = CCSpriteDisplayData.new
        weapon.size.times do |i|
          displayData.setParam(weapon[i])
          armature.getBone("weapon").addDisplay(displayData, i)
        end

        that = self
        @layer.registerScriptTouchHandler(Proc.new {|event, x, y|
                                            if event == CCTOUCHBEGAN
                                              that.ccTouchBegan(x, y)
                                            end},
                                          false, -1, false)
      end
    end

    def title
      "Test One CCArmature Use Different Picture"
    end

    def subtitle
      "weapon and armature are in different picture"
    end

    def ccTouchBegan(x, y)
      @displayIndex += 1
      @displayIndex %= 6
      @armature.getBone("weapon").changeDisplayByIndex(@displayIndex, true)
      false
    end
  end

  class TestAnchorPoint < ArmatureTestBase
    def init_with_layer(layer)
      super(layer)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.node_event_handler(tag)})
      @layer = layer
      @layer
    end

    def node_event_handler(tag)
      if tag == kCCNodeOnEnter

        5.times do |i|
          armature = CCArmature.create("Cowboy")
          armature.getAnimation().playByIndex(0, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
          armature.setPosition(VisibleRect.center())
          armature.setScale(0.2)
          @layer.addChild(armature, 0, i)
        end

        @layer.getChildByTag(0).setAnchorPoint(ccp(0,0))
        @layer.getChildByTag(1).setAnchorPoint(ccp(0,1))
        @layer.getChildByTag(2).setAnchorPoint(ccp(1,0))
        @layer.getChildByTag(3).setAnchorPoint(ccp(1,1))
        @layer.getChildByTag(4).setAnchorPoint(ccp(0.5,0.5))

        that = self
        @layer.registerScriptTouchHandler(Proc.new {|event, x, y|
                                            if event == CCTOUCHBEGAN
                                              that.ccTouchBegan(x, y)
                                            end},
                                          false, -1, false)
      end
    end

    def title
      "Test Set AnchorPoint"
    end
  end

  class TestArmatureNesting < ArmatureTestBase
    def init_with_layer(layer)
      super(layer)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.node_event_handler(tag)})
      @layer = layer
      @layer
    end

    def node_event_handler(tag)
      if tag == kCCNodeOnEnter
        @layer.setTouchEnabled(true)

        armature = @armature = CCArmature.create("cyborg")
        armature.getAnimation().playByIndex(1, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
        armature.setPosition(VisibleRect.center())
        armature.setScale(1.2)
        armature.getAnimation().setAnimationScale(0.4)
        @layer.addChild(armature)

        @weaponIndex = 0

        that = self
        @layer.registerScriptTouchHandler(Proc.new {|event, x, y|
                                            if event == CCTOUCHBEGAN
                                              that.ccTouchBegan(x, y)
                                            end},
                                          false, -1, false)
      end
    end

    def title
      "Test CCArmature Nesting"
    end

    def ccTouchBegan(x, y)
      @weaponIndex += 1
      @weaponIndex %= 4

      @armature.getBone("armInside").getChildArmature().getAnimation()
        .playByIndex(@weaponIndex, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
      @armature.getBone("armOutside").getChildArmature()
        .getAnimation().playByIndex(@weaponIndex, -1, -1, -1, TWEEN_EASING_MAX) #TODO:
      false
    end
  end

  def initialize
    super

    manager = CCArmatureDataManager.sharedArmatureDataManager
    [["armature/TestBone0.png", "armature/TestBone0.plist", "armature/TestBone.json"],
     ["armature/Cowboy0.png", "armature/Cowboy0.plist", "armature/Cowboy.json"],
     ["armature/knight.png", "armature/knight.plist", "armature/knight.xml"],
     ["armature/weapon.png", "armature/weapon.plist", "armature/weapon.xml"],
     ["armature/robot.png", "armature/robot.plist", "armature/robot.xml"],
     ["armature/cyborg.png", "armature/cyborg.plist", "armature/cyborg.xml"],
     ["armature/Dragon.png", "armature/Dragon.plist", "armature/Dragon.xml"],
    ].each do |args|
      manager.addArmatureFileInfo(*args)
    end

    [TestDragonBones20.new,
     TestCSWithSkeleton.new,
     TestCSWithoutSkeleton.new,
     TestChangeZorder.new,
     TestPerformance.new,
     TestAnimationEvent.new, #sigslot not supported.
     TestParticleDisplay.new,
     TestUseMultiplePicture.new,
     #TestBox2DDetector.new, #Box2d not supported.
     #TestBoundingBox.new, #not implemented.
     TestAnchorPoint.new,
     TestArmatureNesting.new,
    ].each do |test|
      register_create_function(test, :create)
    end
  end

  def new_scene
    scene = CCScene.create
    layer = CCLayer.new

	bg = CCSprite.create("armature/bg.jpg")
	bg.setPosition(VisibleRect.center())

	scaleX = VisibleRect.getVisibleRect().size.width / bg.getContentSize().width
	scaleY = VisibleRect.getVisibleRect().size.height / bg.getContentSize().height

	bg.setScaleX(scaleX)
	bg.setScaleY(scaleY)

	layer.addChild(bg)

    info = @create_function_table[@index]

    init_with_layer(layer)

    @menu.removeFromParent if @menu
    @menu = create_menu
    @current_layer.addChild(@menu, 1)

    scheduler = CCDirector.sharedDirector.getScheduler
    entry = 0

    bye = Proc.new {
      scheduler.unscheduleScriptEntry(entry)
      Cocos2d::Extension::CCArmatureDataManager.purgeArmatureSystem
      ExtensionsTest.main_menu_callback
    }

    back_menu = ExtensionsTest.create_back_menu_item("Back", Proc.new {
      entry = scheduler.scheduleScriptFunc(bye, 0, false)})

    @current_layer = info[:obj].send(info[:symbol], layer)
    scene.addChild(@current_layer)
      .addChild(back_menu)

    scene
  end

  def create
    new_scene
  end
end
