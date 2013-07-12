require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class ClickAndMoveTest < TestBase
  extend TestBaseExt
  self.supported = true

  @@size = CCDirector.sharedDirector.getWinSize

  def initialize
    super()
    @layer = nil
  end

  def kTagSprite
    1
  end

  def on_touch_ended(x, y)
    s = @layer.getChildByTag(kTagSprite)
    s.stopAllActions()
    s.runAction(CCMoveTo.create(1, CCPointMake(x, y)))
    pos = s.getPosition()
    o = x - pos.x
    a = y - pos.y
    at = Math.atan(o / a) / Math.PI * 180.0

    if a < 0
      at = if o < 0 then 180 + at.abs() else 180 - at.abs() end
    end
    s.runAction(CCRotateTo.create(1, at))
  end

  def on_touch(event_type, x, y)
    case event_type
    when CCTOUCHBEGAN
      return true
    when CCTOUCHENDED
      return on_touch_ended(x, y)
    end
    false
  end

  def init_with_layer(layer)
    sprite = CCSprite.create($s_pPathGrossini)

    bgLayer = CCLayerColor.create(ccc4(255,255,0,255))
    layer.addChild(bgLayer, -1)

    layer.addChild(sprite, 0, kTagSprite)
    sprite.setPosition(CCPointMake(20,150))

    sprite.runAction(CCJumpTo.create(4, CCPointMake(300,48), 100, 4))

    bgLayer.runAction(CCRepeatForever.create(CCSequence.createWithTwoActions(CCFadeIn.create(1),
                                                                             CCFadeOut.create(1))))

    layer.setTouchEnabled(true)
    that = self
    layer.registerScriptTouchHandler(Proc.new {|event_type, x, y| that.on_touch(event_type, x, y)}, false, -1, false)
    layer
  end

  def create
    p self.class.to_s
    scene = CCScene.create
    @layer = CCLayer.create

    init_with_layer(@layer)

    scene.addChild(MainMenu.create_back_menu_item)
    scene.addChild(@layer)
    scene
  end
end
