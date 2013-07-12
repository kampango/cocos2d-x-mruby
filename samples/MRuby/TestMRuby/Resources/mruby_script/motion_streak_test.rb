require "mruby_script/test_base"

class MotionStreakTest < TestBase
  extend TestBaseExt
  self.supported = true

  module Helper 
    include Cocos2d

    def mode_callback(*args)
      @streak.setFastMode(!@streak.isFastMode)
    end

    def setup_base_layer(layer)
      item_mode = CCMenuItemToggle.create(CCMenuItemFont.create("Use High Quality Mode"))
      item_mode.addSubItem(CCMenuItemFont.create("Use Fast Mode"))

      that = self
      item_mode.registerScriptTapHandler(Proc.new {|*args| that.mode_callback(*args)})

      node_event_handler = Proc.new {|tag|
        case tag
        when kCCNodeOnExit, kCCNodeOnCleanup
          item_mode.unregisterScriptTapHandler
          item_mode.unregisterScriptHandler
        end
      }

      item_mode.registerScriptHandler(node_event_handler)

      menu_mode = CCMenu.create
      menu_mode
        .addChild(item_mode)
        .setPosition(ccp(@win_size.width / 2, @win_size.height / 4))
      layer.addChild(menu_mode)
      layer
    end
  end

  class MotionStreakTest1 < TestBase
    include Helper

    def update(dt)
      if @first_tick
        @first_tick = false
        return
      end
      @streak.setPosition(@target.convertToWorldSpace(ccp(0, 0)))
    end

    def on_enter
      that = self
      @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.update(dt)}, 0, false)
    end
    def on_exit
      @scheduler.unscheduleScriptEntry(@entry) if @entry
    end

    def initialize
      super
      @scheduler = CCDirector.sharedDirector.getScheduler
      @win_size = CCDirector.sharedDirector.getWinSize
    end

    def init_with_layer(layer)
      super(layer)
      setup_base_layer(layer)

      root = CCSprite.create($s_pPathR1)
      layer.addChild(root, 1)
      root.setPosition(ccp(@win_size.width / 2, @win_size.height / 2))

      @target = CCSprite.create($s_pPathR1)
      root.addChild(@target)
      @target.setPosition(ccp(@win_size.width / 4, 0))

      @streak = CCMotionStreak.create(2, 3, 32, ccc3(0, 255, 0), $s_streak)
      layer.addChild(@streak)

      a1 = CCRotateBy.create(2, 360)

      action1 = CCRepeatForever.create(a1)
      motion = CCMoveBy.create(2, CCPointMake(100,0))
      root.runAction(CCRepeatForever.create(CCSequence.createWithTwoActions(motion, motion.reverse())))
      root.runAction(action1)

      array = CCArray.create()
      array.addObject(CCTintTo.create(0.2, 255, 0, 0))
      array.addObject(CCTintTo.create(0.2, 0, 255, 0))
      array.addObject(CCTintTo.create(0.2, 0, 0, 255))
      array.addObject(CCTintTo.create(0.2, 0, 255, 255))
      array.addObject(CCTintTo.create(0.2, 255, 255, 0))
      array.addObject(CCTintTo.create(0.2, 255, 255, 255))
      color_action = CCRepeatForever.create(CCSequence.create(array))

      @streak.runAction(color_action)

      @first_tick = true
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    case tag
                                    when kCCNodeOnEnter
                                      that.on_enter
                                    when kCCNodeOnExit, kCCNodeOnCleanup
                                      on_exit
                                      layer.unregisterScriptHandler
                                    end})

      @title_label.setString("MotionStreak test 1")
      layer
    end
  end

  class MotionStreakTest2 < TestBase
    include Helper

    def initialize
      super
      @scheduler = CCDirector.sharedDirector.getScheduler
      @win_size = CCDirector.sharedDirector.getWinSize
    end

    def init_with_layer(layer)
      super(layer)
      setup_base_layer(layer)

      @streak = CCMotionStreak.create(3, 3, 64, ccc3(255, 255, 255), $s_streak)
      layer.addChild(@streak)

      @streak.setPosition(CCPointMake(@win_size.width / 2, @win_size.height / 2))

      on_touch_moved = Proc.new {|x, y|
		if @first_tick
          @first_tick = false
        else
          @streak.setPosition(ccp(x, y))
        end
      }

      on_touch = Proc.new {|event_type, x, y|
		if event_type == CCTOUCHBEGAN
          true
        elsif event_type == CCTOUCHMOVED
          on_touch_moved.call(x, y)
        end
      }

      @first_tick = true
      layer.setTouchEnabled(true)
      layer.registerScriptTouchHandler(on_touch, false, -1, false)
      layer.registerScriptHandler(Proc.new {|tag|
                                    case tag
                                    when kCCNodeOnExit, kCCNodeOnCleanup
                                      layer.setTouchEnabled(false)
                                      layer.unregisterScriptTouchHandler
                                      layer.unregisterScriptHandler
                                    end
                                  })

      @title_label.setString("MotionStreak test")
      layer
    end
  end

  class Issue1358 < TestBase
    include Helper

    def initialize
      super
      @scheduler = CCDirector.sharedDirector.getScheduler
      @win_size = CCDirector.sharedDirector.getWinSize
    end

    def update(dt)
      if @first_tick
        @first_tick = false
        return
      end
      @angle += 1.0
      @streak.setPosition(ccp(@center.x + Math.cos(@angle / 180 * Math.PI) * @radius,
                              @center.y + Math.sin(@angle / 180 * Math.PI) * @radius))
                          
    end

    def event_handler(tag)
      case tag
      when kCCNodeOnEnter
        that = self
        @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.update(dt)}, 0, false)
      when kCCNodeOnExit, kCCNodeOnCleanup
        @scheduler.unscheduleScriptEntry(@entry)
      end
    end

    def init_with_layer(layer)
      super(layer)
      setup_base_layer(layer)
      @streak = CCMotionStreak.create(2.0, 1.0, 50.0, ccc3(255, 255, 0), "Images/Icon.png")
      layer.addChild(@streak)

      @center = ccp(@win_size.width / 2, @win_size.height / 2)
      @radius = @win_size.width / 3
      @angle = 0

      @first_tick = true
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    that.event_handler(tag)
                                    if tag == kCCNodeOnExit || tag == kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end
                                  })
      @title_label.setString("Issue 1358")
      @subtitle_label.setString("The tail should use the texture")
      layer
    end
  end

  def initialize
    super
    [MotionStreakTest1,
     MotionStreakTest2,
     Issue1358,
    ].each do |klass|
      register_create_function(klass.new, :create)
    end
  end

  def create
    new_scene
  end
end
