
class PerformanceTest
  class SpriteTest < PerformBase
    self.supported = true

    def initialize
      super
      [SpritePerformTest1,
       SpritePerformTest2,
       SpritePerformTest3,
       SpritePerformTest4,
       SpritePerformTest5,
       SpritePerformTest6,
       SpritePerformTest7,
      ].each do |klass|
        register_create_function(klass, :create)
      end
    end

    def new_scene
      scene = super
      that = self
      notification_center = CCNotificationCenter.sharedNotificationCenter
      notification_center
        .registerScriptObserver(scene,
                                Proc.new {
                                  Cocos2d::CCDirector.sharedDirector
                                    .replaceScene(that.restart_action)
                                }, "restart_action")
      scene.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      notification_center
                                        .unregisterScriptObserver(scene,
                                                                  "restart_action")
                                      scene.unregisterScriptHandler
                                    end
                                  })
      scene
    end

    def create
      new_scene
    end

    class SubTestBase < TestBase
      def self.create
        layer = CCLayer.create
        self.new.init_with_layer(layer)
        layer
      end

      def kMaxNodes
        50000
      end
      def kNodesIncrease
        250
      end

      def kTagInfoLayer
        1
      end
      def kTagMainLayer
        2
      end
      def kTagMenuLayer
        kMaxNodes + 1000
      end

      @@subtestNumber = 1
      @@nNodes = 50

      def init_sub_test
        p = @layer
        @batchNode = nil
        #
        # Tests:
        # 1: 1 (32-bit) PNG sprite of 52 x 139
        # 2: 1 (32-bit) PNG Batch Node using 1 sprite of 52 x 139
        # 3: 1 (16-bit) PNG Batch Node using 1 sprite of 52 x 139
        # 4: 1 (4-bit) PVRTC Batch Node using 1 sprite of 52 x 139

        # 5: 14 (32-bit) PNG sprites of 85 x 121 each
        # 6: 14 (32-bit) PNG Batch Node of 85 x 121 each
        # 7: 14 (16-bit) PNG Batch Node of 85 x 121 each
        # 8: 14 (4-bit) PVRTC Batch Node of 85 x 121 each

        # 9: 64 (32-bit) sprites of 32 x 32 each
        #10: 64 (32-bit) PNG Batch Node of 32 x 32 each
        #11: 64 (16-bit) PNG Batch Node of 32 x 32 each
        #12: 64 (4-bit) PVRTC Batch Node of 32 x 32 each
        #

        # purge textures
        mgr = CCTextureCache.sharedTextureCache()
