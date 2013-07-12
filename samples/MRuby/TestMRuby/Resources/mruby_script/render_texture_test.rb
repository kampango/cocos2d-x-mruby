require "mruby_script/cctype_helper"
require "mruby_script/ccgl_program_constant"
require "mruby_script/gl_constant"
require "mruby_script/main_menu"
require "mruby_script/test_base"

class RenderTextureTest < TestBase
  extend TestBaseExt
  self.supported = true

  class RenderTextureTestBase < TestBase
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
      @layer = layer
      @layer
    end

    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end
  end

  class RenderTextureSave < RenderTextureTestBase
    def title
        "Touch the screen"
    end
    def subtitle
      "Press 'Save Image' to create an snapshot of the render texture"
    end

    def init_with_layer(layer)
      super(layer)
      s = @@size

      # create a render texture, this is what we are going to draw into
      @pTarget = CCRenderTexture.create(s.width, s.height,
                                        kCCTexture2DPixelFormat_RGBA8888)
      @pTarget.setPosition(ccp(s.width / 2, s.height / 2))

      # note that the render texture is a CCNode, and contains a sprite of its texture for convience,
      # so we can just parent it to the scene like any other CCNode
      layer.addChild(@pTarget, -1)

      # create a brush image to draw into the texture with
      @pBrush = CCSprite.create("Images/fire.png")
      @pBrush.setColor(ccRED)
      @pBrush.setOpacity(20)
      layer.setTouchEnabled(true)

      # Save Image menu
      CCMenuItemFont.setFontSize(16)
      item1 = CCMenuItemFont.create("Save Image", self, :saveImage)
      item2 = CCMenuItemFont.create("Clear", self, :clearImage)
      arr = CCArray.create
      arr << item1
      arr << item2
      menu = CCMenu.createWithArray(arr)
      layer.addChild(menu)
      menu.alignItemsVertically()
      menu.setPosition(ccp(VisibleRect.rightTop().x - 80, VisibleRect.rightTop().y - 30))

      that = self
      layer.registerScriptTouchHandler(Proc.new {|*args| that.onTouch(*args)},
                                       false, -1, false)

      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      @counter = 0
      @pngs = []
      @layer = layer
      layer
    end

    def onExit
      cache = CCTextureCache.sharedTextureCache()
      @pngs.each do |png|
        cache.removeTextureForKey(png)
      end
      cache.removeUnusedTextures()
    end

    def clearImage(pSender)
      @pTarget.clear(CCRANDOM_0_1(), CCRANDOM_0_1(), CCRANDOM_0_1(), CCRANDOM_0_1())
    end

    def saveImage(pSender)
      png = sprintf("image-%d.png", @counter)
      jpg = sprintf("image-%d.jpg", @counter)

      @pTarget.saveToFile(png, kCCImageFormatPNG)
      @pTarget.saveToFile(jpg, kCCImageFormatJPEG)
    
      pImage = @pTarget.newCCImage(true)

      tex = CCTextureCache.sharedTextureCache().addUIImage(pImage, png)

      sprite = CCSprite.createWithTexture(tex)

      sprite.setScale(0.3)
      @layer.addChild(sprite)
      sprite.setPosition(ccp(40, 40))
      sprite.setRotation(@counter * 3)

      cclog("Image saved #{@png} and #{jpg}")

      @counter += 1
    end

    def onTouch(event, x, y)
      if event == CCTOUCHBEGAN
        @start = @end = ccp(x, y)
        return true
      end

      @end = @start
      @start = ccp(x, y)

      # begin drawing to the render texture
      @pTarget.begin()

      # for extra points, we'll draw this smoothly from the last position and vary the sprite's
      # scale/rotation/offset
      distance = ccpDistance(@start, @end)
      if distance > 1
        d = distance.to_i
        d.times do |i|
          difx = @end.x - @start.x
          dify = @end.y - @start.y
          delta = (i / distance).to_f
          @pBrush.setPosition(ccp(@start.x + (difx * delta),
                                  @start.y + (dify * delta)))
          @pBrush.setRotation(rand() * 360)
          r = rand() + 0.25
          @pBrush.setScale(r)
          /*@pBrush.setColor(ccc3(CCRANDOM_0_1() * 127 + 128, 255, 255))*/
          # Use CCRANDOM_0_1() will cause error when loading libtests.so on android, I don't know why.
          @pBrush.setColor(ccc3(rand() * 127 + 128, 255, 255))
          # Call visit to draw the brush, don't call draw..
          @pBrush.visit()
        end
      end

      # finish drawing and return context back to the screen
      @pTarget.end()
    end
  end

  class RenderTextureIssue937 < RenderTextureTestBase
    def title
      "Testing issue #937"
    end
    def subtitle
      "All images should be equal..."
    end

    def init_with_layer(layer)
      super(layer)
      #
      #     1    2
      # A: A1   A2
      #
      # B: B1   B2
      #
      #  A1: premulti sprite
      #  A2: premulti render
      #
      #  B1: non-premulti sprite
      #  B2: non-premulti render
      #
      background = CCLayerColor.create(ccc4(200,200,200,255))
      layer.addChild(background)

      spr_premulti = CCSprite.create("Images/fire.png")
      spr_premulti.setPosition(ccp(16,48))

      spr_nonpremulti = CCSprite.create("Images/fire.png")
      spr_nonpremulti.setPosition(ccp(16,16))

      # A2 & B2 setup
      rend = CCRenderTexture.create(32, 64, kCCTexture2DPixelFormat_RGBA8888)

      if rend.nil?
        return layer
      end

      # It's possible to modify the RenderTexture blending function by
      #        [[rend sprite] setBlendFunc:(ccBlendFunc) {GL_ONE, GL_ONE_MINUS_SRC_ALPHA}];

      rend.begin()
      spr_premulti.visit()
      spr_nonpremulti.visit()
      rend.end()

      s = @@size

      # A1: setup
      spr_premulti.setPosition(ccp(s.width/2-16, s.height/2+16))
      # B1: setup
      spr_nonpremulti.setPosition(ccp(s.width/2-16, s.height/2-16))

      rend.setPosition(ccp(s.width/2+16, s.height/2))

      layer.addChild(spr_nonpremulti)
      layer.addChild(spr_premulti)
      layer.addChild(rend)
      layer
    end
  end

  class RenderTextureZbuffer < RenderTextureTestBase
    def title
      "Testing Z Buffer in Render Texture"
    end
    def subtitle
      "Touch screen. It should be green"
    end

    def init_with_layer(layer)
      super(layer)

      layer.setTouchEnabled(true)
      size = @@size
      label = CCLabelTTF.create("vertexZ = 50", "Marker Felt", 64)
      label.setPosition(ccp(size.width / 2, size.height * 0.25))
      layer.addChild(label)

      label2 = CCLabelTTF.create("vertexZ = 0", "Marker Felt", 64)
      label2.setPosition(ccp(size.width / 2, size.height * 0.5))
      layer.addChild(label2)

      label3 = CCLabelTTF.create("vertexZ = -50", "Marker Felt", 64)
      label3.setPosition(ccp(size.width / 2, size.height * 0.75))
      layer.addChild(label3)

      label.setVertexZ(50)
      label2.setVertexZ(0)
      label3.setVertexZ(-50)

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("Images/bugs/circle.plist")
      mgr = CCSpriteBatchNode.create("Images/bugs/circle.png", 9)
      layer.addChild(mgr)

      @sp1 = CCSprite.createWithSpriteFrameName("circle.png")
      @sp2 = CCSprite.createWithSpriteFrameName("circle.png")
      @sp3 = CCSprite.createWithSpriteFrameName("circle.png")
      @sp4 = CCSprite.createWithSpriteFrameName("circle.png")
      @sp5 = CCSprite.createWithSpriteFrameName("circle.png")
      @sp6 = CCSprite.createWithSpriteFrameName("circle.png")
      @sp7 = CCSprite.createWithSpriteFrameName("circle.png")
      @sp8 = CCSprite.createWithSpriteFrameName("circle.png")
      @sp9 = CCSprite.createWithSpriteFrameName("circle.png")

      mgr.addChild(@sp1, 9)
      mgr.addChild(@sp2, 8)
      mgr.addChild(@sp3, 7)
      mgr.addChild(@sp4, 6)
      mgr.addChild(@sp5, 5)
      mgr.addChild(@sp6, 4)
      mgr.addChild(@sp7, 3)
      mgr.addChild(@sp8, 2)
      mgr.addChild(@sp9, 1)

      @sp1.setVertexZ(400)
      @sp2.setVertexZ(300)
      @sp3.setVertexZ(200)
      @sp4.setVertexZ(100)
      @sp5.setVertexZ(0)
      @sp6.setVertexZ(-100)
      @sp7.setVertexZ(-200)
      @sp8.setVertexZ(-300)
      @sp9.setVertexZ(-400)

      @sp9.setScale(2)
      @sp9.setColor(ccYELLOW)

      that = self
      layer.registerScriptTouchHandler(Proc.new {|*args| that.touchHandler(*args)},
                                       false, -1, false)
      layer
    end

    def touchHandler(event_type, x, y)
      if event_type == CCTOUCHBEGAN
        ccTouchesBegan(x, y)
      elsif event_type == CCTOUCHMOVED
        ccTouchesMoved(x, y)
      elsif event_type == CCTOUCHENDED
        ccTouchesEnded(x, y)
      end
    end

    def ccTouchesBegan(x, y)
      location = ccp(x, y)

      @sp1.setPosition(location)
      @sp2.setPosition(location)
      @sp3.setPosition(location)
      @sp4.setPosition(location)
      @sp5.setPosition(location)
      @sp6.setPosition(location)
      @sp7.setPosition(location)
      @sp8.setPosition(location)
      @sp9.setPosition(location)
      true
    end

    def ccTouchesMoved(x, y)
      location = ccp(x, y)

      @sp1.setPosition(location)
      @sp2.setPosition(location)
      @sp3.setPosition(location)
      @sp4.setPosition(location)
      @sp5.setPosition(location)
      @sp6.setPosition(location)
      @sp7.setPosition(location)
      @sp8.setPosition(location)
      @sp9.setPosition(location)
    end

    def ccTouchesEnded(x, y)
      renderScreenShot()
    end

    def renderScreenShot()
      texture = CCRenderTexture.create(512, 512)
      return if texture.nil?

      texture.setAnchorPoint(ccp(0, 0))
      texture.begin()

      @layer.visit()

      texture.end()

      sprite = CCSprite.createWithTexture(texture.getSprite().getTexture())

      sprite.setPosition(ccp(256, 256))
      sprite.setOpacity(182)
      sprite.setFlipY(1)
      @layer.addChild(sprite, 999999)
      sprite.setColor(ccGREEN)

      arr = CCArray.create
      arr << CCFadeTo.create(2, 0)
      arr << CCHide.create()
      sprite.runAction(CCSequence.create(arr))
    end
  end

  class RenderTextureTestDepthStencil < RenderTextureTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      sprite = CCSprite.create("Images/fire.png")
      sprite.setPosition(ccp(s.width * 0.25, 0))
      sprite.setScale(10)
      rend = CCRenderTexture.create(s.width, s.height,
                                    kCCTexture2DPixelFormat_RGBA4444,
                                    GL_DEPTH24_STENCIL8)

      glStencilMask(0xFF)
      rend.beginWithClear(0, 0, 0, 0, 0, 0)

      #! mark sprite quad into stencil buffer
      glEnable(GL_STENCIL_TEST)
      glStencilFunc(GL_ALWAYS, 1, 0xFF)
      glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE)
      glColorMask(0, 0, 0, 1)
      sprite.visit()

      #! move sprite half width and height, and draw only where not marked
      sprite.setPosition(ccpAdd(sprite.getPosition(),
                                ccpMult(ccp(sprite.getContentSize().width * sprite.getScale(),
                                            sprite.getContentSize().height * sprite.getScale()),
                                        0.5)))
      glStencilFunc(GL_NOTEQUAL, 1, 0xFF)
      glColorMask(1, 1, 1, 1)
      sprite.visit()

      rend.end()

      glDisable(GL_STENCIL_TEST)

      rend.setPosition(ccp(s.width * 0.5, s.height * 0.5))

      layer.addChild(rend)
      layer
    end

    def title
      "Testing depthStencil attachment"
    end

    def subtitle
      "Circle should be missing 1/4 of its region"
    end
  end

  class RenderTextureTargetNode < RenderTextureTestBase
    def init_with_layer(layer)
      super(layer)
      #
      #     1    2
      # A: A1   A2
      #
      # B: B1   B2
      #
      #  A1: premulti sprite
      #  A2: premulti render
      #
      #  B1: non-premulti sprite
      #  B2: non-premulti render
      #
      background = CCLayerColor.create(ccc4(40,40,40,255))
      layer.addChild(background)

      # sprite 1
      @sprite1 = CCSprite.create("Images/fire.png")

      # sprite 2
      @sprite2 = CCSprite.create("Images/fire_rgba8888.pvr")

      s = @@size

      # Create the render texture
      @renderTexture = CCRenderTexture.create(s.width, s.height,
                                              kCCTexture2DPixelFormat_RGBA4444)
    
      @renderTexture.setPosition(ccp(s.width/2, s.height/2))
      #     [renderTexture setPosition:ccp(s.width, s.height)];
      #     renderTexture.scale = 2;
    
      # add the sprites to the render texture
      @renderTexture.addChild(@sprite1)
      @renderTexture.addChild(@sprite2)
      @renderTexture.setClearColor(ccc4f(0, 0, 0, 0))
      @renderTexture.setClearFlags(GL_COLOR_BUFFER_BIT)

      # add the render texture to the scene
      layer.addChild(@renderTexture)

      @renderTexture.setAutoDraw(true)

      that = self
      layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)

      # Toggle clear on / off
      item = CCMenuItemFont.create("Clear On/Off", self, :touched)
      menu = CCMenu.createWithItem(item)
      layer.addChild(menu)

      menu.setPosition(ccp(s.width/2, s.height/2))

      layer
    end

    def touched(*args)
      if @renderTexture.getClearFlags() == 0
        @renderTexture.setClearFlags(GL_COLOR_BUFFER_BIT)
      else
        @renderTexture
          .setClearFlags(0)
          .setClearColor(ccc4f( CCRANDOM_0_1(), CCRANDOM_0_1(), CCRANDOM_0_1(), 1))
      end
    end

    def update(dt)
      @time = 0 unless @time
      r = 80
      @sprite1.setPosition(ccp(Math.cos(@time * 2) * r, Math.sin(@time * 2) * r))
      @sprite2.setPosition(ccp(Math.sin(@time * 2) * r, Math.cos(@time * 2) * r))
      @time += dt
    end

    def title
      "Testing Render Target Node"
    end

    def subtitle
      "Sprites should be equal and move with each frame"
    end
  end

  def initialize
    super
    [RenderTextureSave,
     RenderTextureIssue937,
     RenderTextureZbuffer,
     #RenderTextureTestDepthStencil, #needs GL
     RenderTextureTargetNode,
     #SpriteRenderTextureBug, #not supported
     ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end

