# -*- coding: utf-8 -*-
require "mruby_script/test_base"
require "mruby_script/test_resource"
require "mruby_script/visible_rect"

class LabelTest < TestBase
  extend TestBaseExt
  self.supported = true

  module LabelTestConstant
    def kTagTileMap
      1
    end
    def kTagSpriteManager
      1
    end
    def kTagAnimation1
      1
    end
    def kTagBitmapAtlas1
      1
    end
    def kTagBitmapAtlas2
      2
    end
    def kTagBitmapAtlas3
      3
    end
    def kTagSprite1
      0
    end
    def kTagSprite2
      1
    end
    def kTagSprite3
      2
    end
    def kTagSprite4
      3
    end
    def kTagSprite5
      4
    end
    def kTagSprite6
      5
    end
    def kTagSprite7
      6
    end
    def kTagSprite8
      7
    end
  end

  class LabelTestBase < TestBase
    include LabelTestConstant

    def initialize
      super
      @time = 0
      @scheduler = CCDirector.sharedDirector().getScheduler()
    end

    def init_with_layer(layer)
      super(layer)
      @layer = layer
      @layer
    end

    def self.create
      layer = CCLayer.create()
      self.new.init_with_layer(layer)
      layer
    end
  end

  class LabelAtlasTest < LabelTestBase
    def step(dt)
      @time += dt
      string = sprintf("%2.2f Test", @time)

      label1 = @layer.getChildByTag(kTagSprite1)
      label1.setString(string)

      label2 = @layer.getChildByTag(kTagSprite2)
      string = sprintf("%d", @time)
      label2.setString(string)
    end

    def onNodeEvent(tag)
      if tag == kCCNodeOnExit
        @layer.unscheduleUpdate()
      end
    end

    def init_with_layer(layer)
      super(layer)
      label1 = CCLabelAtlas.create("123 Test", "fonts/tuffy_bold_italic-charmap.plist")
      layer.addChild(label1, 0, kTagSprite1)
      label1.setPosition( ccp(10,100) )
      label1.setOpacity( 200 )

      label2 = CCLabelAtlas.create("0123456789", "fonts/tuffy_bold_italic-charmap.plist")
      layer.addChild(label2, 0, kTagSprite2)
      label2.setPosition( ccp(10,200) )
      label2.setOpacity( 32 )

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.onNodeEvent(tag)})
      layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.step(dt)}, 0)

      @title_label.setString("LabelAtlas")
      @subtitle_label.setString("Updating label should be fast")
      layer
    end
  end

  class LabelAtlasColorTest < LabelAtlasTest

    def actionFinishCallback
      cclog("Action finished")
    end

    def init_with_layer(layer)
      super(layer)

      label1 = layer.getChildByTag(kTagSprite1)
      label2 = layer.getChildByTag(kTagSprite2)

      label1.setOpacity( 200 )

      label2.setOpacity( 200 )
      label2.setColor(ccc3(255, 0, 0))

      fade = CCFadeOut.create(1.0)
      fade_in = fade.reverse()

      cb = CCCallFunc.create(self, :actionFinishCallback)
      actionArr = CCArray.create()
      actionArr << fade
      actionArr << fade_in
      actionArr << cb

      seq = CCSequence.create(actionArr)
      repeatAction = CCRepeatForever.create( seq )
      label2.runAction( repeatAction )

      @title_label.setString("LabelAtlas")
      @subtitle_label.setString("Opacity + Color should work at the same time")
      layer
    end
  end

####################################################################
#
# Atlas3
#
# Use any of these editors to generate BMFonts:
# 	 http://glyphdesigner.71squared.com/ (Commercial, Mac OS X)
# 	 http://www.n4te.com/hiero/hiero.jnlp (Free, Java)
# 	 http://slick.cokeandcode.com/demos/hiero.jnlp (Free, Java)
# 	 http://www.angelcode.com/products/bmfont/ (Free, Windows only)
#
####################################################################

  class Atlas3 < LabelTestBase
    def init_with_layer(layer)
      super(layer)

      col = CCLayerColor.create( ccc4(128,128,128,255) )
      layer.addChild(col, -10)

      label1 = CCLabelBMFont.create("Test",  "fonts/bitmapFontTest2.fnt")

      # testing anchors
      label1.setAnchorPoint( ccp(0,0) )
      layer.addChild(label1, 0, kTagBitmapAtlas1)

      fade = CCFadeOut.create(1.0)
      fade_in = fade.reverse()

      actionArr = CCArray.create()
      actionArr.addObject(fade)
      actionArr.addObject(fade_in)
      seq = CCSequence.create(actionArr)
      repeatAction = CCRepeatForever.create(seq)
      label1.runAction(repeatAction)

      # VERY IMPORTANT
      #color and opacity work OK because bitmapFontAltas2 loads a BMP image (not a PNG image)
      #If you want to use both opacity and color, it is recommended to use NON premultiplied images like BMP images
      #Of course, you can also tell XCode not to compress PNG images, but I think it doesn't work as expected
      label2 = CCLabelBMFont.create("Test", "fonts/bitmapFontTest2.fnt")

      # testing anchors
      label2.setAnchorPoint( ccp(0.5, 0.5) )
      label2.setColor(ccc3(255, 0, 0 ))
      layer.addChild(label2, 0, kTagBitmapAtlas2)

      label2.runAction(repeatAction.copy())

      label3 = CCLabelBMFont.create("Test", "fonts/bitmapFontTest2.fnt")
      # testing anchors
      label3.setAnchorPoint( ccp(1,1) )
      layer.addChild(label3, 0, kTagBitmapAtlas3)

      label1.setPosition( VisibleRect.leftBottom() )
      label2.setPosition( VisibleRect.center() )
      label3.setPosition( VisibleRect.rightTop() )

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.onNodeEvent(tag)})
      layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.step(dt)}, 0)

      @title_label.setString( "CCLabelBMFont" )
      @subtitle_label.setString( "Testing alignment. Testing opacity + tint" )
      layer
    end

    def step(dt)
      @time += dt
      string = sprintf("%2.2f Test j", @time)

      label1 = @layer.getChildByTag(kTagBitmapAtlas1)
      label1.setString(string)

      label2 = @layer.getChildByTag(kTagBitmapAtlas2)
      label2.setString(string)

      label3 = @layer.getChildByTag(kTagBitmapAtlas3)
      label3.setString(string)
    end

    def onNodeEvent(tag)
      if tag == kCCNodeOnExit
        @layer.unscheduleUpdate()
      end
    end
  end