#        [mgr removeAllTextures];
        mgr.removeTexture(mgr.addImage("Images/grossinis_sister1.png"))
        mgr.removeTexture(mgr.addImage("Images/grossini_dance_atlas.png"))
        mgr.removeTexture(mgr.addImage("Images/spritesheet1.png"))

        case @@subtestNumber
        when 1, 4, 7
          #
        when 2
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
          @batchNode = CCSpriteBatchNode.create("Images/grossinis_sister1.png", 100)
          p.addChild(@batchNode, 0)
        when 3
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA4444)
          @batchNode = CCSpriteBatchNode.create("Images/grossinis_sister1.png", 100)
          p.addChild(@batchNode, 0)
        when 5
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
          @batchNode = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 100)
          p.addChild(@batchNode, 0)
        when 6
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA4444)
          @batchNode = CCSpriteBatchNode.create("Images/grossini_dance_atlas.png", 100)
          p.addChild(@batchNode, 0)
        when 8
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
          @batchNode = CCSpriteBatchNode.create("Images/spritesheet1.png", 100)
          p.addChild(@batchNode, 0)
        when 9
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA4444)
          @batchNode = CCSpriteBatchNode.create("Images/spritesheet1.png", 100)
          p.addChild(@batchNode, 0);
        end

        CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_Default)
      end

      def createSpriteWithTag(tag)
        # create 
        CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)

        sprite = nil
        case @@subtestNumber
        when 1
          sprite = CCSprite.create("Images/grossinis_sister1.png")
          @layer.addChild(sprite, 0, tag+100)

        when 2, 3
          sprite = CCSprite.createWithTexture(@batchNode.getTexture(),
                                              CCRectMake(0, 0, 52, 139))
          @batchNode.addChild(sprite, 0, tag+100)

        when 4
          idx = (CCRANDOM_0_1() * 1400 / 100) + 1
          str = sprintf("Images/grossini_dance_%02d.png", idx)
          sprite = CCSprite.create(str)
          @layer.addChild(sprite, 0, tag+100)

        when 5, 6
          r = (CCRANDOM_0_1() * 1400 / 100).to_i

          y = (r / 5).to_i
          x = r % 5

          x *= 85
          y *= 121
          sprite = CCSprite.createWithTexture(@batchNode.getTexture(),
                                              CCRectMake(x,y,85,121))
          @batchNode.addChild(sprite, 0, tag+100);

        when 7
          r = (CCRANDOM_0_1() * 6400 / 100).to_i

          y = (r / 8).to_i
          x = r % 8

          str = sprintf("Images/sprites_test/sprite-%d-%d.png", x, y)
          sprite = CCSprite.create(str)
          @layer.addChild(sprite, 0, tag+100)

        when 8, 9
          r = (CCRANDOM_0_1() * 6400 / 100).to_i

          y = (r / 8).to_i
          x = r % 8

          x *= 32
          y *= 32
          sprite = CCSprite.createWithTexture(@batchNode.getTexture(),
                                              CCRectMake(x,y,32,32))
          @batchNode.addChild(sprite, 0, tag+100)
        end

        CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_Default)
        sprite
      end

      def removeByTag(tag)
        case @@subtestNumber
        when 1, 4, 7
          @layer.removeChildByTag(tag+100, true)
        when 2, 3, 5, 6, 8, 9
          @batchNode.removeChildAtIndex(tag, true)
          #[batchNode removeChildByTag:tag+100 cleanup:YES];
        end
      end

      def init_with_layer(layer)
        super(layer)
        @layer = layer

        @lastRenderedCount = 0
        @quantityNodes = 0

        init_sub_test()

        s = @@size

        CCMenuItemFont.setFontSize(65)
        decrease = CCMenuItemFont.create(" - ", self, :onDecrease)
        decrease.setColor(ccc3(0,200,20))
        increase = CCMenuItemFont.create(" + ", self, :onIncrease)
        increase.setColor(ccc3(0,200,20))

        items = CCArray.create
        items << decrease
        items << increase
        menu = CCMenu.createWithArray(items)
        menu.alignItemsHorizontally()
        menu.setPosition(ccp(s.width/2, s.height-65))
        layer.addChild(menu, 1)

        infoLabel = CCLabelTTF.create("0 nodes", "Marker Felt", 30)
        infoLabel.setColor(ccc3(0,200,20))
        infoLabel.setPosition(ccp(s.width/2, s.height-90))
        layer.addChild(infoLabel, 1, kTagInfoLayer)

        # Sub Tests
        CCMenuItemFont.setFontSize(32)
        pSubMenu = CCMenu.create()
        9.times do |i|
          itemFont = CCMenuItemFont.create("#{i + 1}", self, :testNCallback)
          itemFont.setTag(i + 1)
          pSubMenu.addChild(itemFont, 10)

          if i<= 3
            itemFont.setColor(ccc3(200,20,20))
          elsif i <= 6
            itemFont.setColor(ccc3(0,200,20))
          else
            itemFont.setColor(ccc3(0,20,200))
          end
        end

        pSubMenu.alignItemsHorizontally()
        pSubMenu.setPosition(ccp(s.width/2, 80))
        layer.addChild(pSubMenu, 2)

        # add title label
        @title_label.setString(self.title)
          .setFontSize(40)
          .setPosition(ccp(s.width/2, s.height-32))
          .setColor(ccc3(255,255,40))

        nodes = @@nNodes
        while @quantityNodes < nodes
          onIncrease()
        end

        layer
      end

      def title
        "No title"
      end

      def testNCallback(pSender)
        @@subtestNumber = pSender.getTag()
        p "#{@@subtestNumber}"
        #pMenu = @layer.getChildByTag(kTagMenuLayer)
        #pMenu.restartCallback(pSender)
        CCNotificationCenter.sharedNotificationCenter
          .postNotification("restart_action", self)
      end

      def updateNodes
        if @quantityNodes != @lastRenderedCount
          infoLabel = @layer.getChildByTag(kTagInfoLayer)
          str = sprintf("%u nodes", @quantityNodes)
          infoLabel.setString(str)

          @lastRenderedCount = @quantityNodes
        end
      end

      def onIncrease(pSender = nil)
        return if @quantityNodes >= kMaxNodes

        kNodesIncrease.times do |i|
          sprite = createSpriteWithTag(@quantityNodes)
          doTest(sprite)
          @quantityNodes += 1
        end

        @@nNodes = @quantityNodes
        updateNodes()
      end

      def onDecrease(pSender)
        return if @quantityNodes <= 0

        kNodesIncrease.times do |i|
          @quantityNodes -= 1
          removeByTag(@quantityNodes)
        end

        @@nNodes = @quantityNodes
        updateNodes()
      end

      def performanceActions(pSprite)
        size = @@size
        pSprite.setPosition(ccp(CCRANDOM_0_1() * size.width.to_i,
                                CCRANDOM_0_1() * size.height.to_i))

        period = 0.5 + (CCRANDOM_0_1() * 1000) / 500.0
        rot = CCRotateBy.create(period, 360.0 * CCRANDOM_0_1())
        rot_back = rot.reverse()

        acts = CCArray.create
        acts << rot
        acts << rot_back
        permanentRotation = CCRepeatForever.create(CCSequence.create(acts))
        pSprite.runAction(permanentRotation)

        growDuration = 0.5 + (CCRANDOM_0_1() * 1000) / 500.0
        grow = CCScaleBy.create(growDuration, 0.5, 0.5)

        acts = CCArray.create
        acts << grow
        acts << grow.reverse()
        permanentScaleLoop = CCRepeatForever.create(CCSequence.create(acts))
        pSprite.runAction(permanentScaleLoop)
      end

      def performanceActions20(pSprite)
        size = @@size

        if CCRANDOM_0_1() < 0.2
          pSprite.setPosition(ccp(CCRANDOM_0_1() * size.width.to_i,
                                  CCRANDOM_0_1() * size.height.to_i))
        else
          pSprite.setPosition(ccp( -1000, -1000))
        end

        period = 0.5 + (CCRANDOM_0_1() * 1000) / 500.0
        rot = CCRotateBy.create(period, 360.0 * CCRANDOM_0_1())
        rot_back = rot.reverse()

        acts = CCArray.create
        acts << rot
        acts << rot_back
        permanentRotation = CCRepeatForever.create(CCSequence.create(acts))
        pSprite.runAction(permanentRotation)

        growDuration = 0.5 + (CCRANDOM_0_1() * 1000) / 500.0
        grow = CCScaleBy.create(growDuration, 0.5, 0.5)
        permanentScaleLoop = CCRepeatForever.create(CCSequence.createWithTwoActions(grow, grow.reverse()))
        pSprite.runAction(permanentScaleLoop)
      end

      def performanceRotationScale(pSprite)
        size = @@size
        pSprite.setPosition(ccp(CCRANDOM_0_1() * size.width.to_i,
                                CCRANDOM_0_1() * size.height.to_i))
        pSprite.setRotation(CCRANDOM_0_1() * 360)
        pSprite.setScale(CCRANDOM_0_1() * 2)
      end

      def performancePosition(pSprite)
        size = @@size
        pSprite.setPosition(ccp(CCRANDOM_0_1() * size.width.to_i,
                                CCRANDOM_0_1() * size.height.to_i))
      end

      def performanceout20(pSprite)
        size = @@size

        if CCRANDOM_0_1() < 0.2
          pSprite.setPosition(ccp(CCRANDOM_0_1() * size.width.to_i,
                                  CCRANDOM_0_1() * size.height.to_i))
        else
          pSprite.setPosition(ccp( -1000, -1000))
        end
      end

      def performanceOut100(pSprite)
        pSprite.setPosition(ccp( -1000, -1000))
      end

      def performanceScale(pSprite)
        size = @@size
        pSprite.setPosition(ccp(CCRANDOM_0_1() * size.width.to_i,
                                CCRANDOM_0_1() * size.height.to_i))
        pSprite.setScale(CCRANDOM_0_1() * 100 / 50)
      end
    end

    class SpritePerformTest1 < SubTestBase
      def title
        "A (#{@@subtestNumber}) position"
      end

      def doTest(sprite)
        performancePosition(sprite)
      end
    end

    class SpritePerformTest2 < SubTestBase
      def title
        "B (#{@@subtestNumber}) scale"
      end

      def doTest(sprite)
        performanceScale(sprite)
      end
    end

    class SpritePerformTest3 < SubTestBase
      def title
        "C (#{@@subtestNumber}) scale + rot"
      end

      def doTest(sprite)
        performanceRotationScale(sprite)
      end
    end

    class SpritePerformTest4 < SubTestBase
      def title
        "D (#{@@subtestNumber}) 100% out"
      end

      def doTest(sprite)
        performanceOut100(sprite)
      end
    end

    class SpritePerformTest5 < SubTestBase
      def title
        "E (#{@@subtestNumber}) 80% out"
      end

      def doTest(sprite)
        performanceout20(sprite)
      end
    end

    class SpritePerformTest6 < SubTestBase
      def title
        "F (#{@@subtestNumber}) actions"
      end

      def doTest(sprite)
        performanceActions(sprite)
      end
    end

    class SpritePerformTest7 < SubTestBase
      def title
        "G (#{@@subtestNumber}) actions 80% out"
      end

      def doTest(sprite)
        performanceActions20(sprite)
      end
    end
  end
end
