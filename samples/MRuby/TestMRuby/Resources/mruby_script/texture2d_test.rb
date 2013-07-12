require "mruby_script/cctype_helper"
require "mruby_script/ccgl_program_constant"
require "mruby_script/gl_constant"
require "mruby_script/main_menu"
require "mruby_script/test_base"

class Texture2dTest < TestBase
  extend TestBaseExt
  self.supported = true

  class Texture2dDemoBase < TestBase
    include Cocos2d
    include GLConstant

    def title
      ""
    end
    def subtitle
      ""
    end

    def init_with_layer(layer)
      super(layer)
      @title_label.setString(self.title)
      @subtitle_label.setString(self.subtitle)

      col = CCLayerColor.create(ccc4(128,128,128,255))
      layer.addChild(col, -10)

      CCTextureCache.sharedTextureCache().dumpCachedTextureInfo()

      @layer = layer
      @layer
    end

    def onEnter
    end

    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end
  end

  class TextureMemoryAlloc < Texture2dDemoBase
    def init_with_layer(layer)
      super(layer)
      @pBackground = nil
    
      CCMenuItemFont.setFontSize(24)
    
      item1 = CCMenuItemFont.create("PNG", self, :updateImage)
      item1.setTag(0)

      item2 = CCMenuItemFont.create("RGBA8", self, :updateImage)
      item2.setTag(1)
    
      item3 = CCMenuItemFont.create("RGB8", self, :updateImage)
      item3.setTag(2)
    
      item4 = CCMenuItemFont.create("RGBA4", self, :updateImage)
      item4.setTag(3)
    
      item5 = CCMenuItemFont.create("A8", self, :updateImage)
      item5.setTag(4)

      arr = CCArray.create
      [item1, item2, item3, item4, item5].each do |item|
        arr << item
      end
      menu = CCMenu.createWithArray(arr)
      menu.alignItemsHorizontally()
    
      layer.addChild(menu)
    
      warmup = CCMenuItemFont.create("warm up texture",
                                     self, :changeBackgroundVisible)

      menu2 = CCMenu.createWithItem(warmup)

      menu2.alignItemsHorizontally()

      layer.addChild(menu2)
      s = @@size

      menu2.setPosition(ccp(s.width/2, s.height/4))
      layer
    end

    def changeBackgroundVisible(*args)
      p "changeBackgroundVisible:#{@pBackground}"
      @pBackground.setVisible(true) if @pBackground
    end

    def updateImage(sender)
      p "updateImage:#{sender.getTag}"
      @pBackground.removeFromParentAndCleanup(true) if @pBackground
    
      CCTextureCache.sharedTextureCache().removeUnusedTextures()
	
      tag = sender.getTag()
      file = nil
      case tag
      when 0
        file = "Images/test_1021x1024.png"
      else
        if CC.os == "android"
          # android can not pack .gz file into apk file
          case tag
          when 1
            file = "Images/test_1021x1024_rgba8888.pvr"
          when 2
            file = "Images/test_1021x1024_rgb888.pvr"
          when 3
            file = "Images/test_1021x1024_rgba4444.pvr"
          when 4
            file = "Images/test_1021x1024_a8.pvr"
          end
        else
          case tag
          when 1
			file = "Images/test_1021x1024_rgba8888.pvr.gz"
          when 2
			file = "Images/test_1021x1024_rgb888.pvr.gz"
          when 3
			file = "Images/test_1021x1024_rgba4444.pvr.gz"
          when 4
			file = "Images/test_1021x1024_a8.pvr.gz"
          end
        end
      end

      return if file.nil?

      @pBackground = CCSprite.create(file)
      @layer.addChild(@pBackground, -10)
	
      @pBackground.setVisible(false)

      s = @@size
      @pBackground.setPosition(ccp(s.width/2, s.height/2))
    end

    def title
      "Texture memory"
    end

    def subtitle
      "Testing Texture Memory allocation. Use Instruments + VM Tracker"
    end
  end

  class TextureAlias < Texture2dDemoBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      #
      # Sprite 1: GL_LINEAR
      #
      # Default filter is GL_LINEAR

      sprite = CCSprite.create("Images/grossinis_sister1.png")
      sprite.setPosition(ccp( s.width/3.0, s.height/2.0))
      layer.addChild(sprite)

      # this is the default filterting
      sprite.getTexture().setAntiAliasTexParameters()

      #
      # Sprite 1: GL_NEAREST
      #

      sprite2 = CCSprite.create("Images/grossinis_sister2.png")
      sprite2.setPosition(ccp( 2*s.width/3.0, s.height/2.0))
      layer.addChild(sprite2)

      # Use Nearest in this one
      sprite2.getTexture().setAliasTexParameters()

      # scale them to show
      sc = CCScaleBy.create(3, 8.0)
      sc_back = sc.reverse()
      arr = CCArray.create
      [sc, sc_back].each do |elem|
        arr << elem
      end
      scaleforever = CCRepeatForever.create(CCSequence.create(arr))
      scaleToo = scaleforever.copy()

      sprite2.runAction(scaleforever)
      sprite.runAction(scaleToo)
      CCTextureCache.sharedTextureCache().dumpCachedTextureInfo()

      layer
    end

    def title
      "AntiAlias / Alias textures"
    end

    def subtitle
      "Left image is antialiased. Right image is aliases"
    end
  end

