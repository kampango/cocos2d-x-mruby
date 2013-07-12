require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class MultiTouchTest < TestBase
  extend TestBaseExt
  self.supported = true

  class TouchPoint < CCDrawNode
    include Cocos2d
    include CCTypeHelper

    def self.create(size)
      draw = self.new
      draw.init_with_size(size)
      draw
    end

    def init_with_size(size)
      init
      @dirty = false
      @touch_point = nil
      @touch_color = nil
      setContentSize(size)
      setAnchorPoint(ccp(0, 0))
      that = self
      scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)
      true
    end

    def touch_point=(pos)
      @touch_point = pos
      @dirty = true
    end

    def touch_color=(color)
      @touch_color = color
      @dirty = true
    end

    def update(dt)
      return unless @dirty
      s = getContentSize()
      clear
      #s = CCDirector.sharedDirector.getWinSize
      drawDot(@touch_point, 30, @touch_color)
      drawSegment(ccp(@touch_point.x, 0), ccp(@touch_point.x, s.height),
                  10, @touch_color)
      drawSegment(ccp(0, @touch_point.y), ccp(s.width, @touch_point.y),
                  10, @touch_color)
      @dirty = false
    end
  end

  def init_with_layer(layer)
    super(layer)
    @layer = layer
    layer.setTouchEnabled(true)
    that = self
    layer.registerScriptTouchHandler(Proc.new {|*args| that.on_touches(*args)},
                                     true, -1, false)
    layer
  end

  def on_touches(event_type, touches)
    if event_type == CCTOUCHBEGAN
      ccTouchesBegan(touches)
    elsif event_type == CCTOUCHMOVED
      ccTouchesMoved(touches)
    elsif event_type == CCTOUCHENDED
      ccTouchesEnded(touches)
    elsif event_type == CCTOUCHCANCELLED
      ccTouchesEnded(touches)
    end
  end

  c3y = Cocos2d.ccYELLOW
  c3b = Cocos2d.ccBLUE
  c3g = Cocos2d.ccGREEN
  c3r = Cocos2d.ccRED
  c3m = Cocos2d.ccMAGENTA
  @@s_TouchColors =
    [Cocos2d.ccc4f(c3y.r / 255, c3y.g / 255, c3y.b / 255, 1),
     Cocos2d.ccc4f(c3b.r / 255, c3b.g / 255, c3b.b / 255, 1),
     Cocos2d.ccc4f(c3g.r / 255, c3g.g / 255, c3g.b / 255, 1),
     Cocos2d.ccc4f(c3r.r / 255, c3r.g / 255, c3r.b / 255, 1),
     Cocos2d.ccc4f(c3m.r / 255, c3m.g / 255, c3m.b / 255, 1),
    ]

  def ccTouchesBegan(touches)
    touches.each do |pTouch|
      pTouchPoint = TouchPoint.create(@layer.getContentSize)
      location = pTouch.getLocation()

      pTouchPoint.touch_point = location
      pTouchPoint.touch_color = @@s_TouchColors[pTouch.getID()]

      @layer.addChild(pTouchPoint);
      @s_dic[pTouch.getID()] = pTouchPoint
    end
  end

  def ccTouchesMoved(touches)
    touches.each do |pTouch|
      pTP = @s_dic[pTouch.getID()]
      location = pTouch.getLocation()
      pTP.touch_point = location
    end
  end

  def ccTouchesEnded(touches)
    touches.each do |pTouch|
      pTP = @s_dic[pTouch.getID()]
      @layer.removeChild(pTP, true)
      @s_dic.delete(pTouch.getID())
    end
  end

  def ccTouchesCancelled(touches)
    ccTouchesEnded(touches)
  end

  def initialize
    super
    @s_dic = {}
  end

  def create
    layer = CCLayer.create
    init_with_layer(layer)
    scene = CCScene.create
    scene.addChild(layer)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end
