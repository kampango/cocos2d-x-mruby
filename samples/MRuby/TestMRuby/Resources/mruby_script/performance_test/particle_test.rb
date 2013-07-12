require "mruby_script/menu_base"
require "mruby_script/test_base"

class PerformanceTest
  class ParticleTest < PerformBase
    self.supported = true

    class ParticleTestBase < TestBase
      def kTagInfoLayer
        1
      end
      def kTagMainLayer
        2
      end
      def kTagParticleSystem
        3
      end
      def kTagLabelAtlas
        4
      end
      def kTagMenuLayer
        1000
      end

      def kMaxParticles
        14000
      end
      def kNodesIncrease
        500
      end

      @@subtestNumber = 1
      @@particles = 500

      def self.create
        layer = CCLayer.create
        self.new.init_with_layer(layer)
        layer
      end

      def self.reset
        @@subtestNumber = 1
        @@particles = 500
      end

      def title
        "No title"
      end

      def subtitle
        ""
      end

      def init_with_layer(layer)
        super(layer)
        @layer = layer
        @title_label.setString(self.title)
        @title_label.setColor(ccc3(255,255,40))
        @subtitle_label.setString(self.subtitle)

        s = @@size

        @lastRenderedCount = 0
        @quantityParticles = @@particles
        p "#{@quantityParticles}"

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
        infoLabel.setPosition(ccp(s.width/2, s.height - 90))
        layer.addChild(infoLabel, 1, kTagInfoLayer)

        # particles on stage
        labelAtlas = CCLabelAtlas.create("0000", "fps_images.png", 12, 32, ".".bytes[0])
        layer.addChild(labelAtlas, 0, kTagLabelAtlas)
        labelAtlas.setPosition(ccp(s.width-66,50))

        # Next Prev Test
        #pMenu = ParticleMenuLayer.new(true, TEST_COUNT, s_nParCurIdx)
        #layer.addChild(pMenu, 1, kTagMenuLayer)

        # Sub Tests
        CCMenuItemFont.setFontSize(40)
        pSubMenu = CCMenu.create()
        6.times do |i|
          str = "#{i + 1}"
          itemFont = CCMenuItemFont.create("#{i + 1}", self, :testNCallback)
          itemFont.setTag(i + 1)
          pSubMenu.addChild(itemFont, 10)

          if i <= 2
            itemFont.setColor(ccc3(200,20,20))
          else
            itemFont.setColor(ccc3(0,200,20))
          end
        end

        pSubMenu.alignItemsHorizontally()
        pSubMenu.setPosition(ccp(s.width/2, 80))
        layer.addChild(pSubMenu, 2)

        updateQuantityLabel()
        createParticleSystem()

        that = self
        @entry = CCDirector.sharedDirector.getScheduler
          .scheduleScriptFunc(Proc.new {|dt| that.step(dt)}, 0, false)

        layer.registerScriptHandler(Proc.new {|tag|
                                      if tag == Cocos2d.kCCNodeOnExit
                                        that.onExit
                                      end})

        layer
      end

      def onExit
        if @entry
          CCDirector.sharedDirector.getScheduler
            .unscheduleScriptEntry(@entry)
          @entry = nil
        end
      end

      def title
        "No title"
      end

      def step(dt)
        atlas = @layer.getChildByTag(kTagLabelAtlas)
        emitter = @layer.getChildByTag(kTagParticleSystem)

        str = sprintf("%4d", emitter.getParticleCount())
        atlas.setString(str)
      end

      def createParticleSystem
        particleSystem = nil

        #
        # Tests:
        # 1: Point Particle System using 32-bit textures (PNG)
        # 2: Point Particle System using 16-bit textures (PNG)
        # 3: Point Particle System using 8-bit textures (PNG)
        # 4: Point Particle System using 4-bit textures (PVRTC)

        # 5: Quad Particle System using 32-bit textures (PNG)
        # 6: Quad Particle System using 16-bit textures (PNG)
        # 7: Quad Particle System using 8-bit textures (PNG)
        # 8: Quad Particle System using 4-bit textures (PVRTC)
        #
        if @layer.getChildByTag(kTagParticleSystem)
          @layer.removeChildByTag(kTagParticleSystem, true)
        end

        # remove the "fire.png" from the TextureCache cache. 
        cache = CCTextureCache.sharedTextureCache()
        texture = cache.addImage("Images/fire.png")
        cache.removeTexture(texture)

        #TODO:if subtestNumber <= 3
        #       particleSystem = CCParticleSystemPoint.new()
        #     else
        particleSystem = CCParticleSystemQuad.new
        #     end

        case @@subtestNumber
        when 1
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
          particleSystem.initWithTotalParticles(@quantityParticles)
          particleSystem.setTexture(cache.addImage("Images/fire.png"))
        when 2
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA4444)
          particleSystem.initWithTotalParticles(@quantityParticles)
          particleSystem.setTexture(cache.addImage("Images/fire.png"))
        when 3
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_A8)
          particleSystem.initWithTotalParticles(@quantityParticles)
          particleSystem.setTexture(cache.addImage("Images/fire.png"))
        #when 4
        #  particleSystem.initWithTotalParticles(@quantityParticles)
        #  #---- particleSystem.texture = [[CCTextureCache sharedTextureCache] addImage:@"fire.pvr"];
        #  particleSystem.setTexture(cache.addImage("Images/fire.png"))
        when 4
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
          particleSystem.initWithTotalParticles(@quantityParticles)
          particleSystem.setTexture(cache.addImage("Images/fire.png"))
        when 5
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA4444)
          particleSystem.initWithTotalParticles(@quantityParticles)
          particleSystem.setTexture(cache.addImage("Images/fire.png"))
        when 6
          CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_A8)
          particleSystem.initWithTotalParticles(@quantityParticles)
          particleSystem.setTexture(cache.addImage("Images/fire.png"))
        #when 8
        #  particleSystem.initWithTotalParticles(@quantityParticles)
          #---- particleSystem.texture = [[CCTextureCache sharedTextureCache] addImage:@"fire.pvr"];
        #  particleSystem.setTexture(cache.addImage("Images/fire.png"))
        else
          particleSystem = nil
          cclog("Shall not happen!")
        end

        @layer.addChild(particleSystem, 0, kTagParticleSystem)

        doTest()

        # restore the default pixel format
        CCTexture2D.setDefaultAlphaPixelFormat(kCCTexture2DPixelFormat_RGBA8888)
      end

      def testNCallback(pSender)
        @@subtestNumber = pSender.getTag()
        #pMenu = @layer.getChildByTag(kTagMenuLayer)
        #pMenu.restart_action
        CCNotificationCenter.sharedNotificationCenter
          .postNotification("restart_action", self)
      end

      def onIncrease(pSender)
        @quantityParticles += kNodesIncrease
        @quantityParticles = kMaxParticles if @quantityParticles > kMaxParticles
        @@particles = @quantityParticles

        updateQuantityLabel()
        createParticleSystem()
      end

      def onDecrease(pSender)
        @quantityParticles -= kNodesIncrease
        @quantityParticles = 0 if @quantityParticles < 0
        @@particles = @quantityParticles

        updateQuantityLabel()
        createParticleSystem()
      end

      def updateQuantityLabel
        if @quantityParticles != @lastRenderedCount
          infoLabel = @layer.getChildByTag(kTagInfoLayer)
          str = sprintf("%u particles", @quantityParticles)
          infoLabel.setString(str)

          @lastRenderedCount = @quantityParticles
        end
      end
    end

    class ParticlePerformTest1 < ParticleTestBase
      def title
        "A (#{@@subtestNumber}) size=4"
      end

      def doTest
        s = @@size
        particleSystem = @layer.getChildByTag(kTagParticleSystem)

        # duration
        particleSystem.setDuration(-1)

        # gravity
        particleSystem.setGravity(ccp(0,-90))

        # angle
        particleSystem.setAngle(90)
        particleSystem.setAngleVar(0)

        # radial
        particleSystem.setRadialAccel(0)
        particleSystem.setRadialAccelVar(0)

        # speed of particles
        particleSystem.setSpeed(180)
        particleSystem.setSpeedVar(50)

        # emitter position
        particleSystem.setPosition(ccp(s.width/2, 100))
        particleSystem.setPosVar(ccp(s.width/2,0))

        # life of particles
        particleSystem.setLife(2.0)
        particleSystem.setLifeVar(1)

        # emits per frame
        particleSystem.setEmissionRate(particleSystem.getTotalParticles() /particleSystem.getLife())

        # color of particles
        startColor = ccc4f(0.5, 0.5, 0.5, 1.0)
        particleSystem.setStartColor(startColor)

        startColorVar = ccc4f(0.5, 0.5, 0.5, 1.0)
        particleSystem.setStartColorVar(startColorVar)

        endColor = ccc4f(0.1, 0.1, 0.1, 0.2)
        particleSystem.setEndColor(endColor)

        endColorVar = ccc4f(0.1, 0.1, 0.1, 0.2)
        particleSystem.setEndColorVar(endColorVar)

        # size, in pixels
        particleSystem.setEndSize(4.0)
        particleSystem.setStartSize(4.0)
        particleSystem.setEndSizeVar(0)
        particleSystem.setStartSizeVar(0)

        # additive
        particleSystem.setBlendAdditive(false)
      end
    end

    class ParticlePerformTest2 < ParticleTestBase
      def title
        "B (#{@@subtestNumber}) size=8"
      end

      def doTest
        s = @@size
        particleSystem = @layer.getChildByTag(kTagParticleSystem)

        # duration
        particleSystem.setDuration(-1)

        # gravity
        particleSystem.setGravity(ccp(0,-90))

        # angle
        particleSystem.setAngle(90)
        particleSystem.setAngleVar(0)

        # radial
        particleSystem.setRadialAccel(0)
        particleSystem.setRadialAccelVar(0)

        # speed of particles
        particleSystem.setSpeed(180)
        particleSystem.setSpeedVar(50)

        # emitter position
        particleSystem.setPosition(ccp(s.width/2, 100))
        particleSystem.setPosVar(ccp(s.width/2,0))

        # life of particles
        particleSystem.setLife(2.0)
        particleSystem.setLifeVar(1)

        # emits per frame
        particleSystem.setEmissionRate(particleSystem.getTotalParticles() / particleSystem.getLife())

        # color of particles
        startColor = ccc4f(0.5, 0.5, 0.5, 1.0)
        particleSystem.setStartColor(startColor)

        startColorVar = ccc4f(0.5, 0.5, 0.5, 1.0)
        particleSystem.setStartColorVar(startColorVar)

        endColor = ccc4f(0.1, 0.1, 0.1, 0.2)
        particleSystem.setEndColor(endColor)

        endColorVar = ccc4f(0.1, 0.1, 0.1, 0.2)
        particleSystem.setEndColorVar(endColorVar)

        # size, in pixels
        particleSystem.setEndSize(8.0)
        particleSystem.setStartSize(8.0)
        particleSystem.setEndSizeVar(0)
        particleSystem.setStartSizeVar(0)

        # additive
        particleSystem.setBlendAdditive(false)
      end
    end

    class ParticlePerformTest3 < ParticleTestBase
      def title
        "C (#{@@subtestNumber}) size=32"
      end

      def doTest
        s = @@size
        particleSystem = @layer.getChildByTag(kTagParticleSystem)

        # duration
        particleSystem.setDuration(-1)

        # gravity
        particleSystem.setGravity(ccp(0,-90))

        # angle
        particleSystem.setAngle(90)
        particleSystem.setAngleVar(0)

        # radial
        particleSystem.setRadialAccel(0)
        particleSystem.setRadialAccelVar(0)

        # speed of particles
        particleSystem.setSpeed(180)
        particleSystem.setSpeedVar(50)

        # emitter position
        particleSystem.setPosition(ccp(s.width/2, 100))
        particleSystem.setPosVar(ccp(s.width/2,0))

        # life of particles
        particleSystem.setLife(2.0)
        particleSystem.setLifeVar(1)

        # emits per frame
        particleSystem.setEmissionRate(particleSystem.getTotalParticles() / particleSystem.getLife())

        # color of particles
        startColor = ccc4f(0.5, 0.5, 0.5, 1.0)
        particleSystem.setStartColor(startColor)

        startColorVar = ccc4f(0.5, 0.5, 0.5, 1.0)
        particleSystem.setStartColorVar(startColorVar)

        endColor = ccc4f(0.1, 0.1, 0.1, 0.2)
        particleSystem.setEndColor(endColor)

        endColorVar = ccc4f(0.1, 0.1, 0.1, 0.2)
        particleSystem.setEndColorVar(endColorVar)

        # size, in pixels
        particleSystem.setEndSize(32.0)
        particleSystem.setStartSize(32.0)
        particleSystem.setEndSizeVar(0)
        particleSystem.setStartSizeVar(0)

        # additive
        particleSystem.setBlendAdditive(false)
      end
    end

    class ParticlePerformTest4 < ParticleTestBase
      def title
        "D (#{@@subtestNumber}) size=64"
      end

      def doTest
        s = @@size
        particleSystem = @layer.getChildByTag(kTagParticleSystem)

        # duration
        particleSystem.setDuration(-1)

        # gravity
        particleSystem.setGravity(ccp(0,-90))

        # angle
        particleSystem.setAngle(90)
        particleSystem.setAngleVar(0)

        # radial
        particleSystem.setRadialAccel(0)
        particleSystem.setRadialAccelVar(0)

        # speed of particles
        particleSystem.setSpeed(180)
        particleSystem.setSpeedVar(50)

        # emitter position
        particleSystem.setPosition(ccp(s.width/2, 100))
        particleSystem.setPosVar(ccp(s.width/2,0))

        # life of particles
        particleSystem.setLife(2.0)
        particleSystem.setLifeVar(1)

        # emits per frame
        particleSystem.setEmissionRate(particleSystem.getTotalParticles() / particleSystem.getLife())

        # color of particles
        startColor = ccc4f(0.5, 0.5, 0.5, 1.0)
        particleSystem.setStartColor(startColor)

        startColorVar = ccc4f(0.5, 0.5, 0.5, 1.0)
        particleSystem.setStartColorVar(startColorVar)

        endColor = ccc4f(0.1, 0.1, 0.1, 0.2)
        particleSystem.setEndColor(endColor)

        endColorVar = ccc4f(0.1, 0.1, 0.1, 0.2)
        particleSystem.setEndColorVar(endColorVar)

        # size, in pixels
        particleSystem.setEndSize(64.0)
        particleSystem.setStartSize(64.0)
        particleSystem.setEndSizeVar(0)
        particleSystem.setStartSizeVar(0)

        # additive
        particleSystem.setBlendAdditive(false)
      end
    end


    def initialize
      super
      [
       ParticlePerformTest1,
       ParticlePerformTest2,
       ParticlePerformTest3,
       ParticlePerformTest4,
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
  end
end
