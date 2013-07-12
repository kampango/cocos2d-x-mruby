require "mruby_script/cctype_helper"
require "mruby_script/visible_rect"
require "mruby_script/test_base"

class AccelerometerTest < TestBase
  extend TestBaseExt
  self.supported = true

  class AccelerometerTestLayer < CCLayer
    include Cocos2d
    include CCTypeHelper

    def self.create
      layer = self.new
      layer.init
      layer
    end

    def FIX_POS(pos, min, max)
      if pos < min
        min
      elsif pos > max
        max
      else
        pos
      end
    end

    def init
      super
      that = self
      registerScriptAccelerateHandler(Proc.new {|*args| that.accelerate_handler(*args)})
      @size = CCDirector.sharedDirector.getWinSize
    end

    def onEnter
      setAccelerometerEnabled(true)
      @pBall = CCSprite.create("Images/ball.png")
      @pBall.setPosition(ccp(VisibleRect.center().x, VisibleRect.center().y))
      addChild(@pBall)

      #that = self
      #sched = CCDirector.sharedDirector.getScheduler
      #@entry = sched.scheduleScriptFunc(Proc.new{|dt| that.update(dt)},
      #                                   0.5, false)
    end

    def onExit
      sched = CCDirector.sharedDirector.getScheduler
      sched.removeScheduleScriptEntry(@entry) unless @entry.nil?
      @entry = nil
    end

    def update(dt)
      @count = -1 if @count.nil?
      @count += 1
      v = CCAcceleration.new
      rs = v.respond_to? :x=
      p "#{v}:#{rs}"
      v.x = @size.width / 10 * @count
      v.y = @size.height / 10 * @count
      if v.x > @size.width && v.y > @size.height / 10
        @count = 0
      end
      v.timestamp = Time.now.to_f
      didAccelerate(v)
    end

    def did_accelerate(pAccelerationValue)
      pDir = CCDirector.sharedDirector()

      #FIXME: Testing on the Nexus S sometimes @pBall is NULL
      return if @pBall.nil?

      ballSize  = @pBall.getContentSize()

      ptNow  = @pBall.getPosition()
      ptTemp = pDir.convertToUI(ptNow)

      ptTemp.x += pAccelerationValue.x * 9.81
      ptTemp.y -= pAccelerationValue.y * 9.81

      ptNext = pDir.convertToGL(ptTemp)
      ptNext.x = FIX_POS(ptNext.x, (VisibleRect.left().x+ballSize.width / 2.0), (VisibleRect.right().x - ballSize.width / 2.0))
      ptNext.y = FIX_POS(ptNext.y, (VisibleRect.bottom().y+ballSize.height / 2.0), (VisibleRect.top().y - ballSize.height / 2.0))
      @pBall.setPosition(ptNext)
    end

    def accelerate_handler(pAccelerationValue)
      #cclog("accelerate_handler")
    end
  end

  def init_with_layer(layer)
    super(layer)
    @title_label.setString("AccelerometerTest")
    layer
  end

  def create
    scene = CCScene.create
    layer = AccelerometerTestLayer.create
    init_with_layer(layer)
    scene.addChild(layer)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end
