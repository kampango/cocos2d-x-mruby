require "mruby_script/main_menu"
require "mruby_script/visible_rect"
require "mruby_script/test_base"

class IntervalTest < TestBase
  extend TestBaseExt
  self.supported = true

  def init_with_layer(ret)
    super(ret)

    m_time0 = 0
    m_time1 = 0
    m_time2 = 0
    m_time3 = 0
    m_time4 = 0

    s = CCDirector.sharedDirector().getWinSize()
    # sun
     sun = CCParticleSun.create()
    sun.setTexture(CCTextureCache.sharedTextureCache().addImage("Images/fire.png"))
    sun.setPosition( ccp(VisibleRect.rightTop().x-32,VisibleRect.rightTop().y-32) )

    sun.setTotalParticles(130)
    sun.setLife(0.6)
    ret.addChild(sun)

    # timers
    m_label0 = CCLabelBMFont.create("0", "fonts/bitmapFontTest4.fnt")
    m_label1 = CCLabelBMFont.create("0", "fonts/bitmapFontTest4.fnt")
    m_label2 = CCLabelBMFont.create("0", "fonts/bitmapFontTest4.fnt")
    m_label3 = CCLabelBMFont.create("0", "fonts/bitmapFontTest4.fnt")
    m_label4 = CCLabelBMFont.create("0", "fonts/bitmapFontTest4.fnt")

    update = Proc.new {|dt|
      m_time0 += dt
      str = sprintf("%2.1f", m_time0)
      m_label0.setString(str)
    }

    ret.scheduleUpdateWithPriorityLua(update, 0)

    step1 = Proc.new {|dt|
      m_time1 += dt
      str = sprintf("%2.1f", m_time1)
      m_label1.setString( str )
    }

    step2 = Proc.new {|dt|
      m_time2 += dt
      str = sprintf("%2.1f", m_time2)
      m_label2.setString( str )
    }

    step3 = Proc.new {|dt|
      m_time3 += dt
      str = sprintf("%2.1f", m_time3)
      m_label3.setString( str )
    }

    step4 = Proc.new {|dt|
      m_time4 += dt
      str = sprintf("%2.1f", m_time4)
      m_label4.setString( str )
    }

    schedulerEntry1 = nil
    schedulerEntry2 = nil
    schedulerEntry3 = nil
    schedulerEntry4 = nil

    onNodeEvent = Proc.new {|event|
      if event == Cocos2d.kCCNodeOnEnter
        scheduler = Cocos2d::CCDirector.sharedDirector.getScheduler
        schedulerEntry1 = scheduler.scheduleScriptFunc(step1, 0, false)
        schedulerEntry2 = scheduler.scheduleScriptFunc(step2, 0, false)
        schedulerEntry3 = scheduler.scheduleScriptFunc(step3, 1.0, false)
        schedulerEntry4 = scheduler.scheduleScriptFunc(step4, 2.0, false)
      elsif event == Cocos2d.kCCNodeOnExit
        scheduler = Cocos2d::CCDirector.sharedDirector.getScheduler
        scheduler.unscheduleScriptEntry(schedulerEntry1)
        scheduler.unscheduleScriptEntry(schedulerEntry2)
        scheduler.unscheduleScriptEntry(schedulerEntry3)
        scheduler.unscheduleScriptEntry(schedulerEntry4)
        if Cocos2d::CCDirector.sharedDirector().isPaused()
          Cocos2d::CCDirector.sharedDirector().resume()
        end
      end
    }

    ret.registerScriptHandler(onNodeEvent)


    m_label0.setPosition(ccp(s.width*1/6, s.height/2))
    m_label1.setPosition(ccp(s.width*2/6, s.height/2))
    m_label2.setPosition(ccp(s.width*3/6, s.height/2))
    m_label3.setPosition(ccp(s.width*4/6, s.height/2))
    m_label4.setPosition(ccp(s.width*5/6, s.height/2))

    ret.addChild(m_label0)
    ret.addChild(m_label1)
    ret.addChild(m_label2)
    ret.addChild(m_label3)
    ret.addChild(m_label4)

    # Sprite
    sprite = CCSprite.create($s_pPathGrossini)
    sprite.setPosition( ccp(VisibleRect.left().x + 40, VisibleRect.bottom().y + 50) )

    jump = CCJumpBy.create(3, ccp(s.width-80,0), 50, 4)

    ret.addChild(sprite)
    arr = CCArray.create()
    arr.addObject(jump)
    arr.addObject(jump.reverse())
    sprite.runAction( CCRepeatForever.create(CCSequence.create(arr)))
    # pause button
    item1 = CCMenuItemFont.create("Pause")
    onPause = Proc.new {|tag, pSender|
      director = Cocos2d::CCDirector.sharedDirector()
      if director.isPaused()
        director.resume()
      else
        director.pause()
      end
    }

    item1.registerScriptTapHandler(onPause)
    menu = CCMenu.createWithItem(item1)
    menu.setPosition( ccp(s.width/2, s.height-50) )

    ret.addChild( menu )
    ret
  end

  def create
    scene = CCScene.create
    layer = CCLayer.create
    init_with_layer(layer)
    scene.addChild(layer, 0)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end
