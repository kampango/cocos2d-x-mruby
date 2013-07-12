require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class EffectsTest < TestBase
  extend TestBaseExt
  self.supported = true

  @@size = CCDirector.sharedDirector.getWinSize

  @@effects_list =
    [{:name => "Shaky3D", :sym => :shaky3d_demo},
     {:name => "Waves3D", :sym => :waves_3d_demo},
     {:name => "FlipX3D", :sym => :flip_x3d_demo},
     {:name => "FlipY3D", :sym => :flip_y3d_demo},
     {:name => "Lens3D",  :sym => :lens_3d_demo},
     {:name => "Ripple3D",:sym => :ripple_3d_demo},
     {:name => "Liquid",  :sym => :liquid_demo},
     {:name => "Waves",   :sym => :waves_demo},
     {:name => "Twirl",   :sym => :twirl_demo},
     {:name => "ShakyTiles3D",:sym => :shaky_tiles_3d_demo},
     {:name => "ShatteredTiles3D", :sym => :shattered_tiles_3d_demo},
     {:name => "ShuffleTiles",   :sym => :shuffle_tiles_demo},
     {:name => "FadeOutTRTiles", :sym => :fade_out_tr_tiles_demo},
     {:name => "FadeOutBLTiles", :sym => :fade_out_bl_tiles_demo},
     {:name => "FadeOutUpTiles", :sym => :fade_out_up_tiles_demo},
     {:name => "FadeOutDownTiles", :sym => :fade_out_down_tiles_demo},
     {:name => "TurnOffTiles", :sym => :turn_off_tiles_demo},
     {:name => "WavesTiles3D", :sym => :waves_tiles_3d_demo},
     {:name => "JumpTiles3D",  :sym => :jump_tiles_3d_demo},
     {:name => "SplitRows", :sym => :split_rows_demo},
     {:name => "SplitCols", :sym => :split_cols_demo},
     {:name => "PageTurn3D",:sym => :page_turn_3d_demo}
    ]

  def initialize
    super()
    @@effects_list.each do
      register_create_function(self, :create_effects_test_layer)
    end
  end

  def kTagBackground
    0
  end

  def kTagLabel
    1
  end

  def shaky3d_demo(t)
    CCShaky3D.create(t, CCSizeMake(15, 10), 5, false)
  end

  def waves_3d_demo(t)
    CCWaves3D.create(t, CCSizeMake(15,10), 5, 40)
  end

  def flip_x3d_demo(t)
    flipx  = CCFlipX3D.create(t)
    flipx_back = flipx.reverse()
    delay = CCDelayTime.create(2)

    array = CCArray.create()
    array.addObject(flipx)
    array.addObject(flipx_back)
    array.addObject(delay)
    CCSequence.create(array)
  end

  def flip_y3d_demo(t)
    flipy  = CCFlipY3D.create(t)
    flipy_back = flipy.reverse()
    delay = CCDelayTime.create(2)

    array = CCArray.create()
    array.addObject(flipy)
    array.addObject(flipy_back)
    array.addObject(delay)
    CCSequence.create(array)
  end

  def lens_3d_demo(t)
    CCLens3D.create(t, CCSizeMake(15,10), ccp(@@size.width/2,@@size.height/2), 240)
  end

  def ripple_3d_demo(t)
    CCRipple3D.create(t, CCSizeMake(32,24), ccp(@@size.width/2,@@size.height/2), 240, 4, 160)
  end

  def liquid_demo(t)
    CCLiquid.create(t, CCSizeMake(16,12), 4, 20)
  end

  def waves_demo(t)
    CCWaves.create(t, CCSizeMake(16,12), 4, 20, true, true)
  end

  def twirl_demo(t)
    CCTwirl.create(t, CCSizeMake(12,8), ccp(@@size.width/2, @@size.height/2), 1, 2.5)
  end

  def shaky_tiles_3d_demo(t)
    CCShakyTiles3D.create(t, CCSizeMake(16,12), 5, false)
  end

  def shattered_tiles_3d_demo(t)
    CCShatteredTiles3D.create(t, CCSizeMake(16,12), 5, false)
  end

  def shuffle_tiles_demo(t)
    shuffle = CCShuffleTiles.create(t, CCSizeMake(16,12), 25)
    shuffle_back = shuffle.reverse()
    delay = CCDelayTime.create(2)

    array = CCArray.create()
    array.addObject(shuffle)
    array.addObject(shuffle_back)
    array.addObject(delay)
    CCSequence.create(array)
  end

  def fade_out_tr_tiles_demo(t)
    fadeout = CCFadeOutTRTiles.create(t, CCSizeMake(16,12))
    back = fadeout.reverse()
    delay = CCDelayTime.create(0.5)

    array = CCArray.create()
    array.addObject(fadeout)
    array.addObject(back)
    array.addObject(delay)
    CCSequence.create(array)
  end

  def fade_out_bl_tiles_demo(t)
    fadeout = CCFadeOutBLTiles.create(t, CCSizeMake(16,12))
    back = fadeout.reverse()
    delay = CCDelayTime.create(0.5)

    array = CCArray.create()
    array.addObject(fadeout)
    array.addObject(back)
    array.addObject(delay)
    CCSequence.create(array)
  end

  def fade_out_up_tiles_demo(t)
    fadeout = CCFadeOutUpTiles.create(t, CCSizeMake(16,12))
    back = fadeout.reverse()
    delay = CCDelayTime.create(0.5)

    array = CCArray.create()
    array.addObject(fadeout)
    array.addObject(back)
    array.addObject(delay)
    CCSequence.create(array)
  end

  def fade_out_down_tiles_demo(t)
    fadeout = CCFadeOutDownTiles.create(t, CCSizeMake(16,12))
    back = fadeout.reverse()
    delay = CCDelayTime.create(0.5)

    array = CCArray.create()
    array.addObject(fadeout)
    array.addObject(back)
    array.addObject(delay)
    CCSequence.create(array)
  end

  def turn_off_tiles_demo(t)
    fadeout = CCTurnOffTiles.create(t, CCSizeMake(48,32), 25)
    back = fadeout.reverse()
    delay = CCDelayTime.create(0.5)

    array = CCArray.create()
    array.addObject(fadeout)
    array.addObject(back)
    array.addObject(delay)
    CCSequence.create(array)
  end

  def waves_tiles_3d_demo(t)
    CCWavesTiles3D.create(t, CCSizeMake(15,10), 4, 120)
  end

  def jump_tiles_3d_demo(t)
    CCJumpTiles3D.create(t, CCSizeMake(15,10), 2, 30)
  end

  def split_rows_demo(t)
    CCSplitRows.create(t, 9)
  end

  def split_cols_demo(t)
    CCSplitCols.create(t, 9)
  end

  def page_turn_3d_demo(t)
    CCDirector.sharedDirector().setDepthTest(true)
    CCPageTurn3D.create(t, CCSizeMake(15,10))
  end

  def create_effect(idx, t)
    info = @@effects_list[idx]
    self.__send__(info[:sym], t)
  end

  def create_effects_test_layer
    test_layer = CCLayerColor.create(ccc4(32,128,32,255))
    init_with_layer(test_layer)

    x = @@size.width
    y = @@size.height

    node = CCNode.create
    effect = create_effect(index, 3)
    node.runAction(effect)
    test_layer.addChild(node, 0, kTagBackground)

    bg = CCSprite.create($s_back3)
    node.addChild(bg, 0)
    bg.setPosition(ccp(@@size.width / 2, @@size.height / 2))

    grossini = CCSprite.create($s_pPathSister2)
    node.addChild(grossini, 1)
    grossini.setPosition( CCPointMake(x / 3, y / 2) )
    sc = CCScaleBy.create(2, 5)
    sc_back = sc.reverse()
    grossini.runAction(CCRepeatForever.create(CCSequence.createWithTwoActions(sc, sc_back)))

    tamara = CCSprite.create($s_pPathSister1)
    node.addChild(tamara, 1)
    tamara.setPosition(CCPointMake(2 * x / 3, y / 2))
    sc2 = CCScaleBy.create(2, 5)
    sc2_back = sc2.reverse()
    tamara.runAction(CCRepeatForever.create(CCSequence.createWithTwoActions(sc2, sc2_back)))

    title_label.setString(@@effects_list[index][:name])
    title_label.setFontSize(32)
    title_label.setPosition(ccp(x / 2, y - 80))
    title_label.setTag(kTagLabel)
    test_layer
  end

  def create
    p self.class.to_s
    @index = 0
    new_scene
  end
end
