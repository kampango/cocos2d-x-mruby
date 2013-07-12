require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class ZwoptexTest < TestBase
  extend TestBaseExt
  self.supported = true

  class ZwoptexGenericTest < TestBase
    def onEnter
      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("zwoptex/grossini.plist")
      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("zwoptex/grossini-generic.plist")

      layer1 = CCLayerColor.create(ccc4(255, 0, 0, 255), 85, 121)
      layer1.setPosition(ccp(s.width/2-80 - (85.0 * 0.5),
                             s.height/2 - (121.0 * 0.5)))
      @layer.addChild(layer1)

      @sprite1 = CCSprite.createWithSpriteFrame(
        CCSpriteFrameCache.sharedSpriteFrameCache()
          .spriteFrameByName("grossini_dance_01.png"))
      @sprite1.setPosition(ccp( s.width/2-80, s.height/2))
      @layer.addChild(@sprite1)

      @sprite1.setFlipX(false)
      @sprite1.setFlipY(false)

      layer2 = CCLayerColor.create(ccc4(255, 0, 0, 255), 85, 121)
      layer2.setPosition(ccp(s.width/2+80 - (85.0 * 0.5),
                              s.height/2 - (121.0 * 0.5)))
      @layer.addChild(layer2)
    
      @sprite2 = CCSprite.createWithSpriteFrame(
        CCSpriteFrameCache.sharedSpriteFrameCache()
          .spriteFrameByName("grossini_dance_generic_01.png"))
      @sprite2.setPosition(ccp( s.width/2 + 80, s.height/2))
      @layer.addChild(@sprite2)

      @sprite2.setFlipX(false)
      @sprite2.setFlipY(false)

      that = self
      @entry = CCDirector.sharedDirector.getScheduler
        .scheduleScriptFunc(Proc.new {|dt| that.startIn05Secs(dt)}, 1.0, false)
    end

    def init_with_layer(layer)
      super(layer)
      @title_label.setString(self.title)
      @subtitle_label.setString(self.subtitle)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    elsif tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      @counter = 0

      @layer = layer
      @layer
    end

    def startIn05Secs(dt)
      return unless @entry
      CCDirector.sharedDirector.getScheduler.unscheduleScriptEntry(@entry)
      that = self
      @entry = CCDirector.sharedDirector.getScheduler
        .scheduleScriptFunc(Proc.new {|dt| that.flipSprites(dt)}, 0.5, false)
    end

    def flipSprites(dt)
      @spriteFrameIndex ||= 0
      @counter += 1

      fx = false
      fy = false
      i = @counter % 4

      case i
      when 0
        fx = false
        fy = false
      when 1
        fx = true
        fy = false
      when 2
        fx = false
        fy = true
      when 3
        fx = true
        fy = true
      end

      @sprite1.setFlipX(fx)
      @sprite2.setFlipX(fx)
      @sprite1.setFlipY(fy)
      @sprite2.setFlipY(fy)

      @spriteFrameIndex += 1
      @spriteFrameIndex = 1 if @spriteFrameIndex > 14

      str1 = sprintf("grossini_dance_%02d.png", @spriteFrameIndex)
      str2 = sprintf("grossini_dance_generic_%02d.png", @spriteFrameIndex)
      @sprite1.setDisplayFrame(CCSpriteFrameCache.sharedSpriteFrameCache()
                                 .spriteFrameByName(str1))
      @sprite2.setDisplayFrame(CCSpriteFrameCache.sharedSpriteFrameCache()
                                 .spriteFrameByName(str2))
    end

    def onExit
      if @entry
        CCDirector.sharedDirector.getScheduler.unscheduleScriptEntry(@entry)
        @entry = nil
      end
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("zwoptex/grossini.plist")
      cache.removeSpriteFramesFromFile("zwoptex/grossini-generic.plist")
    end

    def title
      "Zwoptex Tests"
    end

    def subtitle
      "Coordinate Formats, Rotation, Trimming, flipX/Y"
    end

    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end
  end

  def initialize
    super
    register_create_function(ZwoptexGenericTest, :create)
  end

  def create
    new_scene
  end
end