####################################################################
#
# Atlas4
#
# Use any of these editors to generate BMFonts:
#     http://glyphdesigner.71squared.com/ (Commercial, Mac OS X)
#     http://www.n4te.com/hiero/hiero.jnlp (Free, Java)
#     http://slick.cokeandcode.com/demos/hiero.jnlp (Free, Java)
#     http://www.angelcode.com/products/bmfont/ (Free, Windows only)
#
####################################################################
  class Atlas4 < LabelTestBase
    def initialize
      super
      @stepEntry = nil
    end

    def onNodeEvent(tag)
      if tag == kCCNodeOnEnter
        that = self
        @stepEntry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.step(dt)}, 0.1, false)
      elsif tag == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@stepEntry)
      end
    end

    def init_with_layer(layer)
      super(layer)

      # Label
      label = CCLabelBMFont.create("Bitmap Font Atlas", "fonts/bitmapFontTest.fnt")
      layer.addChild(label)

      s = @@size

      label.setPosition( ccp(s.width/2, s.height/2) )
      label.setAnchorPoint( ccp(0.5, 0.5) )


      BChar = label.getChildByTag(0)
      FChar = label.getChildByTag(7)
      AChar = label.getChildByTag(12)


      rotate = CCRotateBy.create(2, 360)
      rot_4ever = CCRepeatForever.create(rotate)

      scale = CCScaleBy.create(2, 1.5)
      scale_back = scale.reverse()
      action_arr = CCArray.create()
      action_arr.addObject(scale)
      action_arr.addObject(scale_back)

      scale_seq = CCSequence.create(action_arr)
      scale_4ever = CCRepeatForever.create(scale_seq)

      jump = CCJumpBy.create(0.5, ccp(0, 0), 60, 1)
      jump_4ever = CCRepeatForever.create(jump)

      fade_out = CCFadeOut.create(1)
      fade_in = CCFadeIn.create(1)

      action_arr2 = CCArray.create()
      action_arr2.addObject(fade_out)
      action_arr2.addObject(fade_in)
      seq = CCSequence.create(action_arr2)
      fade_4ever = CCRepeatForever.create(seq)

      BChar.runAction(rot_4ever)
      BChar.runAction(scale_4ever)
      FChar.runAction(jump_4ever)
      AChar.runAction(fade_4ever)


      # Bottom Label
      label2 = CCLabelBMFont.create("00.0", "fonts/bitmapFontTest.fnt")
      layer.addChild(label2, 0, kTagBitmapAtlas2)
      label2.setPosition( ccp(s.width/2.0, 80) )

      lastChar = label2.getChildByTag(3)
      lastChar.runAction(rot_4ever.copy())

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.onNodeEvent(tag)})
      layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.step(dt)}, 0)

      @title_label.setString("CCLabelBMFont")
      @subtitle_label.setString( "Using fonts as CCSprite objects. Some characters should rotate.")
      layer
    end

    def draw
      # never called!
      s = @@size
      ccDrawLine( ccp(0, s.height/2), ccp(s.width, s.height/2) )
      ccDrawLine( ccp(s.width/2, 0), ccp(s.width/2, s.height) )
    end

    def step(dt)
      @time += dt
      string = sprintf("%04.1f", @time)
      label1 = @layer.getChildByTag(kTagBitmapAtlas2)
      label1.setString(string)
    end
  end


####################################################################
#
# Atlas5
#
# Use any of these editors to generate BMFonts:
#	   http://glyphdesigner.71squared.com/ (Commercial, Mac OS X)
#	   http://www.n4te.com/hiero/hiero.jnlp (Free, Java)
#	   http://slick.cokeandcode.com/demos/hiero.jnlp (Free, Java)
#	   http://www.angelcode.com/products/bmfont/ (Free, Windows only)
#
####################################################################

  class Atlas5 < LabelTestBase
    def init_with_layer(layer)
      super(layer)

      label = CCLabelBMFont.create("abcdefg", "fonts/bitmapFontTest4.fnt")
      layer.addChild(label)

      s = @@size

      label.setPosition( ccp(s.width/2, s.height/2) )
      label.setAnchorPoint( ccp(0.5, 0.5) )

      @title_label.setString("CCLabelBMFont")
      @subtitle_label.setString("Testing padding")
      layer
    end
  end

