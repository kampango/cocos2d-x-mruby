require "mruby_script/cctype_helper"
require "mruby_script/gl_constant"
require "mruby_script/test_base"

class EffectAdvancedTest < TestBase
  extend TestBaseExt
  self.supported = true

  class EffectAdvancedTestBase < TestBase
    include Cocos2d
    include GLConstant

    def kTagTextLayer
      1
    end
    def kTagSprite1
      1
    end
    def kTagSprite2
      2
    end
    def kTagBackground
      1
    end
    def kTagLabel
      2
    end

    def title
      "No title"
    end
    def subtitle
      ""
    end

    def init_with_layer(layer)
      super(layer)

      bg = CCSprite.create("Images/background3.png")
      layer.addChild(bg, 0, kTagBackground)
      bg.setPosition( VisibleRect.center() )
    
      grossini = CCSprite.create("Images/grossinis_sister2.png")
      bg.addChild(grossini, 1, kTagSprite1)
      grossini.setPosition(
        ccp(VisibleRect.left().x+VisibleRect.getVisibleRect().size.width/3.0,
            VisibleRect.bottom().y+ 200) )

      arr = CCArray.create
      arr << CCScaleBy.create(2, 5)
      arr << arr[-1].reverse()
      grossini.runAction( CCRepeatForever.create(CCSequence.create(arr)) )

      tamara = CCSprite.create("Images/grossinis_sister1.png")
      bg.addChild(tamara, 1, kTagSprite2)
      tamara.setPosition(
        ccp(VisibleRect.left().x+2*VisibleRect.getVisibleRect().size.width/3.0,
            VisibleRect.bottom().y+200) )

      arr = CCArray.create
      arr << CCScaleBy.create(2, 5)
      arr << arr[-1].reverse()
      tamara.runAction( CCRepeatForever.create(CCSequence.create(arr)) )

      @title_label.setString(self.title)
      @subtitle_label.setString(self.subtitle)
      @subtitle_label.setZOrder(101)

      @layer = layer
      @layer
    end

    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end
  end

  class Effect1 < EffectAdvancedTestBase
    def init_with_layer(layer)
      super(layer)

      target = layer.getChildByTag(kTagBackground)

      # To reuse a grid the grid size and the grid type must be the same.
      # in this case:
      #     Lens3D is Grid3D and it's size is (15,10)
      #     Waves3D is Grid3D and it's size is (15,10)

      size = @@size
      lens = CCLens3D.create(0.0, CCSizeMake(15,10),
                             ccp(size.width/2,size.height/2), 240)
      waves = CCWaves3D.create(10, CCSizeMake(15,10), 18, 15)

      reuse = CCReuseGrid.create(1)
      delay = CCDelayTime.create(8)

      orbit = CCOrbitCamera.create(5, 1, 2, 0, 180, 0, -90)
      orbit_back = orbit.reverse()

      arr = CCArray.create
      arr << orbit
      arr << orbit_back
      target.runAction( CCRepeatForever.create( CCSequence.create(arr) ) )

      arr = CCArray.create
      [lens, delay, reuse, waves].each do |act|
        arr << act
      end
      target.runAction( CCSequence.create(arr) )

      layer
    end

    def title
      "Lens + Waves3d and OrbitCamera"
    end
  end

  class Effect2 < EffectAdvancedTestBase
    def init_with_layer(layer)
      super(layer)

      target = layer.getChildByTag(kTagBackground)
    
      # To reuse a grid the grid size and the grid type must be the same.
      # in this case:
      #     ShakyTiles is TiledGrid3D and it's size is (15,10)
      #     Shuffletiles is TiledGrid3D and it's size is (15,10)
      #       TurnOfftiles is TiledGrid3D and it's size is (15,10)
      shaky = CCShakyTiles3D.create(5, CCSizeMake(15,10), 4, false)
      shuffle = CCShuffleTiles.create(0, CCSizeMake(15,10), 3)
      turnoff = CCTurnOffTiles.create(0, CCSizeMake(15,10), 3)
      turnon = turnoff.reverse()

      # reuse 2 times:
      #   1 for shuffle
      #   2 for turn off
      #   turnon tiles will use a new grid
      reuse = CCReuseGrid.create(2)

      delay = CCDelayTime.create(1)
    
