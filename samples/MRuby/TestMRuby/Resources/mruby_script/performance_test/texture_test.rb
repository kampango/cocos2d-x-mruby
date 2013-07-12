
class PerformanceTest
  class TextureTest < PerformBase
    self.supported = true

    def calculateDeltaTime(lastUpdate)
      now = Time.now
      dt = now - lastUpdate
      dt.to_f
    end

    def create
      scene = super
      scene.addChild(create_back_menu_item)
      scene
    end

    def init_with_layer(layer)
      super(layer)
      @layer = layer

      s = @@size

      # Title
      @title_label.setString(self.title)
      @title_label.setColor(ccc3(255,255,40))

      # Subtitle
      @subtitle_label.setString(self.subtitle)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == kCCNodeOnEnter
                                      that.onEnter
                                    end})
      layer
    end

    def onEnter
      performTests()
    end

    def performTestsPNG(filename)
      cache = CCTextureCache.sharedTextureCache()

      cclog("RGBA 8888")
      CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
      now = Time.now
      texture = cache.addImage(filename)
      if texture
        cclog("  sec:%f", calculateDeltaTime(now))
      else
        cclog(" ERROR")
      end
      cache.removeTexture(texture)

      cclog("RGBA 4444")
      CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA4444)
      now = Time.now
      texture = cache.addImage(filename)
      if texture
        cclog("  sec:%f", calculateDeltaTime(now))
      else
        cclog(" ERROR")
      end
      cache.removeTexture(texture)

      cclog("RGBA 5551")
      CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGB5A1)
      now = Time.now
      texture = cache.addImage(filename)
      if texture
        cclog("  sec:%f", calculateDeltaTime(now))
      else
        cclog(" ERROR")
      end
      cache.removeTexture(texture)

      cclog("RGB 565")
      CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGB565)
      now = Time.now
      texture = cache.addImage(filename)
      if texture
        cclog("  sec:%f", calculateDeltaTime(now))
      else
        cclog(" ERROR")
      end
      cache.removeTexture(texture)
    end

    def performTests
#      cache = CCTextureCache.sharedTextureCache()

      cclog("--------")

      cclog("--- PNG 128x128 ---")
      performTestsPNG("Images/test_image.png")

#      cclog("--- PVR 128x128 ---")
#      cclog("RGBA 8888")
#      now = Time.now
#      texture = cache.addImage("Images/test_image_rgba8888.pvr")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
#  
#      cclog("BGRA 8888")
#      now = Time.now
#      texture = cache.addImage("Images/test_image_bgra8888.pvr")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
#  
#      cclog("RGBA 4444")
#      now = Time.now
#      texture = cache.addImage("Images/test_image_rgba4444.pvr")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
#  
#      cclog("RGB 565")
#      now = Time.now
#      texture = cache.addImage("Images/test_image_rgb565.pvr")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)


      cclog("--- PNG 512x512 ---")
      performTestsPNG("Images/texture512x512.png")

#      cclog("--- PVR 512x512 ---")
#      cclog("RGBA 4444")
#      now = Time.now
#      texture = cache.addImage("Images/texture512x512_rgba4444.pvr")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)

    # 
    #  ---- 1024X1024
    #  RGBA4444
    #  Empty image
    # 

    cclog("EMPTY IMAGE")
    cclog("--- PNG 1024x1024 ---")
    performTestsPNG("Images/texture1024x1024.png")

#      cclog("--- PVR 1024x1024 ---")
#      cclog("RGBA 4444")
#      now = Time.now
#      texture = cache.addImage("Images/texture1024x1024_rgba4444.pvr")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
#  
#      cclog("--- PVR.GZ 1024x1024 ---")
#      cclog("RGBA 4444")
#      now = Time.now
#      texture = cache.addImage("Images/texture1024x1024_rgba4444.pvr.gz")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
#  
#      cclog("--- PVR.CCZ 1024x1024 ---")
#      cclog("RGBA 4444")
#      now = Time.now
#      texture = cache.addImage("Images/texture1024x1024_rgba4444.pvr.ccz")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)

    # 
    #  ---- 1024X1024
    #  RGBA4444
    #  SpriteSheet images
    # 

    cclog("SPRITESHEET IMAGE")
    cclog("--- PNG 1024x1024 ---")
    performTestsPNG("Images/PlanetCute-1024x1024.png")

#      cclog("--- PVR 1024x1024 ---")
#      cclog("RGBA 4444")
#      now = Time.now
#      texture = cache.addImage("Images/PlanetCute-1024x1024-rgba4444.pvr")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
#  
#      cclog("--- PVR.GZ 1024x1024 ---")
#      cclog("RGBA 4444")
#      now = Time.now
#      texture = cache.addImage("Images/PlanetCute-1024x1024-rgba4444.pvr.gz")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
#  
#      cclog("--- PVR.CCZ 1024x1024 ---")
#      cclog("RGBA 4444")
#      now = Time.now
#      texture = cache.addImage("Images/PlanetCute-1024x1024-rgba4444.pvr.ccz")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)


    # 
    #  ---- 1024X1024
    #  RGBA8888
    #  Landscape Image
    # 

    cclog("LANDSCAPE IMAGE")

    cclog("--- PNG 1024x1024 ---")
    performTestsPNG("Images/landscape-1024x1024.png")

#      cclog("--- PVR 1024x1024 ---")
#      cclog("RGBA 8888")
#      now = Time.now
#      texture = cache.addImage("Images/landscape-1024x1024-rgba8888.pvr")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
#  
#      cclog("--- PVR.GZ 1024x1024 ---")
#      cclog("RGBA 8888")
#      now = Time.now
#      texture = cache.addImage("Images/landscape-1024x1024-rgba8888.pvr.gz")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
#  
#      cclog("--- PVR.CCZ 1024x1024 ---")
#      cclog("RGBA 8888")
#      now = Time.now
#      texture = cache.addImage("Images/landscape-1024x1024-rgba8888.pvr.ccz")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)


    # 
    #  2048x2048
    #  RGBA444
    # 

#  most platform don't support texture with width/height is 2048
#      cclog("--- PNG 2048x2048 ---")
#      performTestsPNG("Images/texture2048x2048.png")

#      cclog("--- PVR 2048x2048 ---")
#      cclog("RGBA 4444")
#      now = Time.now
#      texture = cache.addImage("Images/texture2048x2048_rgba4444.pvr")
#      if texture
#          cclog("  sec:%f", calculateDeltaTime(now))
#      else
#          cclog("ERROR")
#      end
#      cache.removeTexture(texture)
    end

    def title
      "Texture Performance Test"
    end

    def subtitle
      "See console for results"
    end
  end
end
