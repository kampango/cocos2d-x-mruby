require "mruby_script/test_base"
require "mruby_script/cctype_helper"
require "mruby_script/gl_constant"
require "mruby_script/test_resource"
require "mruby_script/visible_rect"

class SceneTest < TestBase
  extend TestBaseExt
  self.supported = true

  def self.delay(proc)
    scheduler = CCDirector.sharedDirector.getScheduler
    entry = 0
    proc1 = Proc.new {
      proc.call
      scheduler.unscheduleScriptEntry(entry)
    }
    entry = scheduler.scheduleScriptFunc(proc1, 0, false)
    entry = entry #avoid to mruby's bug
  end

  class SceneTestLayer1
    include Cocos2d
    include CCTypeHelper

    def onPushScene(tag, pSender)
      scene = CCScene.create()
      layer = SceneTest.createSceneTestLayer2()
      scene.addChild(layer, 0)
      scene.addChild(MainMenu.create_back_menu_item("MainMenu",
                                                    Proc.new{
                                                      Cocos2d::CCDirector.sharedDirector().popToSceneStackLevel(1)
                                                      # to catch kCCNodeOnCleanup
                                                      SceneTest.delay(Proc.new{MainMenu.main_menu_callback})
                                                    }))
      CCDirector.sharedDirector().pushScene( scene )
    end

    def onPushSceneTran(tag, pSender)
      scene = CCScene.create()
      layer = SceneTest.createSceneTestLayer2()
      scene.addChild(layer, 0)
      scene.addChild(MainMenu.create_back_menu_item("MainMenu",
                                                    Proc.new{
                                                      Cocos2d::CCDirector.sharedDirector().popToSceneStackLevel(1)
                                                      SceneTest.delay(Proc.new{MainMenu.main_menu_callback})
                                                    }))
      CCDirector.sharedDirector().pushScene( CCTransitionSlideInT.create(1, scene) )
    end


    def onQuit(tag, pSender)
      cclog("onQuit")
    end

    def onNodeEvent(event)
      if event == kCCNodeOnEnter
        cclog("SceneTestLayer1#onEnter")
      elsif event == kCCNodeOnEnterTransitionDidFinish
        cclog("SceneTestLayer1#onEnterTransitionDidFinish")
      end
    end

    def create_layer
      ret = CCLayer.create()

      that = self

      item1 = CCMenuItemFont.create( "Test pushScene")
      item1.registerScriptTapHandler(Proc.new {|*args| that.onPushScene(*args)})
      item2 = CCMenuItemFont.create( "Test pushScene w/transition")
      item2.registerScriptTapHandler(Proc.new {|*args| that.onPushSceneTran(*args)})
      item3 = CCMenuItemFont.create( "Quit")
      item3.registerScriptTapHandler(Proc.new {|*args| that.onQuit(*args)})

      arr = CCArray.create()
      arr.addObject(item1)
      arr.addObject(item2)
      arr.addObject(item3)
      menu = CCMenu.createWithArray(arr)
      menu.alignItemsVertically()

      ret.addChild( menu )

      s = CCDirector.sharedDirector().getWinSize()
      sprite = CCSprite.create($s_pPathGrossini)
      ret.addChild(sprite)
      sprite.setPosition( ccp(s.width-40, s.height/2) )
      rotate = CCRotateBy.create(2, 360)
      repeatAction = CCRepeatForever.create(rotate)
      sprite.runAction(repeatAction)

      ret.registerScriptHandler(Proc.new {|tag| that.onNodeEvent(tag)})
      ret
    end
  end

  class SceneTestLayer2
    include Cocos2d
    include CCTypeHelper

    def onGoBack(tag, pSender)
      CCDirector.sharedDirector().popScene()
    end

    def onReplaceScene(tag, pSender)
      scene = CCScene.create()
      layer = SceneTest.createSceneTestLayer3()
      scene.addChild(layer, 0)
      scene.addChild(MainMenu.create_back_menu_item("MainMenu",
                                                    Proc.new{
                                                      Cocos2d::CCDirector.sharedDirector().popToSceneStackLevel(1)
                                                      SceneTest.delay(Proc.new{MainMenu.main_menu_callback})
                                                    }))
      CCDirector.sharedDirector().replaceScene( scene )
    end


    def onReplaceSceneTran(tag, pSender)
      scene = CCScene.create()
      layer = SceneTest.createSceneTestLayer3()
      scene.addChild(layer, 0)
      scene.addChild(MainMenu.create_back_menu_item("MainMenu",
                                                    Proc.new{
                                                      Cocos2d::CCDirector.sharedDirector().popToSceneStackLevel(1)
                                                      SceneTest.delay(Proc.new{MainMenu.main_menu_callback})
                                                    }))
      CCDirector.sharedDirector().replaceScene( CCTransitionFlipX.create(2, scene) )
    end

    def create_layer
      ret = CCLayer.create()
      m_timeCounter = 0

      that = self
      item1 = CCMenuItemFont.create( "replaceScene")
      item1.registerScriptTapHandler(Proc.new {|*args| that.onReplaceScene(*args)})
      item2 = CCMenuItemFont.create( "replaceScene w/transition")
      item2.registerScriptTapHandler(Proc.new {|*args| that.onReplaceSceneTran(*args)})
      item3 = CCMenuItemFont.create( "Go Back")
      item3.registerScriptTapHandler(Proc.new {|*args| that.onGoBack(*args)})
      arr = CCArray.create()
      arr.addObject(item1)
      arr.addObject(item2)
      arr.addObject(item3)
      menu = CCMenu.createWithArray(arr)
      menu.alignItemsVertically()

      ret.addChild( menu )

      s = CCDirector.sharedDirector().getWinSize()
      sprite = CCSprite.create($s_pPathGrossini)
      ret.addChild(sprite)
      sprite.setPosition( ccp(s.width-40, s.height/2) )
      rotate = CCRotateBy.create(2, 360)
      repeat_action = CCRepeatForever.create(rotate)
      sprite.runAction(repeat_action)
      ret
    end
  end

  class SceneTestLayer3
    include Cocos2d
    include CCTypeHelper

    def item0Clicked(tag, pSender)
      newScene = CCScene.create()
      newScene.addChild(SceneTest.createSceneTestLayer3())
      CCDirector.sharedDirector().pushScene(CCTransitionFade.create(0.5, newScene, ccc3(0,255,255)))
    end

    def item1Clicked(tag, pSender)
      CCDirector.sharedDirector().popScene()
    end

    def item2Clicked(tag, pSender)
      CCDirector.sharedDirector().popToRootScene()
    end

    def create_layer
      ret = CCLayerColor.create(ccc4(0,0,255,255))
      s = CCDirector.sharedDirector().getWinSize()

      that = self
      item0 = CCMenuItemFont.create("Touch to pushScene (self)")
      item0.registerScriptTapHandler(Proc.new {|*args| that.item0Clicked(*args)})
      item1 = CCMenuItemFont.create("Touch to popScene")
      item1.registerScriptTapHandler(Proc.new {|*args| that.item1Clicked(*args)})
      item2 = CCMenuItemFont.create("Touch to popToRootScene")
      item2.registerScriptTapHandler(Proc.new {|*args| that.item2Clicked(*args)})

      arr = CCArray.create()
      arr.addObject(item0)
      arr.addObject(item1)
      arr.addObject(item2)

      menu = CCMenu.createWithArray(arr)
      ret.addChild(menu)
      menu.alignItemsVertically()

      sprite = CCSprite.create($s_pPathGrossini)
      ret.addChild(sprite)
      sprite.setPosition( ccp(s.width/2, 40) )
      rotate = CCRotateBy.create(2, 360)
      repeatAction = CCRepeatForever.create(rotate)
      sprite.runAction(repeatAction)
      ret
    end
  end

  def self.createSceneTestLayer1
    SceneTestLayer1.new.create_layer
  end

  def self.createSceneTestLayer2
    SceneTestLayer2.new.create_layer
  end

  def self.createSceneTestLayer3
    SceneTestLayer3.new.create_layer
  end

  def create
    scene = CCScene.create
    layer = self.class.createSceneTestLayer1
    scene.addChild(layer, 0)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end
