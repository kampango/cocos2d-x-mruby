require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class TexturePackerEncryption < TestBase
  extend TestBaseExt
  self.supported = true

  def title
    "Texture Atlas Encryption"
  end

  def subtitle
    ""
  end

  def onEnter
    s = @@size
    # Load the non-encrypted atlas
    CCSpriteFrameCache.sharedSpriteFrameCache()
      .addSpriteFramesWithFile("Images/nonencryptedAtlas.plist",
                               "Images/nonencryptedAtlas.pvr.ccz")

    # Create a sprite from the non-encrypted atlas
    nonencryptedSprite = CCSprite.createWithSpriteFrameName("Icon.png")
    nonencryptedSprite.setPosition(ccp(s.width * 0.25, s.height * 0.5))
    @layer.addChild(nonencryptedSprite)

    nonencryptedSpriteLabel = CCLabelTTF.create("non-encrypted", "Arial", 28)
    nonencryptedSpriteLabel.setPosition(ccp(s.width * 0.25, nonencryptedSprite.boundingBox().getMinY() - nonencryptedSprite.getContentSize().height/2))
    @layer.addChild(nonencryptedSpriteLabel, 1)

    # Load the encrypted atlas
    # 1) Set the encryption keys or step 2 will fail
    # In this case the encryption key 0xaaaaaaaabbbbbbbbccccccccdddddddd is
    # split into four parts. See the header docs for more information.
    #ZipUtils.ccSetPvrEncryptionKeyPart(0, 0xaaaaaaaa)
    #ZipUtils.ccSetPvrEncryptionKeyPart(1, 0xbbbbbbbb)
    #ZipUtils.ccSetPvrEncryptionKeyPart(2, 0xcccccccc)
    #ZipUtils.ccSetPvrEncryptionKeyPart(3, 0xdddddddd)

    #0xaaaaaaaa # mruby handles this as Float
    ZipUtils.ccSetPvrEncryptionKeyPart(0, (0x55555555 + 1) * -1)
    ZipUtils.ccSetPvrEncryptionKeyPart(1, (0x44444444 + 1) * -1)
    ZipUtils.ccSetPvrEncryptionKeyPart(2, (0x33333333 + 1) * -1)
    ZipUtils.ccSetPvrEncryptionKeyPart(3, (0x22222222 + 1) * -1)

    # Alternatively, you can call the function that accepts the key in a single
    # function call.
    # This is slightly less secure because the entire key is more easily
    # found in the compiled source. See the header docs for more information.
    # ZipUtils.ccSetPvrEncryptionKey(0xaaaaaaaa, 0xbbbbbbbb, 0xcccccccc, 0xdddddddd)

    # 2) Load the encrypted atlas
    CCSpriteFrameCache.sharedSpriteFrameCache()
      .addSpriteFramesWithFile("Images/encryptedAtlas.plist",
                               "Images/encryptedAtlas.pvr.ccz")

    # 3) Create a sprite from the encrypted atlas
    encryptedSprite = CCSprite.createWithSpriteFrameName("powered.png")
    encryptedSprite.setPosition(ccp(s.width * 0.75, s.height * 0.5))
    @layer.addChild(encryptedSprite)

    encryptedSpriteLabel = CCLabelTTF.create("encrypted", "Arial", 28)
    encryptedSpriteLabel.setPosition(ccp(s.width * 0.75, encryptedSprite.boundingBox().getMinY() - encryptedSpriteLabel.getContentSize().height/2))
    @layer.addChild(encryptedSpriteLabel, 1)
  end

  def init_with_layer(layer)
    super(layer)
    @layer = layer

    that = self
    layer.registerScriptHandler(Proc.new {|tag|
                                  if tag == Cocos2d.kCCNodeOnEnter
                                    that.onEnter
                                  end})
    @layer
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
