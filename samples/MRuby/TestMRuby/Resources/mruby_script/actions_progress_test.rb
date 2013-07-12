require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class ActionsProgressTest < TestBase
  extend TestBaseExt
  self.supported = true

  def initialize
    super()
    [:sprite_progress_to_radial,
     :sprite_progress_to_horizontal,
     :sprite_progress_to_vertical,
     :sprite_progress_to_radial_midpoint_changed,
     :sprite_progress_bar_various,
     :sprite_progress_bar_tint_and_fade,
     :sprite_progress_with_sprite_frame,
    ].each do |sym|
      register_create_function(self, sym)
    end
  end

  def sprite_progress_to_radial
    layer = CCLayer.create
    init_with_layer(layer)

    s = CCDirector.sharedDirector.getWinSize

    to1 = CCProgressTo.create(2, 100)
    to2 = CCProgressTo.create(2, 100)

    left = CCProgressTimer.create(CCSprite.create($s_pPathSister1))
    left.setType(kCCProgressTimerTypeRadial)
    left.setPosition(CCPointMake(100, s.height / 2))
    left.runAction(CCRepeatForever.create(to1))
    layer.addChild(left)

    right = CCProgressTimer.create(CCSprite.create($s_pPathBlock))
    right.setType(kCCProgressTimerTypeRadial)
    # Makes the ridial CCW
    right.setReverseProgress(true)
    right.setPosition(CCPointMake(s.width - 100, s.height / 2))
    right.runAction(CCRepeatForever.create(to2))
    layer.addChild(right)

    subtitle_label.setString("ProgressTo Radial")
    layer
  end

  def sprite_progress_to_horizontal
    layer = CCLayer.create
    init_with_layer(layer)

    s = CCDirector.sharedDirector.getWinSize

    to1 = CCProgressTo.create(2, 100)
    to2 = CCProgressTo.create(2, 100)

    left = CCProgressTimer.create(CCSprite.create($s_pPathSister1))
    left.setType(kCCProgressTimerTypeBar)
    # Setup for a bar starting from the left since the midpoint is 0 for the x
    left.setMidpoint(CCPointMake(0, 0))
    # Setup for a horizontal bar since the bar change rate is 0 for y meaning no vertical change
    left.setBarChangeRate(CCPointMake(1, 0))
    left.setPosition(CCPointMake(100, s.height / 2))
    left.runAction(CCRepeatForever.create(to1))
    layer.addChild(left)

    right = CCProgressTimer.create(CCSprite.create($s_pPathSister2))
    right.setType(kCCProgressTimerTypeBar)
    # Setup for a bar starting from the left since the midpoint is 1 for the x
    right.setMidpoint(CCPointMake(1, 0))
    # Setup for a horizontal bar since the bar change rate is 0 for y meaning no vertical change
    right.setBarChangeRate(CCPointMake(1, 0))
    right.setPosition(CCPointMake(s.width - 100, s.height / 2))
    right.runAction(CCRepeatForever.create(to2))
    layer.addChild(right)

    subtitle_label.setString("ProgressTo Horizontal")
    layer
  end

  def sprite_progress_to_vertical
    layer = CCLayer.create
    init_with_layer(layer)

    s = CCDirector.sharedDirector.getWinSize

    to1 = CCProgressTo.create(2, 100)
    to2 = CCProgressTo.create(2, 100)

    left = CCProgressTimer.create(CCSprite.create($s_pPathSister1))
    left.setType(kCCProgressTimerTypeBar)

    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    left.setMidpoint(CCPointMake(0,0))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    left.setBarChangeRate(CCPointMake(0, 1))
    left.setPosition(CCPointMake(100, s.height / 2))
    left.runAction(CCRepeatForever.create(to1))
    layer.addChild(left)

    right = CCProgressTimer.create(CCSprite.create($s_pPathSister2))
    right.setType(kCCProgressTimerTypeBar)
    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    right.setMidpoint(CCPointMake(0, 1))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    right.setBarChangeRate(CCPointMake(0, 1))
    right.setPosition(CCPointMake(s.width - 100, s.height / 2))
    right.runAction(CCRepeatForever.create(to2))
    layer.addChild(right)

    subtitle_label.setString("ProgressTo Vertical")
    layer
  end

  def sprite_progress_to_radial_midpoint_changed
    layer = CCLayer.create
    init_with_layer(layer)

    s = CCDirector.sharedDirector.getWinSize

    action = CCProgressTo.create(2, 100)

    # Our image on the left should be a radial progress indicator, clockwise
    left = CCProgressTimer.create(CCSprite.create($s_pPathBlock))
    left.setType(kCCProgressTimerTypeRadial)
    left.setMidpoint(CCPointMake(0.25, 0.75))
    left.setPosition(CCPointMake(100, s.height / 2))
    left.runAction(CCRepeatForever.create(CCProgressTo.create(2, 100)))
    layer.addChild(left)

    # Our image on the left should be a radial progress indicator, counter clockwise
    right = CCProgressTimer.create(CCSprite.create($s_pPathBlock))
    right.setType(kCCProgressTimerTypeRadial)
    right.setMidpoint(CCPointMake(0.75, 0.25))

    # Note the reverse property (default=NO) is only added to the right image. That's how
    #   we get a counter clockwise progress.

    right.setPosition(CCPointMake(s.width - 100, s.height / 2))
    right.runAction(CCRepeatForever.create(CCProgressTo.create(2, 100)))
    layer.addChild(right)

    subtitle_label.setString("Radial w/ Different Midpoints")
    layer
  end

  def sprite_progress_bar_various
    layer = CCLayer.create
    init_with_layer(layer)

    s = CCDirector.sharedDirector.getWinSize

    to = CCProgressTo.create(2, 100)

    left = CCProgressTimer.create(CCSprite.create($s_pPathSister1))
    left.setType(kCCProgressTimerTypeBar)

    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    left.setMidpoint(CCPointMake(0.5, 0.5))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    left.setBarChangeRate(CCPointMake(1, 0))
    left.setPosition(CCPointMake(100, s.height / 2))
    left.runAction(CCRepeatForever.create(CCProgressTo.create(2, 100)))
    layer.addChild(left)

    middle = CCProgressTimer.create(CCSprite.create($s_pPathSister2))
    middle.setType(kCCProgressTimerTypeBar)
    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    middle.setMidpoint(CCPointMake(0.5, 0.5))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    middle.setBarChangeRate(CCPointMake(1, 1))
    middle.setPosition(CCPointMake(s.width/2, s.height/2))
    middle.runAction(CCRepeatForever.create(CCProgressTo.create(2, 100)))
    layer.addChild(middle)

    right = CCProgressTimer.create(CCSprite.create($s_pPathSister2))
    right.setType(kCCProgressTimerTypeBar)
    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    right.setMidpoint(CCPointMake(0.5, 0.5))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    right.setBarChangeRate(CCPointMake(0, 1))
    right.setPosition(CCPointMake(s.width-100, s.height/2))
    right.runAction(CCRepeatForever.create(CCProgressTo.create(2, 100)))
    layer.addChild(right)

    subtitle_label.setString("ProgressTo Bar Mid")
    layer
  end

  def sprite_progress_bar_tint_and_fade
    layer = CCLayer.create
    init_with_layer(layer)

    s = CCDirector.sharedDirector.getWinSize

    to = CCProgressTo.create(6, 100)
    array = CCArray.create()
    array.addObject(CCTintTo.create(1, 255, 0, 0))
    array.addObject(CCTintTo.create(1, 0, 255, 0))
    array.addObject(CCTintTo.create(1, 0, 0, 255))
    tint = CCSequence.create(array)
    fade = CCSequence.createWithTwoActions(CCFadeTo.create(1.0, 0),
                                           CCFadeTo.create(1.0, 255))

    left = CCProgressTimer.create(CCSprite.create($s_pPathSister1))
    left.setType(kCCProgressTimerTypeBar)

    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    left.setMidpoint(CCPointMake(0.5, 0.5))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    left.setBarChangeRate(CCPointMake(1, 0))
    left.setPosition(CCPointMake(100, s.height / 2))
    left.runAction(CCRepeatForever.create(CCProgressTo.create(6, 100)))
    left.runAction(CCRepeatForever.create(CCSequence.create(array)))
    layer.addChild(left)

    left.addChild(CCLabelTTF.create("Tint", "Marker Felt", 20.0))

    middle = CCProgressTimer.create(CCSprite.create($s_pPathSister2))
    middle.setType(kCCProgressTimerTypeBar)
    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    middle.setMidpoint(CCPointMake(0.5, 0.5))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    middle.setBarChangeRate(CCPointMake(1, 1))
    middle.setPosition(CCPointMake(s.width / 2, s.height / 2))
    middle.runAction(CCRepeatForever.create(CCProgressTo.create(6, 100)))

    fade2 = CCSequence.createWithTwoActions(CCFadeTo.create(1.0, 0),
                                            CCFadeTo.create(1.0, 255))
    middle.runAction(CCRepeatForever.create(fade2))
    layer.addChild(middle)

    middle.addChild(CCLabelTTF.create("Fade", "Marker Felt", 20.0))

    right = CCProgressTimer.create(CCSprite.create($s_pPathSister2))
    right.setType(kCCProgressTimerTypeBar)
    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    right.setMidpoint(CCPointMake(0.5, 0.5))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    right.setBarChangeRate(CCPointMake(0, 1))
    right.setPosition(CCPointMake(s.width - 100, s.height / 2))
    right.runAction(CCRepeatForever.create(CCProgressTo.create(6, 100)))
    right.runAction(CCRepeatForever.create(CCSequence.create(array)))
    right.runAction(CCRepeatForever.create(CCSequence.createWithTwoActions(CCFadeTo.create(1.0, 0),
                                                                           CCFadeTo.create(1.0, 255))))
    layer.addChild(right)

    right.addChild(CCLabelTTF.create("Tint and Fade", "Marker Felt", 20.0))

    subtitle_label.setString("ProgressTo Bar Mid")
    layer
  end

  def sprite_progress_with_sprite_frame
    layer = CCLayer.create
    init_with_layer(layer)

    s = CCDirector.sharedDirector.getWinSize

    to = CCProgressTo.create(6, 100)

    CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("zwoptex/grossini.plist")

    left = CCProgressTimer.create(CCSprite.createWithSpriteFrameName("grossini_dance_01.png"))
    left.setType(kCCProgressTimerTypeBar)
    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    left.setMidpoint(CCPointMake(0.5, 0.5))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    left.setBarChangeRate(CCPointMake(1, 0))
    left.setPosition(CCPointMake(100, s.height / 2))
    left.runAction(CCRepeatForever.create(CCProgressTo.create(6, 100)))
    layer.addChild(left)

    middle = CCProgressTimer.create(CCSprite.createWithSpriteFrameName("grossini_dance_02.png"))
    middle.setType(kCCProgressTimerTypeBar)
    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    middle.setMidpoint(CCPointMake(0.5, 0.5))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    middle.setBarChangeRate(CCPointMake(1, 1))
    middle.setPosition(CCPointMake(s.width / 2, s.height / 2))
    middle.runAction(CCRepeatForever.create(CCProgressTo.create(6, 100)))
    layer.addChild(middle)

    right = CCProgressTimer.create(CCSprite.createWithSpriteFrameName("grossini_dance_03.png"))
    right.setType(kCCProgressTimerTypeRadial)
    # Setup for a bar starting from the bottom since the midpoint is 0 for the y
    right.setMidpoint(CCPointMake(0.5, 0.5))
    # Setup for a vertical bar since the bar change rate is 0 for x meaning no horizontal change
    right.setBarChangeRate(CCPointMake(0, 1))
    right.setPosition(CCPointMake(s.width - 100, s.height / 2))
    right.runAction(CCRepeatForever.create(CCProgressTo.create(6, 100)))
    layer.addChild(right)

    subtitle_label.setString("Progress With Sprite Frame")
    layer
  end

  def create
    new_scene
  end
end
