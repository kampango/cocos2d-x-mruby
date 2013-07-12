require "mruby_script/cctype_helper"
require "mruby_script/test_base"

module Math
  def self.PI
    3.1415
  end
end

require "mruby_script/visible_rect"

class Ball < Cocos2d::CCSprite
  include Cocos2d
  include CCTypeHelper

  def initialize
    super()
    @velocity = nil
  end

  def radius
    getTexture.getContentSize.width / 2
  end

  def move(delta)
    pos = ccp(getPosition)
    setPosition(ccpAdd(pos, ccpMult(@velocity, delta)))
    #setPosition(@velocity * delta + pos)

    if pos.x > VisibleRect.right.x - radius
      setPosition(ccp(VisibleRect.right.x - radius, pos.y))
      @velocity.x *= -1
    elsif pos.x < VisibleRect.left.x + radius
      setPosition(ccp(VisibleRect.left.x + radius, pos.y))
      @velocity.x *= -1
    end
  end

  def collide_with_paddle(paddle)
    paddle_rect = paddle.rect
    paddle_pos = paddle.getPosition

    paddle_rect.origin.x += paddle_pos.x
    paddle_rect.origin.y += paddle_pos.y

    low_y = paddle_rect.getMinY
    mid_y = paddle_rect.getMidY
    high_y = paddle_rect.getMaxY

    left_x = paddle_rect.getMinX
    right_x = paddle_rect.getMaxX

    pos = getPosition()
    if pos.x > left_x && pos.x < right_x
      hit = false
      angle_offset = 0.0
      if pos.y > mid_y && pos.y <= high_y + radius
        setPosition(ccp(pos.x, high_y + radius))
        hit = true
        angle_offset = Math.PI / 2

      elsif pos.y < mid_y && pos.y >= low_y - radius
        setPosition(ccp(pos.x, low_y - radius))
        hit = true
        angle_offset = -Math.PI / 2
      end

      if hit
        hit_angle = ccpToAngle(ccpSub(paddle_pos, paddle_pos)) + angle_offset
        scalar_velocity = ccpLength(@velocity) * 1.05
        velocity_angle = -ccpToAngle(@velocity) + 0.5 * hit_angle
        @velocity = ccpMult(ccpForAngle(velocity_angle), scalar_velocity)
      end
    end
  end

  def velocity=(velocity)
    @velocity = velocity
  end
  def velocity
    @velocity
  end

  def self.ball_with_texture(texture)
    ball = Ball.new
    ball.initWithTexture(texture)
    #ball.autorelease
    ball
  end
end

class Paddle < Cocos2d::CCSprite
  include Cocos2d
  #extend CCTypeHelper
  include CCTypeHelper
  #include Cocos2d::CCTargetedTouchDelegate

  @@kPaddleStateGrabbed = 0
  @@kPaddleStateUngrabbed = 1

  def kPaddleStateGrabbed
    @@kPaddleStateGrabbed
  end

  def kPaddleStateUngrabbed
    @@kPaddleStateUngrabbed
  end

  def initialize
    super()
    @state = nil
  end

  def rect
    s = getTexture.getContentSize
    CCRectMake(-s.width / 2, -s.height / 2, s.width, s.height)
  end

  def initWithTexture(texture)
    return false unless super(texture)
    @state = kPaddleStateUngrabbed
    true
  end

  def contains_touch_location(x, y)
    pos = ccp(getPosition)
    s = getTexture.getContentSize
    touch_rect = CCRectMake(-s.width / 2 + pos.x, -s.height / 2 + pos.y, s. width, s.height)
    b = touch_rect.containsPoint(ccp(x, y))
    return b
  end

  def touch_began(x, y)
    @state = kPaddleStateGrabbed
    true
  end

  def touch_moved(x, y)
    return if @state == kPaddleStateUngrabbed
    setPosition(ccp(x, y))
  end

  def touch_ended(x, y)
    @state = kPaddleStateUngrabbed
  end

  def on_touch(event_type, x, y)
    case event_type
    when CCTOUCHBEGAN
      touch_began(x, y)
    when CCTOUCHMOVED
      touch_moved(x, y)
    when CCTOUCHENDED
      touch_ended(x, y)
    end
  end

  def self.paddle_with_texture(texture)
    paddle = Paddle.new
    paddle.initWithTexture(texture)
    #paddle.autorelease
    paddle
  end

end

class TouchesTest < TestBase
  extend TestBaseExt
  self.supported = true

  def kStatusBarHeight
    0.0
  end

  def kHighPlayer
    0
  end
  def kLowPlayer
    1
  end

  def kSpriteTag
    0
  end

  def initialize
    super()
    register_create_function(self, :create_touches_layer)
  end

  def reset_and_score_ball_for_player(player)
    @ball_starting_velocity = ccpMult(@ball_starting_velocity, -1.1)
    @ball.velocity = @ball_starting_velocity
    @ball.setPosition(VisibleRect.center)
  end

  def do_step(delta)
    @ball.move(delta)
    @paddles.each do |paddle|
      @ball.collide_with_paddle(paddle)
    end

    ball_pos = ccp(@ball.getPosition)
    if ball_pos.y > VisibleRect.top.y - kStatusBarHeight + @ball.radius
      reset_and_score_ball_for_player(kLowPlayer)
    elsif ball_pos.y < VisibleRect.bottom.y - @ball.radius
      reset_and_score_ball_for_player(kHighPlayer)
    end
  end

  def on_touch(event, x, y)
    @paddles.each do |paddle|
      if paddle.contains_touch_location(x, y)
        return paddle.on_touch(event, x, y)
      end
      true
    end
    false
  end

  def create_touches_layer
    layer = CCLayer.create
    init_with_layer(layer)

    @ball_starting_velocity = ccp(20.0, -100.0)
    mgr = CCTextureCache.sharedTextureCache
    texture = mgr.addImage($s_Ball)
    @ball = Ball.ball_with_texture(texture)

    @ball.setPosition(VisibleRect.center)
    @ball.velocity = @ball_starting_velocity
    layer.addChild(@ball)
    #@ball.retain

    paddle_texture = CCTextureCache.sharedTextureCache.addImage($s_Paddle)

    positions = [ccp(VisibleRect.center.x, VisibleRect.bottom.y + 15),
                 ccp(VisibleRect.center.x, VisibleRect.top.y - kStatusBarHeight - 15),
                 ccp(VisibleRect.center.x, VisibleRect.bottom.y + 100),
                 ccp(VisibleRect.center.x, VisibleRect.top.y - kStatusBarHeight - 100)]

    @paddles = []
    positions.each do |pos|
      paddle = Paddle.paddle_with_texture(paddle_texture)
      paddle.setPosition(pos)
      @paddles.push(paddle)
      layer.addChild(paddle)
    end

    # schedule
    that = self
    layer.scheduleUpdateWithPriorityLua(->(delta) {that.do_step(delta)}, 0)
    layer.setTouchEnabled(true)
    layer.registerScriptTouchHandler(->(event, x, y) {that.on_touch(event, x, y)}, false, -1, false)
    layer
  end

  def create
    scene = CCScene.create
    scene.addChild(create_touches_layer)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end

end
