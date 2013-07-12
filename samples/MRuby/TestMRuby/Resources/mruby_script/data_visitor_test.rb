require "mruby_script/test_base"

class DataVisitorTest < TestBase
  extend TestBaseExt
  self.supported = true

  class PrettyPrinterDemo < TestBase
    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end

    def init_with_layer(layer)
      super(layer)
      @title_label.setString(self.title)
      @subtitle_label.setString(self.subtitle)

      that = self
      layer.registerScriptHandler(Proc.new{|tag|
                                    if tag == Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    #elsif tag == Cocos2d.kCCNodeOnExit
                                    #  that.onExit
                                    end})
      @layer = layer
      @layer
    end

    def title
      "PrettyPrinter Test"
    end

    def subtitle
      "Please see log!"
    end

    def addSprite
      # create sprites

      s1 = CCSprite.create("Images/grossini.png")
      s2 = CCSprite.create("Images/grossini_dance_01.png")
      s3 = CCSprite.create("Images/grossini_dance_02.png")
      s4 = CCSprite.create("Images/grossini_dance_03.png")
      s5 = CCSprite.create("Images/grossini_dance_04.png")

      s1.setPosition(ccp(50, 50))
      s2.setPosition(ccp(60, 50))
      s3.setPosition(ccp(70, 50))
      s4.setPosition(ccp(80, 50))
      s5.setPosition(ccp(90, 50))

      @layer.addChild(s1)
      @layer.addChild(s2)
      @layer.addChild(s3)
      @layer.addChild(s4)
      @layer.addChild(s5)
    end

    def onEnter
      s = @@size
      # Test code
      vistor = CCPrettyPrinter.new(0)
    
      # print dictionary
      pDict = CCDictionary.createWithContentsOfFile("animations/animations.plist")
      pDict.acceptVisitor(vistor)
      cclog("%s", vistor.getResult())
      cclog("-------------------------------")

      myset = CCSet.new
      30.times do |i|
        myset.addObject(CCString.create("str: #{i}"))
      end

      vistor.clear()
      myset.acceptVisitor(vistor)
      cclog("%s", vistor.getResult())
      cclog("-------------------------------")
    
      vistor.clear()
      addSprite()
      pDict = CCTextureCache.sharedTextureCache().snapshotTextures()
      pDict.acceptVisitor(vistor)
      cclog("%s", vistor.getResult())
    end
  end

  def initialize
    super
    register_create_function(PrettyPrinterDemo, :create)
  end

  def create
    new_scene
  end
end
