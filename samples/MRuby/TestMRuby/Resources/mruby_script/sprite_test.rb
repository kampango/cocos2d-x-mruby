require "mruby_script/cctype_helper"
require "mruby_script/ccgl_program_constant"
require "mruby_script/main_menu"
require "mruby_script/test_base"

module Cocos2d
  class CCNode
    def schedule(*args)
      delay = 0
      if args[0].kind_of? Proc
        callback, delay = args
        callfunc = CCCallFunc.create(callback)
      else
        target, method, delay = args
        callfunc = CCCallFunc.create(target, method)
      end
      delay = CCDelayTime.create(delay)
      sequence = CCSequence.createWithTwoActions(delay, callfunc)
      action = CCRepeatForever.create(sequence)
      runAction(action)
      action
    end

    def performWithDelay(*args)
      delay = 0
      if args[0].kind_of? Proc
        callback, delay = args
        callfunc = CCCallFunc.create(callback)
      else
        target, method, delay = args
        callfunc = CCCallFunc.create(target, method)
      end
      delay = CCDelayTime.create(delay)
      sequence = CCSequence.createWithTwoActions(delay, callfunc)
      runAction(sequence)
      sequence
    end
  end
end

class SpriteTest < TestBase
  extend TestBaseExt
  self.supported = true

  class SpriteTestBase < TestBase
    include CCGLProgramConstant

    def kTagTileMap
      1
    end
    def kTagSpriteBatchNode
      1
    end
    def kTagNode
      2
    end
    def kTagAnimation1
      1
    end
    def kTagSpriteLeft
      2
    end
    def kTagSpriteRight
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

    def initialize
      @testLayer  = nil
      @entry      = nil
    end

    def init_with_layer(layer)
      super(layer)
      @layer = layer
      @layer
    end

    def self.create
      Cocos2d::cclog(self.to_s)
      layer = CCLayer.create()
      self.new.init_with_layer(layer)
      layer
    end
  end

  class Sprite1 < SpriteTestBase

    def init_with_layer(layer)
      super(layer)

      point = ccp(@@size.width/2, @@size.height/2)
      addNewSpriteWithCoords(layer, point)

      layer.setTouchEnabled(true)
      that = self
      layer.registerScriptTouchHandler(Proc.new {|*args| that.onTouch(*args)},
                                       false, -1, false)

      @title_label.setString("Sprite (tap screen)")
      layer
    end

    def addNewSpriteWithCoords(layer, point)
      idx = (rand() * 1400 / 100).floor
      x = ((idx % 5) * 85).floor
      y = (idx / 5 * 121).floor

      sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                               CCRectMake(x,y,85,121) )
      layer.addChild( sprite )

      sprite.setPosition( ccp(point.x, point.y) )

      action = nil
      random = rand()
      cclog("random = #{random}")
      if random < 0.20
        action = CCScaleBy.create(3, 2)
      elsif random < 0.40
        action = CCRotateBy.create(3, 360)
      elsif random < 0.60
        action = CCBlink.create(1, 3)
      elsif random < 0.8
        action = CCTintBy.create(2, 0, -255, -255)
      else
        action = CCFadeOut.create(2)
      end

      action_back = action.reverse()
      seq = CCSequence.createWithTwoActions(action, action_back)

      sprite.runAction( CCRepeatForever.create(seq) )
      layer
    end

    def onTouch(event, x, y)
      if event == CCTOUCHBEGAN
        true
      elsif event == CCTOUCHENDED
        addNewSpriteWithCoords(@layer, ccp(x,y))
        true
      end
    end
  end

  class SpriteBatchNode1 < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      batch_node = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 50)
      layer.addChild(batch_node, 0, kTagSpriteBatchNode)

      addNewSpriteWithCoords(layer, ccp(@@size.width/2, @@size.height/2))
      layer.setTouchEnabled(true)
      that = self
      layer.registerScriptTouchHandler(Proc.new {|*args| that.onTouch(*args)},
                                       false, -1, false)

      @title_label.setString("SpriteBatchNode (tap screen)")
      layer
    end

    def addNewSpriteWithCoords(layer, point)
      batch_node = layer.getChildByTag( kTagSpriteBatchNode )
      idx = (rand() * 1400 / 100).floor
      x = ((idx % 5) * 85).floor
      y = (idx / 5 * 121).floor

      sprite = CCSprite.createWithTexture(batch_node.getTexture(), CCRectMake(x,y,85,121) )
      layer.addChild( sprite )

      sprite.setPosition( ccp(point.x, point.y) )

      action = nil
      random = rand()
      cclog("random = #{random}")
      if random < 0.20
        action = CCScaleBy.create(3, 2)
      elsif random < 0.40
        action = CCRotateBy.create(3, 360)
      elsif random < 0.60
        action = CCBlink.create(1, 3)
      elsif random < 0.8
        action = CCTintBy.create(2, 0, -255, -255)
      else
        action = CCFadeOut.create(2)
      end

      action_back = action.reverse()
      seq = CCSequence.createWithTwoActions(action, action_back)

      sprite.runAction( CCRepeatForever.create(seq) )
    end

    def onTouch(event, x, y)
      if event == CCTOUCHBEGAN
        true
      elsif event == CCTOUCHENDED
        addNewSpriteWithCoords(@layer, ccp(x,y))
        true
      end
    end
  end

  class SpriteColorOpacity < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      setLayerSprite(layer)
      @title_label.setString("Sprite: Color & Opacity")

      that = self
      layer.registerScriptHandler(Proc.new {|*args| that.onEnterOrExit(*args)})
      layer
    end

    def setLayerSprite(layer)
      sprite1 = CCSprite.create("Images/grossini_dance_atlas.png",
                                CCRectMake(85*0, 121*1, 85, 121))
      sprite2 = CCSprite.create("Images/grossini_dance_atlas.png",
                                CCRectMake(85*1, 121*1, 85, 121))
      sprite3 = CCSprite.create("Images/grossini_dance_atlas.png",
                                CCRectMake(85*2, 121*1, 85, 121))
      sprite4 = CCSprite.create("Images/grossini_dance_atlas.png",
                                CCRectMake(85*3, 121*1, 85, 121))

      sprite5 = CCSprite.create("Images/grossini_dance_atlas.png",
                                CCRectMake(85*0, 121*1, 85, 121))
      sprite6 = CCSprite.create("Images/grossini_dance_atlas.png",
                                CCRectMake(85*1, 121*1, 85, 121))
      sprite7 = CCSprite.create("Images/grossini_dance_atlas.png",
                                CCRectMake(85*2, 121*1, 85, 121))
      sprite8 = CCSprite.create("Images/grossini_dance_atlas.png",
                                CCRectMake(85*3, 121*1, 85, 121))

      s = @@size
      sprite1.setPosition( ccp( (s.width/5)*1, (s.height/3)*1) )
      sprite2.setPosition( ccp( (s.width/5)*2, (s.height/3)*1) )
      sprite3.setPosition( ccp( (s.width/5)*3, (s.height/3)*1) )
      sprite4.setPosition( ccp( (s.width/5)*4, (s.height/3)*1) )
      sprite5.setPosition( ccp( (s.width/5)*1, (s.height/3)*2) )
      sprite6.setPosition( ccp( (s.width/5)*2, (s.height/3)*2) )
      sprite7.setPosition( ccp( (s.width/5)*3, (s.height/3)*2) )
      sprite8.setPosition( ccp( (s.width/5)*4, (s.height/3)*2) )
    
      action = CCFadeIn.create(2)
      action_back = action.reverse()
      fade = CCRepeatForever.create( CCSequence.createWithTwoActions(action, action_back) )
    
      tintred = CCTintBy.create(2, 0, -255, -255)
      tintred_back = tintred.reverse()
      red = CCRepeatForever.create( CCSequence.createWithTwoActions(tintred, tintred_back) )

      tintgreen = CCTintBy.create(2, -255, 0, -255)
      tintgreen_back = tintgreen.reverse()
      green = CCRepeatForever.create( CCSequence.createWithTwoActions(tintgreen, tintgreen_back) )

      tintblue = CCTintBy.create(2, -255, -255, 0)
      tintblue_back = tintblue.reverse()
      blue = CCRepeatForever.create( CCSequence.createWithTwoActions(tintblue, tintblue_back) )

      sprite5.runAction(red)
      sprite6.runAction(green)
      sprite7.runAction(blue)
      sprite8.runAction(fade)

      layer.addChild(sprite1, 0, kTagSprite1)
      layer.addChild(sprite2, 0, kTagSprite2)
      layer.addChild(sprite3, 0, kTagSprite3)
      layer.addChild(sprite4, 0, kTagSprite4)
      layer.addChild(sprite5, 0, kTagSprite5)
      layer.addChild(sprite6, 0, kTagSprite6)
      layer.addChild(sprite7, 0, kTagSprite7)
      layer.addChild(sprite8, 0, kTagSprite8)
    end

    def onEnterOrExit(tag)
      if tag == kCCNodeOnEnter
        that = self
        scheduler = CCDirector.sharedDirector.getScheduler
        @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.removeAndAddSprite(dt)}, 2, false)
      else tag == kCCNodeOnExit
        CCDirector.sharedDirector.getScheduler
          .unscheduleScriptEntry(@entry)
      end
    end

    def removeAndAddSprite(dt)
      sprite = @layer.getChildByTag(kTagSprite5)    
      @layer.removeChild(sprite, false)
      @layer.addChild(sprite, 0, kTagSprite5)
    end
  end

  class SpriteBatchNodeColorOpacity < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      setLayerSprite(layer)
      @title_label.setString("SpriteBatchNode: Color & Opacity")

      that = self
      layer.registerScriptHandler(Proc.new {|*args| that.onEnterOrExit(*args)})
      layer
    end

    def setLayerSprite(layer)
      # small capacity. Testing resizing.
      # Don't use capacity=1 in your real game. It is expensive to resize the capacity
      batch = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 1)
      sprite1 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*0, 121*1, 85, 121))
      sprite2 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*1, 121*1, 85, 121))
      sprite3 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*2, 121*1, 85, 121))
      sprite4 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*3, 121*1, 85, 121))

      sprite5 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*0, 121*1, 85, 121))
      sprite6 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*1, 121*1, 85, 121))
      sprite7 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*2, 121*1, 85, 121))
      sprite8 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*3, 121*1, 85, 121))

      s = @@size
      sprite1.setPosition( ccp( (s.width/5)*1, (s.height/3)*1) )
      sprite2.setPosition( ccp( (s.width/5)*2, (s.height/3)*1) )
      sprite3.setPosition( ccp( (s.width/5)*3, (s.height/3)*1) )
      sprite4.setPosition( ccp( (s.width/5)*4, (s.height/3)*1) )
      sprite5.setPosition( ccp( (s.width/5)*1, (s.height/3)*2) )
      sprite6.setPosition( ccp( (s.width/5)*2, (s.height/3)*2) )
      sprite7.setPosition( ccp( (s.width/5)*3, (s.height/3)*2) )
      sprite8.setPosition( ccp( (s.width/5)*4, (s.height/3)*2) )
    
      action = CCFadeIn.create(2)
      action_back = action.reverse()
      fade = CCRepeatForever.create( CCSequence.createWithTwoActions(action, action_back) )
    
      tintred = CCTintBy.create(2, 0, -255, -255)
      tintred_back = tintred.reverse()
      red = CCRepeatForever.create( CCSequence.createWithTwoActions(tintred, tintred_back) )

      tintgreen = CCTintBy.create(2, -255, 0, -255)
      tintgreen_back = tintgreen.reverse()
      green = CCRepeatForever.create( CCSequence.createWithTwoActions(tintgreen, tintgreen_back) )

      tintblue = CCTintBy.create(2, -255, -255, 0)
      tintblue_back = tintblue.reverse()
      blue = CCRepeatForever.create( CCSequence.createWithTwoActions(tintblue, tintblue_back) )

      sprite5.runAction(red)
      sprite6.runAction(green)
      sprite7.runAction(blue)
      sprite8.runAction(fade)

      layer.addChild(sprite1, 0, kTagSprite1)
      layer.addChild(sprite2, 0, kTagSprite2)
      layer.addChild(sprite3, 0, kTagSprite3)
      layer.addChild(sprite4, 0, kTagSprite4)
      layer.addChild(sprite5, 0, kTagSprite5)
      layer.addChild(sprite6, 0, kTagSprite6)
      layer.addChild(sprite7, 0, kTagSprite7)
      layer.addChild(sprite8, 0, kTagSprite8)
    end

    def onEnterOrExit(tag)
      if tag == kCCNodeOnEnter
        that = self
        scheduler = CCDirector.sharedDirector.getScheduler
        @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.removeAndAddSprite(dt)}, 2, false)
      else tag == kCCNodeOnExit
        CCDirector.sharedDirector.getScheduler
          .unscheduleScriptEntry(@entry)
      end
    end

    def removeAndAddSprite(dt)
      sprite = @layer.getChildByTag(kTagSprite5)    
      @layer.removeChild(sprite, false)
      @layer.addChild(sprite, 0, kTagSprite5)
    end
  end

  class SpriteFrameTest < SpriteTestBase
    def initialize
      @entry = nil
      @pSprite1 = nil
      @pSprite2 = nil
      @nCounter = 0
    end

    def onEnter
      s = @@size
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()

      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist", "animations/grossini_gray.png")
      cache.addSpriteFramesWithFile("animations/grossini_blue.plist", "animations/grossini_blue.png")

      @pSprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      @pSprite1.setPosition( ccp( s.width/2-80, s.height/2) )

      spritebatch = CCSpriteBatchNode.create("animations/grossini.png")
      spritebatch.addChild(@pSprite1)
      @layer.addChild(spritebatch)

      animFrames = CCArray.createWithCapacity(15)
      14.times do |i|
        frame = cache.spriteFrameByName( sprintf("grossini_dance_%02d.png", i + 1) )
        animFrames.addObject(frame)
      end

      animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
      @pSprite1.runAction( CCRepeatForever.create( CCAnimate.create(animation) ) )

      @pSprite1.setFlipX(false)
      @pSprite1.setFlipY(false)

      @pSprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      @pSprite2.setPosition( ccp( s.width/2 + 80, s.height/2) )
      @layer.addChild(@pSprite2)

      moreFrames = CCArray.createWithCapacity(20)

      14.times do |i|
        frame = cache.spriteFrameByName(sprintf("grossini_dance_gray_%02d.png", i + 1))
        moreFrames.addObject(frame)
      end

      4.times do |i|
        frame = cache.spriteFrameByName(sprintf("grossini_blue_%02d.png", i + 1))
        p i
        moreFrames.addObject(frame)
      end

      moreFrames.addObjectsFromArray(animFrames)
      animMixed = CCAnimation.createWithSpriteFrames(moreFrames, 0.3)

      @pSprite2.runAction(CCRepeatForever.create( CCAnimate.create(animMixed) ) )

      @pSprite2.setFlipX(false)
      @pSprite2.setFlipY(false)


      @layer.performWithDelay(self, :startIn05Secs, 0.5)
      #that = self
      #@layer.performWithDelay(Proc.new {that.startIn05Secs}, 0.5)
      @nCounter = 0
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/grossini.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_blue.plist")
    end

    def startIn05Secs
      @layer.schedule(self, :flipSprites, 1)
      #that = self
      #@layer.schedule(Proc.new{|dt| that.flipSprites(dt)}, 1)
    end

    def flipSprites
      @nCounter += 1

      fx = false
      fy = false
      i  = @nCounter % 4

      if i == 0
        fx = false
        fy = false
      elsif i == 1
        fx = true
        fy = false
      elsif i == 2
        fx = false
        fy = true
      elsif i == 3
        fx = true
        fy = true
      end

      @pSprite1.setFlipX(fx)
      @pSprite1.setFlipY(fy)
      @pSprite2.setFlipX(fx)
      @pSprite2.setFlipY(fy)
    end

    def onEnterOrExit(tag)
      if tag == kCCNodeOnEnter
        onEnter
      elsif tag == kCCNodeOnExit
        onExit
      end
    end

    def init_with_layer(layer)
      super(layer)
      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.onEnterOrExit(tag)})
      @title_label.setString("Sprite vs. SpriteBatchNode animation")
      layer
    end
  end

  class SpriteFrameAliasNameTest < SpriteTestBase
    def onEnter
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini-aliases.plist",
                                    "animations/grossini-aliases.png")

      sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite.setPosition(ccp(s.width * 0.5, s.height * 0.5))

      spriteBatch = CCSpriteBatchNode.create("animations/grossini-aliases.png")
      cclog("spriteBatch = #{spriteBatch}")
      cclog("sprite = #{sprite}")

      spriteBatch.addChild(sprite)
      @layer.addChild(spriteBatch)

      animFrames = CCArray.createWithCapacity(15)

      14.times do |i|
        frame = cache.spriteFrameByName(sprintf("dance_%02d", i + 1))
        animFrames.addObject(frame)
      end

      animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
      # 14 frames * 1sec = 14 seconds
      sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))
    end

    def onExit
      CCSpriteFrameCache.sharedSpriteFrameCache()
        .removeSpriteFramesFromFile("animations/grossini-aliases.plist")
    end

    def onEnterOrExit(tag)
      if tag == kCCNodeOnEnter
		onEnter
      elsif tag == kCCNodeOnExit
		onExit
      end
    end

    def init_with_layer(layer)
      super(layer)
      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.onEnterOrExit(tag)})
      @title_label.setString("SpriteFrame Alias Name")
      @subtitle_label.setString("SpriteFrames are obtained using the alias name")
      layer
    end
  end

  class SpriteAnchorPoint < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      rotate = CCRotateBy.create(10, 360)
      action = CCRepeatForever.create(rotate)

      3.times do |i|
        sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                                 CCRectMake(85*i, 121*1, 85, 121) )
          .setPosition( ccp( s.width/4*(i+1), s.height/2) )
        
        point = CCSprite.create("Images/r1.png")
          .setScale( 0.25 )
          .setPosition( sprite.getPosition() )
        layer.addChild(point, 10)
        
        if i == 0
          sprite.setAnchorPoint( ccp(0, 0) )
        elsif i == 1 then
          sprite.setAnchorPoint( ccp(0.5, 0.5) )
        elsif i == 2
          sprite.setAnchorPoint( ccp(1,1) )
        end
        point.setPosition( sprite.getPosition() )
        
        copy = action.copy()
        sprite.runAction(copy)
        layer.addChild(sprite, i)
      end

      @title_label.setString("Sprite. anchor point")
      @subtitle_label.setString("")
      layer
    end
  end

  class SpriteBatchNodeAnchorPoint < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      # small capacity. Testing resizing.
      # Don't use capacity=1 in your real game. It is expensive to resize the capacity
      batch = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 1)
      layer.addChild(batch, 0, kTagSpriteBatchNode)        

      s = @@size

      rotate = CCRotateBy.create(10, 360)
      action = CCRepeatForever.create(rotate)
      3.times do |i|
        sprite = CCSprite.createWithTexture(batch.getTexture(),
                                            CCRectMake(85*i, 121*1, 85, 121))
          .setPosition( ccp( s.width/4*(i+1), s.height/2) )

        point = CCSprite.create("Images/r1.png")
          .setScale( 0.25 )
          .setPosition( ccp(sprite.getPosition()) )
        layer.addChild(point, 1)

        if i == 0
          sprite.setAnchorPoint( ccp(0,0) )
        elsif i == 1
          sprite.setAnchorPoint( ccp(0.5, 0.5) )
        elsif i == 2 
          sprite.setAnchorPoint( ccp(1,1) )
        end

        point.setPosition( ccp(sprite.getPosition()) )

        copy = action.copy()
        sprite.runAction(copy)
        batch.addChild(sprite, i)
      end

      @title_label.setString("SpriteBatchNode: anchor point")
      @subtitle_label.setString("")
      layer
    end
  end

  class SpriteOffsetAnchorRotation < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      3.times do |i|
        #
        # Animation using Sprite batch
        #
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp( s.width/4*(i+1), s.height/2))

        point = CCSprite.create("Images/r1.png")
        point.setScale( 0.25 )
        point.setPosition( sprite.getPosition() )
        layer.addChild(point, 1)

        if i == 0
          sprite.setAnchorPoint( ccp(0, 0) )
        elsif i == 1
          sprite.setAnchorPoint( ccp(0.5, 0.5) )
        elsif i == 2 then
          sprite.setAnchorPoint( ccp(1,1) )
        end

        point.setPosition( ccp(sprite.getPosition()) )

        animFrames = CCArray.createWithCapacity(14)
        
        14.times do |i|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png",(i+1)))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))
        sprite.runAction(CCRepeatForever.create(CCRotateBy.create(10, 360)))

        layer.addChild(sprite, 0)
      end        

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("Sprite offset + anchor + rot")
      @subtitle_label.setString("")

      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteBatchNodeOffsetAnchorRotation < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      spritebatch = CCSpriteBatchNode.create("animations/grossini.png")
      cclog("1")
      layer.addChild(spritebatch)

      cclog("2")
      3.times do |i|
        #
        # Animation using Sprite BatchNode
        #
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition( ccp( s.width/4*(i+1), s.height/2))

        point = CCSprite.create("Images/r1.png")
        point.setScale( 0.25 )
        point.setPosition( ccp(sprite.getPosition()) )
        layer.addChild(point, 200)

        if i == 0
          sprite.setAnchorPoint( ccp(0,0) )
        elsif i == 1
          sprite.setAnchorPoint( ccp(0.5, 0.5) )
        elsif i == 2
          sprite.setAnchorPoint( ccp(1,1) )
        end

        point.setPosition( ccp(sprite.getPosition()) )

        animFrames = CCArray.createWithCapacity(14)
        14.times do |k|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png",(k+1)))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create( CCAnimate.create(animation) ))
        sprite.runAction(CCRepeatForever.create(CCRotateBy.create(10, 360) ))
        spritebatch.addChild(sprite, i)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("SpriteBatchNode offset + anchor + rot")
      @subtitle_label.setString("")

      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteOffsetAnchorScale < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")
    
      3.times do |i|
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition( ccp( s.width/4*(i+1), s.height/2) )
        
        point = CCSprite.create("Images/r1.png")
        point.setScale( 0.25 )
        point.setPosition( sprite.getPosition() )
        layer.addChild(point, 1)
        
        if i == 0
          sprite.setAnchorPoint( ccp(0, 0) )
        elsif i == 1
          sprite.setAnchorPoint( ccp(0.5, 0.5) )
        elsif i == 2
          sprite.setAnchorPoint( ccp(1,1) )
        end
        
        point.setPosition( ccp(sprite.getPosition()) )
        
        animFrames = CCArray.createWithCapacity(14)

        14.times do |i|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png",(i+1)))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create( CCAnimate.create(animation) ))

        scale = CCScaleBy.create(2, 2)
        scale_back = scale.reverse()
        seq_scale = CCSequence.createWithTwoActions(scale, scale_back)
        sprite.runAction(CCRepeatForever.create(seq_scale))
        
        layer.addChild(sprite, 0)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("Sprite offset + anchor + scale")
      @subtitle_label.setString("")

      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteBatchNodeOffsetAnchorScale < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      spritesheet = CCSpriteBatchNode.create("animations/grossini.png")
      layer.addChild(spritesheet)

      3.times do |i|
        # Animation using Sprite BatchNode
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width/4*(i+1), s.height/2))

        point = CCSprite.create("Images/r1.png")
        point.setScale(0.25)
        point.setPosition(sprite.getPosition())
        layer.addChild(point, 200)

        if i == 0
          sprite.setAnchorPoint(CCPointMake(0,0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        else
          sprite.setAnchorPoint(ccp(1, 1))
        end

        point.setPosition(sprite.getPosition())

        animFrames = CCArray.createWithCapacity(14)
        14.times do |k|
          str = sprintf("grossini_dance_%02d.png", (k+1))
          frame = cache.spriteFrameByName(str)
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))

        scale = CCScaleBy.create(2, 2)
        scale_back = scale.reverse()
        seq_scale = CCSequence.createWithTwoActions(scale, scale_back)
        sprite.runAction(CCRepeatForever.create(seq_scale))

        spritesheet.addChild(sprite, i)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("SpriteBatchNode offset + anchor + scale")
      @subtitle_label.setString("")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteOffsetAnchorSkew < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      3.times do |i|
        #
        # Animation using Sprite batch
        #
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width / 4 * (i + 1), s.height / 2))

        point = CCSprite.create("Images/r1.png")
        point.setScale(0.25)
        point.setPosition(sprite.getPosition())
        layer.addChild(point, 1)

        if i == 0
          sprite.setAnchorPoint(ccp(0, 0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        elsif i == 2
          sprite.setAnchorPoint(ccp(1, 1))
        end

        point.setPosition(sprite.getPosition())

        animFrames = CCArray.create()
        14.times do |j|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", j + 1))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))

        actionArray = CCArray.create()
        skewX = CCSkewBy.create(2, 45, 0)
        actionArray.addObject(skewX)
        skewX_back = skewX.reverse()
        actionArray.addObject(skewX_back)
        skewY = CCSkewBy.create(2, 0, 45)
        actionArray.addObject(skewY)
        skewY_back = skewY.reverse()
        actionArray.addObject(skewY_back)

        seq_skew = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq_skew))

        layer.addChild(sprite, 0)
      end       

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("Sprite offset + anchor + skew")
      @subtitle_label.setString("")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteBatchNodeOffsetAnchorSkew < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")
    
      spritebatch = CCSpriteBatchNode.create("animations/grossini.png")
      layer.addChild(spritebatch)

      3.times do |i|
        #
        # Animation using Sprite batch
        #
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width / 4 * (i + 1), s.height / 2))

        point = CCSprite.create("Images/r1.png")
        point.setScale(0.25)
        point.setPosition(ccp(sprite.getPosition()))
        layer.addChild(point, 200)

        if i == 0
          sprite.setAnchorPoint(ccp(0, 0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        elsif i == 2
          sprite.setAnchorPoint(ccp(1, 1))
        end

        point.setPosition(ccp(sprite.getPosition()))
        
        animFrames = CCArray.create()
        14.times do |j|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", j + 1))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))

        actionArray = CCArray.create()
        skewX = CCSkewBy.create(2, 45, 0)
        actionArray.addObject(skewX)
        skewX_back = skewX.reverse()
        actionArray.addObject(skewX_back)
        skewY = CCSkewBy.create(2, 0, 45)
        actionArray.addObject(skewY)
        skewY_back = skewY.reverse()
        actionArray.addObject(skewY_back)

        seq_skew = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq_skew))

        spritebatch.addChild(sprite, i)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("SpriteBatchNode offset + anchor + skew")
      @subtitle_label.setString("")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteOffsetAnchorRotationalSkew < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")
    
      3.times do |i|
        #
        # Animation using Sprite batch
        #
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width/4*(i+1), s.height/2))
        
        point = CCSprite.create("Images/r1.png")
                            
        point.setScale(0.25)
        point.setPosition(ccp(sprite.getPosition()))
        layer.addChild(point, 1)
        
        if i == 0
          sprite.setAnchorPoint(ccp(0,0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        elsif i == 2
          sprite.setAnchorPoint(ccp(1,1))
        end
        
        point.setPosition(ccp(sprite.getPosition()))
        
        animFrames = CCArray.create()
        14.times do |i|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", (i+1)))
          animFrames.addObject(frame)
        end
        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))
        
        actionArray = CCArray.create()
        skewX = CCRotateBy.create(2, 45, 0)
        actionArray.addObject(skewX)
        skewX_back = skewX.reverse()
        actionArray.addObject(skewX_back)
        skewY = CCRotateBy.create(2, 0, -45)
        actionArray.addObject(skewY)
        skewY_back = skewY.reverse()
        actionArray.addObject(skewY_back)
        
        seq_skew = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq_skew))
        
        layer.addChild(sprite, 0)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("Sprite offset + anchor + rotational skew")
      @subtitle_label.setString("")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteBatchNodeOffsetAnchorRotationalSkew < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")
    
      spritebatch = CCSpriteBatchNode.create("animations/grossini.png")
      layer.addChild(spritebatch)

      3.times do |i|
        #
        # Animation using Sprite batch
        #
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width/4*(i+1), s.height/2))
        
        point = CCSprite.create("Images/r1.png")
        
        point.setScale(0.25)
        point.setPosition(ccp(sprite.getPosition()))
        layer.addChild(point, 200)
        
        if i == 0
          sprite.setAnchorPoint(ccp(0,0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        elsif i == 2
          sprite.setAnchorPoint(ccp(1,1))
        end

        point.setPosition(ccp(sprite.getPosition()))
        
        animFrames = CCArray.create()
        14.times do |j|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", (j+1)))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))
        
        actionArray = CCArray.create()
        skewX = CCRotateBy.create(2, 45, 0)
        actionArray.addObject(skewX)
        skewX_back = skewX.reverse()
        actionArray.addObject(skewX_back)
        skewY = CCRotateBy.create(2, 0, -45)
        actionArray.addObject(skewY)
        skewY_back = skewY.reverse()
        actionArray.addObject(skewY_back)
        
        seq_skew = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq_skew))
        
        spritebatch.addChild(sprite, i)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("SpriteBatchNode offset + anchor + rot skew")
      @subtitle_label.setString("")
      layer
    end

    # remove resources
    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteOffsetAnchorRotationalSkewScale < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")
    
      3.times do |i|
        # Animation using Sprite batch
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width/4*(i+1), s.height/2))
        
        point = CCSprite.create("Images/r1.png")

        point.setScale(0.25)
        point.setPosition(sprite.getPosition())
        layer.addChild(point, 1)

        if i == 0
          sprite.setAnchorPoint(ccp(0, 0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        else
          sprite.setAnchorPoint(ccp(1, 1))
        end
        
        point.setPosition(sprite.getPosition())

        animFrames = CCArray.create()
        14.times do |j|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", (j+1)))
          animFrames.addObject(frame)
        end
        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))
        
        # Skew
        skewX = CCRotateBy.create(2, 45, 0)
        skewX_back = skewX.reverse()
        skewY = CCRotateBy.create(2, 0, 45)
        skewY_back = skewY.reverse()

        actionArray = CCArray.create()
        actionArray.addObject(skewX)
        actionArray.addObject(skewX_back)
        actionArray.addObject(skewY)
        actionArray.addObject(skewY_back)
        seq_skew = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq_skew))
        
        # Scale
        scale = CCScaleBy.create(2, 2)
        scale_back = scale.reverse()
        seq_scale = CCSequence.createWithTwoActions(scale, scale_back)
        sprite.runAction(CCRepeatForever.create(seq_scale))

        layer.addChild(sprite, i)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("Sprite anchor + rot skew + scale")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteBatchNodeOffsetAnchorRotationalSkewScale < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      spritebatch = CCSpriteBatchNode.create("animations/grossini.png")
      layer.addChild(spritebatch)

      3.times do |i|
        # Animation using Sprite batch
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width/4*(i+1), s.height/2))

        point = CCSprite.create("Images/r1.png")

        point.setScale(0.25)
        point.setPosition(sprite.getPosition())

        layer.addChild(point, 200)

        if i == 0
          sprite.setAnchorPoint(ccp(0, 0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        else
          sprite.setAnchorPoint(ccp(1, 1))
        end
        
        point.setPosition(sprite.getPosition())

        animFrames = CCArray.create()
        14.times do |j|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", j+1))
          animFrames.addObject(frame)
        end
        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))
        
        # Skew
        skewX = CCRotateBy.create(2, 45, 0)
        skewX_back = skewX.reverse()
        skewY = CCRotateBy.create(2, 0, 45)
        skewY_back = skewY.reverse()

        actionArray = CCArray.create()
        actionArray.addObject(skewX)
        actionArray.addObject(skewX_back)
        actionArray.addObject(skewY)
        actionArray.addObject(skewY_back)
        seq_skew = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq_skew))
        
        # Scale
        scale = CCScaleBy.create(2, 2)
        scale_back = scale.reverse()
        seq_scale = CCSequence.createWithTwoActions(scale, scale_back)
        sprite.runAction(CCRepeatForever.create(seq_scale))
        
        spritebatch.addChild(sprite, i)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("SpriteBatchNode anchor + rot skew + scale")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteOffsetAnchorFlip < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      3.times do |i|
        # Animation using Sprite batch
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width / 4 * (i + 1), s.height / 2))

        point = CCSprite.create("Images/r1.png")
        point.setScale(0.25)
        point.setPosition(sprite.getPosition())
        layer.addChild(point, 200)

        if i == 0
          sprite.setAnchorPoint(ccp(0, 0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        else
          sprite.setAnchorPoint(ccp(1, 1))
        end

        point.setPosition(sprite.getPosition())

        animFrames = CCArray.create()
        14.times do |j|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", j+1))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))

        flip = CCFlipY.create(true)
        flip_back = CCFlipY.create(false)
        delay = CCDelayTime.create(1)
        delay2 = CCDelayTime.create(1)

        actionArray = CCArray.create()
        actionArray.addObject(delay)
        actionArray.addObject(flip)
        actionArray.addObject(delay2)
        actionArray.addObject(flip_back)
        seq = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq))

        layer.addChild(sprite, 0)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("Sprite offset + anchor + flip")
      @subtitle_label.setString("issue #1078")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteBatchNodeOffsetAnchorFlip < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      spritebatch = CCSpriteBatchNode.create("animations/grossini.png")
      layer.addChild(spritebatch)

      3.times do |i|
        # Animation using Sprite batch
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width / 4 * (i + 1), s.height / 2))

        point = CCSprite.create("Images/r1.png")
        point.setScale(0.25)
        point.setPosition(sprite.getPosition())
        layer.addChild(point, 1)

        if i == 0
          sprite.setAnchorPoint(ccp(0, 0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        else
          sprite.setAnchorPoint(ccp(1, 1))
        end

        point.setPosition(sprite.getPosition())

        animFrames = CCArray.create()
        14.times do |j|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", j+1))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))

        flip = CCFlipY.create(true)
        flip_back = CCFlipY.create(false)
        delay = CCDelayTime.create(1)
        delay2 = CCDelayTime.create(1)

        actionArray = CCArray.create()
        actionArray.addObject(delay)
        actionArray.addObject(flip)
        actionArray.addObject(delay2)
        actionArray.addObject(flip_back)
        seq = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq))

        spritebatch.addChild(sprite, i)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("SpriteBatchNode offset + anchor + flip")
      @subtitle_label.setString("issue #1078")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteOffsetAnchorSkewScale < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      3.times do |i|
        # Animation using Sprite batch
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width / 4 * (i + 1), s.height / 2))

        point = CCSprite.create("Images/r1.png")
        point.setScale(0.25)
        point.setPosition(sprite.getPosition())
        layer.addChild(point, 1)

        if i == 0
          sprite.setAnchorPoint(ccp(0,0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        else
          sprite.setAnchorPoint(ccp(1, 1))
        end

        point.setPosition(sprite.getPosition())

        animFrames = CCArray.create()
        14.times do |j|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", j+1))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))

        # Skew
        skewX = CCSkewBy.create(2, 45, 0)
        skewX_back = skewX.reverse()
        skewY = CCSkewBy.create(2, 0, 45)
        skewY_back = skewY.reverse()

        actionArray = CCArray.create()
        actionArray.addObject(skewX)
        actionArray.addObject(skewX_back)
        actionArray.addObject(skewY)
        actionArray.addObject(skewY_back)
        seq_skew = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq_skew))

        # Scale
        scale = CCScaleBy.create(2, 2)
        scale_back = scale.reverse()
        seq_scale = CCSequence.createWithTwoActions(scale, scale_back)
        sprite.runAction(CCRepeatForever.create(seq_scale))

        layer.addChild(sprite, 0)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("Sprite anchor + skew + scale")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteBatchNodeOffsetAnchorSkewScale < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      spritebatch = CCSpriteBatchNode.create("animations/grossini.png")
      layer.addChild(spritebatch)

      3.times do |i|
        # Animation using Sprite batch

        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width / 4 * (i + 1), s.height / 2))

        point = CCSprite.create("Images/r1.png")
        point.setScale(0.25)
        point.setPosition(sprite.getPosition())
        layer.addChild(point, 200)

        if i == 0
          sprite.setAnchorPoint(ccp(0, 0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        else
          sprite.setAnchorPoint(ccp(1, 1)) 
        end

        point.setPosition(sprite.getPosition())       

        animFrames = CCArray.create()
        14.times do |j|
          frame = cache.spriteFrameByName(sprintf("grossini_dance_%02d.png", (j+1)))
          animFrames.addObject(frame)
        end

        animation = CCAnimation.createWithSpriteFrames(animFrames, 0.3)
        sprite.runAction(CCRepeatForever.create(CCAnimate.create(animation)))

        # skew
        skewX = CCSkewBy.create(2, 45, 0)
        skewX_back = skewX.reverse()
        skewY = CCSkewBy.create(2, 0, 45)
        skewY_back = skewY.reverse()

        actionArray = CCArray.create()
        actionArray.addObject(skewX)
        actionArray.addObject(skewX_back)
        actionArray.addObject(skewY)
        actionArray.addObject(skewY_back)
        seq_skew = CCSequence.create(actionArray)
        sprite.runAction(CCRepeatForever.create(seq_skew))


        # scale 
        scale = CCScaleBy.create(2, 2)
        scale_back = scale.reverse()
        seq_scale = CCSequence.createWithTwoActions(scale, scale_back)
        sprite.runAction(CCRepeatForever.create(seq_scale))

        spritebatch.addChild(sprite, i)
      end

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("SpriteBatchNode anchor + skew + scale")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      end
    end
  end

  class SpriteAnimationSplit < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      texture = CCTextureCache.sharedTextureCache()
        .addImage("animations/dragon_animation.png")
    
      # manually add frames to the frame cache
      frame0 = CCSpriteFrame.createWithTexture(texture,
                                               CCRectMake(132*0, 132*0, 132, 132))
      frame1 = CCSpriteFrame.createWithTexture(texture,
                                               CCRectMake(132*1, 132*0, 132, 132))
      frame2 = CCSpriteFrame.createWithTexture(texture,
                                               CCRectMake(132*2, 132*0, 132, 132))
      frame3 = CCSpriteFrame.createWithTexture(texture,
                                               CCRectMake(132*3, 132*0, 132, 132))
      frame4 = CCSpriteFrame.createWithTexture(texture,
                                               CCRectMake(132*0, 132*1, 132, 132))
      frame5 = CCSpriteFrame.createWithTexture(texture,
                                               CCRectMake(132*1, 132*1, 132, 132))


      sprite = CCSprite.createWithSpriteFrame(frame0)
      sprite.setPosition( ccp( s.width/2-80, s.height/2) )
      layer.addChild(sprite)
            
      animFrames = CCArray.createWithCapacity(6)
      animFrames.addObject(frame0)
      animFrames.addObject(frame1)
      animFrames.addObject(frame2)
      animFrames.addObject(frame3)
      animFrames.addObject(frame4)
      animFrames.addObject(frame5)
            
      animation = CCAnimation.createWithSpriteFrames(animFrames, 0.2)
      animate = CCAnimate.create(animation)

      actionArray = CCArray.create()
      actionArray.addObject(animate)
      actionArray.addObject(CCFlipX.create(true))
      actionArray.addObject(animate.copy())
      actionArray.addObject(CCFlipX.create(false))
      seq = CCSequence.create(actionArray)
      sprite.runAction(CCRepeatForever.create( seq ) )

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("Sprite: Animation + flip")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnExit
        cache = CCSpriteFrameCache.sharedSpriteFrameCache()
        cache.removeSpriteFramesFromFile("animations/grossini.plist")
        cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
        cache.removeUnusedSpriteFrames
      end
    end
  end

  class SpriteZOrder < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      @dir = 1
      s = @@size
    
      step = s.width/11
      5.times do |i|
        sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                                 CCRectMake(85*0, 121*1, 85, 121))
        sprite.setPosition( ccp( (i+1)*step, s.height/2) )
        layer.addChild(sprite, i)
      end
    
      5.times do |n|
        i = n + 5
        sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                                 CCRectMake(85*1, 121*0, 85, 121))
        sprite.setPosition( ccp( (i+1)*step, s.height/2) )
        layer.addChild(sprite, 14-i)
      end
    
      sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                               CCRectMake(85*3, 121*0, 85, 121))
      layer.addChild(sprite, -1, kTagSprite1)
      sprite.setPosition( ccp(s.width/2, s.height/2 - 20) )
      sprite.setScaleX( 6 )
      sprite.setColor(ccRED)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("Sprite: Z order")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnEnter
        @layer.schedule(self, :reorderSprite, 1)
      end
    end

    def reorderSprite(*args)
      sprite = @layer.getChildByTag(kTagSprite1)

      z = sprite.getZOrder()
    
      if z < -1
        @dir = 1
      elsif z > 10
        @dir = -1
      end
      z += @dir * 3

      @layer.reorderChild(sprite, z)
    end
  end

  class SpriteBatchNodeZOrder < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      @dir = 1

      # small capacity. Testing resizing.
      # Don't use capacity=1 in your real game. It is expensive to resize the capacity
      @batch = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 1)
      layer.addChild(@batch, 0, kTagSpriteBatchNode)

      s = @@size
    
      step = s.width/11
      5.times do |i|
        sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                                 CCRectMake(85*0, 121*1, 85, 121))
        sprite.setPosition( ccp( (i+1)*step, s.height/2) )
        @batch.addChild(sprite, i)
      end
    
      5.times do |n|
        i = n + 5
        sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                                 CCRectMake(85*1, 121*0, 85, 121))
        sprite.setPosition( ccp( (i+1)*step, s.height/2) )
        @batch.addChild(sprite, 14-i)
      end
    
      sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                               CCRectMake(85*3, 121*0, 85, 121))
      @batch.addChild(sprite, -1, kTagSprite1)
      sprite.setPosition( ccp(s.width/2, s.height/2 - 20) )
      sprite.setScaleX( 6 )
      sprite.setColor(ccRED)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.eventHandler(tag)})
      @title_label.setString("SpriteBatchNode: Z order")
      layer
    end

    def eventHandler(tag)
      if tag == kCCNodeOnEnter
        @layer.schedule(self, :reorderSprite, 1)
      end
    end

    def reorderSprite(*args)
      sprite = @batch.getChildByTag(kTagSprite1)

      z = sprite.getZOrder()

      if z < -1
        @dir = 1
      elsif z > 10
        @dir = -1
      end
      z += @dir * 3

      @batch.reorderChild(sprite, z)
    end
  end

  class SpriteBatchNodeReorder < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      a = CCArray.createWithCapacity(10)
      asmtest = CCSpriteBatchNode.create("animations/ghosts.png")

      10.times do |i|
        s1 = CCSprite.createWithTexture(asmtest.getTexture(),
                                        CCRectMake(0, 0, 50, 50))
        a.addObject(s1)
        asmtest.addChild(s1, 10)
      end

      10.times do |i|
        asmtest.reorderChild( a.objectAtIndex(i), 9 ) if i != 5
      end
    
      prev = -1
      children = asmtest.getChildren()
      children.each do |child|
        break if child.nil?

        currentIndex = child.getAtlasIndex()

        raise "Child order failed" unless prev == currentIndex - 1
        cclog("children #{child} - atlasIndex:#{currentIndex}")
        prev = currentIndex
      end
    
      prev = -1
      sChildren = asmtest.getDescendants()
      sChildren.each do |child|
        break if child.nil?

        currentIndex = child.getAtlasIndex()
        raise "Child order failed" unless prev == currentIndex - 1
        cclog("descendant #{child} - atlasIndex:#{currentIndex}")
        prev = currentIndex
      end

      @title_label.setString("SpriteBatchNode: reorder #1")
      @subtitle_label.setString("Should not crash")
      layer
    end
  end

  class SpriteBatchNodeReorderIssue744 < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size

      # Testing issue #744
      # http://code.google.com/p/cocos2d-iphone/issues/detail?id=744
      batch = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 15)
      layer.addChild(batch, 0, kTagSpriteBatchNode)

      sprite = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(0, 0, 85, 121))
      sprite.setPosition( ccp(s.width/2, s.height/2) )
      batch.addChild(sprite, 3)
      batch.reorderChild(sprite, 1)

      @title_label.setString("SpriteBatchNode: reorder issue #744")
      @subtitle_label.setString("Should not crash")
      layer
    end
  end

  class SpriteBatchNodeReorderIssue766 < SpriteTestBase
    def makeSpriteZ(aZ)
      sprite = CCSprite.createWithTexture(@batchNode.getTexture(),
                                           CCRectMake(128,0,64,64))
      @batchNode.addChild(sprite, aZ+1, 0)

      #children
      spriteShadow = CCSprite.createWithTexture(@batchNode.getTexture(),
                                                 CCRectMake(0,0,64,64))
      spriteShadow.setOpacity(128)
      sprite.addChild(spriteShadow, aZ, 3)

      spriteTop = CCSprite.createWithTexture(@batchNode.getTexture(),
                                              CCRectMake(64,0,64,64))
      sprite.addChild(spriteTop, aZ+2, 3)
      sprite
    end

    def reorderSprite(*args)
      @batchNode.reorderChild(@sprite1, 4)
    end

    def init_with_layer(layer)
      super(layer)
      @batchNode = CCSpriteBatchNode.create("Images/piece.png", 15)
      layer.addChild(@batchNode, 1, 0)

      @sprite1 = makeSpriteZ(2)
      @sprite1.setPosition(ccp(200,160))

      sprite2 = makeSpriteZ(3)
      sprite2.setPosition(ccp(264,160))

      sprite3 = makeSpriteZ(4)
      sprite3.setPosition(ccp(328,160))

      layer.performWithDelay(self, :reorderSprite, 2)
      @title_label.setString("SpriteBatchNode: reorder issue #766")
      @subtitle_label.setString("In 2 seconds 1 sprite will be reordered")
      layer
    end
  end

  class SpriteBatchNodeReorderIssue767 < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/ghosts.plist", "animations/ghosts.png")

      #
      # SpriteBatchNode: 3 levels of children
      #
      aParent = CCSpriteBatchNode.create("animations/ghosts.png")
      layer.addChild(aParent, 0, kTagSprite1)

      # parent
      l1 = CCSprite.createWithSpriteFrameName("father.gif")
      l1.setPosition(ccp( s.width/2, s.height/2))
      aParent.addChild(l1, 0, kTagSprite2)
      l1Size = l1.getContentSize()

      # child left
      l2a = CCSprite.createWithSpriteFrameName("sister1.gif")
      l2a.setPosition(ccp( -25 + l1Size.width/2, 0 + l1Size.height/2))
      l1.addChild(l2a, -1, kTagSpriteLeft)
      l2aSize = l2a.getContentSize()


      # child right
      l2b = CCSprite.createWithSpriteFrameName("sister2.gif")
      l2b.setPosition(ccp( +25 + l1Size.width/2, 0 + l1Size.height/2))
      l1.addChild(l2b, 1, kTagSpriteRight)
      l2bSize = l2a.getContentSize()


      # child left bottom
      l3a1 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3a1.setScale(0.65)
      l3a1.setPosition(ccp(0+l2aSize.width/2,-50+l2aSize.height/2))
      l2a.addChild(l3a1, -1)

      # child left top
      l3a2 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3a2.setScale(0.65)
      l3a2.setPosition(ccp(0+l2aSize.width/2,+50+l2aSize.height/2))
      l2a.addChild(l3a2, 1)

      # child right bottom
      l3b1 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3b1.setScale(0.65)
      l3b1.setPosition(ccp(0+l2bSize.width/2,-50+l2bSize.height/2))
      l2b.addChild(l3b1, -1)

      # child right top
      l3b2 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3b2.setScale(0.65)
      l3b2.setPosition(ccp(0+l2bSize.width/2,+50+l2bSize.height/2))
      l2b.addChild(l3b2, 1)

      layer.schedule(self, :reorderSprites, 1)
      @title_label.setString("SpriteBatchNode: reorder issue #767")
      @subtitle_label.setString("Should not crash")
      layer
    end

    def reorderSprites(*args)
      spritebatch = @layer.getChildByTag(kTagSprite1)
      father = spritebatch.getChildByTag(kTagSprite2)
      left = father.getChildByTag(kTagSpriteLeft)
      right = father.getChildByTag(kTagSpriteRight)

      newZLeft = if left.getZOrder() == 1 then -1 else 1 end

      father.reorderChild(left, newZLeft)
      father.reorderChild(right, -newZLeft)
    end
  end

  class SpriteBatchNodeReorderSameIndex < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      @pBatchNode = CCSpriteBatchNode.create("Images/piece.png", 15)
      layer.addChild(@pBatchNode, 1, 0)

      @pSprite1 = CCSprite.createWithTexture(@pBatchNode.getTexture(),
                                             CCRectMake(128,0,64,64))
      @pSprite1.setPosition(ccp(100,160))
      @pBatchNode.addChild(@pSprite1, 3, 1)

      @pSprite2= CCSprite.createWithTexture(@pBatchNode.getTexture(),
                                            CCRectMake(128,0,64,64))
      @pSprite2.setPosition(ccp(164,160))
      @pBatchNode.addChild(@pSprite2, 4, 2)

      @pSprite3 = CCSprite.createWithTexture(@pBatchNode.getTexture(),
                                             CCRectMake(128,0,64,64))
      @pSprite3.setPosition(ccp(228,160))
      @pBatchNode.addChild(@pSprite3, 4, 3)

      @pSprite4 = CCSprite.createWithTexture(@pBatchNode.getTexture(),
                                             CCRectMake(128,0,64,64))
      @pSprite4.setPosition(ccp(292,160))
      @pBatchNode.addChild(@pSprite4, 5, 4)

      @pSprite5 = CCSprite.createWithTexture(@pBatchNode.getTexture(),
                                             CCRectMake(128,0,64,64))
      @pSprite5.setPosition(ccp(356,160))
      @pBatchNode.addChild(@pSprite5, 6, 5)


      layer.performWithDelay(self, :reorderSprite, 2)
      
      @title_label.setString("SpriteBatchNodeReorder same index")
      @title_label.setString("tag order in console should be 2,3,4,5,1")
      layer
    end

    def reorderSprite(*args)
      @pBatchNode.reorderChild(@pSprite4, 4)
      @pBatchNode.reorderChild(@pSprite5, 4)
      @pBatchNode.reorderChild(@pSprite1, 4)

      @pBatchNode.sortAllChildren()
      @pBatchNode.getDescendants().each do |child|
        cclog("tag #{child.getTag}")
      end
    end
  end

  class SpriteBatchNodeReorderOneChild < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/ghosts.plist")

      #
      # SpriteBatchNode: 3 levels of children
      #

      aParent = CCSpriteBatchNode.create("animations/ghosts.png")

      @pBatchNode = aParent
      #[[aParent texture] generateMipmap];
      layer.addChild(aParent)

      # parent
      l1 = CCSprite.createWithSpriteFrameName("father.gif")
      l1.setPosition(ccp( s.width/2, s.height/2))

      aParent.addChild(l1)
      l1Size = l1.getContentSize()

      # child left
      l2a = CCSprite.createWithSpriteFrameName("sister1.gif")
      l2a.setPosition(ccp( -10 + l1Size.width/2, 0 + l1Size.height/2))

      l1.addChild(l2a, 1)
      l2aSize = l2a.getContentSize()


      # child right
      l2b = CCSprite.createWithSpriteFrameName("sister2.gif")
      l2b.setPosition(ccp( +50 + l1Size.width/2, 0 + l1Size.height/2))

      l1.addChild(l2b, 2)
      l2bSize = l2a.getContentSize()


      # child left bottom
      l3a1 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3a1.setScale(0.45)
      l3a1.setPosition(ccp(0+l2aSize.width/2,-50+l2aSize.height/2))
      l2a.addChild(l3a1, 1)

      # child left top
      l3a2 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3a2.setScale(0.45)
      l3a2.setPosition(ccp(0+l2aSize.width/2,+50+l2aSize.height/2))
      l2a.addChild(l3a2, 2)

      @pReorderSprite = l2a

      # child right bottom
      l3b1 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3b1.setScale(0.45)
      l3b1.setFlipY(true)
      l3b1.setPosition(ccp(0+l2bSize.width/2,-50+l2bSize.height/2))
      l2b.addChild(l3b1)

      # child right top
      l3b2 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3b2.setScale(0.45)
      l3b2.setFlipY(true)
      l3b2.setPosition(ccp(0+l2bSize.width/2,+50+l2bSize.height/2))
      l2b.addChild(l3b2)

      layer.performWithDelay(self, :reorderSprite, 2.0)
      @title_label.setString("SpriteBatchNode reorder 1 child")
      layer
    end

    def reorderSprite(*args)
      @pReorderSprite.getParent().reorderChild(@pReorderSprite, -1)

      @pBatchNode.sortAllChildren()
      #@pBatchNode.getDescendants.each do |child|
      #  cclog("tag #{child.getTag}")
      #end
    end
  end

  class NodeSort < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      @pNode = CCNode.create()
      layer.addChild(@pNode, 0, 0)

      @pSprite1 = CCSprite.create("Images/piece.png", CCRectMake(128, 0, 64, 64))
      @pSprite1.setPosition(ccp(100, 160))
      @pNode.addChild(@pSprite1, -6, 1)

      @pSprite2 = CCSprite.create("Images/piece.png", CCRectMake(128, 0, 64, 64))
      @pSprite2.setPosition(ccp(164, 160))
      @pNode.addChild(@pSprite2, -6, 2)

      @pSprite4 = CCSprite.create("Images/piece.png", CCRectMake(128, 0, 64, 64))
      @pSprite4.setPosition(ccp(292, 160))
      @pNode.addChild(@pSprite4, -3, 4)

      @pSprite3 = CCSprite.create("Images/piece.png", CCRectMake(128, 0, 64, 64))
      @pSprite3.setPosition(ccp(228, 160))
      @pNode.addChild(@pSprite3, -4, 3)

      @pSprite5 = CCSprite.create("Images/piece.png", CCRectMake(128, 0, 64, 64))
      @pSprite5.setPosition(ccp(356, 160))
      @pNode.addChild(@pSprite5, -3, 5)

      layer.performWithDelay(self, :reorderSprite, 2)

      @title_label.setString("node sort same index")
      @title_label.setString("tag order in console should be 2,1,3,4,5")
      layer
    end

    def reorderSprite(*args)
      cclog("Before reorder--")
    
      @pNode.getChildren().each do |child|
        cclog("tag #{child.getTag} z #{child.getZOrder}")
      end
      #z-4
      @pNode.reorderChild(@pNode.getChildren().objectAtIndex(0), -6)

      @pNode.sortAllChildren()
      cclog("After reorder--")
      @pNode.getChildren().each do |child|
        cclog("tag #{child.getTag} z #{child.getZOrder}")
      end
    end
  end

  class SpriteZVertex < SpriteTestBase
    def onEnter
      CCDirector.sharedDirector().setProjection(kCCDirectorProjection3D)
    end

    def onExit
      CCDirector.sharedDirector().setProjection(kCCDirectorProjection2D)
    end

    def init_with_layer(layer)
      super(layer)
      #
      # This test tests z-order
      # If you are going to use it is better to use a 3D projection
      #
      # WARNING:
      # The developer is resposible for ordering its sprites according to its Z if the sprite has
      # transparent parts.
      #

      #
      # Configure shader to mimic glAlphaTest
      #
      alphaTestShader = CCShaderCache.sharedShaderCache()
        .programForKey(kCCShader_PositionTextureColorAlphaTest)
      alphaValueLocation = glGetUniformLocation(alphaTestShader.getProgram(),
                                                kCCUniformAlphaTestValue)

      # set alpha test value
      # NOTE: alpha test shader is hard-coded to use the equivalent of a glAlphaFunc(GL_GREATER) comparison
      if getShaderProgram()
        getShaderProgram().setUniformLocationWith1f(alphaValueLocation, 0.0)
      end
    
      @dir = 1
      @time = 0

      s = @@size
      step = s.width/12
    
      node = CCNode.create()
      # camera uses the center of the image as the pivoting point
      node.setContentSize( CCSizeMake(s.width,s.height) )
      node.setAnchorPoint( ccp(0.5, 0.5))
      node.setPosition( ccp(s.width/2, s.height/2))

      layer.addChild(node, 0)

      5.times do |i|
        sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                                  CCRectMake(85*0, 121*1, 85, 121))
        sprite.setPosition( ccp((i+1)*step, s.height/2) )
        sprite.setVertexZ( 10 + i*40 )
        sprite.setShaderProgram(alphaTestShader)
        node.addChild(sprite, 0)
      end

      6.times do |n|
        i = n + 5
        sprite = CCSprite.create("Images/grossini_dance_atlas.png",
                                  CCRectMake(85*1, 121*0, 85, 121))
        sprite.setPosition( ccp( (i+1)*step, s.height/2) )
        sprite.setVertexZ( 10 + (10-i)*40 )
        sprite.setShaderProgram(alphaTestShader)
        node.addChild(sprite, 0)
      end

      node.runAction( CCOrbitCamera.create(10, 1, 0, 0, 360, 0, 0) )

      @title_label.setString("Sprite: openGL Z vertex")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    elsif tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end
  end


  class SpriteBatchNodeZVertex < SpriteTestBase
    def onEnter
      CCDirector.sharedDirector().setProjection(kCCDirectorProjection3D)
    end

    def onExit
      CCDirector.sharedDirector().setProjection(kCCDirectorProjection2D)
    end

    def init_with_layer(layer)
      super(layer)
      #
      # This test tests z-order
      # If you are going to use it is better to use a 3D projection
      #
      # WARNING:
      # The developer is resposible for ordering its sprites according to its Z if the sprite has
      # transparent parts.
      #

      #
      # Configure shader to mimic glAlphaTest
      #
      alphaTestShader = CCShaderCache.sharedShaderCache()
        .programForKey(kCCShader_PositionTextureColorAlphaTest)
      alphaValueLocation = glGetUniformLocation(alphaTestShader.getProgram(),
                                                kCCUniformAlphaTestValue)

      # set alpha test value
      # NOTE: alpha test shader is hard-coded to use the equivalent of a glAlphaFunc(GL_GREATER) comparison
      if getShaderProgram()
        getShaderProgram().setUniformLocationWith1f(alphaValueLocation, 0.0)
      end

      s = @@size
      step = s.width/12
    
      # small capacity. Testing resizing.
      # Don't use capacity=1 in your real game. It is expensive to resize the capacity
      batch = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 1)
      # camera uses the center of the image as the pivoting point
      batch.setContentSize( CCSizeMake(s.width,s.height))
      batch.setAnchorPoint( ccp(0.5, 0.5))
      batch.setPosition( ccp(s.width/2, s.height/2))
    
      batch.setShaderProgram(alphaTestShader)
      layer.addChild(batch, 0, kTagSpriteBatchNode)      

      5.times do |i|
        sprite = CCSprite.createWithTexture(batch.getTexture(),
                                             CCRectMake(85*0, 121*1, 85, 121))
        sprite.setPosition( ccp( (i+1)*step, s.height/2) )
        sprite.setVertexZ(  10 + i*40 )
        batch.addChild(sprite, 0)
      end

      6.times do |n|
        i = n + 5
        sprite = CCSprite.createWithTexture(batch.getTexture(),
                                             CCRectMake(85*1, 121*0, 85, 121))
        sprite.setPosition( ccp( (i+1)*step, s.height/2) )
        sprite.setVertexZ(  10 + (10-i)*40 )
        batch.addChild(sprite, 0)
      end

      batch.runAction(CCOrbitCamera.create(10, 1, 0, 0, 360, 0, 0) )

      @title_label.setString("SpriteBatchNode: openGL Z vertex")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    elsif tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end
  end

  class Sprite6 < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      # small capacity. Testing resizing
      # Don't use capacity=1 in your real game. It is expensive to resize the capacity
      batch = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 1)
      layer.addChild(batch, 0, kTagSpriteBatchNode)
      batch.ignoreAnchorPointForPosition( true )

      s = @@size

      batch.setAnchorPoint( ccp(0.5, 0.5) )
      batch.setContentSize( CCSizeMake(s.width, s.height) )


      # SpriteBatchNode actions
      rotate = CCRotateBy.create(5, 360)
      action = CCRepeatForever.create(rotate)

      # SpriteBatchNode actions
      rotate_back = rotate.reverse()
      arr = CCArray.create
      arr << rotate
      arr << rotate_back
      rotate_seq = CCSequence.create(arr)
      rotate_forever = CCRepeatForever.create(rotate_seq)
    
      scale = CCScaleBy.create(5, 1.5)
      scale_back = scale.reverse()
      arr = CCArray.create
      arr << scale
      arr << scale_back
      scale_seq = CCSequence.create(arr)
      scale_forever = CCRepeatForever.create(scale_seq)

      step = s.width/4

      3.times do |i|
        sprite = CCSprite.createWithTexture(batch.getTexture(),
                                            CCRectMake(85*i, 121*1, 85, 121))
        sprite.setPosition( ccp( (i+1)*step, s.height/2) )

        sprite.runAction(action.copy)
        batch.addChild(sprite, i)
      end
    
      batch.runAction(scale_forever)
      batch.runAction(rotate_forever)

      @title_label.setString("SpriteBatchNode transformation")
      layer
    end
  end

  class SpriteFlip < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      sprite1 = CCSprite.create("Images/grossini_dance_atlas.png",
                                 CCRectMake(85*1, 121*1, 85, 121))
      sprite1.setPosition( ccp( s.width/2 - 100, s.height/2 ) )
      layer.addChild(sprite1, 0, kTagSprite1)
    
      sprite2 = CCSprite.create("Images/grossini_dance_atlas.png",
                                 CCRectMake(85*1, 121*1, 85, 121))
      sprite2.setPosition( ccp( s.width/2 + 100, s.height/2 ) )
      layer.addChild(sprite2, 0, kTagSprite2)
    
      layer.schedule(self, :flipSprites, 1)
      @title_label.setString("Sprite Flip X & Y")
      layer
    end

    def flipSprites(*args)
      sprite1 = @layer.getChildByTag(kTagSprite1)
      sprite2 = @layer.getChildByTag(kTagSprite2)
    
      x = sprite1.isFlipX()
      y = sprite2.isFlipY()
    
      cclog("Pre: %f", sprite1.getContentSize().height)
      sprite1.setFlipX(!x)
      sprite2.setFlipY(!y)
      cclog("Post: %f", sprite1.getContentSize().height)
    end
  end

  class SpriteBatchNodeFlip < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      batch = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 10)
      layer.addChild(batch, 0, kTagSpriteBatchNode)
    
      s = @@size
    
      sprite1 = CCSprite.createWithTexture(batch.getTexture(),
                                            CCRectMake(85*1, 121*1, 85, 121))
      sprite1.setPosition( ccp( s.width/2 - 100, s.height/2 ) )
      batch.addChild(sprite1, 0, kTagSprite1)
    
      sprite2 = CCSprite.createWithTexture(batch.getTexture(),
                                            CCRectMake(85*1, 121*1, 85, 121))
      sprite2.setPosition( ccp( s.width/2 + 100, s.height/2 ) )
      batch.addChild(sprite2, 0, kTagSprite2)
    
      layer.schedule(self, :flipSprites, 1)

      @title_label.setString("SpriteBatchNode Flip X & Y")
      layer
    end

    def flipSprites(*args)
      batch= @layer.getChildByTag( kTagSpriteBatchNode )
      sprite1 = batch.getChildByTag(kTagSprite1)
      sprite2 = batch.getChildByTag(kTagSprite2)
    
      x = sprite1.isFlipX()
      y = sprite2.isFlipY()
    
      cclog("Pre: %f", sprite1.getContentSize().height)
      sprite1.setFlipX(!x)
      sprite2.setFlipY(!y)
      cclog("Post: %f", sprite1.getContentSize().height)
    end
  end

  class SpriteAliased < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size
    
      sprite1 = CCSprite.create("Images/grossini_dance_atlas.png",
                                 CCRectMake(85*1, 121*1, 85, 121))
      sprite1.setPosition( ccp( s.width/2 - 100, s.height/2 ) )
      layer.addChild(sprite1, 0, kTagSprite1)
    
      sprite2 = CCSprite.create("Images/grossini_dance_atlas.png",
                                 CCRectMake(85*1, 121*1, 85, 121))
      sprite2.setPosition( ccp( s.width/2 + 100, s.height/2 ) )
      layer.addChild(sprite2, 0, kTagSprite2)
    
      scale = CCScaleBy.create(2, 5)
      scale_back = scale.reverse()
      arr = CCArray.create
      arr << scale
      arr << scale_back
      seq = CCSequence.create( arr )
      repeat = CCRepeatForever.create(seq)
    
      repeat2 = repeat.copy
    
      sprite1.runAction(repeat)
      sprite2.runAction(repeat2)
    
      @title_label.setString("Sprite Aliased")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    elsif tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onEnter
      #
      # IMPORTANT:
      # This change will affect every sprite that uses the same texture
      # So sprite1 and sprite2 will be affected by this change
      #
      sprite = @layer.getChildByTag(kTagSprite1)
      sprite.getTexture().setAliasTexParameters()
    end

    def onExit
      # restore the tex parameter to AntiAliased.
      sprite = @layer.getChildByTag(kTagSprite1)
      sprite.getTexture().setAntiAliasTexParameters()
    end
  end

  class SpriteBatchNodeAliased < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      batch = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 10)
      layer.addChild(batch, 0, kTagSpriteBatchNode)
    
      s = @@size

      sprite1 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*1, 121*1, 85, 121))
      sprite1.setPosition( ccp( s.width/2 - 100, s.height/2 ) )
      batch.addChild(sprite1, 0, kTagSprite1)
    
      sprite2 = CCSprite.createWithTexture(batch.getTexture(),
                                           CCRectMake(85*1, 121*1, 85, 121))
      sprite2.setPosition( ccp( s.width/2 + 100, s.height/2 ) )
      batch.addChild(sprite2, 0, kTagSprite2)
    
      scale = CCScaleBy.create(2, 5)
      scale_back = scale.reverse()
      arr = CCArray.create
      arr << scale
      arr << scale_back
      seq = CCSequence.create(arr)
      repeat = CCRepeatForever.create(seq)
    
      repeat2 = repeat.copy
    
      sprite1.runAction(repeat)
      sprite2.runAction(repeat2)

      @title_label.setString("SpriteBatchNode Aliased")
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    elsif tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onEnter
      batch = @layer.getChildByTag( kTagSpriteBatchNode )
      batch.getTexture().setAliasTexParameters()
    end

    def onExit
      # restore the tex parameter to AntiAliased.
      batch = @layer.getChildByTag( kTagSpriteBatchNode )
      batch.getTexture().setAntiAliasTexParameters()
    end
  end

  class SpriteNewTexture < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      layer.setTouchEnabled( true )
    
      node = CCNode.create()
      layer.addChild(node, 0, kTagSpriteBatchNode)

      @texture1 = CCTextureCache.sharedTextureCache()
        .addImage("Images/grossini_dance_atlas.png")

      @texture2 = CCTextureCache.sharedTextureCache()
        .addImage("Images/grossini_dance_atlas-mono.png")
    
      @usingTexture1 = true

      30.times do |i|
        addNewSprite()
      end

      that = self
      layer.registerScriptTouchHandler(Proc.new {|*args| that.onTouch(*args)},
                                       false, -1, false)
      @title_label.setString("Sprite New texture (tap)")
      layer
    end

    def addNewSprite
      s = @@size
      p = ccp( CCRANDOM_0_1() * s.width, CCRANDOM_0_1() * s.height)

      idx = CCRANDOM_0_1() * 1400 / 100
      x = (idx%5) * 85
      y = (idx/5) * 121


      node = @layer.getChildByTag( kTagSpriteBatchNode )
      sprite = CCSprite.createWithTexture(@texture1, CCRectMake(x,y,85,121))
      node.addChild(sprite)
    
      sprite.setPosition( ccp( p.x, p.y) )

      action = nil
      random = CCRANDOM_0_1()

      if random < 0.20
        action = CCScaleBy.create(3, 2)
      elsif random < 0.40
        action = CCRotateBy.create(3, 360)
      elsif random < 0.60
        action = CCBlink.create(1, 3)
      elsif random < 0.8
        action = CCTintBy.create(2, 0, -255, -255)
      else 
        action = CCFadeOut.create(2)
      end

      action_back = action.reverse()
      arr = CCArray.create
      arr << action
      arr << action_back
      seq = CCSequence.create(arr)
    
      sprite.runAction( CCRepeatForever.create(seq) )
    end

    def onTouch(event, x, y)
      if event == CCTOUCHBEGAN
        true
      elsif event == CCTOUCHENDED
        onTouchEnded(ccp(x,y))
        true
      end
    end

    def onTouchEnded(point)
      node = @layer.getChildByTag( kTagSpriteBatchNode )

      children = node.getChildren()
      if @usingTexture1  #--> win32 : Let's it make just simple sentence
        children.each do |sprite|
          break if sprite.nil?
          sprite.setTexture(@texture2)
        end
        @usingTexture1 = false
      else 
        children.each do |sprite|
          break if sprite.nil?
          sprite.setTexture(@texture1)
        end
        @usingTexture1 = true
      end
    end
  end

  class SpriteBatchNodeNewTexture < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      layer.setTouchEnabled( true )
    
      batch = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 50)
      layer.addChild(batch, 0, kTagSpriteBatchNode)
    
      @texture1 = batch.getTexture()
      @texture2 = CCTextureCache.sharedTextureCache()
        .addImage("Images/grossini_dance_atlas-mono.png")

      30.times do |i|
        addNewSprite()
      end

      that = self
      layer.registerScriptTouchHandler(Proc.new {|*args| that.onTouch(*args)},
                                       false, -1, false)
      @title_label.setString("SpriteBatchNode new texture (tap)")
      layer
    end

    def addNewSprite
      s = @@size
    
      p = ccp( CCRANDOM_0_1() * s.width, CCRANDOM_0_1() * s.height)
    
      batch = @layer.getChildByTag( kTagSpriteBatchNode )
    
      idx = CCRANDOM_0_1() * 1400 / 100
      x = (idx%5) * 85
      y = (idx/5) * 121


      sprite = CCSprite.createWithTexture(batch.getTexture(),
                                          CCRectMake(x,y,85,121))
      batch.addChild(sprite)
    
      sprite.setPosition( ccp( p.x, p.y) )
    
      action = nil
      random = CCRANDOM_0_1()

      if random < 0.20
        action = CCScaleBy.create(3, 2)
      elsif random < 0.40
        action = CCRotateBy.create(3, 360)
      elsif random < 0.60
        action = CCBlink.create(1, 3)
      elsif random < 0.8
        action = CCTintBy.create(2, 0, -255, -255)
      else 
        action = CCFadeOut.create(2)
      end

      action_back = action.reverse()
      arr = CCArray.create
      arr << action
      arr << action_back
      seq = CCSequence.create(arr)
    
      sprite.runAction( CCRepeatForever.create(seq) )
    end

    def onTouch(event, x, y)
      if event == CCTOUCHBEGAN
        true
      elsif event == CCTOUCHENDED
        onTouchEnded(ccp(x,y))
        true
      end
    end

    def onTouchEnded(point)
      batch = @layer.getChildByTag( kTagSpriteBatchNode )

      if batch.getTexture() == @texture1
        batch.setTexture(@texture2)
      else
        batch.setTexture(@texture1)
      end
    end
  end

  class SpriteHybrid < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      # parents
      parent1 = CCNode.create()
      parent2 = CCSpriteBatchNode.create("animations/grossini.png", 50)
    
      layer.addChild(parent1, 0, kTagNode)
      layer.addChild(parent2, 0, kTagSpriteBatchNode)


      # IMPORTANT:
      # The sprite frames will be cached AND RETAINED, and they won't be released unless you call
      #     CCSpriteFrameCache.sharedSpriteFrameCache().removeUnusedSpriteFrames
      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/grossini.plist")


      # create 250 sprites
      # only show 80% of them
      250.times do |i|
        spriteIdx = (CCRANDOM_0_1() * 14).to_i
        str = sprintf("grossini_dance_%02d.png", (spriteIdx+1))
        frame = CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(str)
        sprite = CCSprite.createWithSpriteFrame(frame)
        parent1.addChild(sprite, i, i)
        
        x=-1000
        y=-1000
        if CCRANDOM_0_1() < 0.2
          x = CCRANDOM_0_1() * s.width
          y = CCRANDOM_0_1() * s.height
        end
        sprite.setPosition( ccp(x,y) )
            
        action = CCRotateBy.create(4, 360)
        sprite.runAction( CCRepeatForever.create(action) )
      end
    
      @usingSpriteBatchNode = false

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer.schedule(self, :reparentSprite, 2)
      @title_label.setString("HybrCCSprite* sprite Test")
      layer
    end

    def reparentSprite(*args)
      p1 = @layer.getChildByTag(kTagNode)
      p2 = @layer.getChildByTag( kTagSpriteBatchNode )

      retArray = CCArray.createWithCapacity(250)

      if @usingSpriteBatchNode
        tmp = p1
        p1 = p2
        p2 = tmp
      end
      #cclog("New parent is: #{p2}")
    
      children = p1.getChildren()
      children.each do |node|
        break if node.nil?
        retArray.addObject(node)
      end

      p1.removeAllChildrenWithCleanup(false)

      i = 0
      retArray.each do |node|
        break if node.nil?
        p2.addChild(node, i, i)
        i += 1
      end

      @usingSpriteBatchNode = ! @usingSpriteBatchNode
    end

    def onExit
      CCSpriteFrameCache.sharedSpriteFrameCache()
        .removeSpriteFramesFromFile("animations/grossini.plist")
    end
  end

  class SpriteBatchNodeChildren < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size
    
      # parents
      batch = CCSpriteBatchNode.create("animations/grossini.png", 50)
    
      layer.addChild(batch, 0, kTagSpriteBatchNode)
    
      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/grossini.plist")
    
      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite1.setPosition(ccp( s.width/3, s.height/2))
    
      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(50,50))
    
      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-50,-50))
    
      batch.addChild(sprite1)
      sprite1.addChild(sprite2)
      sprite1.addChild(sprite3)
    
      # BEGIN NEW CODE
      animFrames = CCArray.create()

      14.times do |i|
        str = sprintf("grossini_dance_%02d.png",i + 1)
        frame = CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(str)
        animFrames.addObject(frame)
      end
    
      animation = CCAnimation.createWithSpriteFrames(animFrames, 0.2)
      sprite1.runAction(CCRepeatForever.create( CCAnimate.create(animation) ) )
      # END NEW CODE

      action = CCMoveBy.create(2, ccp(200,0))
      action_back = action.reverse()
      action_rot = CCRotateBy.create(2, 360)
      action_s = CCScaleBy.create(2, 2)
      action_s_back = action_s.reverse()

      seq2 = action_rot.reverse()
      sprite2.runAction( CCRepeatForever.create(seq2) )

      sprite1.runAction( CCRepeatForever.create(action_rot))

      arr = CCArray.create
      arr << action
      arr << action_back
      sprite1.runAction( CCRepeatForever.create(CCSequence.create(arr)) )

      arr = CCArray.create
      arr << action_s
      arr << action_s_back
      sprite1.runAction( CCRepeatForever.create(CCSequence.create(arr)) )

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      @title_label.setString("SpriteBatchNode Grand Children")
      layer
    end

    def onExit
      CCSpriteFrameCache.sharedSpriteFrameCache().removeUnusedSpriteFrames()
    end
  end

  class SpriteBatchNodeChildrenZ < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      # parents
      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/grossini.plist")
    
      # test 1
      batch = CCSpriteBatchNode.create("animations/grossini.png", 50)
      layer.addChild(batch, 0, kTagSpriteBatchNode)

      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite1.setPosition(ccp( s.width/3, s.height/2))

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      batch.addChild(sprite1)
      sprite1.addChild(sprite2, 2)
      sprite1.addChild(sprite3, -2)

      # test 2
      batch = CCSpriteBatchNode.create("animations/grossini.png", 50)
      layer.addChild(batch, 0, kTagSpriteBatchNode)

      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite1.setPosition(ccp( 2*s.width/3, s.height/2))

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      batch.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, 2)

      # test 3
      batch = CCSpriteBatchNode.create("animations/grossini.png", 50)
      layer.addChild(batch, 0, kTagSpriteBatchNode)

      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite1.setPosition(ccp( s.width/2 - 90, s.height/4))

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp( s.width/2 - 60,s.height/4))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp( s.width/2 - 30, s.height/4))

      batch.addChild(sprite1, 10)
      batch.addChild(sprite2, -10)
      batch.addChild(sprite3, -5)

      # test 4
      batch = CCSpriteBatchNode.create("animations/grossini.png", 50)
      layer.addChild(batch, 0, kTagSpriteBatchNode)

      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite1.setPosition(ccp( s.width/2 +30, s.height/4))

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp( s.width/2 +60,s.height/4))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp( s.width/2 +90, s.height/4))

      batch.addChild(sprite1, -10)
      batch.addChild(sprite2, -5)
      batch.addChild(sprite3, -2)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      @title_label.setString("SpriteBatchNode Children Z")
      layer
    end

    def onExit
      CCSpriteFrameCache::sharedSpriteFrameCache()
        .removeUnusedSpriteFrames()
    end
  end

  class SpriteChildrenVisibility < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/grossini.plist")

      #
      # SpriteBatchNode
      #
      # parents
      aParent = CCSpriteBatchNode.create("animations/grossini.png", 50)
      aParent.setPosition( ccp(s.width/3, s.height/2) )
      layer.addChild(aParent, 0)

      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite1.setPosition(ccp(0,0))

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, 2)

      sprite1.runAction(CCBlink.create(5, 10))

      #
      # Sprite
      #
      aParent = CCNode.create()
      aParent.setPosition( ccp(2*s.width/3, s.height/2) )
      layer.addChild(aParent, 0)

      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite1.setPosition(ccp(0,0))

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, 2)

      sprite1.runAction(CCBlink.create(5, 10))

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      @title_label.setString("Sprite & SpriteBatchNode Visibility")
      layer
    end

    def onExit
      CCSpriteFrameCache.sharedSpriteFrameCache().removeUnusedSpriteFrames()
    end
  end

  class SpriteChildrenVisibilityIssue665 < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/grossini.plist")

      #
      # SpriteBatchNode
      #
      # parents
      aParent = CCSpriteBatchNode.create("animations/grossini.png", 50)
      aParent.setPosition(ccp(s.width/3, s.height/2))
      layer.addChild(aParent, 0)

      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite1.setPosition(ccp(0,0))

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      # test issue #665
      sprite1.setVisible(false)

      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, 2)

      #
      # Sprite
      #
      aParent = CCNode.create()
      aParent.setPosition(ccp(2*s.width/3, s.height/2))
      layer.addChild(aParent, 0)

      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
      sprite1.setPosition(ccp(0,0))

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      # test issue #665
      sprite1.setVisible(false)

      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, 2)

      @title_label.setString("Sprite & SpriteBatchNode Visibility")
      @subtitle_label.setString("No sprites should be visible")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      CCSpriteFrameCache.sharedSpriteFrameCache().removeUnusedSpriteFrames()
    end
  end

  class SpriteChildrenAnchorPoint < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/grossini.plist")

      #
      # SpriteBatchNode
      #
      # parents
      aParent = CCNode.create()
      layer.addChild(aParent, 0)

      #anchor (0,0)
      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_08.png")
      sprite1.setPosition(ccp(s.width/4,s.height/2))
      sprite1.setAnchorPoint( ccp(0,0) )

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      sprite4 = CCSprite.createWithSpriteFrameName("grossini_dance_04.png")
      sprite4.setPosition(ccp(0,0))
      sprite4.setScale( 0.5 )


      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, -2)
      sprite1.addChild(sprite4, 3)

      point = CCSprite.create("Images/r1.png")
      point.setScale( 0.25 )
      point.setPosition( sprite1.getPosition() )
      layer.addChild(point, 10)


      # anchor (0.5, 0.5)
      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_08.png")
      sprite1.setPosition(ccp(s.width/2,s.height/2))
      sprite1.setAnchorPoint( ccp(0.5, 0.5) )

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      sprite4 = CCSprite.createWithSpriteFrameName("grossini_dance_04.png")
      sprite4.setPosition(ccp(0,0))
      sprite4.setScale( 0.5 )

      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, -2)
      sprite1.addChild(sprite4, 3)

      point = CCSprite.create("Images/r1.png")
      point.setScale( 0.25 )
      point.setPosition( sprite1.getPosition() )
      layer.addChild(point, 10)

      # anchor (1,1)
      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_08.png")
      sprite1.setPosition(ccp(s.width/2+s.width/4,s.height/2))
      sprite1.setAnchorPoint( ccp(1,1) )


      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      sprite4 = CCSprite.createWithSpriteFrameName("grossini_dance_04.png")
      sprite4.setPosition(ccp(0,0))
      sprite4.setScale( 0.5 )  

      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, -2)
      sprite1.addChild(sprite4, 3)

      point = CCSprite.create("Images/r1.png")
      point.setScale( 0.25 )
      point.setPosition( sprite1.getPosition() )
      layer.addChild(point, 10)

      @title_label.setString("Sprite: children + anchor")
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      CCSpriteFrameCache.sharedSpriteFrameCache().removeUnusedSpriteFrames()
    end
  end

  class SpriteBatchNodeChildrenAnchorPoint < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/grossini.plist")

      #
      # SpriteBatchNode
      #
      # parents
      aParent = CCSpriteBatchNode.create("animations/grossini.png", 50)
      layer.addChild(aParent, 0)
    
      # anchor (0,0)
      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_08.png")
      sprite1.setPosition(ccp(s.width/4,s.height/2))
      sprite1.setAnchorPoint( ccp(0,0) )

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      sprite4 = CCSprite.createWithSpriteFrameName("grossini_dance_04.png")
      sprite4.setPosition(ccp(0,0))
      sprite4.setScale( 0.5 )

      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, -2)
      sprite1.addChild(sprite4, 3)

      point = CCSprite.create("Images/r1.png")
      point.setScale( 0.25 )
      point.setPosition( sprite1.getPosition() )
      layer.addChild(point, 10)

      # anchor (0.5, 0.5)
      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_08.png")
      sprite1.setPosition(ccp(s.width/2,s.height/2))
      sprite1.setAnchorPoint( ccp(0.5, 0.5) )

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      sprite4 = CCSprite.createWithSpriteFrameName("grossini_dance_04.png")
      sprite4.setPosition(ccp(0,0))
      sprite4.setScale( 0.5 )  
    
      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, -2)
      sprite1.addChild(sprite4, 3)

      point = CCSprite.create("Images/r1.png")
      point.setScale( 0.25 )
      point.setPosition( sprite1.getPosition() )
      layer.addChild(point, 10)

      # anchor (1,1)
      sprite1 = CCSprite.createWithSpriteFrameName("grossini_dance_08.png")
      sprite1.setPosition(ccp(s.width/2+s.width/4,s.height/2))
      sprite1.setAnchorPoint( ccp(1,1) )

      sprite2 = CCSprite.createWithSpriteFrameName("grossini_dance_02.png")
      sprite2.setPosition(ccp(20,30))

      sprite3 = CCSprite.createWithSpriteFrameName("grossini_dance_03.png")
      sprite3.setPosition(ccp(-20,30))

      sprite4 = CCSprite.createWithSpriteFrameName("grossini_dance_04.png")
      sprite4.setPosition(ccp(0,0))
      sprite4.setScale( 0.5 )  

      aParent.addChild(sprite1)
      sprite1.addChild(sprite2, -2)
      sprite1.addChild(sprite3, -2)
      sprite1.addChild(sprite4, 3)

      point = CCSprite.create("Images/r1.png")
      point.setScale( 0.25 )
      point.setPosition( sprite1.getPosition() )
      layer.addChild(point, 10)

      @title_label.setString("SpriteBatchNode: children + anchor")
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      CCSpriteFrameCache.sharedSpriteFrameCache().removeUnusedSpriteFrames()
    end
  end

  class SpriteBatchNodeChildrenScale < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/grossini_family.plist")

      rot = CCRotateBy.create(10, 360)
      seq = CCRepeatForever.create(rot)
    
      #
      # Children + Scale using Sprite
      # Test 1
      #
      aParent = CCNode.create()
      sprite1 = CCSprite.createWithSpriteFrameName("grossinis_sister1.png")
      sprite1.setPosition( ccp( s.width/4, s.height/4) )
      sprite1.setScaleX( -0.5 )
      sprite1.setScaleY( 2.0 )
      sprite1.runAction(seq)

      sprite2 = CCSprite.createWithSpriteFrameName("grossinis_sister2.png")
      sprite2.setPosition( ccp(50,0) )

      layer.addChild(aParent)
      aParent.addChild(sprite1)
      sprite1.addChild(sprite2)

      #
      # Children + Scale using SpriteBatchNode
      # Test 2
      #
      aParent = CCSpriteBatchNode.create("animations/grossini_family.png")
      sprite1 = CCSprite.createWithSpriteFrameName("grossinis_sister1.png")
      sprite1.setPosition( ccp( 3*s.width/4, s.height/4) )
      sprite1.setScaleX( -0.5 )
      sprite1.setScaleY( 2.0 )
      sprite1.runAction( seq.copy() )

      sprite2 = CCSprite.createWithSpriteFrameName("grossinis_sister2.png")
      sprite2.setPosition( ccp(50,0) )

      layer.addChild(aParent)
      aParent.addChild(sprite1)
      sprite1.addChild(sprite2)

      #
      # Children + Scale using Sprite
      # Test 3
      #
      aParent = CCNode.create()
      sprite1 = CCSprite.createWithSpriteFrameName("grossinis_sister1.png")
      sprite1.setPosition( ccp( s.width/4, 2*s.height/3) )
      sprite1.setScaleX( 1.5 )
      sprite1.setScaleY( -0.5 )
      sprite1.runAction( seq.copy() )

      sprite2 = CCSprite.createWithSpriteFrameName("grossinis_sister2.png")
      sprite2.setPosition( ccp(50,0) )

      layer.addChild(aParent)
      aParent.addChild(sprite1)
      sprite1.addChild(sprite2)

      #
      # Children + Scale using Sprite
      # Test 4
      #
      aParent = CCSpriteBatchNode.create("animations/grossini_family.png")
      sprite1 = CCSprite.createWithSpriteFrameName("grossinis_sister1.png")
      sprite1.setPosition( ccp( 3*s.width/4, 2*s.height/3) )
      sprite1.setScaleX( 1.5 )
      sprite1.setScaleY( -0.5 )
      sprite1.runAction( seq.copy() )

      sprite2 = CCSprite.createWithSpriteFrameName("grossinis_sister2.png")
      sprite2.setPosition( ccp(50,0) )

      layer.addChild(aParent)
      aParent.addChild(sprite1)
      sprite1.addChild(sprite2)

      @title_label.setString("Sprite/BatchNode + child + scale + rot")
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/grossini_family.plist")
      cache.removeUnusedSpriteFrames()
    end
  end

  class SpriteChildrenChildren < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/ghosts.plist")

      rot = CCRotateBy.create(10, 360)
      seq = CCRepeatForever.create(rot)

      rot_back = rot.reverse()
      rot_back_fe = CCRepeatForever.create(rot_back)

      #
      # SpriteBatchNode: 3 levels of children
      #
      aParent = CCNode.create()
      layer.addChild(aParent)

      # parent
      l1 = CCSprite.createWithSpriteFrameName("father.gif")
      l1.setPosition( ccp( s.width/2, s.height/2) )
      l1.runAction( seq.copy() )
      aParent.addChild(l1)
      l1Size = l1.getContentSize()
    
      # child left
      l2a = CCSprite.createWithSpriteFrameName("sister1.gif")
      l2a.setPosition( ccp( -50 + l1Size.width/2, 0 + l1Size.height/2) )
      l2a.runAction( rot_back_fe.copy() )
      l1.addChild(l2a)
      l2aSize = l2a.getContentSize()

      # child right
      l2b = CCSprite.createWithSpriteFrameName("sister2.gif")
      l2b.setPosition( ccp( +50 + l1Size.width/2, 0 + l1Size.height/2) )
      l2b.runAction( rot_back_fe.copy() )
      l1.addChild(l2b)
      l2bSize = l2a.getContentSize()
      
      # child left bottom
      l3a1 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3a1.setScale( 0.45 )
      l3a1.setPosition( ccp(0+l2aSize.width/2,-100+l2aSize.height/2) )
      l2a.addChild(l3a1)

      # child left top
      l3a2 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3a2.setScale( 0.45 )
      l3a1.setPosition( ccp(0+l2aSize.width/2,+100+l2aSize.height/2) )
      l2a.addChild(l3a2)

      # child right bottom
      l3b1 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3b1.setScale( 0.45 )
      l3b1.setFlipY( true )
      l3b1.setPosition( ccp(0+l2bSize.width/2,-100+l2bSize.height/2) )
      l2b.addChild(l3b1)

      # child right top
      l3b2 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3b2.setScale( 0.45 )
      l3b2.setFlipY( true )
      l3b1.setPosition( ccp(0+l2bSize.width/2,+100+l2bSize.height/2) )
      l2b.addChild(l3b2)

      @title_label.setString("Sprite multiple levels of children")
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/ghosts.plist")
      cache.removeUnusedSpriteFrames()
    end
  end

  class SpriteBatchNodeChildrenChildren < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/ghosts.plist")

      rot = CCRotateBy.create(10, 360)
      seq = CCRepeatForever.create(rot)

      rot_back = rot.reverse()
      rot_back_fe = CCRepeatForever.create(rot_back)

      #
      # SpriteBatchNode: 3 levels of children
      #

      aParent = CCSpriteBatchNode.create("animations/ghosts.png")
      aParent.getTexture().generateMipmap()
      layer.addChild(aParent)

      # parent
      l1 = CCSprite.createWithSpriteFrameName("father.gif")
      l1.setPosition( ccp( s.width/2, s.height/2) )
      l1.runAction( seq.copy() )
      aParent.addChild(l1)
      l1Size = l1.getContentSize()

      # child left
      l2a = CCSprite.createWithSpriteFrameName("sister1.gif")
      l2a.setPosition( ccp( -50 + l1Size.width/2, 0 + l1Size.height/2) )
      l2a.runAction( rot_back_fe.copy() )
      l1.addChild(l2a)
      l2aSize = l2a.getContentSize()

      # child right
      l2b = CCSprite.createWithSpriteFrameName("sister2.gif")
      l2b.setPosition( ccp( +50 + l1Size.width/2, 0 + l1Size.height/2) )
      l2b.runAction( rot_back_fe.copy() )
      l1.addChild(l2b)
      l2bSize = l2a.getContentSize()

      # child left bottom
      l3a1 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3a1.setScale( 0.45 )
      l3a1.setPosition( ccp(0+l2aSize.width/2,-100+l2aSize.height/2) )
      l2a.addChild(l3a1)

      # child left top
      l3a2 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3a2.setScale( 0.45 )
      l3a1.setPosition( ccp(0+l2aSize.width/2,+100+l2aSize.height/2) )
      l2a.addChild(l3a2)

      # child right bottom
      l3b1 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3b1.setScale( 0.45 )
      l3b1.setFlipY( true )
      l3b1.setPosition( ccp(0+l2bSize.width/2,-100+l2bSize.height/2) )
      l2b.addChild(l3b1)

      # child right top
      l3b2 = CCSprite.createWithSpriteFrameName("child1.gif")
      l3b2.setScale( 0.45 )
      l3b2.setFlipY( true )
      l3b1.setPosition( ccp(0+l2bSize.width/2,+100+l2bSize.height/2) )
      l2b.addChild(l3b2)

      @title_label.setString("SpriteBatchNode multiple levels of children")
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/ghosts.plist")
      cache.removeUnusedSpriteFrames()
    end
  end

  class SpriteSkewNegativeScaleChildren < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      parent = CCNode.create()
      layer.addChild(parent)

      2.times do |i|
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp( s.width/4*(i+1), s.height/2))

        # Skew
        skewX = CCSkewBy.create(2, 45, 0)
        skewX_back = skewX.reverse()
        skewY = CCSkewBy.create(2, 0, 45)
        skewY_back = skewY.reverse()

        sprite.setScale(-1.0) if i == 1

        arr = CCArray.create
        [skewX, skewX_back, skewY, skewY_back].each do |elem|
          arr << elem
        end
        seq_skew = CCSequence.create(arr)
        sprite.runAction(CCRepeatForever.create(seq_skew))

        child1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        child1.setPosition(ccp(sprite.getContentSize().width / 2.0,
                               sprite.getContentSize().height / 2.0))

        sprite.addChild(child1)
        child1.setScale(0.8)
        parent.addChild(sprite, i)
      end

      @title_label.setString("Sprite + children + skew")
      @subtitle_label.setString("Sprite skew + negative scale with children")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/grossini.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
    end
  end

  class SpriteRotationalSkewNegativeScaleChildren < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      parent = CCNode.create()
      layer.addChild(parent)

      2.times do |i|
        #
        # Animation using Sprite batch
        #
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width/4*(i+1), s.height/2))

        point = CCSprite.create("Images/r1.png")
        point.setScale(0.25)
        point.setPosition(sprite.getPosition())
        layer.addChild(point, 200)

        # Skew
        skewX = CCRotateBy.create(2, 45, 0)
        skewX_back = skewX.reverse()
        skewY = CCRotateBy.create(2, 0, 45)
        skewY_back = skewY.reverse()

        sprite.setScale(-1.0) if i == 1

        arr = CCArray.create
        [skewX, skewX_back, skewY, skewY_back].each do |elem|
          arr << elem
        end
        seq_skew = CCSequence.create(arr)
        sprite.runAction(CCRepeatForever.create(seq_skew))

        child1 = CCSprite.create("Images/grossini_dance_01.png")
        child1.setPosition(ccp(sprite.getContentSize().width/2.0,
                               sprite.getContentSize().height/2.0))

        sprite.addChild(child1)
        child1.setScale(0.8)
        parent.addChild(sprite, i)
      end

      @title_label.setString("Sprite rot skew + negative scale with children")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/grossini.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
    end
  end

  class SpriteBatchNodeSkewNegativeScaleChildren < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      spritebatch = CCSpriteBatchNode.create("animations/grossini.png")
      layer.addChild(spritebatch)

      2.times do |i|
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp( s.width/4*(i+1), s.height/2))

        # Skew
        skewX = CCSkewBy.create(2, 45, 0)
        skewX_back = skewX.reverse()
        skewY = CCSkewBy.create(2, 0, 45)
        skewY_back = skewY.reverse()

        sprite.setScale(-1.0) if i == 1

        arr = CCArray.create
        [skewX, skewX_back, skewY, skewY_back].each do |elem|
          arr << elem
        end
        seq_skew = CCSequence.create(arr)
        sprite.runAction(CCRepeatForever.create(seq_skew))

        child1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        child1.setPosition(ccp(sprite.getContentSize().width / 2.0,
                               sprite.getContentSize().height / 2.0))

        child1.setScale(0.8)
        sprite.addChild(child1)
        spritebatch.addChild(sprite, i)
      end

      @title_label.setString("SpriteBatchNode + children + skew")
      @title_label.setString("SpriteBatchNode skew + negative scale with children")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/grossini.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
    end
  end

  class SpriteSkewNegativeScaleChildren < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      parent = CCNode.create()
      layer.addChild(parent)

      2.times do |i|
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp( s.width/4*(i+1), s.height/2))

        # Skew
        skewX = CCSkewBy.create(2, 45, 0)
        skewX_back = skewX.reverse()
        skewY = CCSkewBy.create(2, 0, 45)
        skewY_back = skewY.reverse()

        sprite.setScale(-1.0) if i == 1

        arr = CCArray.create
        [skewX, skewX_back, skewY, skewY_back].each do |elem|
          arr << elem
        end
        seq_skew = CCSequence.create(arr)
        sprite.runAction(CCRepeatForever.create(seq_skew))

        child1 = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        child1.setPosition(ccp(sprite.getContentSize().width / 2.0,
                               sprite.getContentSize().height / 2.0))

        sprite.addChild(child1)
        child1.setScale(0.8)
        parent.addChild(sprite, i)
      end

      @title_label.setString("Sprite + children + skew")
      @subtitle_label.setString("Sprite skew + negative scale with children")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/grossini.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
    end
  end

  class SpriteBatchNodeRotationalSkewNegativeScaleChildren < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.addSpriteFramesWithFile("animations/grossini.plist")
      cache.addSpriteFramesWithFile("animations/grossini_gray.plist",
                                    "animations/grossini_gray.png")

      spritebatch = CCSpriteBatchNode.create("animations/grossini.png")
      layer.addChild(spritebatch)

      2.times do |i|
        #
        # Animation using Sprite batch
        #
        sprite = CCSprite.createWithSpriteFrameName("grossini_dance_01.png")
        sprite.setPosition(ccp(s.width/4*(i+1), s.height/2))

        point = CCSprite.create("Images/r1.png")

        point.setScale(0.25)
        point.setPosition(sprite.getPosition())
        layer.addChild(point, 200)
        
        # Skew
        skewX = CCRotateBy.create(2, 45, 0)
        skewX_back = skewX.reverse()
        skewY = CCRotateBy.create(2, 0, 45)
        skewY_back = skewY.reverse()
        
        sprite.setScale(-1.0) if i == 1

        arr = CCArray.create
        [skewX, skewX_back, skewY, skewY_back].each do |elem|
          arr << elem
        end
        seq_skew = CCSequence.create(arr)
        sprite.runAction(CCRepeatForever.create(seq_skew))

        child1 = CCSprite.create("Images/grossini_dance_01.png")
        child1.setPosition(ccp(sprite.getContentSize().width/2.0,
                               sprite.getContentSize().height/2.0))
        
        sprite.addChild(child1)
        child1.setScale(0.8)
        spritebatch.addChild(sprite, i)
      end

      @title_label.setString("SpriteBatchNode + children + rot skew")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end
    
    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/grossini.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
    end
  end

  class SpriteNilTexture < SpriteTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      # TEST: If no texture is given, then Opacity + Color should work.

      sprite = CCSprite.new
      sprite.init()
      sprite.setTextureRect( CCRectMake(0, 0, 300,300) )
      sprite.setColor(ccRED)
      sprite.setOpacity(128)
      sprite.setPosition(ccp(3*s.width/4, s.height/2))
      layer.addChild(sprite, 100)

      sprite = CCSprite.new
      sprite.init()
      sprite.setTextureRect(CCRectMake(0, 0, 300,300))
      sprite.setColor(ccBLUE)
      sprite.setOpacity(128)
      sprite.setPosition(ccp(1*s.width/4, s.height/2))
      layer.addChild(sprite, 100)

      @title_label.setString("Sprite without texture")
      @subtitle_label.setString("opacity and color should work")
      layer
    end
  end

  class SpriteSubclass < SpriteTestBase
    class MySprite1 < CCSprite
      include Cocos2d

      def inititalize
        super
        @ivar = 10
      end

      def self.createWithSpriteFrameName(name)
        pFrame = CCSpriteFrameCache.sharedSpriteFrameCache().spriteFrameByName(name)
        pobSprite = MySprite1.new
        pobSprite.initWithSpriteFrame(pFrame)
        pobSprite
      end
    end

    class MySprite2 < CCSprite
      include Cocos2d

      def initialize
        super
        @ivar = 10
      end

      def self.create(name)
        pobSprite = MySprite2.new
        pobSprite.initWithFile(name)
        pobSprite
      end
    end

    def init_with_layer(layer)
      super(layer)
      s = @@size

      CCSpriteFrameCache.sharedSpriteFrameCache()
        .addSpriteFramesWithFile("animations/ghosts.plist")
      aParent = CCSpriteBatchNode.create("animations/ghosts.png")

      # MySprite1
      sprite = MySprite1.createWithSpriteFrameName("father.gif")
      sprite.setPosition(ccp( s.width/4*1, s.height/2))
      aParent.addChild(sprite)
      layer.addChild(aParent)

      # MySprite2
      sprite2 = MySprite2.create("Images/grossini.png")
      layer.addChild(sprite2)
      sprite2.setPosition(ccp(s.width/4*3, s.height/2))

      @title_label.setString("Sprite subclass")
      @subtitle_label.setString("Testing initWithTexture:rect method")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/ghosts.plist")
      cache.removeUnusedSpriteFrames()
    end
  end

  class SpriteBatchBug1217 < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      bn = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 15)
      s1 = CCSprite.createWithTexture(bn.getTexture(), CCRectMake(0, 0, 57, 57))
      s2 = CCSprite.createWithTexture(bn.getTexture(), CCRectMake(0, 0, 57, 57))
      s3 = CCSprite.createWithTexture(bn.getTexture(), CCRectMake(0, 0, 57, 57))

      s1.setColor(ccc3(255, 0, 0))
      s2.setColor(ccc3(0, 255, 0))
      s3.setColor(ccc3(0, 0, 255))

      s1.setPosition(ccp(20,200))
      s2.setPosition(ccp(100,0))
      s3.setPosition(ccp(100,0))

      bn.setPosition(ccp(0,0))

      #!!!!!
      s1.addChild(s2)
      s2.addChild(s3)
      bn.addChild(s1)

      layer.addChild(bn)

      @title_label.setString("SpriteBatch - Bug 1217")
      @subtitle_label.setString("Adding big family to spritebatch." +
                                " You shall see 3 heads")
      layer
    end
  end

  class AnimationCache < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      frameCache = CCSpriteFrameCache.sharedSpriteFrameCache()
      frameCache.addSpriteFramesWithFile("animations/grossini.plist")
      frameCache.addSpriteFramesWithFile("animations/grossini_gray.plist")
      frameCache.addSpriteFramesWithFile("animations/grossini_blue.plist")

      #
      # create animation "dance"
      #
      animFrames = CCArray.createWithCapacity(15)
      14.times do |i|
        str = sprintf("grossini_dance_%02d.png",i + 1)
        frame = frameCache.spriteFrameByName(str)
        animFrames.addObject(frame)
      end

      animation = CCAnimation.createWithSpriteFrames(animFrames, 0.2)

      # Add an animation to the Cache
      CCAnimationCache.sharedAnimationCache().addAnimation(animation, "dance")

      #
      # create animation "dance gray"
      #
      animFrames.removeAllObjects()

      14.times do |i|
        str = sprintf("grossini_dance_gray_%02d.png",i + 1)
        frame = frameCache.spriteFrameByName(str)
        animFrames.addObject(frame)
      end

      animation = CCAnimation.createWithSpriteFrames(animFrames, 0.2)

      # Add an animation to the Cache
      CCAnimationCache.sharedAnimationCache().addAnimation(animation, "dance_gray")

      #
      # create animation "dance blue"
      #
      animFrames.removeAllObjects()

      3.times do |i|
        str = sprintf("grossini_blue_%02d.png",i + 1)
        frame = frameCache.spriteFrameByName(str)
        animFrames.addObject(frame)
      end

      animation = CCAnimation.createWithSpriteFrames(animFrames, 0.2)

      # Add an animation to the Cache
      CCAnimationCache.sharedAnimationCache().addAnimation(animation, "dance_blue")


      animCache = CCAnimationCache.sharedAnimationCache()

      animates = CCArray.create
      ["dance", "dance_gray", "dance_blue"].each do |name|
        animation = animCache.animationByName(name)
        animation.setRestoreOriginalFrame(true)
        animates << CCAnimate.create(animation)
      end
      seq = CCSequence.create(animates)

      # create an sprite without texture
      grossini = CCSprite.create()
      frame = frameCache.spriteFrameByName("grossini_dance_01.png")
      grossini.setDisplayFrame(frame)

      winSize = @@size
      grossini.setPosition(ccp(winSize.width/2, winSize.height/2))
      layer.addChild(grossini)

      # run the animation
      grossini.runAction(seq)

      @title_label.setString("AnimationCache")
      @subtitle_label.setString("Sprite should be animated")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/grossini.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_blue.plist")
      cache.removeUnusedSpriteFrames()

      animCache = CCAnimationCache.sharedAnimationCache()
      ["dance", "dance_gray", "dance_blue"].each do |name|
        animCache.removeAnimationByName(name)
      end
    end
  end

  class AnimationCacheFile < SpriteTestBase
    def init_with_layer(layer)
      super(layer)

      frameCache = CCSpriteFrameCache.sharedSpriteFrameCache()
      frameCache.addSpriteFramesWithFile("animations/grossini.plist")
      frameCache.addSpriteFramesWithFile("animations/grossini_gray.plist")
      frameCache.addSpriteFramesWithFile("animations/grossini_blue.plist")


      # Purge previously loaded animation
      CCAnimationCache.purgeSharedAnimationCache()

      animCache = CCAnimationCache.sharedAnimationCache()

      # Add an animation to the Cache
      animCache.addAnimationsWithFile("animations/animations.plist")

      animates = CCArray.create
      ["dance_1", "dance_2", "dance_3"].each do |name|
        animation = animCache.animationByName(name)
        animation.setRestoreOriginalFrame(true)
        animates << CCAnimate.create(animation)
      end

      seq = CCSequence.create(animates)

      # create an sprite without texture
      grossini = CCSprite.create()

      frame = frameCache.spriteFrameByName("grossini_dance_01.png")
      grossini.setDisplayFrame(frame)

      winSize = @@size

      grossini.setPosition(ccp(winSize.width/2, winSize.height/2))

      layer.addChild(grossini)

      # run the animation
      grossini.runAction(seq)

      @title_label.setString("AnimationCache - Load file")
      @subtitle_label.setString("Sprite should be animated")

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onExit
      cache = CCSpriteFrameCache.sharedSpriteFrameCache()
      cache.removeSpriteFramesFromFile("animations/grossini.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_gray.plist")
      cache.removeSpriteFramesFromFile("animations/grossini_blue.plist")
      cache.removeUnusedSpriteFrames()

      CCAnimationCache.sharedAnimationCache().purgeSharedAnimationCache
    end
  end

  def initialize
    super
    [
     Sprite1,
     SpriteBatchNode1,
     SpriteFrameTest,
     SpriteFrameAliasNameTest,
     SpriteAnchorPoint,
     SpriteBatchNodeAnchorPoint,
     SpriteOffsetAnchorRotation,
     SpriteBatchNodeOffsetAnchorRotation,
     SpriteOffsetAnchorScale,
     SpriteBatchNodeOffsetAnchorScale,
     SpriteOffsetAnchorSkew,
     SpriteBatchNodeOffsetAnchorSkew,
     SpriteOffsetAnchorRotationalSkew,
     SpriteBatchNodeOffsetAnchorRotationalSkew,
     SpriteOffsetAnchorSkewScale,
     SpriteBatchNodeOffsetAnchorSkewScale,
     SpriteOffsetAnchorRotationalSkewScale,
     SpriteBatchNodeOffsetAnchorRotationalSkewScale,
     SpriteOffsetAnchorFlip,
     SpriteBatchNodeOffsetAnchorFlip,
     SpriteAnimationSplit,
     SpriteColorOpacity,
     SpriteBatchNodeColorOpacity,
     SpriteZOrder,
     SpriteBatchNodeZOrder,
     SpriteBatchNodeReorder,
     SpriteBatchNodeReorderIssue744,
     SpriteBatchNodeReorderIssue766,
     SpriteBatchNodeReorderIssue767,
     SpriteBatchNodeReorderSameIndex,
     SpriteBatchNodeReorderOneChild,
     NodeSort,
     #SpriteZVertex, #needs GL
     #SpriteBatchNodeZVertex, #needs GL
     Sprite6,
     SpriteFlip,
     SpriteBatchNodeFlip,
     SpriteAliased,
     SpriteBatchNodeAliased,
     SpriteNewTexture,
     SpriteBatchNodeNewTexture,
     SpriteHybrid,
     SpriteBatchNodeChildren,
     SpriteBatchNodeChildrenZ,
     SpriteChildrenVisibility,
     SpriteChildrenVisibilityIssue665,
     SpriteChildrenAnchorPoint,
     SpriteBatchNodeChildrenAnchorPoint,
     SpriteBatchNodeChildrenScale,
     SpriteChildrenChildren,
     SpriteBatchNodeChildrenChildren,
     SpriteSkewNegativeScaleChildren,
     SpriteRotationalSkewNegativeScaleChildren,
     SpriteBatchNodeSkewNegativeScaleChildren,
     SpriteBatchNodeRotationalSkewNegativeScaleChildren,
     SpriteNilTexture,

     #SpriteSubclass, #not supported subclassing.
     #SpriteDoubleResolution, #not supported subclassing.

     SpriteBatchBug1217,
     AnimationCache,
     AnimationCacheFile,
    ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end
