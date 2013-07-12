require "mruby_script/cctype_helper"
require "mruby_script/ccgl_program_constant"
require "mruby_script/gl_constant"
require "mruby_script/main_menu"
require "mruby_script/test_base"

class TextureCacheTest < TestBase
  extend TestBaseExt
  self.supported = true

  def init_with_layer(layer)
    super(layer)
    that = self
    layer.registerScriptHandler(Proc.new {|tag|
                                  if tag == Cocos2d.kCCNodeOnEnter
                                    that.onEnter
                                  elsif tag == Cocos2d.kCCNodeOnExit
                                    that.onExit
                                  end})
    @layer = layer
    @layer
  end

  def onEnter
    @nNumberOfSprites = 20
    @nNumberOfLoadedSprites = 0

    size = @@size

    @pLabelLoading = CCLabelTTF.create("loading...", "Arial", 15)
    @pLabelPercent = CCLabelTTF.create("%0", "Arial", 15)

    @pLabelLoading.setPosition(ccp(size.width / 2, size.height / 2 - 20))
    @pLabelPercent.setPosition(ccp(size.width / 2, size.height / 2 + 20))

    @layer.addChild(@pLabelLoading)
    @layer.addChild(@pLabelPercent)

    # load textrues
    @image_names = ["Images/HelloWorld.png",
                    "Images/grossini.png",
                    "Images/grossini_dance_01.png",
                    "Images/grossini_dance_02.png",
                    "Images/grossini_dance_03.png",
                    "Images/grossini_dance_04.png",
                    "Images/grossini_dance_05.png",
                    "Images/grossini_dance_06.png",
                    "Images/grossini_dance_07.png",
                    "Images/grossini_dance_08.png",
                    "Images/grossini_dance_09.png",
                    "Images/grossini_dance_10.png",
                    "Images/grossini_dance_11.png",
                    "Images/grossini_dance_12.png",
                    "Images/grossini_dance_13.png",
                    "Images/grossini_dance_14.png",
                    "Images/background1.png",
                    "Images/background2.png",
                    "Images/background3.png",
                    "Images/blocks.png",
                   ]

    cache = CCTextureCache.sharedTextureCache()
    @image_names.each do |name|
      cache.addImageAsync(name, self, :loadingCallBack)
    end
  end

  def onExit
    cache = CCTextureCache.sharedTextureCache()
    @image_names.each do |name|
      cache.removeTextureForKey(name)
    end
    cache.removeUnusedTextures()
  end

  def loadingCallBack(obj)
    @nNumberOfLoadedSprites += 1
    tmp = "%#{((@nNumberOfLoadedSprites / @nNumberOfSprites) * 100).to_i}"
    @pLabelPercent.setString(tmp)

    if @nNumberOfLoadedSprites == @nNumberOfSprites
      @layer.removeChild(@pLabelLoading, true)
      @layer.removeChild(@pLabelPercent, true)
      addSprite()
    end
  end

  def addSprite
    size = @@size

    # create sprites

    bg = CCSprite.create("Images/HelloWorld.png")
    bg.setPosition(ccp(size.width / 2, size.height / 2))

    s1 = CCSprite.create("Images/grossini.png")
    s2 = CCSprite.create("Images/grossini_dance_01.png")
    s3 = CCSprite.create("Images/grossini_dance_02.png")
    s4 = CCSprite.create("Images/grossini_dance_03.png")
    s5 = CCSprite.create("Images/grossini_dance_04.png")
    s6 = CCSprite.create("Images/grossini_dance_05.png")
    s7 = CCSprite.create("Images/grossini_dance_06.png")
    s8 = CCSprite.create("Images/grossini_dance_07.png")
    s9 = CCSprite.create("Images/grossini_dance_08.png")
    s10 = CCSprite.create("Images/grossini_dance_09.png")
    s11 = CCSprite.create("Images/grossini_dance_10.png")
    s12 = CCSprite.create("Images/grossini_dance_11.png")
    s13 = CCSprite.create("Images/grossini_dance_12.png")
    s14 = CCSprite.create("Images/grossini_dance_13.png")
    s15 = CCSprite.create("Images/grossini_dance_14.png")

    # just loading textures to slow down
    CCSprite.create("Images/background1.png")
    CCSprite.create("Images/background2.png")
    CCSprite.create("Images/background3.png")
    CCSprite.create("Images/blocks.png")

    s1.setPosition(ccp(50, 50))
    s2.setPosition(ccp(60, 50))
    s3.setPosition(ccp(70, 50))
    s4.setPosition(ccp(80, 50))
    s5.setPosition(ccp(90, 50))
    s6.setPosition(ccp(100, 50))

    s7.setPosition(ccp(50, 180))
    s8.setPosition(ccp(60, 180))
    s9.setPosition(ccp(70, 180))
    s10.setPosition(ccp(80, 180))
    s11.setPosition(ccp(90, 180))
    s12.setPosition(ccp(100, 180))

    s13.setPosition(ccp(50, 270))
    s14.setPosition(ccp(60, 270))
    s15.setPosition(ccp(70, 270))

    @layer.addChild(bg)
   
    @layer.addChild(s1)
    @layer.addChild(s2)
    @layer.addChild(s3)
    @layer.addChild(s4)
    @layer.addChild(s5)
    @layer.addChild(s6)
    @layer.addChild(s7)
    @layer.addChild(s8)
    @layer.addChild(s9)
    @layer.addChild(s10)
    @layer.addChild(s11)
    @layer.addChild(s12)
    @layer.addChild(s13)
    @layer.addChild(s14)
    @layer.addChild(s15)
  end

  def create_layer
    layer = CCLayer.create
    init_with_layer(layer)
    layer
  end

  def initialize
    super
    register_create_function(self, :create_layer)
  end

  def create
    new_scene
  end
end
