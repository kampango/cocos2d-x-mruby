
class PerformanceTest
  class TouchesTest < PerformBase
    self.supported = true

    def initialize
      super
      [TouchesPerformTest1,
       TouchesPerformTest2,
      ].each do |klass|
        register_create_function(klass, :create)
      end
    end

    def create
      new_scene
    end

    class TouchesTestBase < TestBase
      def init_with_layer(layer)
        super(layer)
        @layer = layer
        s = @@size

        @title_label.setString(self.title)

        that = self
        layer.registerScriptHandler(Proc.new {|tag|
                                      if tag == Cocos2d.kCCNodeOnEnter
                                        that.onEnter
                                      end})
        layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)

        @plabel = CCLabelBMFont.create("00.0", "fonts/arial16.fnt")
        @plabel.setPosition(ccp(s.width/2, s.height/2))
        layer.addChild(@plabel)

        @elapsedTime = 0
        @numberOfTouchesB = @numberOfTouchesM = 0
        @numberOfTouchesE = @numberOfTouchesC = 0

        layer
      end

      def onEnter
      end

      def update(dt)
        @elapsedTime += dt

        if @elapsedTime > 1.0
          frameRateB = @numberOfTouchesB / @elapsedTime
          frameRateM = @numberOfTouchesM / @elapsedTime
          frameRateE = @numberOfTouchesE / @elapsedTime
          frameRateC = @numberOfTouchesC / @elapsedTime
          @elapsedTime = 0
          @numberOfTouchesB = @numberOfTouchesM = 0
          @numberOfTouchesE = @numberOfTouchesC = 0

          str = sprintf("%.1f %.1f %.1f %.1f",
                        frameRateB, frameRateM, frameRateE, frameRateC)
          @plabel.setString(str)
        end
      end

      def title
        "No title"
      end

      def self.create
        layer = CCLayer.create
        self.new.init_with_layer(layer)
        layer
      end
    end

    class TouchesPerformTest1 < TouchesTestBase
      def onEnter
        super
        registerWithTouchDispatcher
        @layer.setTouchEnabled(true)
      end

      def title
        "Targeted touches"
      end

      def registerWithTouchDispatcher
        #pDirector = CCDirector.sharedDirector()
        #pDirector.getTouchDispatcher().addTargetedDelegate(self, 0, true)
        that = self
        @layer.registerScriptTouchHandler(Proc.new {|*args| that.on_touch(*args)},
                                          false, -1, false)
      end

      def on_touch(event_type, x, y)
        case event_type
        when CCTOUCHBEGAN
          ccTouchBegan(x, y)
        when CCTOUCHMOVED
          ccTouchMoved(x, y)
        when CCTOUCHENDED
          ccTouchEnded(x, y)
        when CCTOUCHCANCELLED
          ccTouchCancelled(x, y)
        end
      end

      def ccTouchBegan(x, y)
        @numberOfTouchesB += 1
        true
      end

      def ccTouchMoved(x, y)
        @numberOfTouchesM += 1
      end

      def ccTouchEnded(x, y)
        @numberOfTouchesE += 1
      end

      def ccTouchCancelled(x, y)
        @numberOfTouchesC += 1
      end
    end


    class TouchesPerformTest2 < TouchesTestBase
      def onEnter
        super
        registerWithTouchDispatcher
        @layer.setTouchEnabled(true)
      end

      def title
        "Standard touches"
      end

      def registerWithTouchDispatcher
        #pDirector = CCDirector.sharedDirector()
        #pDirector.getTouchDispatcher().addStandardDelegate(self, 0)
        that = self
        @layer.registerScriptTouchHandler(Proc.new {|*args| that.on_touch(*args)}, true, -1, false)
      end

      def on_touch(event_type, touches)
        case event_type
        when CCTOUCHBEGAN
          ccTouchesBegan(touches)
        when CCTOUCHMOVED
          ccTouchesMoved(touches)
        when CCTOUCHENDED
          ccTouchesEnded(touches)
        when CCTOUCHCANCELLED
          ccTouchesCancelled(touches)
        end
      end

      def ccTouchesBegan(touches)
        @numberOfTouchesB += touches.size
      end

      def ccTouchesMoved(touches)
        @numberOfTouchesM += touches.size
      end

      def ccTouchesEnded(touches)
        @numberOfTouchesE += touches.size
      end

      def ccTouchesCancelled(touches)
        @numberOfTouchesC += touches.size
      end
    end
  end
end