#------------------------------------------------------------------
#
# TexturePVRMipMap
# To generate PVR images read this article:
# http://developer.apple.com/iphone/library/qa/qa2008/qa1611.html
#
#------------------------------------------------------------------
  class TexturePVRMipMap < Texture2dDemoBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      imgMipMap = CCSprite.create("Images/logo-mipmap.pvr")
      if imgMipMap
        imgMipMap.setPosition(ccp( s.width/2.0-100, s.height/2.0))
        layer.addChild(imgMipMap)

        # support mipmap filtering
        texParams = CC_ccTexParams.new
        texParams.minFilter = GL_LINEAR_MIPMAP_LINEAR
        texParams.magFilter = GL_LINEAR
        texParams.wrapS = GL_CLAMP_TO_EDGE
        texParams.wrapT = GL_CLAMP_TO_EDGE
        imgMipMap.getTexture().setTexParameters(texParams)
      end

      img = CCSprite.create("Images/logo-nomipmap.pvr")
      if img
        img.setPosition(ccp( s.width/2.0+100, s.height/2.0))
        layer.addChild(img)

        scale1 = CCEaseOut.create(CCScaleBy.create(4, 0.01), 3)
        sc_back = scale1.reverse()
        arr = CCArray.create
        arr << scale1
        arr << sc_back
        imgMipMap.runAction(CCRepeatForever.create(CCSequence.create(arr)))

        scale2 = scale1.copy()
        sc_back2 = scale2.reverse()
        arr = CCArray.create
        arr << scale2
        arr << sc_back2
        img.runAction(CCRepeatForever.create(CCSequence.create(arr)))
      end

      CCTextureCache.sharedTextureCache().dumpCachedTextureInfo()
    end

    def title
      "PVRTC MipMap Test"
    end
    def subtitle
      "Left image uses mipmap. Right image doesn't"
    end
  end

  class TexturePVRMipMap2 < Texture2dDemoBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      imgMipMap = CCSprite.create("Images/test_image_rgba4444_mipmap.pvr")
      imgMipMap.setPosition(ccp( s.width/2.0-100, s.height/2.0))
      layer.addChild(imgMipMap)

      # support mipmap filtering
      texParams = CC_ccTexParams.new
      texParams.minFilter = GL_LINEAR_MIPMAP_LINEAR
      texParams.magFilter = GL_LINEAR
      texParams.wrapS = GL_CLAMP_TO_EDGE
      texParams.wrapT = GL_CLAMP_TO_EDGE

      imgMipMap.getTexture().setTexParameters(texParams)

      img = CCSprite.create("Images/test_image.png")
      img.setPosition(ccp( s.width/2.0+100, s.height/2.0))
      layer.addChild(img)

      scale1 = CCEaseOut.create(CCScaleBy.create(4, 0.01), 3)
      sc_back = scale1.reverse()
      arr = CCArray.create
      arr << scale1
      arr << sc_back
      imgMipMap.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      scale2 = scale1.copy()
      sc_back2 = scale2.reverse()
      arr = CCArray.create
      arr << scale2
      arr << sc_back2
      img.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      CCTextureCache.sharedTextureCache().dumpCachedTextureInfo()
      layer
    end

    def title
      "PVR MipMap Test #2"
    end

    def subtitle
      "Left image uses mipmap. Right image doesn't"
    end
  end

  class TexturePVRNonSquare < Texture2dDemoBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      img = CCSprite.create("Images/grossini_128x256_mipmap.pvr")
      img.setPosition(ccp( s.width/2.0, s.height/2.0))
      layer.addChild(img)
      CCTextureCache.sharedTextureCache().dumpCachedTextureInfo()
      layer
    end

    def title
      "PVR + Non square texture"
    end

    def subtitle
      "Loading a 128x256 texture"
    end
  end

  class TexturePVRNPOT4444 < Texture2dDemoBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      img = CCSprite.create("Images/grossini_pvr_rgba4444.pvr")
      if img
        img.setPosition(ccp( s.width/2.0, s.height/2.0))
        layer.addChild(img)
      end
      CCTextureCache.sharedTextureCache().dumpCachedTextureInfo()
    end

    def title
      "PVR RGBA4 + NPOT texture"
    end

    def subtitle
      "Loading a 81x121 RGBA4444 texture."
    end
  end

  class TexturePVRNPOT8888 < Texture2dDemoBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      img = CCSprite.create("Images/grossini_pvr_rgba8888.pvr")
      if img
        img.setPosition(ccp( s.width/2.0, s.height/2.0))
        layer.addChild(img)
      end
      CCTextureCache.sharedTextureCache().dumpCachedTextureInfo()
    end

    def title
      "PVR RGBA8 + NPOT texture"
    end

    def subtitle
      "Loading a 81x121 RGBA8888 texture."
    end
  end

  def initialize
    super
    [
     TextureMemoryAlloc,
     TextureAlias,
     TexturePVRMipMap,
     TexturePVRMipMap2,
     TexturePVRNonSquare,
     TexturePVRNPOT4444,
     TexturePVRNPOT8888,
     #TexturePVR,
     #TexturePVR2BPP,
     #TexturePVR2BPPv3,
     #TexturePVR4BPP,
     #TexturePVR4BPPv3,
     #TexturePVRII4BPPv3,
     #TexturePVRRGBA8888,
     #TexturePVRRGBA8888v3,
     #TexturePVRBGRA8888,
     #TexturePVRBGRA8888v3,
     #TexturePVRRGBA4444,
     #TexturePVRRGBA4444v3,
     #TexturePVRRGBA4444GZ,
     #TexturePVRRGBA4444CCZ,
     #TexturePVRRGBA5551,
     #TexturePVRRGBA5551v3,
     #TexturePVRRGB565,
     #TexturePVRRGB565v3,
     #TexturePVRRGB888,
     #TexturePVRRGB888v3,
     #TexturePVRA8,
     #TexturePVRA8v3,
     #TexturePVRI8,
     #TexturePVRI8v3,
     #TexturePVRAI88,
     #TexturePVRAI88v3,
    
     #TexturePVRv3Premult,
    
     #TexturePVRBadEncoding,
     #TexturePNG,
     #TextureJPEG,
     #TextureTIFF,
     #TextureWEBP,
     #TexturePixelFormat,
     #TextureBlend,
     #TextureAsync,
     #TextureGlClamp,
     #TextureGlRepeat,
     #TextureSizeTest,
     #TextureCache1,
     #TextureDrawAtPoint, #not supported
     #TextureDrawInRect, #not supported
    
     #TextureETC1,

    ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end
