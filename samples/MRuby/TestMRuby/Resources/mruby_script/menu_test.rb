require "mruby_script/test_resource"
require "mruby_script/test_base"

class MenuTest < TestBase
  extend TestBaseExt
  self.supported = true

  def kTagMenu
    1
  end
  def kTagMenu0
    0
  end
  def kTagMenu1
    1
  end

  MID_CALLBACK     = 1000
  MID_CALLBACK2    = 1001
  MID_DISABLED     = 1002
  MID_ENABLE       = 1003
  MID_CONFIG       = 1004
  MID_QUIT         = 1005
  MID_OPACITY      = 1006
  MID_ALIGN        = 1007
  MID_CALLBACK3    = 1008
  MID_BACKCALLBACK = 1009

  def menu_layer_main_menu
    m_disabledItem = nil

    ret = CCLayer.create
    ret.setTouchEnabled(true)
    ret.setTouchPriority(kCCMenuHandlerPriority + 1)
    ret.setTouchMode(kCCTouchesOneByOne)

    # Font Item
    spriteNormal = CCSprite.create($s_MenuItem, CCRectMake(0,23*2,115,23))
    spriteSelected = CCSprite.create($s_MenuItem, CCRectMake(0,23*1,115,23))
    spriteDisabled = CCSprite.create($s_MenuItem, CCRectMake(0,23*0,115,23))

    item1 = CCMenuItemSprite.create(spriteNormal, spriteSelected, spriteDisabled)

    menuCallback = Proc.new {|sender|
      Cocos2d.cclog("menuCallback...")
      ret.getParent.switchTo(1)
    }

    item1.registerScriptTapHandler(menuCallback)
    # Image Item
    menuCallback2 = Proc.new {|sender|
      ret.getParent.switchTo(2)
    }

    item2 = CCMenuItemImage.create($s_SendScore, $s_PressSendScore)
    item2.registerScriptTapHandler(menuCallback2)


    schedulerEntry = nil
    scheduler = CCDirector.sharedDirector.getScheduler
    allowTouches = Proc.new {|dt|
      pDirector = CCDirector.sharedDirector
      #pDirector.getTouchDispatcher.setPriority(kCCMenuHandlerPriority+1, ret)
      unless schedulerEntry.nil?
        scheduler.unscheduleScriptEntry(schedulerEntry)
        schedulerEntry = nil
      end
      Cocos2d.cclog("TOUCHES ALLOWED AGAIN")
    }

    menuCallbackDisabled = Proc.new {|sender|
      # hijack all touch events for 5 seconds
      pDirector = CCDirector.sharedDirector
      #pDirector.getTouchDispatcher.setPriority(kCCMenuHandlerPriority-1, ret)
      if schedulerEntry.nil?
        schedulerEntry = scheduler.scheduleScriptFunc(allowTouches, 5, false)
      end
      Cocos2d.cclog("TOUCHES DISABLED FOR 5 SECONDS")
    }

    # Label Item (LabelAtlas)
    labelAtlas = CCLabelAtlas.create("0123456789", "fonts/labelatlas.png", 16, 24, ".".getbyte(0))
    item3 = CCMenuItemLabel.create(labelAtlas)
    item3.registerScriptTapHandler(menuCallbackDisabled)
    item3.setDisabledColor( ccc3(32,32,64) )
    item3.setColor( ccc3(200,200,255) )

    menuCallbackEnable = Proc.new {|sender|
      m_disabledItem.setEnabled( !m_disabledItem.isEnabled )
    }

    # Font Item
    item4 = CCMenuItemFont.create("I toggle enable items")
    item4.registerScriptTapHandler(menuCallbackEnable)

    item4.setFontSizeObj(20)
    CCMenuItemFont.setFontName("Marker Felt")

    menuCallbackConfig = Proc.new {|sender|
      ret.getParent.switchTo(3)
    }

    # Label Item (CCLabelBMFont)
    label = CCLabelBMFont.create("configuration", "fonts/bitmapFontTest3.fnt")
    item5 = CCMenuItemLabel.create(label)
    item5.registerScriptTapHandler(menuCallbackConfig)

    # Testing issue #500
    item5.setScale( 0.8 )

    menuCallbackPriorityTest = Proc.new {|pSender|
      ret.getParent.switchTo(4)
    }

    # Events
    CCMenuItemFont.setFontName("Marker Felt")
    item6 = CCMenuItemFont.create("Priority Test")
    item6.registerScriptTapHandler(menuCallbackPriorityTest)

    menuCallbackBugsTest = Proc.new {|pSender|
      ret.getParent.switchTo(5)
    }

    # Bugs Item
    item7 = CCMenuItemFont.create("Bugs")
    item7.registerScriptTapHandler(menuCallbackBugsTest)

    onQuit = Proc.new {|sender|
      Cocos2d.cclog("onQuit item is clicked.")
    }

    # Font Item
    item8 = CCMenuItemFont.create("Quit")
    item8.registerScriptTapHandler(onQuit)

    menuMovingCallback = Proc.new {|pSender|
      ret.getParent.switchTo(6)
    }

    item9 = CCMenuItemFont.create("Remove menu item when moving")
    item9.registerScriptTapHandler(menuMovingCallback)

    color_action = CCTintBy.create(0.5, 0, -255, -255)
    color_back = color_action.reverse
    arr = CCArray.create
    arr.addObject(color_action)
    arr.addObject(color_back)
    seq = CCSequence.create(arr)
    item8.runAction(CCRepeatForever.create(seq))

    menu = CCMenu.create

    menu.addChild(item1)
    menu.addChild(item2)
    menu.addChild(item3)
    menu.addChild(item4)
    menu.addChild(item5)
    menu.addChild(item6)
    menu.addChild(item7)
    menu.addChild(item8)
    menu.addChild(item9)

    menu.alignItemsVertically

    # elastic effect
    s = CCDirector.sharedDirector.getWinSize

    i        = 0
    child    = nil
    pArray   = menu.getChildren
    len      = pArray.count
    pObject  = nil

    len.times do |i|
      pObject = pArray.objectAtIndex(i)
      if pObject.nil? then
        break
      end
      child = pObject
      pos = child.getPosition
      dstPointX = pos.x
      dstPointY = pos.y
      offset = s.width/2 + 50
      if  i % 2 == 0
        offset = 0-offset
      end
      child.setPosition( ccp( dstPointX + offset, dstPointY) )
      child.runAction( CCEaseElasticOut.create(CCMoveBy.create(2, ccp(dstPointX - offset,0)), 0.35) )
    end

    m_disabledItem = item3
    #item3.retain

    m_disabledItem.setEnabled( false )

    ret.addChild(menu)
    menu.setPosition(ccp(s.width/2, s.height/2))

    #schedulerEntry = nil
    onNodeEvent = Proc.new {|event|
      if event == Cocos2d.kCCNodeOnExit
        if schedulerEntry
          scheduler.unscheduleScriptEntry(schedulerEntry)
        end
        if m_disabledItem
          #m_disabledItem.release
        end
      end
    }

    ret.registerScriptHandler(onNodeEvent)
    ret
  end

  def menu_layer2
    ret = CCLayer.create
    m_centeredMenu = nil
    m_alignedH = false

    alignMenusH = Proc.new {
      2.times do |i|
        menu = ret.getChildByTag(100+i)
        menu.setPosition( m_centeredMenu )
        if i==0
          # TIP. if no padding, padding = 5
          menu.alignItemsHorizontally
          pos = menu.getPosition
          menu.setPosition( ccpAdd(pos, ccp(0,30)) )
        else
          # TIP. but padding is configurable
          menu.alignItemsHorizontallyWithPadding(40)
          pos = menu.getPosition
          menu.setPosition( ccpSub(pos, ccp(0,30)) )
        end
      end
    }

    alignMenusV = Proc.new {
      2.times do |i|
        menu = ret.getChildByTag(100+i)
        menu.setPosition( m_centeredMenu )
        if i==0
          # TIP. if no padding, padding = 5
          menu.alignItemsVertically
          pos = menu.getPosition
          menu.setPosition( ccpAdd(pos, ccp(100,0)) )
        else
          # TIP. but padding is configurable
          menu.alignItemsVerticallyWithPadding(40)
          pos = menu.getPosition
          menu.setPosition( ccpSub(pos, ccp(100,0)) )
        end
      end
    }

    menuCallback = Proc.new {|sender|
      ret.getParent.switchTo(0)
    }

    menuCallbackOpacity = Proc.new {|tag, sender|
      menu = sender.getParent
      opacity = menu.getOpacity
      if opacity == 128
        menu.setOpacity(255)
      else
        menu.setOpacity(128)
      end
    }

    menuCallbackAlign = Proc.new {|sender|
      m_alignedH = !m_alignedH

      if m_alignedH
        alignMenusH.call
      else
        alignMenusV.call
      end
    }

    2.times do |i|
      item1 = CCMenuItemImage.create($s_PlayNormal, $s_PlaySelect)
      item1.registerScriptTapHandler(menuCallback)

      item2 = CCMenuItemImage.create($s_HighNormal, $s_HighSelect)
      item2.registerScriptTapHandler(menuCallbackOpacity)

      item3 = CCMenuItemImage.create($s_AboutNormal, $s_AboutSelect)
      item3.registerScriptTapHandler(menuCallbackAlign)

      item1.setScaleX( 1.5 )
      item2.setScaleX( 0.5 )
      item3.setScaleX( 0.5 )

      menu = CCMenu.create

      menu.addChild(item1)
      menu.addChild(item2)
      menu.addChild(item3)

      s = CCDirector.sharedDirector.getWinSize
      menu.setPosition(ccp(s.width/2, s.height/2))

      menu.setTag( kTagMenu )

      ret.addChild(menu, 0, 100+i)

      pos = menu.getPosition
      m_centeredMenu = pos
    end

    m_alignedH = true
    alignMenusH.call
    ret
  end

  def menu_layer3
    m_disabledItem = nil
    ret = CCLayer.create
    menuCallback = Proc.new {|sender|
      ret.getParent.switchTo(0)
    }

    menuCallback2 = Proc.new {|sender|
      Cocos2d.cclog("Label clicked. Toogling AtlasSprite")
      m_disabledItem.setEnabled( !m_disabledItem.isEnabled )
      m_disabledItem.stopAllActions
    }

    menuCallback3 = Proc.new {|sender|
      Cocos2d.cclog("MenuItemSprite clicked")
    }

    CCMenuItemFont.setFontName("Marker Felt")
    CCMenuItemFont.setFontSize(28)

    label = CCLabelBMFont.create("Enable AtlasItem", "fonts/bitmapFontTest3.fnt")
    item1 = CCMenuItemLabel.create(label)
    item1.registerScriptTapHandler(menuCallback2)

    item2 = CCMenuItemFont.create("--- Go Back ---")
    item2.registerScriptTapHandler(menuCallback)

    spriteNormal   = CCSprite.create($s_MenuItem,  CCRectMake(0,23*2,115,23))
    spriteSelected = CCSprite.create($s_MenuItem,  CCRectMake(0,23*1,115,23))
    spriteDisabled = CCSprite.create($s_MenuItem,  CCRectMake(0,23*0,115,23))


    item3 = CCMenuItemSprite.create(spriteNormal, spriteSelected, spriteDisabled)
    item3.registerScriptTapHandler(menuCallback3)
    m_disabledItem = item3
    #item3.retain
    m_disabledItem.setEnabled( false )

    menu = CCMenu.create

    menu.addChild(item1)
    menu.addChild(item2)
    menu.addChild(item3)

    menu.setPosition( ccp(0,0) )

    s = CCDirector.sharedDirector.getWinSize

    item1.setPosition( ccp(s.width/2 - 150, s.height/2) )
    item2.setPosition( ccp(s.width/2 - 200, s.height/2) )
    item3.setPosition( ccp(s.width/2, s.height/2 - 100) )

    jump = CCJumpBy.create(3, ccp(400,0), 50, 4)
    arr = CCArray.create
    arr.addObject(jump)
    arr.addObject(jump.reverse)
    item2.runAction( CCRepeatForever.create(CCSequence.create( arr)))

    spin1 = CCRotateBy.create(3, 360)
    spin2 = spin1.copy
    spin3 = spin1.copy

    item1.runAction( CCRepeatForever.create(spin1) )
    item2.runAction( CCRepeatForever.create(spin2) )
    item3.runAction( CCRepeatForever.create(spin3) )

    ret.addChild( menu )

    menu.setPosition(ccp(0,0))

    onNodeEvent = Proc.new {|event|
      if event == Cocos2d.kCCNodeOnExit
        if m_disabledItem
          #m_disabledItem.release
        end
      end
    }

    ret.registerScriptHandler(onNodeEvent)

    ret
  end


  def menu_layer4
    ret = CCLayer.create
    CCMenuItemFont.setFontName("American Typewriter")
    CCMenuItemFont.setFontSize(18)
    title1 = CCMenuItemFont.create("Sound")
    title1.setEnabled(false)
    CCMenuItemFont.setFontName( "Marker Felt" )
    CCMenuItemFont.setFontSize(34)
    item1 = CCMenuItemToggle.create(CCMenuItemFont.create( "On" ))

    menuCallback = Proc.new {|tag, sender|
      Cocos2d.cclog("selected item. tag. %d, index.%d", tag, sender.getSelectedIndex )
    }

    backCallback = Proc.new {|tag, sender|
      ret.getParent.switchTo(0)
    }

    item1.registerScriptTapHandler(menuCallback)
    item1.addSubItem(CCMenuItemFont.create( "Off"))

    CCMenuItemFont.setFontName( "American Typewriter" )
    CCMenuItemFont.setFontSize(18)
    title2 = CCMenuItemFont.create( "Music" )
    title2.setEnabled(false)
    CCMenuItemFont.setFontName( "Marker Felt" )
    CCMenuItemFont.setFontSize(34)
    item2 = CCMenuItemToggle.create(CCMenuItemFont.create( "On" ))
    item2.registerScriptTapHandler(menuCallback)
    item2.addSubItem(CCMenuItemFont.create( "Off"))

    CCMenuItemFont.setFontName( "American Typewriter" )
    CCMenuItemFont.setFontSize(18)
    title3 = CCMenuItemFont.create( "Quality" )
    title3.setEnabled( false )
    CCMenuItemFont.setFontName( "Marker Felt" )
    CCMenuItemFont.setFontSize(34)
    item3 = CCMenuItemToggle.create(CCMenuItemFont.create( "High" ))
    item3.registerScriptTapHandler(menuCallback)
    item3.addSubItem(CCMenuItemFont.create( "Low" ))

    CCMenuItemFont.setFontName( "American Typewriter" )
    CCMenuItemFont.setFontSize(18)
    title4 = CCMenuItemFont.create( "Orientation" )
    title4.setEnabled(false)
    CCMenuItemFont.setFontName( "Marker Felt" )
    CCMenuItemFont.setFontSize(34)
    item4 = CCMenuItemToggle.create(CCMenuItemFont.create( "Off" ))
    item4.registerScriptTapHandler(menuCallback)

    item4.getSubItems.addObject( CCMenuItemFont.create( "33%" ) )
    item4.getSubItems.addObject( CCMenuItemFont.create( "66%" ) )
    item4.getSubItems.addObject( CCMenuItemFont.create( "100%" ) )

    # you can change the one of the items by doing this
    item4.setSelectedIndex( 2 )

    CCMenuItemFont.setFontName( "Marker Felt" )
    CCMenuItemFont.setFontSize( 34 )

    label = CCLabelBMFont.create( "go back", "fonts/bitmapFontTest3.fnt" )
    back = CCMenuItemLabel.create(label)
    back.registerScriptTapHandler(backCallback)

    menu = CCMenu.create

    menu.addChild(title1)
    menu.addChild(title2)
    menu.addChild(item1 )
    menu.addChild(item2 )
    menu.addChild(title3)
    menu.addChild(title4)
    menu.addChild(item3 )
    menu.addChild(item4 )
    menu.addChild(back  )

    arr = CCArray.create
    arr.addObject(CCInteger.create(2))
    arr.addObject(CCInteger.create(2))
    arr.addObject(CCInteger.create(2))
    arr.addObject(CCInteger.create(2))
    arr.addObject(CCInteger.create(1))
    menu.alignItemsInColumnsWithArray(arr)

    ret.addChild(menu)

    s = CCDirector.sharedDirector.getWinSize
    menu.setPosition(ccp(s.width/2, s.height/2))
    ret
  end

  def menu_layer_priority_test
    ret = CCLayer.create
    m_bPriority = false
    # Testing empty menu
    m_pMenu1 = CCMenu.create
    m_pMenu2 = CCMenu.create

    menuCallback = Proc.new {|tag, pSender|
      ret.getParent.switchTo(0)
    }

    enableMenuCallback = Proc.new {
      m_pMenu1.setEnabled(true)
    }

    disableMenuCallback = Proc.new {|tag, pSender|
      m_pMenu1.setEnabled(false)
      wait = CCDelayTime.create(5)
      enable = CCCallFunc.create(enableMenuCallback)
      arr = CCArray.create
      arr.addObject(wait)
      arr.addObject(enable)
      seq = CCSequence.create(arr)
      m_pMenu1.runAction(seq)
    }

    togglePriorityCallback = Proc.new {|tag, pSender|
      if m_bPriority then
        m_pMenu2.setHandlerPriority(kCCMenuHandlerPriority + 20)
        m_bPriority = false
      else
        m_pMenu2.setHandlerPriority(kCCMenuHandlerPriority - 20)
        m_bPriority = true
      end
    }

    # Menu 1
    CCMenuItemFont.setFontName("Marker Felt")
    CCMenuItemFont.setFontSize(18)
    item1 = CCMenuItemFont.create("Return to Main Menu")
    item1.registerScriptTapHandler(menuCallback)
    item2 = CCMenuItemFont.create("Disable menu for 5 seconds")
    item2.registerScriptTapHandler(disableMenuCallback)

    m_pMenu1.addChild(item1)
    m_pMenu1.addChild(item2)

    m_pMenu1.alignItemsVerticallyWithPadding(20)

    ret.addChild(m_pMenu1)

    # Menu 2
    m_bPriority = true
    CCMenuItemFont.setFontSize(48)
    item1 = CCMenuItemFont.create("Toggle priority")
    item2.registerScriptTapHandler(togglePriorityCallback)
    item1.setColor(ccc3(0,0,255))
    m_pMenu2.addChild(item1)
    ret.addChild(m_pMenu2)
    ret
  end


  # BugsTest
  def bugs_test
    ret = CCLayer.create
    issue1410MenuCallback = Proc.new {|tag, pSender|
      menu = pSender.getParent
      menu.setTouchEnabled(false)
      menu.setTouchEnabled(true)
      Cocos2d.cclog("NO CRASHES")
    }

    issue1410v2MenuCallback = Proc.new {|tag, pSender|
      menu = pSender.getParent
      menu.setTouchEnabled(true)
      menu.setTouchEnabled(false)
      Cocos2d.cclog("NO CRASHES. AND MENU SHOULD STOP WORKING")
    }

    backMenuCallback = Proc.new {|tag, pSender|
      ret.getParent.switchTo(0)
    }


    issue1410 = CCMenuItemFont.create("Issue 1410")
    issue1410.registerScriptTapHandler(issue1410MenuCallback)
    issue1410_2 = CCMenuItemFont.create("Issue 1410 #2")
    issue1410_2.registerScriptTapHandler(issue1410v2MenuCallback)
    back = CCMenuItemFont.create("Back")
    back.registerScriptTapHandler(backMenuCallback)

    menu = CCMenu.create
    menu.addChild(issue1410)
    menu.addChild(issue1410_2)
    menu.addChild(back)
    ret.addChild(menu)
    menu.alignItemsVertically

    s = CCDirector.sharedDirector.getWinSize
    menu.setPosition(ccp(s.width/2, s.height/2))
    ret
  end


  def remove_menu_item_when_move
    ret = CCLayer.create
    s = CCDirector.sharedDirector.getWinSize

    label = CCLabelTTF.create("click item and move, should not crash", "Arial", 20)
    label.setPosition(ccp(s.width/2, s.height - 30))
    ret.addChild(label)

    item = CCMenuItemFont.create("item 1")
    #item.retain

    back = CCMenuItemFont.create("go back")
    goBack = Proc.new {|tag, pSender|
      ret.getParent.switchTo(0)
    }

    back.registerScriptTapHandler(goBack)

    menu = CCMenu.create
    menu.addChild(item)
    menu.addChild(back)

    ret.addChild(menu)
    menu.alignItemsVertically

    menu.setPosition(ccp(s.width/2, s.height/2))

    ret.setTouchEnabled(true)

    #function onNodeEvent(event)
    #    if event == "enter" then
    #        CCDirector.sharedDirector.getTouchDispatcher.addTargetedDelegate(ret, -129, false)
    #    elseif event == "exit" then
    #       # item.release
    #    end
    #end

    #ret.registerScriptHandler(onNodeEvent)

    onTouchEvent = Proc.new {|eventType, x, y|
      if eventType == CCTOUCHBEGAN
        true
      elsif  eventType == CCTOUCHMOVED
        if item
          item.removeFromParentAndCleanup(true)
          #item.release
          #item = nil
        end
      end
    }

    ret.registerScriptTouchHandler(onTouchEvent,false,-129,false)
    ret
  end

  def create
    cclog("MenuTestMain")
    scene = CCScene.create

    pLayer1 = menu_layer_main_menu
    pLayer2 = menu_layer2

    pLayer3 = menu_layer3
    pLayer4 = menu_layer4
    pLayer5 = menu_layer_priority_test
    pLayer6 = bugs_test
    pLayer7 = remove_menu_item_when_move


    arr = CCArray.create
    arr.addObject(pLayer1)
    arr.addObject(pLayer2)
    arr.addObject(pLayer3)
    arr.addObject(pLayer4)
    arr.addObject(pLayer5)
    arr.addObject(pLayer6)
    arr.addObject(pLayer7)

    layer = CCLayerMultiplex.createWithArray(arr)

    scene.addChild(layer, 0)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end
