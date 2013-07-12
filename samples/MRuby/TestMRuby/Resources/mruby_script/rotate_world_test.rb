require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class RotateWorldTest < TestBase
  extend TestBaseExt
  self.supported = true

  def create_sprite_layer
    layer = CCLayer.create

    x = @@size.width
    y = @@size.height

    sprite = CCSprite.create($s_pPathGrossini)
    spriteSister1 = CCSprite.create($s_pPathSister1)
    spriteSister2 = CCSprite.create($s_pPathSister2)

    sprite.setScale(1.5)
    spriteSister1.setScale(1.5)
    spriteSister2.setScale(1.5)

    sprite.setPosition(CCPointMake(x / 2, y / 2))
    spriteSister1.setPosition(CCPointMake(40, y / 2))
    spriteSister2.setPosition(CCPointMake(x - 40, y / 2))

    layer.addChild(sprite)
    layer.addChild(spriteSister1)
    layer.addChild(spriteSister2)

    rot = CCRotateBy.create(16, -3600)
    sprite.runAction(rot)

    jump1 = CCJumpBy.create(4, CCPointMake(-400, 0), 100, 4)
    jump2 = jump1.reverse()

    rot1 = CCRotateBy.create(4, 360 * 2)
    rot2 = rot1.reverse()

    jump3 = CCJumpBy.create(4, CCPointMake(-400, 0), 100, 4)
    jump4 = jump3.reverse()
    rot3 = CCRotateBy.create(4, 360 * 2)
    rot4 = rot3.reverse()

    spriteSister1.runAction(CCRepeat.create(CCSequence.createWithTwoActions(jump2, jump1), 5))
    spriteSister2.runAction(CCRepeat.create(CCSequence.createWithTwoActions(jump3, jump4), 5))

    spriteSister1.runAction(CCRepeat.create(CCSequence.createWithTwoActions(rot1, rot2), 5))
    spriteSister2.runAction(CCRepeat.create(CCSequence.createWithTwoActions(rot4, rot3), 5))
    layer
  end

  def create_test_layer
    layer = CCLayer.create

    x = @@size.width
    y = @@size.height

    label = CCLabelTTF.create("cocos2d", "Tahoma", 64)
    label.setPosition(ccp(x / 2, y / 2))
    layer.addChild(label)
    layer
  end

  def create_rotate_world_layer
    layer = CCLayer.create

    x = @@size.width
    y = @@size.height

    blue =  CCLayerColor.create(ccc4(0,0,255,255))
    red =   CCLayerColor.create(ccc4(255,0,0,255))
    green = CCLayerColor.create(ccc4(0,255,0,255))
    white = CCLayerColor.create(ccc4(255,255,255,255))

    blue.setScale(0.5)
    blue.setPosition(CCPointMake(- x / 4, - y / 4))
    blue.addChild(create_sprite_layer)

    red.setScale(0.5)
    red.setPosition(CCPointMake(x / 4, - y / 4))

    green.setScale(0.5)
    green.setPosition(CCPointMake(- x / 4, y / 4))
    green.addChild(create_test_layer)

    white.setScale(0.5)
    white.setPosition(CCPointMake(x / 4, y / 4))
    white.ignoreAnchorPointForPosition(false)
    white.setPosition(CCPointMake(x / 4 * 3, y / 4 * 3))

    layer.addChild(blue, -1)
    layer.addChild(white)
    layer.addChild(green)
    layer.addChild(red)

    rot = CCRotateBy.create(8, 720)
    rot1 = rot.copy
    rot2 = rot.copy
    rot3 = rot.copy

    blue.runAction(rot)
    red.runAction(rot1)
    green.runAction(rot2)
    white.runAction(rot3)

    layer.runAction(CCRotateBy.create(4, -360))
    layer
  end


  def create
    p self.class.to_s
    scene = CCScene.create
    layer = create_rotate_world_layer
    layer.addChild(MainMenu.create_back_menu_item)
    scene.addChild(layer)
    scene
  end
end