####################################################################
#
# Atlas6
#
# Use any of these editors to generate BMFonts:
#	   http://glyphdesigner.71squared.com/ (Commercial, Mac OS X)
#	   http://www.n4te.com/hiero/hiero.jnlp (Free, Java)
#	   http://slick.cokeandcode.com/demos/hiero.jnlp (Free, Java)
#	   http://www.angelcode.com/products/bmfont/ (Free, Windows only)
#
####################################################################
  class Atlas6 < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
      label = CCLabelBMFont.create("FaFeFiFoFu", "fonts/bitmapFontTest5.fnt")
      layer.addChild(label)
      label.setPosition( ccp(s.width/2, s.height/2+50) )
      label.setAnchorPoint( ccp(0.5, 0.5) )

      label = CCLabelBMFont.create("fafefifofu", "fonts/bitmapFontTest5.fnt")
      layer.addChild(label)
      label.setPosition( ccp(s.width/2, s.height/2) )
      label.setAnchorPoint( ccp(0.5, 0.5) )

      label = CCLabelBMFont.create("aeiou", "fonts/bitmapFontTest5.fnt")
      layer.addChild(label)
      label.setPosition( ccp(s.width/2, s.height/2-50) )
      label.setAnchorPoint( ccp(0.5, 0.5) )

      @title_label.setString("CCLabelBMFont")
      @subtitle_label.setString("Rendering should be OK. Testing offset")
      layer
    end
  end

####################################################################
#
# AtlasBitmapColor
#
# Use any of these editors to generate BMFonts:
#     http://glyphdesigner.71squared.com/ (Commercial, Mac OS X)
#     http://www.n4te.com/hiero/hiero.jnlp (Free, Java)
#     http://slick.cokeandcode.com/demos/hiero.jnlp (Free, Java)
#     http://www.angelcode.com/products/bmfont/ (Free, Windows only)
#
####################################################################
  class AtlasBitmapColor < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      label = CCLabelBMFont.create("Blue", "fonts/bitmapFontTest5.fnt")
      label.setColor( ccc3(0, 0, 255 ))
      layer.addChild(label)
      label.setPosition( ccp(s.width/2, s.height/4) )
      label.setAnchorPoint( ccp(0.5, 0.5) )

      label = CCLabelBMFont.create("Red", "fonts/bitmapFontTest5.fnt")
      layer.addChild(label)
      label.setPosition( ccp(s.width/2, 2*s.height/4) )
      label.setAnchorPoint( ccp(0.5, 0.5) )
      label.setColor( ccc3(255, 0, 0) )

      label = CCLabelBMFont.create("G", "fonts/bitmapFontTest5.fnt")
      layer.addChild(label)
      label.setPosition( ccp(s.width/2, 3*s.height/4) )
      label.setAnchorPoint( ccp(0.5, 0.5) )
      label.setColor( ccc3(0, 255, 0 ))
      label.setString("Green")

      @title_label.setString("CCLabelBMFont")
      @subtitle_label.setString("Testing color")
      layer
    end
  end

####################################################################
#
# AtlasFastBitmap
#
# Use any of these editors to generate BMFonts:
#     http://glyphdesigner.71squared.com/ (Commercial, Mac OS X)
#     http://www.n4te.com/hiero/hiero.jnlp (Free, Java)
#     http://slick.cokeandcode.com/demos/hiero.jnlp (Free, Java)
#     http://www.angelcode.com/products/bmfont/ (Free, Windows only)
#
####################################################################

  class AtlasFastBitmap < LabelTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size
      srand(Time.new.to_i)

      # Upper Label
      101.times do |i|
        str = "-#{i}-"
        label = CCLabelBMFont.create(str, "fonts/bitmapFontTest.fnt")
        layer.addChild(label)

        p = ccp( rand() * s.width, rand() * s.height)
        label.setPosition( p )
        label.setAnchorPoint(ccp(0.5, 0.5))
      end

      @title_label.setString("CCLabelBMFont")
      @subtitle_label.setString("Creating several CCLabelBMFont with the same .fnt file should be fast")
      layer
    end
  end

