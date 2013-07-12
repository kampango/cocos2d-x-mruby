require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class TranScene < TestBase
  extend TestBaseExt
  self.supported = true

  @@win_size = CCDirector.sharedDirector.getWinSize
  def win_size
    @@win_size
  end

  def initialize(delegate, trans_name, scene_no)
    super()
    @trans_name = trans_name
    @scene_no = scene_no
    @bg_path = if scene_no == 0 then $s_back1 else $s_back2 end
    @delegate = delegate
  end

  def delegate
    @delegate
  end
  def delegate=(delegate)
    @delegate = delegate
  end

  def next_action
    @delegate.next_action
  end

  def back_action
    @delegate.back_action
  end

  def restart_action
    @delegate.restart_action
  end

  def init_with_layer(layer)
    super(layer)

    if @menu.nil?
      @menu = create_menu
      if @menu
        layer.addChild(@menu, 1)
      end
    end

    s = win_size
    x = s.width
    y = s.height

    bg = CCSprite.create(@bg_path)
    bg.setPosition(CCPointMake(x / 2, y / 2))
    layer.addChild(bg, -1)

    subtitle_label.setFontSize(32)
    subtitle_label.setString(@trans_name)
    subtitle_label.setColor(ccc3(235, 32, 32))
    subtitle_label.setPosition(CCPointMake(x / 2, y - 100))

    label = CCLabelTTF.create("SCENE #{@scene_no + 1}", "Marker Felt", 38)
    label.setColor(ccc3(16, 16, 255))
    label.setPosition(CCPointMake(x / 2, y / 2))
    layer.addChild(label)
  end

  def create
    scene = CCScene.create
    layer = CCLayer.create
    init_with_layer(layer)
    scene.addChild(layer)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end

class TransitionsTest < TestBase
  extend TestBaseExt
  self.supported = true

  TRANSITION_DURATION = 1.2

  class TransitionPageForward < CCTransitionPageTurn
    def self.create(t, scene)
      Cocos2d::CCDirector.sharedDirector().setDepthTest(true)
      super(t, scene, false)
    end
  end

  class TransitionPageBackward < CCTransitionPageTurn
    def self.create(t, scene)
      Cocos2d::CCDirector.sharedDirector().setDepthTest(true)
      super(t, scene, true)
    end
  end

  class FadeWhiteTransition < CCTransitionFade
    extend CCTypeHelper
    def self.create(t, scene)
      super(t, scene, Cocos2d::ccc3(255, 255, 255))
    end
  end

  class FlipXLeftOver < CCTransitionFlipX
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationLeftOver)
    end
  end

  class FlipXRightOver < CCTransitionFlipX
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationRightOver)
    end
  end

  class FlipYUpOver < CCTransitionFlipY
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationUpOver)
    end
  end

  class FlipYDownOver < CCTransitionFlipY
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationDownOver)
    end
  end

  class FlipAngularLeftOver < CCTransitionFlipAngular
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationLeftOver)
    end
  end

  class FlipAngularRightOver < CCTransitionFlipAngular
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationRightOver)
    end
  end

  class ZoomFlipXLeftOver < CCTransitionZoomFlipX
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationLeftOver)
    end
  end

  class ZoomFlipXRightOver < CCTransitionZoomFlipX
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationRightOver)
    end
  end

  class ZoomFlipYUpOver < CCTransitionZoomFlipY
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationUpOver)
    end
  end

  class ZoomFlipYDownOver < CCTransitionZoomFlipY
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationDownOver)
    end
  end

  class ZoomFlipAngularLeftOver < CCTransitionZoomFlipAngular
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationLeftOver)
    end
  end

  class ZoomFlipAngularRightOver < CCTransitionZoomFlipAngular
    def self.create(t, scene)
      super(t, scene, Cocos2d::kCCTransitionOrientationRightOver)
    end
  end


  @@trans_classes =
    [CCTransitionJumpZoom,
     CCTransitionProgressRadialCCW,
     CCTransitionProgressRadialCW,
     CCTransitionProgressHorizontal,
     CCTransitionProgressVertical,
     CCTransitionProgressInOut,
     CCTransitionProgressOutIn,
     CCTransitionCrossFade,
     TransitionPageForward,
     TransitionPageBackward,
     CCTransitionFadeTR,
     CCTransitionFadeBL,
     CCTransitionFadeUp,
     CCTransitionFadeDown,
     CCTransitionTurnOffTiles,
     CCTransitionSplitRows,
     CCTransitionSplitCols,
     CCTransitionFade,
     FadeWhiteTransition,
     FlipXLeftOver,
     FlipXRightOver,
     FlipYUpOver,
     FlipYDownOver,
     FlipAngularLeftOver,
     FlipAngularRightOver,
     ZoomFlipXLeftOver,
     ZoomFlipXRightOver,
     ZoomFlipYUpOver,
     ZoomFlipYDownOver,
     ZoomFlipAngularLeftOver,
     ZoomFlipAngularRightOver,
     CCTransitionShrinkGrow,
     CCTransitionRotoZoom,
     CCTransitionMoveInL,
     CCTransitionMoveInR,
     CCTransitionMoveInT,
     CCTransitionMoveInB,
     CCTransitionSlideInL,
     CCTransitionSlideInR,
     CCTransitionSlideInT,
     CCTransitionSlideInB,
    ]

  def initialize
    super()

    @@trans_classes.each do |klass|
      register_create_function(self, :create_transition_entry)
    end
  end

  def switch_scene_type_no
    @cur_scene_no += 1
    @cur_scene_no %= 2
  end

  def next_action
    switch_scene_type_no
    super()
  end

  def back_action
    switch_scene_type_no
    super()
  end

  def new_scene
    klass = @@trans_classes[index]
    @cur_tran_scene.delegate = nil if @cur_trans_scene
    @cur_tran_scene = TranScene.new(self, klass.to_s, @cur_scene_no)
    scene = @cur_tran_scene.create
    create_transition(index, TRANSITION_DURATION, scene)
  end

  def create_transition(index, t, scene)
    CCDirector.sharedDirector.setDepthTest(false)

    if @first_enter
      @first_enter = false
      return scene
    end

    klass = @@trans_classes[index]
    scene = klass.create(t, scene)
    scene
  end

  def create
    p self.class
    @cur_scene_no = 0
    @first_enter = true
    new_scene
  end
end