#    id orbit = [OrbitCamera.create:5 radius:1 deltaRadius:2 angleZ:0 deltaAngleZ:180 angleX:0 deltaAngleX:-90];
#    id orbit_back = [orbit reverse];
#
#    [target runAction: [RepeatForever.create: [Sequence actions: orbit, orbit_back, nil]]];

      arr = CCArray.create
      [shaky, delay, reuse, shuffle, delay.copy, turnoff, turnon].each do |act|
        arr << act
      end

      target.runAction(CCSequence.create(arr))
      layer
    end

    def title
      "ShakyTiles + ShuffleTiles + TurnOffTiles"
    end
  end

  class Effect3 < EffectAdvancedTestBase
    def init_with_layer(layer)
      super(layer)

      bg = layer.getChildByTag(kTagBackground)
      target1 = bg.getChildByTag(kTagSprite1)
      target2 = bg.getChildByTag(kTagSprite2)

      waves = CCWaves.create(5, CCSizeMake(15,10), 5, 20, true, false)
      shaky = CCShaky3D.create(5, CCSizeMake(15,10), 4, false)

      target1.runAction( CCRepeatForever.create( waves ) )
      target2.runAction( CCRepeatForever.create( shaky ) )
    
      # moving background. Testing issue #244
      move = CCMoveBy.create(3, ccp(200,0) )
      arr = CCArray.create
      arr << move
      arr << move.reverse
      bg.runAction(CCRepeatForever.create( CCSequence.create(arr) ))

      layer
    end

    def title
      "Effects on 2 sprites"
    end
  end

  class Effect4 < EffectAdvancedTestBase
    class Lens3DTarget < CCNode
      include Cocos2d

      # not supported
      #def setPosition(var)
      #  @pLens3D.setPosition(var)
      #end

      #def getPosition
      #  @pLens3D.getPosition()
      #end

      # super's method cought argument 'action', why?
      #def initialize(action)
      #  super
      #  @pLens3D = action
      #end

      def initialize
        super
        @pLens3D = nil
      end

      def init_with_action(action)
        unless init
          return false
        end
        @pLens3D = action
        that = self
        #@entry = CCDirector.sharedDirector.getScheduler
        #  .scheduleScriptFunc(Proc.new {|dt| that.move_lens}, 0, false)
        true
      end

      #def move_lens
      #  @pLens3D.setPosition(getPosition)
      #end

      #def on_exit
      #  unless @entry.nil?
      #    CCDirector.sharedDirector.getScheduler
      #      .unscheduleScriptEntry(@entry)
      #  end
      #end
    
      def self.create(pAction)
        #Lens3DTarget.new(pAction)
        target = Lens3DTarget.new
        target.init_with_action(pAction)
        target
      end
    end

    def init_with_layer(layer)
      super(layer)

      lens = CCLens3D.create(10, CCSizeMake(32,24), ccp(100,180), 150)
      move = CCJumpBy.create(5, ccp(380,0), 100, 4)
      move_back = move.reverse()
      arr = CCArray.create
      arr << move
      arr << move_back
      seq = CCSequence.create(arr)

      # In cocos2d-iphone, the type of action's target is 'id', so it supports using the instance of 'CCLens3D' as its target.
      # While in cocos2d-x, the target of action only supports CCNode or its subclass,
      # so we make an encapsulation for CCLens3D to achieve that.
      #

      director = CCDirector.sharedDirector()
      pTarget = Lens3DTarget.create(lens)
      # Please make sure the target been added to its parent.
      layer.addChild(pTarget)

      director.getActionManager().addAction(seq, pTarget, false)
      layer.runAction( lens )
      layer
    end

    def title
      "Jumpy Lens3D"
    end
  end

  class Effect5 < EffectAdvancedTestBase

    def init_with_layer(layer)
      super(layer)
      #CCDirector.sharedDirector().setProjection(CCDirectorProjection2D)

      effect = CCLiquid.create(2, CCSizeMake(32,24), 1, 20)

      arr = CCArray.create
      arr << effect
      arr << CCDelayTime.create(2)
      arr << CCStopGrid.create()
      #[DelayTime.create:2],
      #[[effect copy] autorelease],

      stopEffect = CCSequence.create(arr)
    
      bg = layer.getChildByTag(kTagBackground)
      bg.runAction(stopEffect)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def title
      "Test Stop-Copy-Restar"
    end

    def onExit
      CCDirector.sharedDirector().setProjection(kCCDirectorProjection3D)
    end
  end

  class Issue631 < EffectAdvancedTestBase
    def init_with_layer(layer)
      super(layer)

      arr = CCArray.create
      arr << CCDelayTime.create(2.0)
      arr << CCShaky3D.create(5.0, CCSizeMake(5, 5), 16, false)
      effect = CCSequence.create(arr)

      # cleanup
      bg = layer.getChildByTag(kTagBackground)
      layer.removeChild(bg, true)

      # background
      layer1 = CCLayerColor.create( ccc4(255,0,0,255) )
      layer.addChild(layer1, -10)
      sprite = CCSprite.create("Images/grossini.png")
      sprite.setPosition( ccp(50,80) )
      layer1.addChild(sprite, 10)
    
      # foreground
      layer2 = CCLayerColor.create(ccc4( 0, 255,0,255 ) )
      fog = CCSprite.create("Images/Fog.png")

      bf = CC_ccBlendFunc.new
      bf.src = GL_SRC_ALPHA
      bf.dst = GL_ONE_MINUS_SRC_ALPHA
      fog.setBlendFunc(bf)

      layer2.addChild(fog, 1)
      layer.addChild(layer2, 1)
    
      layer2.runAction( CCRepeatForever.create(effect) )

      layer
    end

    def title
      "Testing Opacity"
    end

    def subtitle
      "Effect image should be 100% opaque. Testing issue #631"
    end
  end

  def initialize
    super
    [
     Effect3,
     Effect2,
     Effect1,
     Effect4,
     Effect5,
     Issue631,
     ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end
