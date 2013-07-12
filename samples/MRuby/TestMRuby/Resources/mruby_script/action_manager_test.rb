require "mruby_script/test_base"
require "mruby_script/test_resource"
require "mruby_script/visible_rect"

class ActionManagerTest < TestBase
  extend TestBaseExt
  self.supported = true

  class ActionManagerTestBase < TestBase
    def self.kTagNode
      0
    end
    def self.kTagGrossini
      1
    end
    def self.kTagSequence
      2
    end

    def initialize
      super
      @scheduler = CCDirector.sharedDirector.getScheduler
    end

    def create
      layer = CCLayer.create
      init_with_layer(layer)
      layer
    end
  end

  class CrashTest < ActionManagerTestBase
    def init_with_layer(layer)
      super(layer)
      @title_label.setString("Test 1. Should not crash")

      child = CCSprite.create($s_pPathGrossini)
      child.setPosition( VisibleRect.center() )
      layer.addChild(child, 1)

      #Sum of all action's duration is 1.5 second.
      child.runAction(CCRotateBy.create(1.5, 90))
      arr = CCArray.create()
      arr.addObject(CCDelayTime.create(1.4))
      arr.addObject(CCFadeOut.create(1.1))
      child.runAction(CCSequence.create(arr))
    
      arr = CCArray.create()
      arr.addObject(CCDelayTime.create(1.4))

      notification_center = CCNotificationCenter.sharedNotificationCenter
      removeThis = Proc.new {
        layer.stopAllActions
        layer.getParent().removeChild(layer, true)
        notification_center.postNotification("next_action", layer)
      }

      arr.addObject(CCCallFunc.create(removeThis))
      #After 1.5 second, self will be removed.
      layer.runAction( CCSequence.create(arr))
      @layer = layer
      @layer
    end
  end

  class LogicTest < ActionManagerTestBase
    def init_with_layer(layer)
      super(layer)
      @title_label.setString("Logic test")
      grossini = CCSprite.create($s_pPathGrossini)
      layer.addChild(grossini, 0, 2)
      grossini.setPosition(VisibleRect.center())

      arr = CCArray.create()
      arr.addObject(CCMoveBy.create(1, ccp(150,0)))

      bugMe = Proc.new {|node|
        node.stopAllActions() #After this stop next action not working, if remove this stop everything is working
        node.runAction(CCScaleTo.create(2, 2))
      }

      arr.addObject(CCCallFuncN.create(bugMe))
      grossini.runAction( CCSequence.create(arr))
      @layer = layer
      @layer
    end
  end

  class PauseTest < ActionManagerTestBase
    def init_with_layer(layer)
      super(layer)
      @title_label.setString("Pause Test")

      @schedulerEntry = nil
      that = self
      layer.registerScriptHandler(Proc.new{|event| that.onNodeEvent(event)})
      @layer = layer
      @layer
    end

    def unpause(dt)
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
      @schedulerEntry = nil
      node = @layer.getChildByTag( self.class.kTagGrossini )
      pDirector = CCDirector.sharedDirector()
      pDirector.getActionManager().resumeTarget(node)
    end

    def onNodeEvent(event)
      if event == kCCNodeOnEnter
        l = CCLabelTTF.create("After 3 seconds grossini should move", "Thonburi", 16)
        @layer.addChild(l)
        l.setPosition( ccp(VisibleRect.center().x, VisibleRect.top().y-75) )
            
        grossini = CCSprite.create($s_pPathGrossini)
        @layer.addChild(grossini, 0, self.class.kTagGrossini)
        grossini.setPosition(VisibleRect.center() )
            
        action = CCMoveBy.create(1, ccp(150,0))

        pDirector = CCDirector.sharedDirector()
        pDirector.getActionManager().addAction(action, grossini, true)

        that = self
        @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.unpause(dt)}, 3.0, false)
      elsif event == kCCNodeOnExit
        if @schedulerEntry
          @scheduler.unscheduleScriptEntry(@schedulerEntry)
        end
      end
    end
  end

  class RemoveTest < ActionManagerTestBase
    def init_with_layer(layer)
      super(layer)
      @title_label.setString("Remove Test")
      l = CCLabelTTF.create("Should not crash", "Thonburi", 16)
      layer.addChild(l)
      l.setPosition( ccp(VisibleRect.center().x, VisibleRect.top().y - 75) )

      pMove = CCMoveBy.create(2, ccp(200, 0))
      that = self
      stopAction = Proc.new {
        pSprite = layer.getChildByTag(that.class.kTagGrossini)
        pSprite.stopActionByTag(that.class.kTagSequence)
      }

      pCallback = CCCallFunc.create(stopAction)
      arr = CCArray.create()
      arr.addObject(pMove)
      arr.addObject(pCallback)
      pSequence = CCSequence.create(arr)
      pSequence.setTag(self.class.kTagSequence)

      pChild = CCSprite.create($s_pPathGrossini)
      pChild.setPosition( VisibleRect.center() )

      layer.addChild(pChild, 1, self.class.kTagGrossini)
      pChild.runAction(pSequence)
      @layer = layer
      @layer
    end
  end

  class ResumeTest < ActionManagerTestBase
    def init_with_layer(layer)
      super(layer)
      @title_label.setString("Resume Test")
      @schedulerEntry = nil
      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.onNodeEvent(tag)})
      @layer = layer
      @layer
    end

    def resumeGrossini(time)
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
      @schedulerEntry = nil
      pGrossini = @layer.getChildByTag(self.class.kTagGrossini)
      pDirector = CCDirector.sharedDirector()
      pDirector.getActionManager().resumeTarget(pGrossini)
    end

    def onNodeEvent(event)
      if event == Cocos2d.kCCNodeOnEnter
        l = CCLabelTTF.create("Grossini only rotate/scale in 3 seconds", "Thonburi", 16)
        @layer.addChild(l)
        l.setPosition( ccp(VisibleRect.center().x, VisibleRect.top().y - 75))

        pGrossini = CCSprite.create($s_pPathGrossini)
        @layer.addChild(pGrossini, 0, self.class.kTagGrossini)
        pGrossini.setPosition(VisibleRect.center())

        pGrossini.runAction(CCScaleBy.create(2, 2))

        pDirector = CCDirector.sharedDirector()
        pDirector.getActionManager().pauseTarget(pGrossini)
        pGrossini.runAction(CCRotateBy.create(2, 360))

        that = self
        @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new {|time| that.resumeGrossini(time)}, 3.0, false)
      elsif event == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@schedulerEntry) if @schedulerEntry
      end
    end
  end

  def initialize
    super
    [CrashTest,
     LogicTest,
     PauseTest,
     RemoveTest,
     ResumeTest,
    ].each do |klass|
      register_create_function(klass.new, :create)
    end
  end

  def new_scene
    scene = super
    that = self
    notification_center = CCNotificationCenter.sharedNotificationCenter
    notification_center.registerScriptObserver(scene,
                                               Proc.new {
                                                 Cocos2d::CCDirector.sharedDirector.replaceScene(that.next_action)
                                               }, "next_action")
    scene.registerScriptHandler(Proc.new {|tag|
                                  if tag == Cocos2d.kCCNodeOnCleanup
                                    notification_center
                                      .unregisterScriptObserver(scene, "next_action")
                                    scene.unregisterScriptHandler
                                  end
                                })
    scene
  end

  def create
    new_scene
  end
end