####################################################################
#
# BitmapFontMultiLine
#
# Use any of these editors to generate BMFonts:
#     http://glyphdesigner.71squared.com/ (Commercial, Mac OS X)
#     http://www.n4te.com/hiero/hiero.jnlp (Free, Java)
#     http://slick.cokeandcode.com/demos/hiero.jnlp (Free, Java)
#     http://www.angelcode.com/products/bmfont/ (Free, Windows only)
#
####################################################################
  class BitmapFontMultiLine < LabelTestBase
    def init_with_layer(layer)
      super(layer)

      # Left
      label1 = CCLabelBMFont.create(" Multi line\nLeft", "fonts/bitmapFontTest3.fnt")
      label1.setAnchorPoint(ccp(0,0))
      layer.addChild(label1, 0, kTagBitmapAtlas1)

      s = label1.getContentSize()
      cclog("content size: %.2fx%.2f", s.width, s.height)


      # Center
      label2 = CCLabelBMFont.create("Multi line\nCenter", "fonts/bitmapFontTest3.fnt")
      label2.setAnchorPoint(ccp(0.5, 0.5))
      layer.addChild(label2, 0, kTagBitmapAtlas2)

      s = label2.getContentSize()
      cclog("content size: %.2fx%.2f", s.width, s.height)

      # right
      label3 = CCLabelBMFont.create("Multi line\nRight\nThree lines Three", "fonts/bitmapFontTest3.fnt")
      label3.setAnchorPoint(ccp(1, 1))
      layer.addChild(label3, 0, kTagBitmapAtlas3)

      s = label3.getContentSize()
      cclog("content size: %.2fx%.2f", s.width, s.height)

      label1.setPosition(VisibleRect.leftBottom())
      label2.setPosition(VisibleRect.center())
      label3.setPosition(VisibleRect.rightTop())
      @title_label.setString("CCLabelBMFont")
      @subtitle_label.setString("Multiline + anchor point")
      layer
    end
  end

  class LabelsEmpty < LabelTestBase
    def initialize
      super
      @setEmpty = false
      @updateEntry = nil
    end

    def onNodeEvent(tag)
      if tag == kCCNodeOnEnter
        that = self
        @updateEntry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.updateStrings(dt)}, 1.0, false)
      elsif tag == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@updateEntry)
      end
    end

    def init_with_layer(layer)
      super(layer)

      s = @@size

      # CCLabelBMFont
      label1 = CCLabelBMFont.create("", "fonts/bitmapFontTest3.fnt")
      layer.addChild(label1, 0, kTagBitmapAtlas1)
      label1.setPosition(ccp(s.width/2, s.height-100))

      # CCLabelTTF
      label2 = CCLabelTTF.create("", "Arial", 24)
      layer.addChild(label2, 0, kTagBitmapAtlas2)
      label2.setPosition(ccp(s.width/2, s.height/2))

      # CCLabelAtlas
      label3 = CCLabelAtlas.create("", "fonts/tuffy_bold_italic-charmap.png", 48, 64,  " ".getbyte(0))
      layer.addChild(label3, 0, kTagBitmapAtlas3)
      label3.setPosition(ccp(s.width/2, 0+100))

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.onNodeEvent(tag)})

      @setEmpty = false
      @title_label.setString("Testing empty labels")
      @subtitle_label.setString("3 empty labels: LabelAtlas, LabelTTF and LabelBMFont")
      layer
    end

    def updateStrings(dt)
      label1 = @layer.getChildByTag(kTagBitmapAtlas1)
      label2 = @layer.getChildByTag(kTagBitmapAtlas2)
      label3 = @layer.getChildByTag(kTagBitmapAtlas3)

      if @setEmpty == false
        label1.setString("not empty")
        label2.setString("not empty")
        label3.setString("hi")
        @setEmpty = true
      else
        label1.setString("")
        label2.setString("")
        label3.setString("")
        @setEmpty = false
      end
    end
  end

  class LabelBMFontHD < LabelTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size

      # CCLabelBMFont
      label1 = CCLabelBMFont.create("TESTING RETINA DISPLAY", "fonts/konqa32.fnt")
      layer.addChild(label1)
      label1.setPosition(ccp(s.width/2, s.height/2))

      @title_label.setString("Testing Retina Display BMFont")
      @subtitle_label.setString("loading arista16 or arista16-hd")
      layer
    end
  end

  class LabelAtlasHD < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      # CCLabelBMFont
      label1 = CCLabelAtlas.create("TESTING RETINA DISPLAY", "fonts/larabie-16.plist")
      label1.setAnchorPoint(ccp(0.5, 0.5))

      layer.addChild(label1)
      label1.setPosition(ccp(s.width/2, s.height/2))

      @title_label.setString("LabelAtlas with Retina Display")
      @subtitle_label.setString("loading larabie-16 / larabie-16-hd")
      layer
    end
  end

  class LabelGlyphDesigner < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      colorlayer = CCLayerColor.create(ccc4(128,128,128,255))
      layer.addChild(colorlayer, -10)

      # CCLabelBMFont
      label1 = CCLabelBMFont.create("Testing Glyph Designer", "fonts/futura-48.fnt")
      layer.addChild(label1)
      label1.setPosition(ccp(s.width/2, s.height/2))
      @title_label.setString("Testing Glyph Designer")
      @subtitle_label.setString("You should see a font with shawdows and outline")

      layer
    end
  end

  class LabelTTFTest < LabelTestBase
    def initialize
      super
      @plabel = nil
      @eHorizAlign = kCCTextAlignmentLeft
      @eVertAlign  = kCCVerticalTextAlignmentTop
    end

    def init_with_layer(layer)
      super(layer)
      @eHorizAlign = kCCTextAlignmentLeft
      @eVertAlign  = kCCVerticalTextAlignmentTop

      blockSize = CCSizeMake(200, 160)
      s = @@size

      colorLayer = CCLayerColor.create(ccc4(100, 100, 100, 255), blockSize.width, blockSize.height)
      colorLayer.setAnchorPoint(ccp(0,0))
      colorLayer.setPosition(ccp((s.width - blockSize.width) / 2, (s.height - blockSize.height) / 2))

      layer.addChild(colorLayer)

      that = self

      CCMenuItemFont.setFontSize(30)
      item1 = CCMenuItemFont.create("Left")
      item1.registerScriptTapHandler(Proc.new {|*args| that.setAlignmentLeft(*args)})
      item2 = CCMenuItemFont.create("Center")
      item2.registerScriptTapHandler(Proc.new {|*args| that.setAlignmentCenter(*args)})
      item3 = CCMenuItemFont.create("Right")
      item3.registerScriptTapHandler(Proc.new {|*args| that.setAlignmentRight(*args)})

      menu = CCMenu.create()
      menu.addChild(item1)
      menu.addChild(item2)
      menu.addChild(item3)
      menu.alignItemsVerticallyWithPadding(4)
      menu.setPosition(ccp(50, s.height / 2 - 20))
      layer.addChild(menu)

      menu = CCMenu.create()

      item1 = CCMenuItemFont.create("Top")
      item1.registerScriptTapHandler(Proc.new {|*args| that.setAlignmentTop(*args)})
      item2 = CCMenuItemFont.create("Middle")
      item2.registerScriptTapHandler(Proc.new {|*args| that.setAlignmentMiddle(*args)})
      item3 = CCMenuItemFont.create("Bottom")
      item3.registerScriptTapHandler(Proc.new {|*args| that.setAlignmentBottom(*args)})

      menu.addChild(item1)
      menu.addChild(item2)
      menu.addChild(item3)

      menu.alignItemsVerticallyWithPadding(4)
      menu.setPosition(ccp(s.width - 50, s.height / 2 - 20))
      layer.addChild(menu)

      updateAlignment()
    
      @title_label.setString("Testing CCLabelTTF")
      @subtitle_label.setString("Select the buttons on the sides to change alignment")

      layer
    end

    def updateAlignment
      blockSize = CCSizeMake(200, 160)
      s = @@size

      @plabel.removeFromParentAndCleanup(true) unless @plabel.nil?

      @plabel = CCLabelTTF.create(getCurrentAlignment(), "Marker Felt", 32,
                                  blockSize, @eHorizAlign, @eVertAlign)

      @plabel.setAnchorPoint(ccp(0,0))
      @plabel.setPosition(ccp((s.width - blockSize.width) / 2, (s.height - blockSize.height)/2 ))

      @layer.addChild(@plabel)
    end

    def setAlignmentLeft(*args)
      @eHorizAlign = kCCTextAlignmentLeft
      updateAlignment()
    end

    def setAlignmentCenter(*args)
      @eHorizAlign = kCCTextAlignmentCenter
      updateAlignment()
    end

    def setAlignmentRight(*args)
      @eHorizAlign = kCCTextAlignmentRight
      updateAlignment()
    end

    def setAlignmentTop(*args)
      @eVertAlign = kCCVerticalTextAlignmentTop
      updateAlignment()
    end

    def setAlignmentMiddle(*args)
      @eVertAlign = kCCVerticalTextAlignmentCenter
      updateAlignment()
    end

    def setAlignmentBottom(*args)
      @eVertAlign = kCCVerticalTextAlignmentBottom
      updateAlignment()
    end

    def getCurrentAlignment
      vertical = nil
      horizontal = nil
      if @eVertAlign == kCCVerticalTextAlignmentTop
        vertical = "Top"
      elsif @eVertAlign ==  kCCVerticalTextAlignmentCenter
        vertical = "Middle"
      elsif @eVertAlign ==  kCCVerticalTextAlignmentBottom
        vertical = "Bottom"
      end

      if @eHorizAlign == kCCTextAlignmentLeft
        horizontal = "Left"
      elsif @eHorizAlign == kCCTextAlignmentCenter
        horizontal = "Center"
      elsif @eHorizAlign == kCCTextAlignmentRight
        horizontal = "Right"
      end

      sprintf("Alignment %s %s", vertical, horizontal)
    end
  end

  class Atlas1 < LabelTestBase
    def init_with_layer(layer)
      super(layer)

      @texture_atlas = CCTextureAtlas.create($s_AtlasTest, 3)
      s = @@size

      quads = []

      [[
        [vertex3(0,0,0),ccc4(0,0,255,255),tex2(0.0,1.0),], # bottom left
        [vertex3(s.width,0,0),ccc4(0,0,255,0),tex2(1.0,1.0),], # bottom right
        [vertex3(0,s.height,0),ccc4(0,0,255,0),tex2(0.0,0.0),], # top left
        [vertex3(s.width,s.height,0),[0,0,255,255],tex2(1.0,0.0),], # top right
       ],        
       [
        [vertex3(40,40,0),ccc4(255,255,255,255),tex2(0.0,0.2),], # bottom left
        [vertex3(120,80,0),ccc4(255,0,0,255),tex2(0.5,0.2),], # bottom right
        [vertex3(40,160,0),ccc4(255,255,255,255),tex2(0.0,0.0),], # top left
        [vertex3(160,160,0),ccc4(0,255,0,255),tex2(0.5,0.0),], # top right
       ],
       [
        [vertex3(s.width/2,40,0),ccc4(255,0,0,255),tex2(0.0,1.0),], # bottom left
        [vertex3(s.width,40,0),ccc4(0,255,0,255),tex2(1.0,1.0),], # bottom right
        [vertex3(s.width/2-50,200,0),ccc4(0,0,255,255),tex2(0.0,0.0),], # top left
        [vertex3(s.width,100,0),ccc4(255,255,0,255),tex2(1.0,0.0),], # top right
       ]].each do |q|
        tl = CC_ccV3F_C4B_T2F.new
        tl.vertices = q[0][0]
        tl.colors = q[0][1]
        tl.texCoords = q[0][2]

        bl = CC_ccV3F_C4B_T2F.new
        bl.vertices = q[1][0]
        bl.colors = q[1][1]
        bl.texCoords = q[1][2]

        tr = CC_ccV3F_C4B_T2F.new
        tr.vertices = q[2][0]
        tr.colors = q[2][1]
        tr.texCoords = q[2][2]

        br = CC_ccV3F_C4B_T2F.new
        br.vertices = q[2][0]
        br.colors = q[2][1]
        br.texCoords = q[2][2]

        quad = CC_ccV3F_C4B_T2F_Quad.new
        quad.tl = tl
        quad.bl = bl
        quad.tr = tr
        quad.br = br

        quads << quad
      end

      quads.size.times do |i|
        @texture_atlas.updateQuad(quads[i], i)
      end

      @title_label.setString("CCTextureAtlas")
      @subtitle_label.setString("Manual creation of CCTextureAtlas\nNOT SUPPORTED!")

      layer
    end

    def draw
      # never called!
      @texture_atlas.drawQuads()
    end
  end

  class LabelTTFMultiline < LabelTestBase
    def init_with_layer(layer)
      super(layer)
    
      s = @@size

      center = CCLabelTTF.create("word wrap \"testing\" (bla0) bla1 'bla2' [bla3] (bla4) {bla5} {bla6} [bla7] (bla8) [bla9] 'bla0' \"bla1\"",
                                     "Paint Boy",
                                 32,
                                 CCSizeMake(s.width/2,200),
                                 kCCTextAlignmentCenter,
                                 kCCVerticalTextAlignmentTop)

      center.setPosition(ccp(s.width / 2, 150))

      layer.addChild(center)
      @title_label.setString("Testing CCLabelTTF Word Wrap")
      @subtitle_label.setString("Word wrap using CCLabelTTF and a custom TTF font")

      layer
    end
  end

  class LabelTTFChinese < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      size = @@size
      pLable = CCLabelTTF.create("中国", "Marker Felt", 30)
      pLable.setPosition(ccp(size.width / 2, size.height / 2))

      layer.addChild(pLable)
      @title_label.setString("Testing CCLabelTTF with Chinese character")
      layer
    end
  end

  class LabelBMFontChinese < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      size = @@size
      pLable = CCLabelBMFont.create("中国", "fonts/bitmapFontChinese.fnt")
      pLable.setPosition(ccp(size.width / 2, size.height / 2))
      layer.addChild(pLable)

      @title_label.setString("Testing CCLabelBMFont with Chinese character")
      layer
    end
  end

  class BitmapFontMultiLineAlignment < LabelTestBase
    LongSentencesExample =  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    LineBreaksExample    = "Lorem ipsum dolor\nsit amet\nconsectetur adipisicing elit\nblah\nblah"
    MixedExample         = "ABC\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt\nDEF"

    ArrowsMax             = 0.95
    ArrowsMin             = 0.7

    LeftAlign             = 0
    CenterAlign           = 1
    RightAlign            = 2

    LongSentences         = 0
    LineBreaks            = 1
    Mixed                 = 2

    def alignmentItemPadding
      50
    end
    def menuItemPaddingCenter
      50
    end

    def initialize
      super
      @pLabelShouldRetain = nil
      @pArrowsBarShouldRetain = nil
      @pArrowsShouldRetain = nil
      @pLastSentenceItem = nil
      @drag = false
    end

    def init_with_layer(layer)
      super(layer)

      layer.setTouchEnabled(true)

      # ask director the the window size
      size = @@size

      that = self

      # create and initialize a Label
      @pLabelShouldRetain = CCLabelBMFont.create(LongSentencesExample, "fonts/markerFelt.fnt", size.width/1.5, kCCTextAlignmentCenter)

      @pArrowsBarShouldRetain = CCSprite.create("Images/arrowsBar.png")
      @pArrowsShouldRetain = CCSprite.create("Images/arrows.png")

      CCMenuItemFont.setFontSize(20)
      longSentences = CCMenuItemFont.create("Long Flowing Sentences")
      longSentences.registerScriptTapHandler(Proc.new{|*args| that.stringChanged(*args)})
      lineBreaks    = CCMenuItemFont.create("Short Sentences With Intentional Line Breaks")
      lineBreaks.registerScriptTapHandler(Proc.new {|*args| that.stringChanged(*args)})
      mixed         = CCMenuItemFont.create("Long Sentences Mixed With Intentional Line Breaks")
      mixed.registerScriptTapHandler(Proc.new {|*args| that.stringChanged(*args)})
      stringMenu    = CCMenu.create()
      stringMenu.addChild(longSentences)
      stringMenu.addChild(lineBreaks)
      stringMenu.addChild(mixed)
      stringMenu.alignItemsVertically()

      longSentences.setColor(ccc3(255, 0, 0))
      @pLastSentenceItem = longSentences

      longSentences.setTag(LongSentences)
      lineBreaks.setTag(LineBreaks)
      mixed.setTag(Mixed)

      CCMenuItemFont.setFontSize(30)

      left          = CCMenuItemFont.create("Left")
      left.registerScriptTapHandler(Proc.new {|*args| that.alignmentChanged(*args)})
      center        = CCMenuItemFont.create("Center")
      center.registerScriptTapHandler(Proc.new {|*args| that.alignmentChanged(*args)})
      right         = CCMenuItemFont.create("Right")
      right.registerScriptTapHandler(Proc.new {|*args| that.alignmentChanged(*args)})

      alignmentMenu = CCMenu.create()
      alignmentMenu.addChild(left)
      alignmentMenu.addChild(center)
      alignmentMenu.addChild(right)

      alignmentMenu.alignItemsHorizontallyWithPadding(alignmentItemPadding)

      center.setColor(ccc3(255, 0, 0))
      @pLastAlignmentItem = center
      left.setTag(LeftAlign)
      center.setTag(CenterAlign)
      right.setTag(RightAlign)

      # position the label on the center of the screen
      @pLabelShouldRetain.setPosition(ccp(size.width/2, size.height/2))

      @pArrowsBarShouldRetain.setVisible(false)

      arrowsWidth = (ArrowsMax - ArrowsMin) * size.width
      @pArrowsBarShouldRetain.setScaleX(arrowsWidth / @pArrowsBarShouldRetain.getContentSize().width)
      @pArrowsBarShouldRetain.setPosition( ccp(((ArrowsMax + ArrowsMin) / 2) * size.width, @pLabelShouldRetain.getPositionY() ))

      snapArrowsToEdge()

      stringMenu.setPosition(ccp(size.width/2, size.height - menuItemPaddingCenter))
      alignmentMenu.setPosition(ccp(size.width/2, menuItemPaddingCenter+15))

      layer.addChild(@pLabelShouldRetain)
      layer.addChild(@pArrowsBarShouldRetain)
      layer.addChild(@pArrowsShouldRetain)
      layer.addChild(stringMenu)
      layer.addChild(alignmentMenu)
      layer.registerScriptTouchHandler(Proc.new {|*args| that.onTouchEvent(*args)}, false, -1, false)
      layer
    end

    def stringChanged(tag, item)
      item.setColor(ccc3(255, 0, 0))
      @pLastAlignmentItem.setColor(ccc3(255, 255, 255))
      @pLastAlignmentItem = item

      if item.getTag() == LongSentences
        @pLabelShouldRetain.setString(LongSentencesExample)
      elsif item.getTag() == LineBreaks
        @pLabelShouldRetain.setString(LineBreaksExample)
      elsif item.getTag() == Mixed
        @pLabelShouldRetain.setString(MixedExample)
      end

      snapArrowsToEdge()
    end

    def alignmentChanged(tag, item)
      #cclog("BitmapFontMultiLineAlignment.alignmentChanged, tag.#{tag}")
      item.setColor(ccc3(255, 0, 0))
      @pLastAlignmentItem.setColor(ccc3(255, 255, 255))
      @pLastAlignmentItem = item

      if tag == LeftAlign
        cclog("LeftAlign")
        @pLabelShouldRetain.setAlignment(kCCTextAlignmentLeft)
      elsif tag == CenterAlign
        @pLabelShouldRetain.setAlignment(kCCTextAlignmentCenter)
      elsif tag == RightAlign
        @pLabelShouldRetain.setAlignment(kCCTextAlignmentRight)
      end

      snapArrowsToEdge()
    end

    def onTouchEvent(eventType, x, y)
      #cclog("type.#{eventType}[#{x},#{y}]")
      if eventType == CCTOUCHBEGAN
        if @pArrowsShouldRetain.boundingBox().containsPoint(ccp(x, y)) then
          @drag = true
          @pArrowsBarShouldRetain.setVisible(true)
          return true
        end
      elsif eventType == CCTOUCHENDED
        @drag = false
        snapArrowsToEdge()
        @pArrowsBarShouldRetain.setVisible(false)
      elsif eventType == CCTOUCHMOVED
        if @drag == false
          return
        end

        winSize = @@size
        @pArrowsShouldRetain.setPosition(
            ccp([[x, ArrowsMax * winSize.width].min, ArrowsMin*winSize.width].max,
                @pArrowsShouldRetain.getPositionY()))

        labelWidth = (@pArrowsShouldRetain.getPositionX() - @pLabelShouldRetain.getPositionX()).abs() * 2
        
        @pLabelShouldRetain.setWidth(labelWidth)
      end
    end

    def snapArrowsToEdge
      @pArrowsShouldRetain.setPosition(
        ccp(@pLabelShouldRetain.getPositionX() + @pLabelShouldRetain.getContentSize().width/2, @pLabelShouldRetain.getPositionY()))
    end
  end

  class LabelTTFA8Test < LabelTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size

      colorlayer = CCLayerColor.create(ccc4(128, 128, 128, 255))
      layer.addChild(colorlayer, -10)

      # CCLabelBMFont
      label1 = CCLabelTTF.create("Testing A8 Format", "Marker Felt", 48)
      layer.addChild(label1)
      label1.setColor(ccc3(255, 0, 0))
      label1.setPosition(ccp(s.width/2, s.height/2))

      fadeOut = CCFadeOut.create(2)
      fadeIn = CCFadeIn.create(2)
      arr = CCArray.create()
      arr.addObject(fadeOut)
      arr.addObject(fadeIn)

      seq = CCSequence.create(arr)
      forever = CCRepeatForever.create(seq)
      label1.runAction(forever)

      @title_label.setString("Testing A8 Format")
      @subtitle_label.setString("RED label, fading In and Out in the center of the screen")
      layer
    end
  end

  class BMFontOneAtlas < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      label1 = CCLabelBMFont.create("This is Helvetica", "fonts/helvetica-32.fnt",
                                    kCCLabelAutomaticWidth, kCCTextAlignmentLeft,
                                    ccp(0, 0))
                                    
      layer.addChild(label1)
      label1.setPosition(ccp(s.width/2, s.height/3*2))
    
      label2 = CCLabelBMFont.create("And this is Geneva", "fonts/geneva-32.fnt",
                                    kCCLabelAutomaticWidth, kCCTextAlignmentLeft,
                                    ccp(0, 128))
      layer.addChild(label2)
      label2.setPosition(ccp(s.width/2, s.height/3*1))
      @title_label.setString("CCLabelBMFont with one texture")
      @subtitle_label.setString("Using 2 .fnt definitions that share the same texture atlas.")
      layer
    end
  end

  class BMFontUnicode < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      @title_label.setString("CCLabelBMFont with Unicode support")
      @subtitle_label.setString("You should see 3 differnt labels: In Spanish, Chinese and Korean")

      s = @@size
    
      label1 = CCLabelBMFont.create("Buen día", "fonts/arial-unicode-26.fnt",
                                    200, kCCTextAlignmentLeft)
      layer.addChild(label1)
      label1.setPosition(ccp(s.width/2, s.height/4*3))
    
      label2 = CCLabelBMFont.create("美好的一天", "fonts/arial-unicode-26.fnt")
      layer.addChild(label2)
      label2.setPosition(ccp(s.width/2, s.height/4*2))
    
      label3 = CCLabelBMFont.create("良い一日を", "fonts/arial-unicode-26.fnt")
      layer.addChild(label3)
      label3.setPosition(ccp(s.width/2, s.height/4*1))

      layer
    end
  end

  class BMFontInit < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      @title_label.setString("CCLabelBMFont init")
      @subtitle_label.setString("Test for support of init method without parameters.")
    
      s = @@size
    
      bmFont = CCLabelBMFont.new()
      bmFont.init()
      #CCLabelBMFont* bmFont = [CCLabelBMFont create:@"Foo" fntFile:@"arial-unicode-26.fnt"]
      bmFont.setFntFile("fonts/helvetica-32.fnt")
      bmFont.setString("It is working!")
      layer.addChild(bmFont)
      bmFont.setPosition(ccp(s.width/2,s.height/4*2))
      layer
    end
  end


  class TTFFontInit < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      @title_label.setString("CCLabelTTF init")
      @subtitle_label.setString("Test for support of init method without parameters.")
    
      s = @@size
    
      font = CCLabelTTF.new()
      font.init()
      font.setFontName("Marker Felt")
      font.setFontSize(48)
      font.setString("It is working!")
      layer.addChild(font)
      font.setPosition(ccp(s.width/2,s.height/4*2))
      layer
    end
  end

  class Issue1343 < LabelTestBase
    def init_with_layer(layer)
      super(layer)
      @title_label.setString("Issue 1343")
      @subtitle_label.setString("You should see: ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz.,'")
    
      s = @@size
    
      bmFont = CCLabelBMFont.new()
      bmFont.init()
      bmFont.setFntFile("fonts/font-issue1343.fnt")
      bmFont.setString("ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz.,'")
      layer.addChild(bmFont)
      bmFont.setScale(0.3)
    
      bmFont.setPosition(ccp(s.width/2,s.height/4*2))
      layer
    end
  end

  class LabelBMFontBounds < LabelTestBase
    def init_with_layer(layer)
      super(layer)

      @title_label.setString("Testing LabelBMFont Bounds")
      @subtitle_label.setString("You should see string enclosed by a box\nNOT SUPPORTED!")

      s = @@size

      colorlayer = CCLayerColor.create(ccc4(128,128,128,255))
      layer.addChild(colorlayer, -10)

      # CCLabelBMFont
      @label1 = CCLabelBMFont.create("Testing Glyph Designer",
                                     "fonts/boundsTestFont.fnt")

      layer.addChild(@label1)
      @label1.setPosition(ccp(s.width/2, s.height/2))
      layer
    end


    def draw
      # never called!
      labelSize = @label1.getContentSize()
      origin = CCDirector.sharedDirector().getWinSize()
    
      origin.width = origin.width / 2 - (labelSize.width / 2)
      origin.height = origin.height / 2 - (labelSize.height / 2)
    
      vertices = [ccp(origin.width, origin.height),
                  ccp(labelSize.width + origin.width, origin.height),
                  ccp(labelSize.width + origin.width,
                      labelSize.height + origin.height),
                  ccp(origin.width, labelSize.height + origin.height)
                 ]
      ccDrawPoly(vertices, 4, true)
    end
  end

  class LabelTTFAlignment < LabelTestBase
    def init_with_layer(layer)
      super(layer)

      @title_label.setString("CCLabelTTF alignment")
      @subtitle_label.setString("Tests alignment values")
    
      s = @@size

      ttf0 = CCLabelTTF.create("Alignment 0\nnew line", "Helvetica", 12,
                               CCSizeMake(256, 32), kCCTextAlignmentLeft)
      ttf0.setPosition(ccp(s.width/2,(s.height/6)*2))
      ttf0.setAnchorPoint(ccp(0.5,0.5))
      layer.addChild(ttf0)

      ttf1 = CCLabelTTF.create("Alignment 1\nnew line", "Helvetica", 12,
                               CCSizeMake(245, 32), kCCTextAlignmentCenter)
      ttf1.setPosition(ccp(s.width/2,(s.height/6)*3))
      ttf1.setAnchorPoint(ccp(0.5,0.5))
      layer.addChild(ttf1)

      ttf2 = CCLabelTTF.create("Alignment 2\nnew line", "Helvetica", 12,
                               CCSizeMake(245, 32), kCCTextAlignmentRight)
      ttf2.setPosition(ccp(s.width/2,(s.height/6)*4))
      ttf2.setAnchorPoint(ccp(0.5,0.5))
      layer.addChild(ttf2)
      layer
    end
  end

  def initialize
    super
    [
     LabelAtlasTest,
     LabelAtlasColorTest,
     Atlas3,
     Atlas4,
     Atlas5,
     Atlas6,
     AtlasFastBitmap,
     BitmapFontMultiLine,
     LabelsEmpty,
     LabelBMFontHD,
     LabelAtlasHD,
     LabelGlyphDesigner,
     Atlas1,
     LabelTTFTest,
     LabelTTFMultiline,
     LabelTTFChinese,
     LabelBMFontChinese,
     BitmapFontMultiLineAlignment,
     LabelTTFA8Test,
     BMFontOneAtlas,
     BMFontUnicode,
     BMFontInit,
     TTFFontInit,
     Issue1343,
     LabelTTFAlignment,
     LabelBMFontBounds,
    ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end
