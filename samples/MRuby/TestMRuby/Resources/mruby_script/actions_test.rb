require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class ActionsTest < TestBase
  extend TestBaseExt
  include Kazmath
  self.supported = true

  @@size = CCDirector.sharedDirector.getWinSize

  def initialize
    super()
    @grossini = nil
    @tamara = nil
    @kathia = nil
    [:action_manual,
     :action_move,
     :action_scale,
     :action_rotate,
     :action_skew,
     :action_rotational_skew_vs_standard_skew,
     :action_skew_rotate,
     :action_jump,
     :action_cardinal_spline, #km
     :action_catmull_rom, #km
     :action_bezier,
     :action_blink,
     :action_fade,
     :action_tint,
     :action_animate,
     :action_sequence,
     :action_sequence2,
     :action_apawn,
     :action_reverse,
     :action_delaytime,
     :action_repeat,
     :action_repeat_forever,
     :action_rotate_to_repeat,
     :action_rotate_jerk,
     :action_call_func,
     :action_call_func_nd, #not supported!
     :action_reverse_sequence,
     :action_reverse_sequence2,
     :action_orbit,
     :action_follow,
     :action_targeted,
     :pause_resume_actions,
     :action_issue1305,
     :action_issue1305_2,
     :action_issue1288,
     :action_issue1288_2,
     :action_issue1327,
    ].each do |sym|
      register_create_function(self, sym)
    end
  end

  def init_with_layer(layer)
    @grossini = CCSprite.create($s_pPathGrossini)
    @tamara   = CCSprite.create($s_pPathSister1)
    @kathia   = CCSprite.create($s_pPathSister2)

    layer.addChild(@grossini, 1)
    layer.addChild(@tamara, 2)
    layer.addChild(@kathia, 3)

    @grossini.setPosition(ccp(@@size.width / 2, @@size.height / 3))
    @tamara.setPosition(ccp(@@size.width / 2, 2 * @@size.height / 3))
    @kathia.setPosition(ccp(@@size.width / 2, @@size.height / 2))

    super(layer)
  end

  def center_sprites(num_sprites)
    s = @@size
    case num_sprites
    when 0
      @tamara.setVisible(false)
      @kathia.setVisible(false)
      @grossini.setVisible(false)
    when 1
      @tamara.setVisible(false)
      @kathia.setVisible(false)
      @grossini.setPosition(ccp(s.width / 2, s.height / 2))
    when 2
      @tamara.setPosition(ccp(s.width / 3, s.height / 2))
      @kathia.setPosition(ccp(2 * s.width / 3, s.height / 2))
      @grossini.setVisible(false)
    when 3
      @grossini.setPosition(ccp(s.width / 2, s.height / 2))
      @tamara.setPosition(ccp(s.width / 4, s.height / 2))
      @kathia.setPosition(ccp(3 * s.width / 4, s.height / 2))
    end
  end

  def align_sprites_left(num_sprites)
    case num_sprites
    when 1
      @tamara.setVisible(false)
      @kathia.setVisible(false)
      @grossini.setPosition(ccp(60, @@size.height / 2))
    when 2
      @kathia.setPosition(ccp(60, @@size.height / 3))
      @tamara.setPosition(ccp(60, 2 * @@size.height / 3))
      @grossini.setVisible(false)
    when 3
      @grossini.setPosition(ccp(60, @@size.height / 2))
      @tamara.setPosition(ccp(60, 2 * @@size.height / 3))
      @kathia.setPosition(ccp(60, @@size.height / 3))
    end
  end

  def action_manual
    p "action_manual:#{__LINE__}"
    layer = CCLayer.create
    init_with_layer(layer)

	@tamara.setScaleX(2.5)
	@tamara.setScaleY(-1.0)
	@tamara.setPosition(ccp(100, 70))
	@tamara.setOpacity(128)

	@grossini.setRotation(120)
	@grossini.setPosition(ccp(@@size.width / 2, @@size.height / 2))
	@grossini.setColor(ccc3(255, 0, 0))

	@kathia.setPosition(ccp(@@size.width - 100, @@size.height / 2))
	@kathia.setColor(ccc3(0, 0, 255))

	subtitle_label.setString("Manual Transformation")
	layer
  end

  def action_move
    p "action_move:#{__LINE__}"
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(3)
    action_by = CCMoveBy.create(2, ccp(80, 80))
    action_by_back = action_by.reverse

    @tamara.runAction(CCMoveTo.create(2, ccp(@@size.width - 40, @@size.height - 40)))
    @grossini.runAction(CCSequence.createWithTwoActions(action_by, action_by_back))
    @kathia.runAction(CCMoveTo.create(1, ccp(40, 40)))

    subtitle_label.setString("MoveTo / MoveBy")
    layer
  end

  def action_scale
    p "action_move:#{__LINE__}"
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(3)

    action_to = CCScaleTo.create(2.0, 0.5)
    action_by = CCScaleBy.create(2.0, 1.0, 10.0)
    action_by2 = CCScaleBy.create(2.0, 5.0, 1.0)

    @grossini.runAction(action_to)
    @tamara.runAction(CCSequence.createWithTwoActions(action_by, action_by.reverse()))
    @kathia.runAction(CCSequence.createWithTwoActions(action_by2, action_by2.reverse()))

    subtitle_label.setString("ScaleTo / ScaleBy")
    layer
  end

  def action_rotate
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(3)

    action_to = CCRotateTo.create(2, 45)
    action_to2 = CCRotateTo.create(2, -45)
    action_to0 = CCRotateTo.create(2, 0)
    @tamara.runAction(CCSequence.createWithTwoActions(action_to, action_to0))

    action_by = CCRotateBy.create(2, 360)
    action_by_back = action_by.reverse()
    @grossini.runAction(CCSequence.createWithTwoActions(action_by, action_by_back))

    action0_retain = CCRotateTo.create(2, 0)

    @kathia.runAction(CCSequence.createWithTwoActions(action_to2, action0_retain))

    subtitle_label.setString("RotateTo / RotateBy")
    layer
  end

  def action_skew
    layer = CCLayer.create()
    init_with_layer(layer)

    center_sprites(3)

    action_to = CCSkewTo.create(2, 37.2, -37.2)
    action_to_back = CCSkewTo.create(2, 0, 0)
    action_by = CCSkewBy.create(2, 0.0, -90.0)
    action_by2 = CCSkewBy.create(2, 45.0, 45.0)
    action_by_back = action_by.reverse()

    @tamara.runAction(CCSequence.createWithTwoActions(action_to, action_to_back))
    @grossini.runAction(CCSequence.createWithTwoActions(action_by, action_by_back))
    @kathia.runAction(CCSequence.createWithTwoActions(action_by2, action_by2.reverse()))

    subtitle_label.setString("SkewTo / SkewBy")
    layer
  end

  def action_rotational_skew_vs_standard_skew
    layer = CCLayer.create
    init_with_layer(layer)

    @tamara.removeFromParentAndCleanup(true)
    @grossini.removeFromParentAndCleanup(true)
    @kathia.removeFromParentAndCleanup(true)

    s = CCDirector.sharedDirector.getWinSize
    box_size = CCSizeMake(100.0, 100.0)
    box = CCLayerColor.create(ccc4(255,255,0,255))
    box.setAnchorPoint(ccp(0.5,0.5))
    box.setContentSize(box_size)
    box.ignoreAnchorPointForPosition(false)
    box.setPosition(ccp(s.width/2, s.height - 100 - box.getContentSize().height/2))
    layer.addChild(box)
    label = CCLabelTTF.create("Standard cocos2d Skew", "Marker Felt", 16)
    label.setPosition(ccp(s.width/2, s.height - 100 + label.getContentSize().height))
    layer.addChild(label)
    action_to = CCSkewBy.create(2, 360, 0)
    action_to_back = CCSkewBy.create(2, -360, 0)
    seq = CCSequence.createWithTwoActions(action_to, action_to_back)

    box.runAction(seq)

    box = CCLayerColor.create(ccc4(255,255,0,255))
    box.setAnchorPoint(ccp(0.5,0.5))
    box.setContentSize(box_size)
    box.ignoreAnchorPointForPosition(false)
    box.setPosition(ccp(s.width/2, s.height - 250 - box.getContentSize().height/2))
    layer.addChild(box)
    label = CCLabelTTF.create("Rotational Skew", "Marker Felt", 16)
    label.setPosition(ccp(s.width/2, s.height - 250 + label.getContentSize().height/2))
    layer.addChild(label)
    action_to2 = CCRotateBy.create(2, 360)
    action_to_back2 = CCRotateBy.create(2, -360)
    seq = CCSequence.createWithTwoActions(action_to2, action_to_back2)
    box.runAction(seq)

    subtitle_label.setString("Skew Comparison")
    layer
  end

  def action_skew_rotate
    layer = CCLayer.create
    init_with_layer(layer)

    @tamara.removeFromParentAndCleanup(true)
    @grossini.removeFromParentAndCleanup(true)
    @kathia.removeFromParentAndCleanup(true)

    box_size = CCSizeMake(100.0, 100.0)

    box = CCLayerColor.create(ccc4(255, 255, 0, 255))
    box.setAnchorPoint(ccp(0, 0))
    box.setPosition(190, 110)
    box.setContentSize(box_size)

    markrside = 10.0
    uL = CCLayerColor.create(ccc4(255, 0, 0, 255))
    box.addChild(uL)
    uL.setContentSize(CCSizeMake(markrside, markrside))
    uL.setPosition(0, box_size.height - markrside)
    uL.setAnchorPoint(ccp(0, 0))

    uR = CCLayerColor.create(ccc4(0, 0, 255, 255))
    box.addChild(uR)
    uR.setContentSize(CCSizeMake(markrside, markrside))
    uR.setPosition(box_size.width - markrside, box_size.height - markrside)
    uR.setAnchorPoint(ccp(0, 0))
    layer.addChild(box)

    action_to = CCSkewTo.create(2, 0, 2)
    rotate_to = CCRotateTo.create(2, 61.0)
    action_scale_to = CCScaleTo.create(2, -0.44, 0.47)

    action_scale_to_back = CCScaleTo.create(2, 1.0, 1.0)
    rotate_to_back = CCRotateTo.create(2, 0)
    action_to_back = CCSkewTo.create(2, 0, 0)

    box.runAction(CCSequence.createWithTwoActions(action_to, action_to_back))
    box.runAction(CCSequence.createWithTwoActions(rotate_to, rotate_to_back))
    box.runAction(CCSequence.createWithTwoActions(action_scale_to, action_scale_to_back))

	subtitle_label.setString("Skew + Rotate + Scale")
    layer
  end

  def action_jump
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(3)

    action_to = CCJumpTo.create(2, ccp(300,300), 50, 4)
    action_by = CCJumpBy.create(2, ccp(300,0), 50, 4)
    action_up = CCJumpBy.create(2, ccp(0,0), 80, 4)
    action_by_back = action_by.reverse()

    @tamara.runAction(action_to)
    @grossini.runAction(CCSequence.createWithTwoActions(action_by, action_by_back))
    @kathia.runAction(CCRepeatForever.create(action_up))

    subtitle_label.setString("JumpTo / JumpBy")
    layer
  end

  def draw_cardinal_spline(array)
    kmGLPushMatrix()
    kmGLTranslatef(50, 50, 0)
    ccDrawCardinalSpline(array, 0, 100)
    kmGLPopMatrix()

    kmGLPushMatrix()
    kmGLTranslatef(@@size.width / 2, 50, 0)
    ccDrawCardinalSpline(array, 1, 100)
    kmGLPopMatrix()
  end

  def action_cardinal_spline
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(2)

    array = CCPointArray.create(20)
    array.addControlPoint(ccp(0, 0))
    array.addControlPoint(ccp(@@size.width / 2 - 30, 0))
    array.addControlPoint(ccp(@@size.width / 2 - 30, @@size.height - 80))
    array.addControlPoint(ccp(0, @@size.height - 80))
    array.addControlPoint(ccp(0, 0))

    action = CCCardinalSplineBy.create(3, array, 0)
    reverse = action.reverse()
    seq = CCSequence.createWithTwoActions(action, reverse)

    @tamara.setPosition(ccp(50, 50))
    @tamara.runAction(seq)

    action2 = CCCardinalSplineBy.create(3, array, 1)
    reverse2 = action2.reverse()
    seq2 = CCSequence.createWithTwoActions(action2, reverse2)

    @kathia.setPosition(ccp(@@size.width / 2, 50))
    @kathia.runAction(seq2)

    draw_cardinal_spline(array)

    title_label.setString("CardinalSplineBy / CardinalSplineAt")
    subtitle_label.setString("Cardinal Spline paths.\nTesting different tensions for one array")
    layer
  end

  def draw_catmull_rom(array1, array2)
    kmGLPushMatrix()
    kmGLTranslatef(50, 50, 0)
    ccDrawCatmullRom(array1, 50)
    kmGLPopMatrix()

    ccDrawCatmullRom(array2,50)
  end

  def action_catmull_rom
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(2)

    @tamara.setPosition(ccp(50, 50))

    array = CCPointArray.create(20)
    p "#{__LINE__}:#{array.m_uID}"
    array.addControlPoint(ccp(0, 0))
    array.addControlPoint(ccp(80, 80))
    array.addControlPoint(ccp(@@size.width - 80, 80))
    array.addControlPoint(ccp(@@size.width - 80, @@size.height - 80))
    array.addControlPoint(ccp(80, @@size.height - 80))
    array.addControlPoint(ccp(80, 80))
    array.addControlPoint(ccp(@@size.width / 2, @@size.height / 2))

    action = CCCatmullRomBy.create(3, array)
    reverse = action.reverse()
    seq = CCSequence.createWithTwoActions(action, reverse)

    @tamara.runAction(seq)
    array2 = CCPointArray.create(20)
    p "#{__LINE__}:#{array2.m_uID}"
    array2.addControlPoint(ccp(@@size.width / 2, 30))
    array2.addControlPoint(ccp(@@size.width - 80, 30))
    array2.addControlPoint(ccp(@@size.width - 80, @@size.height - 80))
    array2.addControlPoint(ccp(@@size.width / 2, @@size.height - 80))
    array2.addControlPoint(ccp(@@size.width / 2, 30))

    action2 = CCCatmullRomTo.create(3, array2)
    reverse2 = action2.reverse()
    seq2 = CCSequence.createWithTwoActions(action2, reverse2)

    @kathia.runAction(seq2)
	draw_catmull_rom(array, array2)

	title_label.setString("CatmullRomBy / CatmullRomTo")
    subtitle_label.setString("Catmull Rom spline paths. Testing reverse too")
    layer
  end

  def action_bezier
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(3)

	# sprite 1
    bezier = CC_ccBezierConfig.new
    bezier.controlPoint_1 = ccp(0, @@size.height / 2)
    bezier.controlPoint_2 = ccp(300, - @@size.height / 2)
    bezier.endPosition = ccp(300, 100)

    bezier_forward = CCBezierBy.create(3, bezier)
    bezier_back = bezier_forward.reverse()
    rep = CCRepeatForever.create(CCSequence.createWithTwoActions(bezier_forward, bezier_back))

    # sprite 2
    @tamara.setPosition(ccp(80,160))
    bezier2 = CC_ccBezierConfig.new
    bezier2.controlPoint_1 = ccp(100, @@size.height / 2)
    bezier2.controlPoint_2 = ccp(200, - @@size.height / 2)
    bezier2.endPosition = ccp(240, 160)

    bezier_to1 = CCBezierTo.create(2, bezier2)

    # sprite 3
    @kathia.setPosition(ccp(400,160))
    bezier_to2 = CCBezierTo.create(2, bezier2)

    @grossini.runAction(rep)
    @tamara.runAction(bezier_to1)
    @kathia.runAction(bezier_to2)

    subtitle_label.setString("BezierTo / BezierBy")
    layer
  end

  def action_blink
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(2)

    action1 = CCBlink.create(2, 10)
    action2 = CCBlink.create(2, 5)

    @tamara.runAction(action1)
    @kathia.runAction(action2)

    subtitle_label.setString("Blink")
    layer
  end

  def action_fade
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(2)

    @tamara.setOpacity(0)
    action1 = CCFadeIn.create(1)
    action1_back = action1.reverse()

    action2 = CCFadeOut.create(1)
    action2_back = action2.reverse()

    @tamara.runAction(CCSequence.createWithTwoActions(action1, action1_back))
    @kathia.runAction(CCSequence.createWithTwoActions(action2, action2_back))

    subtitle_label.setString("FadeIn / FadeOut")
    layer
  end

  def action_tint
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(2)

    action1 = CCTintTo.create(2, 255, 0, 255)
    action2 = CCTintBy.create(2, -127, -255, -127)
    action2_back = action2.reverse()

    @tamara.runAction(action1)
    @kathia.runAction(CCSequence.createWithTwoActions(action2, action2_back))

    subtitle_label.setString("TintTo / TintBy")
    layer
  end

  def action_animate
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(3)

    animation = CCAnimation.create
    number = 1
    while number <= 14
      name = sprintf("Images/grossini_dance_%02d.png", number)
      animation.addSpriteFrameWithFileName(name)
      number += 1
    end

    # should last 2.8 seconds. And there are 14 frames.
    animation.setDelayPerUnit(2.8 / 14.0)
    animation.setRestoreOriginalFrame(true)

    action = CCAnimate.create(animation)
    @grossini.runAction(CCSequence.createWithTwoActions(action, action.reverse()))

    cache = CCAnimationCache.sharedAnimationCache()
    cache.addAnimationsWithFile("animations/animations-2.plist")
    animation2 = cache.animationByName("dance_1")

    action2 = CCAnimate.create(animation2)
    @tamara.runAction(CCSequence.createWithTwoActions(action2, action2.reverse()))

    #animation3 = animation2.copy().autorelease()
    # problem
    #tolua.cast(animation3,"CCAnimation").setLoops(4)
    animation3 = animation2.copy()
    animation3.setLoops(4)

    action3 = CCAnimate.create(animation3)
    @kathia.runAction(action3)

    title_label.setString("Animation")
    subtitle_label.setString("Center: Manual animation. Border: using file format animation")
    layer
  end

  def action_sequence
    layer = CCLayer.create
    init_with_layer(layer)

    align_sprites_left(1)

    action = CCSequence.createWithTwoActions(CCMoveBy.create(2, ccp(240,0)),
                                             CCRotateBy.create(2, 540))

    @grossini.runAction(action)

    subtitle_label.setString("Sequence: Move + Rotate")
    layer
  end

  class SequenceLayer < Cocos2d::CCLayer
    include Cocos2d
    include CCTypeHelper

    @@size = CCDirector.sharedDirector.getWinSize

    def action_sequence_callback1
      label = CCLabelTTF.create("callback 1 called", "Marker Felt", 16)
      label.setPosition(ccp(@@size.width / 4, @@size.height / 2))
      addChild(label)
    end
    
    def action_sequence_callback2(sender)
      label = CCLabelTTF.create("callback 2 called", "Marker Felt", 16)
      label.setPosition(ccp(@@size.width / 4 * 2, @@size.height / 2))
      addChild(label)
    end
    
    def action_sequence_callback3(sender)
      label = CCLabelTTF.create("callback 3 called", "Marker Felt", 16)
      label.setPosition(ccp(@@size.width / 4 * 3, @@size.height / 2))
      addChild(label)
    end
  end

  def action_sequence2
    layer = SequenceLayer.new
    init_with_layer(layer)

    align_sprites_left(1)

    @grossini.setVisible(false)
    array = CCArray.create()
    place = CCPlace.create(ccp(200,200))
    array.addObject(CCPlace.create(ccp(200,200)))
    array.addObject(CCShow.create())
    array.addObject(CCMoveBy.create(1, ccp(100,0)))
    array.addObject(CCCallFunc.create(Proc.new {
                                        p self.class.to_s #XXX: don't trust 'self'
                                        layer.action_sequence_callback1}))
    array.addObject(CCCallFuncN.create(Proc.new {|sender|
                                         p self.class.to_s #XXX: don't trust 'self'
                                         layer.action_sequence_callback2(sender)}))
    array.addObject(CCCallFuncN.create(Proc.new {|sender| layer.action_sequence_callback3(sender)}))
    action = CCSequence.create(array)

    @grossini.runAction(action)

    subtitle_label.setString("Sequence of InstantActions")
    layer
  end

  def action_apawn
    layer = CCLayer.create
    init_with_layer(layer)

    align_sprites_left(1)

    action = CCSpawn.createWithTwoActions(CCJumpBy.create(2, ccp(300,0), 50, 4),
                                          CCRotateBy.create(2,  720))

    @grossini.runAction(action)

    subtitle_label.setString("Spawn: Jump + Rotate")
    layer
  end


  def action_reverse
    layer = CCLayer.create
    init_with_layer(layer)

    align_sprites_left(1)

    jump = CCJumpBy.create(2, ccp(300,0), 50, 4)
    action = CCSequence.createWithTwoActions(jump, jump.reverse())

    @grossini.runAction(action)

    subtitle_label.setString("Reverse an action")
    layer
  end

  def action_delaytime
    layer = CCLayer.create
    init_with_layer(layer)

    align_sprites_left(1)

    move = CCMoveBy.create(1, ccp(150,0))
    array = CCArray.create
    array.addObject(move)
    array.addObject(CCDelayTime.create(2))
    array.addObject(move)
    action = CCSequence.create(array)

    @grossini.runAction(action)

    subtitle_label.setString("DelayTime. m + delay + m")
    layer
  end

  def action_repeat
    layer = CCLayer.create
    init_with_layer(layer)

    align_sprites_left(2)

    a1 = CCMoveBy.create(1, ccp(150,0))
    action1 = CCRepeat.create(CCSequence.createWithTwoActions(CCPlace.create(ccp(60,60)), a1), 3)

    a2 = CCMoveBy.create(1, ccp(150,0))
    action2 = CCRepeatForever.create(CCSequence.createWithTwoActions(a2, a1.reverse()))

    @kathia.runAction(action1)
    @tamara.runAction(action2)

    subtitle_label.setString("Repeat / RepeatForever actions")
    layer
  end

  def repeat_forever(sender)
    repeat_action = CCRepeatForever.create(CCRotateBy.create(1.0, 360))
    sender.runAction(repeat_action)
  end

  def action_repeat_forever
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(1)

    that = self
    action = CCSequence.createWithTwoActions(CCDelayTime.create(1),
                                             CCCallFuncN.create(Proc.new {|sender|
                                                                  p self.to_s
                                                                  that.repeat_forever(sender)}))

    @grossini.runAction(action)

    subtitle_label.setString("CallFuncN + RepeatForever")
    layer
  end

  def action_rotate_to_repeat
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(2)

    act1 = CCRotateTo.create(1, 90)
    act2 = CCRotateTo.create(1, 0)
    seq  = CCSequence.createWithTwoActions(act1, act2)
    rep1 = CCRepeatForever.create(seq)
    #rep2 = CCRepeat.create(seq.copy().autorelease(), 10)
    rep2 = CCRepeat.create(seq.copy(), 10)

    @tamara.runAction(rep1)
    @kathia.runAction(rep2)

    subtitle_label.setString("Repeat/RepeatForever + RotateTo")
    layer
  end

  def action_rotate_jerk
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(2)

    seq = CCSequence.createWithTwoActions(CCRotateTo.create(0.5, -20),
                                          CCRotateTo.create(0.5, 20))

    rep1 = CCRepeat.create(seq, 10)

    seq2 = CCSequence.createWithTwoActions(CCRotateTo.create(0.5, -20),
                                           CCRotateTo.create(0.5, 20))

    rep2 = CCRepeatForever.create(seq2)

    @tamara.runAction(rep1)
    @kathia.runAction(rep2)

    subtitle_label.setString("RepeatForever / Repeat + Rotate")
    layer
  end

  @call_func_layer = nil

  def call_fucn_callback1
    label = CCLabelTTF.create("callback 1 called", "Marker Felt", 16)
    label.setPosition(ccp(@@size.width / 4, @@size.height / 2))

    @call_func_layer.addChild(label)
  end

  def call_fucn_callback2(sender)
	label = CCLabelTTF.create("callback 2 called", "Marker Felt", 16)
    label.setPosition(ccp(@@size.width / 4 * 2, @@size.height / 2))

    @call_func_layer.addChild(label)
  end

  def call_fucn_callback3(sender)
    label = CCLabelTTF.create("callback 3 called", "Marker Felt", 16)
    label.setPosition(ccp(@@size.width / 4 * 3, @@size.height / 2))

    @call_func_layer.addChild(label)
  end

  def action_call_func
    @call_func_layer = CCLayer.create
    init_with_layer(@call_func_layer)

    center_sprites(3)

    that = self
    action = CCSequence.createWithTwoActions(CCMoveBy.create(2, ccp(200,0)),
                                             CCCallFunc.create(Proc.new {
                                                                 p self
                                                                 that.call_fucn_callback1}))

    array = CCArray.create()
	array.addObject(CCScaleBy.create(2, 2))
	array.addObject(CCFadeOut.create(2))
	array.addObject(CCCallFuncN.create(Proc.new {|sender|
                                         p self
                                         p sender
                                         that.call_fucn_callback2(sender)}))
    action2 = CCSequence.create(array)

    array2 = CCArray.create()
    array2.addObject(CCRotateBy.create(3 , 360))
    array2.addObject(CCFadeOut.create(2))
    array2.addObject(CCCallFuncN.create(Proc.new {|sender|
                                          p self
                                          p sender
                                          that.call_fucn_callback3(sender)}))
    action3 = CCSequence.create(array2)

    @grossini.runAction(action)
    @tamara.runAction(action2)
    @kathia.runAction(action3)

    subtitle_label.setString("Callbacks. CallFunc and friends")
    @call_func_layer
  end

  def action_call_func_nd
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(1)

    title_label.setString("CallFuncND + auto remove")
    subtitle_label.setString("CallFuncND + removeFromParentAndCleanup. Grossini dissapears in 2s\nNOT SUPPORTED!")
    layer
  end

  def action_reverse_sequence
    layer = CCLayer.create
    init_with_layer(layer)

    align_sprites_left(1)

    move1  = CCMoveBy.create(1, ccp(250,0))
    move2  = CCMoveBy.create(1, ccp(0,50))
    array  = CCArray.create()
    array.addObject(move1)
    array.addObject(move2)
    array.addObject(move1.reverse())
    seq    = CCSequence.create(array)
    action = CCSequence.createWithTwoActions(seq, seq.reverse())

    @grossini.runAction(action)

    subtitle_label.setString("Reverse a sequence")
    layer
  end

  def action_reverse_sequence2
    layer = CCLayer.create
    init_with_layer(layer)

    align_sprites_left(2)

    # Test:
    # Sequence should work both with IntervalAction and InstantActions
    move1  = CCMoveBy.create(1, ccp(250,0))
    move2  = CCMoveBy.create(1, ccp(0,50))
    tog1 = CCToggleVisibility.create()
    tog2 = CCToggleVisibility.create()
    array  = CCArray.createWithCapacity(10)
    array.addObject(move1)
    array.addObject(tog1)
    array.addObject(move2)
    array.addObject(tog2)
    array.addObject(move1.reverse())
    seq = CCSequence.create(array)
    action = CCRepeat.create(CCSequence.createWithTwoActions(seq, seq.reverse()), 3)

    # Test:
    # Also test that the reverse of Hide is Show, and vice-versa
    @kathia.runAction(action)

    move_tamara = CCMoveBy.create(1, ccp(100,0))
    move_tamara2 = CCMoveBy.create(1, ccp(50,0))
    hide = CCHide.create()
    array2 = CCArray.createWithCapacity(10)
    array2.addObject(move_tamara)
    array2.addObject(hide)
    array2.addObject(move_tamara2)
    seq_tamara = CCSequence.create(array2)
    seq_back = seq_tamara.reverse()
    @tamara.runAction(CCSequence.createWithTwoActions(seq_tamara, seq_back))

    subtitle_label.setString("Reverse a sequence2")
    layer
  end

  def action_orbit
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(3)

    orbit1 = CCOrbitCamera.create(2,1, 0, 0, 180, 0, 0)
    action1 = CCSequence.createWithTwoActions(orbit1, orbit1.reverse())

    orbit2 = CCOrbitCamera.create(2,1, 0, 0, 180, -45, 0)
    action2 = CCSequence.createWithTwoActions(orbit2, orbit2.reverse())

    orbit3 = CCOrbitCamera.create(2,1, 0, 0, 180, 90, 0)
    action3 = CCSequence.createWithTwoActions(orbit3, orbit3.reverse())

    @kathia.runAction(CCRepeatForever.create(action1))
    @tamara.runAction(CCRepeatForever.create(action2))
    @grossini.runAction(CCRepeatForever.create(action3))

    move = CCMoveBy.create(3, ccp(100,-100))
    move_back = move.reverse()
    seq = CCSequence.createWithTwoActions(move, move_back)
    rfe = CCRepeatForever.create(seq)

    @kathia.runAction(rfe)
    #@tamara.runAction(rfe.copy().autorelease())
    @tamara.runAction(rfe.copy())
    #@grossini.runAction(rfe.copy().autorelease())
    @grossini.runAction(rfe.copy())

    subtitle_label.setString("OrbitCamera action")
    layer
  end

  def action_follow
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(1)

    @grossini.setPosition(ccp(-200, @@size.height / 2))
    move = CCMoveBy.create(2, ccp(@@size.width * 3, 0))
    move_back = move.reverse()
    seq = CCSequence.createWithTwoActions(move, move_back)
    rep = CCRepeatForever.create(seq)

    @grossini.runAction(rep)

    layer.runAction(CCFollow.create(@grossini, CCRectMake(0, 0, @@size.width * 2 - 100, @@size.height)))

    subtitle_label.setString("Follow action")
    layer
  end

  def action_targeted
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(2)

    jump1 = CCJumpBy.create(2, ccp(0, 0), 100, 3)
    jump2 = CCJumpBy.create(2, ccp(0, 0), 100, 3)
    rot1  = CCRotateBy.create(1, 360)
    rot2  = CCRotateBy.create(1, 360)

    t1 = CCTargetedAction.create(@kathia, jump2)
    t2 = CCTargetedAction.create(@kathia, rot2)

    array = CCArray.createWithCapacity(10)
    array.addObject(jump1)
    array.addObject(t1)
    array.addObject(rot1)
    array.addObject(t2)
    seq = CCSequence.create(array)
    always = CCRepeatForever.create(seq)

    @tamara.runAction(always)

    title_label.setString("ActionTargeted")
    subtitle_label.setString("Action that runs on another target. Useful for sequences")
    layer
  end

  #--------------------------------------
  #-- PauseResumeActions *
  #--   problem: schedule feature is constructing
  #--------------------------------------
  @paused_targets = nil
  @pause_resume_actions_pause_entry = nil
  @pause_resume_actions_resume_entry = nil

  def action_pause(dt)
    cclog("Pausing")

    scheduler = CCDirector.sharedDirector().getScheduler()
    scheduler.unscheduleScriptEntry(@pause_resume_actions_pause_entry)

    director = CCDirector.sharedDirector()
    @paused_targets = director.getActionManager().pauseAllRunningActions()
    @paused_targets.retain()
  end

  def action_resume(dt)
    cclog("Resuming")

    scheduler = CCDirector.sharedDirector().getScheduler()
    scheduler.unscheduleScriptEntry(@pause_resume_actions_resume_entry)

    director = CCDirector.sharedDirector()
    unless @paused_targets.nil?
      # problem. will crash here. Try fixing me!
      director.getActionManager().resumeTargets(@paused_targets)
      @paused_targets.release()
    end
  end

  def pause_resume_actions_on_enter_or_exit(tag)
    scheduler = CCDirector.sharedDirector().getScheduler()
    if tag == kCCNodeOnEnter
      @pause_resume_actions_pause_entry = scheduler.scheduleScriptFunc(Proc.new {|dt| action_pause(dt)}, 3, false)
      @pause_resume_actions_resume_entry = scheduler.scheduleScriptFunc(Proc.new {|dt| action_resume(dt)}, 5, false)
    elsif tag == kCCNodeOnExit || tag == kCCNodeOnCleanup
      scheduler.unscheduleScriptEntry(@pause_resume_actions_pause_entry)
      scheduler.unscheduleScriptEntry(@pause_resume_actions_resume_entry)
    end
  end

  def pause_resume_actions
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(2)

    @tamara.runAction(CCRepeatForever.create(CCRotateBy.create(3, 360)))
    @kathia.runAction(CCRepeatForever.create(CCRotateBy.create(3, 360)))

    layer.registerScriptHandler(Proc.new {|tag| pause_resume_actions_on_enter_or_exit(tag)})

    title_label.setString("PauseResumeActions")
    subtitle_label.setString("All actions pause at 3s and resume at 5s")
    layer
  end


  def issue1305_log(sender)
    cclog("This message SHALL ONLY appear when the sprite is added to the scene, NOT BEFORE")
  end

  def add_sprite(dt)
    scheduler = CCDirector.sharedDirector().getScheduler()
    scheduler.unscheduleScriptEntry(@issue1305_entry)

    @sprite_tmp.setPosition(ccp(250, 250))
    @issue1305_layer.addChild(@sprite_tmp)
  end

  def issue1305_on_enter_or_exit(tag)
    scheduler = CCDirector.sharedDirector().getScheduler()
    if tag == kCCNodeOnEnter
      that = self
      @issue1305_entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.add_sprite(dt)}, 2, false)
    elsif tag == kCCNodeOnExit || tag == kCCNodeOnCleanup
      scheduler.unscheduleScriptEntry(@issue1305_entry)
      @sprite_tmp.stopAllActions if @sprite_tmp
      @sprite_tmp = nil
      @issue1305_entry = nil
      @issue1305_layer = nil
    end
  end

  def action_issue1305
    @sprite_tmp = nil
    @issue1305_entry = nil
    @issue1305_layer = CCLayer.create
    init_with_layer(@issue1305_layer)

    center_sprites(0)

    that = self
    @sprite_tmp = CCSprite.create("Images/grossini.png")
    @sprite_tmp.runAction(CCCallFuncN.create(Proc.new {|sender| that.issue1305_log(sender)}))

    @issue1305_layer.registerScriptHandler(Proc.new {|tag| that.issue1305_on_enter_or_exit(tag)})

    title_label.setString("Issue 1305")
    subtitle_label.setString("In two seconds you should see a message on the console. NOT BEFORE.")
    @issue1305_layer
  end

  def issue1305_2_log1
    cclog("1st block")
  end

  def issue1305_2_log2
    cclog("2nd block")
  end

  def issue1305_2_log3
    cclog("3rd block")
  end

  def issue1305_2_log4
    cclog("4th block")
  end

  def action_issue1305_2
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(0)

    spr = CCSprite.create("Images/grossini.png")
    spr.setPosition(ccp(200,200))
    layer.addChild(spr)

    act1 = CCMoveBy.create(2 ,ccp(0, 100))
    act2 = CCCallFunc.create(Proc.new {issue1305_2_log1})
    act3 = CCMoveBy.create(2, ccp(0, -100))
    act4 = CCCallFunc.create(Proc.new {issue1305_2_log2})
    act5 = CCMoveBy.create(2, ccp(100, -100))
    act6 = CCCallFunc.create(Proc.new {issue1305_2_log3})
    act7 = CCMoveBy.create(2, ccp(-100, 0))
    act8 = CCCallFunc.create(Proc.new {issue1305_2_log4})

    array = CCArray.create()
    array.addObject(act1)
    array.addObject(act2)
    array.addObject(act3)
    array.addObject(act4)
    array.addObject(act5)
    array.addObject(act6)
    array.addObject(act7)
    array.addObject(act8)
    actF = CCSequence.create(array)

    CCDirector.sharedDirector().getActionManager().addAction(actF ,spr, false)

    title_label.setString("Issue 1305 #2")
    subtitle_label.setString("See console. You should only see one message for each block")
    layer
  end

  def action_issue1288
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(0)

    spr = CCSprite.create("Images/grossini.png")
    spr.setPosition(ccp(100, 100))
    layer.addChild(spr)

    act1 = CCMoveBy.create(0.5, ccp(100, 0))
    act2 = act1.reverse()
    act3 = CCSequence.createWithTwoActions(act1, act2)
    act4 = CCRepeat.create(act3, 2)

    spr.runAction(act4)

    title_label.setString("Issue 1288")
    subtitle_label.setString("Sprite should end at the position where it started.")
    layer
  end

  def action_issue1288_2
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(0)

    spr = CCSprite.create("Images/grossini.png")
    spr.setPosition(ccp(100, 100))
    layer.addChild(spr)

    act1 = CCMoveBy.create(0.5, ccp(100, 0))
    spr.runAction(CCRepeat.create(act1, 1))

    title_label.setString("Issue 1288 #2")
    subtitle_label.setString("Sprite should move 100 pixels, and stay there")
    layer
  end

  def log_spr_rotation(sender)
	cclog("#{sender.getRotation()}")
  end

  def action_issue1327
    layer = CCLayer.create
    init_with_layer(layer)

    center_sprites(0)

    spr = CCSprite.create("Images/grossini.png")
    spr.setPosition(ccp(100, 100))
    layer.addChild(spr)

    that = self
    act1 = CCCallFuncN.create(Proc.new {|sender|
                                p sender
                                that.log_spr_rotation(sender)})
    act2 = CCRotateBy.create(0.25, 45)
    act3 = CCCallFuncN.create(Proc.new {|sender| that.log_spr_rotation(sender)})
    act4 = CCRotateBy.create(0.25, 45)
    act5 = CCCallFuncN.create(Proc.new {|sender| that.log_spr_rotation(sender)})
    act6 = CCRotateBy.create(0.25, 45)
    act7 = CCCallFuncN.create(Proc.new {|sender| that.log_spr_rotation(sender)})
    act8 = CCRotateBy.create(0.25, 45)
    act9 = CCCallFuncN.create(Proc.new {|sender| that.log_spr_rotation(sender)})

    array = CCArray.create()
    array.addObject(act1)
    array.addObject(act2)
    array.addObject(act3)
    array.addObject(act4)
    array.addObject(act5)
    array.addObject(act6)
    array.addObject(act7)
    array.addObject(act8)
    array.addObject(act9)
    spr.runAction(CCSequence.create(array))

    title_label.setString("Issue 1327")
    subtitle_label.setString("See console: You should see: 0, 45, 90, 135, 180")
    layer
  end

  def create
    new_scene
  end
end
