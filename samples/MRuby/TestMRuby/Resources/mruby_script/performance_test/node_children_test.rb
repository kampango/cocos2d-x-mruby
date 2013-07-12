require "mruby_script/cc_profiler"
require "mruby_script/menu_base"
require "mruby_script/test_base"

class PerformanceTest
  class NodeChildrenTest < PerformBase
    # unstable
    self.supported = false

    class NodeChildrenBase < TestBase
      def kTagInfoLayer
        1
      end
      def kTagMainLayer
        2
      end
      def kTagLabelAtlas
        3
      end
      
      def kTagBase
        20000
      end

      def kMaxNodes
        5000
      end
      def kNodesIncrease
        500
      end

      @@nNodes = 500

      def self.reset
        @@nNodes = 500
      end

      def init_with_layer(layer)
        super(layer)
        @layer = layer

        @title_label.setColor(ccc3(255, 255, 40))
        @title_label.setString(self.title)
        @subtitle_label.setString(self.subtitle)

        s = @@size
        @lastRenderedCount = 0
        @currentQuantityOfNodes = 0
        @quantityOfNodes = @@nNodes

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
        menu.setPosition(ccp(s.width/2, s.height/2+15))
        layer.addChild(menu, 1)

        infoLabel = CCLabelTTF.create("0 nodes", "Marker Felt", 30)
        infoLabel.setColor(ccc3(0,200,20))
        infoLabel.setPosition(ccp(s.width/2, s.height/2-15))
        layer.addChild(infoLabel, 1, kTagInfoLayer)

        #pMenu = NodeChildrenMenuLayer.new(true, TEST_COUNT, @@nCurCase)
        #layer.addChild(pMenu)

        that = self
        layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})

        layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)

        updateQuantityLabel()
        updateQuantityOfNodes()
        layer
      end

      def update(dt)
      end

      def onExit
        @layer.unscheduleUpdate
        CC_PROFILER_DISPLAY_TIMERS()
        CC_PROFILER_PURGE_ALL()
      end

      def onDecrease(pSender)
        @quantityOfNodes -= kNodesIncrease
        @quantityOfNodes = 0 if @quantityOfNodes < 0
        @@nNodes = @quantityOfNodes

        updateQuantityLabel()
        updateQuantityOfNodes()
      end

      def onIncrease(pSender)
        @quantityOfNodes += kNodesIncrease
        @quantityOfNodes = kMaxNodes if @quantityOfNodes > kMaxNodes
        @@nNodes = @quantityOfNodes

        updateQuantityLabel()
        updateQuantityOfNodes()
      end

      def title
        "No title"
      end

      def subtitle
        return ""
      end

      def updateQuantityLabel
        if @quantityOfNodes != @lastRenderedCount
          infoLabel = @layer.getChildByTag(kTagInfoLayer)
          str = sprintf("%u nodes", @quantityOfNodes)
          infoLabel.setString(str)

          @lastRenderedCount = @quantityOfNodes
        end
      end

      def self.create
        layer = CCLayer.create
        self.new.init_with_layer(layer)
        layer
      end
    end

    class IterateSpriteSheet < NodeChildrenBase
      def updateQuantityOfNodes
        s = @@size

        # increase nodes
        if @currentQuantityOfNodes < @quantityOfNodes
          (@quantityOfNodes - @currentQuantityOfNodes).times do |i|
            sprite = CCSprite.createWithTexture(@batchNode.getTexture(),
                                                CCRectMake(0, 0, 32, 32))
            @batchNode.addChild(sprite)
            sprite.setPosition(ccp( CCRANDOM_0_1()*s.width, CCRANDOM_0_1()*s.height))
          end
        # decrease nodes
        elsif @currentQuantityOfNodes > @quantityOfNodes
          (@currentQuantityOfNodes - @quantityOfNodes).times do |i|
            index = @currentQuantityOfNodes - i - 1
            @batchNode.removeChildAtIndex(index, true)
          end
        end

        @currentQuantityOfNodes = @quantityOfNodes
      end

      def init_with_layer(layer)
        @batchNode = CCSpriteBatchNode.create("Images/spritesheet1.png")
        layer.addChild(@batchNode)

        super(layer)
        layer
      end

      def profilerName
        "none"
      end
    end

    class IterateSpriteSheetCArray < IterateSpriteSheet
      def update(dt)
        # iterate using fast enumeration protocol
        pChildren = @batchNode.getChildren()

        CC_PROFILER_START(self.profilerName())

        pChildren.each do |pSprite|
          pSprite.setVisible(false)
        end

        CC_PROFILER_STOP(self.profilerName())
      end


      def title
        "B - Iterate SpriteSheet"
      end

      def subtitle
        "Iterate children using C Array API. See console"
      end

      def profilerName
        "iter c-array"
      end
    end

    class AddRemoveSpriteSheet < NodeChildrenBase
      def init_with_layer(layer)

        @batchNode = CCSpriteBatchNode.create("Images/spritesheet1.png")
        layer.addChild(@batchNode)

        super(layer)
      end

      def updateQuantityOfNodes
        s = @@size

        # increase nodes
        if @currentQuantityOfNodes < @quantityOfNodes
          (@quantityOfNodes - @currentQuantityOfNodes).times do |i|
            sprite = CCSprite.createWithTexture(@batchNode.getTexture(),
                                                CCRectMake(0, 0, 32, 32))
            @batchNode.addChild(sprite)
            sprite.setPosition(ccp( CCRANDOM_0_1()*s.width, CCRANDOM_0_1()*s.height))
            sprite.setVisible(false)
          end
        # decrease nodes
        elsif @currentQuantityOfNodes > @quantityOfNodes
          (@currentQuantityOfNodes - @quantityOfNodes).times do |i|
            index = @currentQuantityOfNodes - i - 1
            @batchNode.removeChildAtIndex(index, true)
          end
        end

        @currentQuantityOfNodes = @quantityOfNodes
      end

      def profilerName
        return "none"
      end
    end

    class AddSpriteSheet < AddRemoveSpriteSheet
      def update(dt)
        # reset seed
        # srandom(0);

        # 15 percent
        totalToAdd = (@currentQuantityOfNodes * 0.15).to_i

        if totalToAdd > 0
          sprites = CCArray.createWithCapacity(totalToAdd)
          zs = Array.new(totalToAdd)

          # Don't include the sprite creation time and random as part of the profiling
          totalToAdd.times do |i|
            pSprite = CCSprite.createWithTexture(@batchNode.getTexture(),
                                                 CCRectMake(0,0,32,32))
            sprites.addObject(pSprite)
            zs[i] = (CCRANDOM_MINUS1_1() * 50).to_i
          end

          # add them with random Z (very important!)
          CC_PROFILER_START( self.profilerName() )

          totalToAdd.times do |i|
            @batchNode.addChild(sprites.objectAtIndex(i), zs[i], kTagBase+i)
          end
        
          @batchNode.sortAllChildren()
        
          CC_PROFILER_STOP(self.profilerName())

          # remove them
          totalToAdd.times do |i|
            @batchNode.removeChildByTag(kTagBase+i, true)
          end
        end
      end

      def title
        "C - Add to spritesheet"
      end

      def subtitle
        "Adds %10 of total sprites with random z. See console"
      end

      def profilerName
        "add sprites"
      end
    end

    class RemoveSpriteSheet < AddRemoveSpriteSheet
      def update(dt)
        #srandom(0);

        # 15 percent
        totalToAdd = (@currentQuantityOfNodes * 0.15).to_i

        if totalToAdd > 0
          sprites = CCArray.createWithCapacity(totalToAdd)

          # Don't include the sprite creation time as part of the profiling
          totalToAdd.times do |i|
            pSprite = CCSprite.createWithTexture(@batchNode.getTexture(),
                                                 CCRectMake(0,0,32,32))
            sprites.addObject(pSprite)
          end

          # add them with random Z (very important!)
          totalToAdd.times do |i|
            @batchNode.addChild(sprites.objectAtIndex(i),
                                CCRANDOM_MINUS1_1() * 50, kTagBase+i)
          end

          # remove them
          CC_PROFILER_START( self.profilerName() )

          totalToAdd.times do |i|
            @batchNode.removeChildByTag(kTagBase+i, true)
          end

          CC_PROFILER_STOP( self.profilerName() )
        end
      end

      def title
        "D - Del from spritesheet"
      end

      def subtitle
        "Remove %10 of total sprites placed randomly. See console"
      end

      def profilerName
        "remove sprites"
      end
    end

    class ReorderSpriteSheet < AddRemoveSpriteSheet
      def update(dt)
        #srandom(0);

        # 15 percent
        totalToAdd = (@currentQuantityOfNodes * 0.15).to_i

        if totalToAdd > 0
          sprites = CCArray.createWithCapacity(totalToAdd)

          # Don't include the sprite creation time as part of the profiling
          totalToAdd.times do |i|
            pSprite = CCSprite.createWithTexture(@batchNode.getTexture(),
                                                 CCRectMake(0,0,32,32))
            sprites.addObject(pSprite)
          end

          # add them with random Z (very important!)
          totalToAdd.times do |i|
            @batchNode.addChild(sprites.objectAtIndex(i),
                                CCRANDOM_MINUS1_1() * 50, kTagBase+i)
          end

          @batchNode.sortAllChildren()

          # reorder them
          CC_PROFILER_START( self.profilerName() )

          children = @batchNode.getChildren()
          totalToAdd.times do |i|
            pNode = children.objectAtIndex(i)
            @batchNode.reorderChild(pNode, CCRANDOM_MINUS1_1() * 50)
          end
        
          @batchNode.sortAllChildren()
          CC_PROFILER_STOP( self.profilerName() )

          # remove them
          totalToAdd.times do |i|
            @batchNode.removeChildByTag(kTagBase+i, true)
          end
        end
      end

      def title
        "E - Reorder from spritesheet"
      end

      def subtitle
        "Reorder %10 of total sprites placed randomly. See console"
      end

      def profilerName
        "reorder sprites"
      end
    end

    def initialize
      super
      [
       #IterateSpriteSheetFastEnum,
       IterateSpriteSheetCArray,
       AddSpriteSheet,
       RemoveSpriteSheet,
       ReorderSpriteSheet,
      ].each do |klass|
        register_create_function(klass, :create)
      end
    end

    def create
      new_scene
    end
  end
end
