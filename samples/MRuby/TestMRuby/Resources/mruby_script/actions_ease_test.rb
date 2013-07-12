require "mruby_script/test_base"

class ActionsEaseTest < TestBase
  extend TestBaseExt
  self.supported = true


  class ActionsEaseTestBase < TestBase
    include Cocos2d

    def initialize
      super
      @scheduler = CCDirector.sharedDirector.getScheduler
    end

    def create_simple_move_by
      CCMoveBy.create(3, CCPointMake(@@size.width - 130, 0))
    end

    def create_simple_delay_time
      CCDelayTime.create(0.25)
    end

    def position_for_two
      s = @@size
      @grossini.setPosition(CCPointMake(60, s.height * 1 / 5))
      @tamara.setPosition(CCPointMake(60, s.height * 4 / 5))
      @kathia.setVisible(false)
    end

    def init_with_layer(layer)
      s = @@size
      @grossini = CCSprite.create($s_pPathGrossini)
      @tamara = CCSprite.create($s_pPathSister1)
      @kathia = CCSprite.create($s_pPathSister2)

      layer.addChild(@grossini, 3)
      layer.addChild(@kathia, 2)
      layer.addChild(@tamara, 1)

      @grossini.setPosition(CCPointMake(60, s.height * 1 / 5))
      @kathia.setPosition(CCPointMake(60, s.height * 2.5 / 5))
      @tamara.setPosition(CCPointMake(60, s.height * 4 / 5))

      super(layer)
      layer
    end

    def create
      layer = CCLayer.create
      init_with_layer(layer)
      layer
    end
  end

  class SpriteEase < ActionsEaseTestBase
    def test_stop_action(dt)
      @scheduler.unscheduleScriptEntry(@entry)
      @tamara.stopActionByTag(1)
      @kathia.stopActionByTag(1)
      @grossini.stopActionByTag(1)
    end

    def on_enter_or_exit(tag)
      if tag == kCCNodeOnEnter
        @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.test_stop_action(dt)}, 6.25, false)
      elsif tag == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@entry)
      end
    end

    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by
      move_back = move.reverse

      move_ease_in = CCEaseIn.create(create_simple_move_by, 2.5)
      move_ease_in_back = move_ease_in.reverse

      move_ease_out = CCEaseOut.create(create_simple_move_by, 2.5)
      move_ease_out_back = move_ease_out.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move)
      arr1.addObject(delay)
      arr1.addObject(move_back)
      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease_in)
      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_in_back)
      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      arr3 = CCArray.create
      arr3.addObject(move_ease_out)
      arr3.addObject(create_simple_delay_time)
      arr3.addObject(move_ease_out_back)
      arr3.addObject(create_simple_delay_time)
      seq3 = CCSequence.create(arr3)

      a2 = @grossini.runAction(CCRepeatForever.create(seq1))
      a2.setTag(1)
      a1 = @tamara.runAction(CCRepeatForever.create(seq2))
      a1.setTag(1)
      a = @kathia.runAction(CCRepeatForever.create(seq3))
      a.setTag(1)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    that.on_enter_or_exit(tag)
                                    if tag == kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end
                                  })

      @title_label.setString("EaseIn - EaseOut - Stop")
      
      layer
    end
  end

  class SpriteEaseInOut < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by

      move_ease_inout1 = CCEaseInOut.create(create_simple_move_by, 0.65)
      move_ease_inout_back1 = move_ease_inout1.reverse

      move_ease_inout2 = CCEaseInOut.create(create_simple_move_by, 1.35)
      move_ease_inout_back2 = move_ease_inout2.reverse

      move_ease_inout3 = CCEaseInOut.create(create_simple_move_by, 1.0)
      move_ease_inout_back3 = move_ease_inout3.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move_ease_inout1)
      arr1.addObject(delay)
      arr1.addObject(move_ease_inout_back1)
      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease_inout2)
      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_inout_back2)
      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      arr3 = CCArray.create
      arr3.addObject(move_ease_inout3)
      arr3.addObject(create_simple_delay_time)
      arr3.addObject(move_ease_inout_back3)
      arr3.addObject(create_simple_delay_time)
      seq3 = CCSequence.create(arr3)

      @tamara.runAction(CCRepeatForever.create(seq1))
      @kathia.runAction(CCRepeatForever.create(seq2))
      @grossini.runAction(CCRepeatForever.create(seq3))

      @title_label.setString("EaseInOut and rates")
      
     layer
    end
  end

  class SpriteEaseExponential < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by
      move_back = move.reverse

      move_ease_in = CCEaseExponentialIn.create(create_simple_move_by)
      move_ease_in_back = move_ease_in.reverse

      move_ease_out = CCEaseExponentialOut.create(create_simple_move_by)
      move_ease_out_back = move_ease_out.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move)
      arr1.addObject(delay)
      arr1.addObject(move_back)

      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease_in)

      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_in_back)

      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      arr3 = CCArray.create
      arr3.addObject(move_ease_out)

      arr3.addObject(create_simple_delay_time)
      arr3.addObject(move_ease_out_back)

      arr3.addObject(create_simple_delay_time)
      seq3 = CCSequence.create(arr3)

      @grossini.runAction(CCRepeatForever.create(seq1))
      @tamara.runAction(CCRepeatForever.create(seq2))
      @kathia.runAction(CCRepeatForever.create(seq3))

      @title_label.setString("ExpIn - ExpOut actions")
      layer
    end
  end

  class SpriteEaseExponentialInOut < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by
      move_back = move.reverse

      move_ease = CCEaseExponentialInOut.create(create_simple_move_by)
      move_ease_back = move_ease.reverse()

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move)
      arr1.addObject(delay)
      arr1.addObject(move_back)

      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease)

      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_back)

      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      position_for_two

      @grossini.runAction(CCRepeatForever.create(seq1))
      @tamara.runAction(CCRepeatForever.create(seq2))

      @title_label.setString("EaseExponentialInOut action")
      layer
    end
  end

  class SpriteEaseSine < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by
      move_back = move.reverse

      move_ease_in = CCEaseSineIn.create(create_simple_move_by)
      move_ease_in_back = move_ease_in.reverse

      move_ease_out = CCEaseSineOut.create(create_simple_move_by)
      move_ease_out_back = move_ease_out.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move)
      arr1.addObject(delay)
      arr1.addObject(move_back)
      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease_in)
      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_in_back)
      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      arr3 = CCArray.create
      arr3.addObject(move_ease_out)
      arr3.addObject(create_simple_delay_time)
      arr3.addObject(move_ease_out_back)
      arr3.addObject(create_simple_delay_time)
      seq3 = CCSequence.create(arr3)

      @grossini.runAction(CCRepeatForever.create(seq1))
      @tamara.runAction(CCRepeatForever.create(seq2))
      @kathia.runAction(CCRepeatForever.create(seq3))

      @title_label.setString("EaseSineIn - EaseSineOut")
      layer
    end
  end

  class SpriteEaseElastic < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by
      move_back = move.reverse

      move_ease_in = CCEaseElasticIn.create(create_simple_move_by)
      move_ease_in_back = move_ease_in.reverse

      move_ease_out = CCEaseElasticOut.create(create_simple_move_by)
      move_ease_out_back = move_ease_out.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move)
      arr1.addObject(delay)
      arr1.addObject(move_back)
      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease_in)
      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_in_back)
      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      arr3 = CCArray.create
      arr3.addObject(move_ease_out)
      arr3.addObject(create_simple_delay_time)
      arr3.addObject(move_ease_out_back)
      arr3.addObject(create_simple_delay_time)
      seq3 = CCSequence.create(arr3)

      @grossini.runAction(CCRepeatForever.create(seq1))
      @tamara.runAction(CCRepeatForever.create(seq2))
      @kathia.runAction(CCRepeatForever.create(seq3))

      @title_label.setString("Elastic In - Out actions")
      layer
    end
  end

  class SpriteEaseElasticInOut < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by

      move_ease_inout1 = CCEaseElasticInOut.create(create_simple_move_by, 0.3)
      move_ease_inout_back1 = move_ease_inout1.reverse

      move_ease_inout2 = CCEaseElasticInOut.create(create_simple_move_by, 0.45)
      move_ease_inout_back2 = move_ease_inout2.reverse

      move_ease_inout3 = CCEaseElasticInOut.create(create_simple_move_by, 0.6)
      move_ease_inout_back3 = move_ease_inout3.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move_ease_inout1)
      arr1.addObject(delay)
      arr1.addObject(move_ease_inout_back1)
      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease_inout2)
      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_inout_back2)
      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      arr3 = CCArray.create
      arr3.addObject(move_ease_inout3)
      arr3.addObject(create_simple_delay_time)
      arr3.addObject(move_ease_inout_back3)
      arr3.addObject(create_simple_delay_time)
      seq3 = CCSequence.create(arr3)

      @tamara.runAction(CCRepeatForever.create(seq1))
      @kathia.runAction(CCRepeatForever.create(seq2))
      @grossini.runAction(CCRepeatForever.create(seq3))

      @title_label.setString("EaseElasticInOut action")
      layer
    end
  end

  class SpriteEaseBounce < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by
      move_back = move.reverse

      move_ease_in = CCEaseBounceIn.create(create_simple_move_by)
      move_ease_in_back = move_ease_in.reverse

      move_ease_out = CCEaseBounceOut.create(create_simple_move_by)
      move_ease_out_back = move_ease_out.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move)
      arr1.addObject(delay)
      arr1.addObject(move_back)
      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease_in)
      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_in_back)
      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      arr3 = CCArray.create
      arr3.addObject(move_ease_out)
      arr3.addObject(create_simple_delay_time)
      arr3.addObject(move_ease_out_back)
      arr3.addObject(create_simple_delay_time)
      seq3 = CCSequence.create(arr3)

      @grossini.runAction(CCRepeatForever.create(seq1))
      @tamara.runAction(CCRepeatForever.create(seq2))
      @kathia.runAction(CCRepeatForever.create(seq3))

      @title_label.setString("Bounce In - Out actions")
      layer
    end
  end

  class SpriteEaseBounceInOut < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by
      move_back = move.reverse

      move_ease = CCEaseBounceInOut.create(create_simple_move_by)
      move_ease_back = move_ease.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move)
      arr1.addObject(delay)
      arr1.addObject(move_back)
      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease)
      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_back)
      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      position_for_two

      @grossini.runAction(CCRepeatForever.create(seq1))
      @tamara.runAction(CCRepeatForever.create(seq2))

      @title_label.setString("EaseBounceInOut action")
      layer
    end
  end

  class SpriteEaseBack < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by
      move_back = move.reverse

      move_ease_in = CCEaseBackIn.create(create_simple_move_by)
      move_ease_in_back = move_ease_in.reverse

      move_ease_out = CCEaseBackOut.create(create_simple_move_by)
      move_ease_out_back = move_ease_out.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move)
      arr1.addObject(delay)
      arr1.addObject(move_back)
      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease_in)
      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_in_back)
      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      arr3 = CCArray.create
      arr3.addObject(move_ease_out)
      arr3.addObject(create_simple_delay_time)
      arr3.addObject(move_ease_out_back)
      arr3.addObject(create_simple_delay_time)
      seq3 = CCSequence.create(arr3)

      @grossini.runAction(CCRepeatForever.create(seq1))
      @tamara.runAction(CCRepeatForever.create(seq2))
      @kathia.runAction(CCRepeatForever.create(seq3))

      @title_label.setString("Back In - Out actions")
      layer
    end
  end

  class SpriteEaseBackInOut < ActionsEaseTestBase
    def init_with_layer(layer)
      super(layer)

      move = create_simple_move_by
      move_back = move.reverse

      move_ease = CCEaseBackInOut.create(create_simple_move_by)
      move_ease_back = move_ease.reverse

      delay = create_simple_delay_time

      arr1 = CCArray.create
      arr1.addObject(move)
      arr1.addObject(delay)
      arr1.addObject(move_back)
      arr1.addObject(create_simple_delay_time)
      seq1 = CCSequence.create(arr1)

      arr2 = CCArray.create
      arr2.addObject(move_ease)
      arr2.addObject(create_simple_delay_time)
      arr2.addObject(move_ease_back)
      arr2.addObject(create_simple_delay_time)
      seq2 = CCSequence.create(arr2)

      position_for_two

      @grossini.runAction(CCRepeatForever.create(seq1))
      @tamara.runAction(CCRepeatForever.create(seq2))

      @title_label.setString("EaseBackInOut action")
      layer
    end
  end

  class SpeedTest < ActionsEaseTestBase
    def initialize
      super
      @entry = nil
      @action1 = nil
      @action2 = nil
      @action3 = nil
    end

    def altertime(dt)
      @action1.setSpeed(rand() * 2)
      @action2.setSpeed(rand() * 2)
      @action3.setSpeed(rand() * 2)
    end

    def on_enter_or_exit(tag)
      if tag == kCCNodeOnEnter
        that = self
        @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.altertime(dt)}, 1.0, false)
      elsif tag == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@entry)
      end
    end

    def init_with_layer(layer)
      super(layer)

      s = @@size
      jump1 = CCJumpBy.create(4, CCPointMake(- s.width + 80, 0), 100, 4)
      jump2 = jump1.reverse
      rot1 = CCRotateBy.create(4, 360 * 2)
      rot2 = rot1.reverse

      seq3_1 = CCSequence.createWithTwoActions(jump2, jump1)
      seq3_2 = CCSequence.createWithTwoActions(rot1, rot2)

      spawn = CCSpawn.createWithTwoActions(seq3_1, seq3_2)
      @action1 = CCSpeed.create(CCRepeatForever.create(spawn), 1.0)

      spawn2 = spawn.copy()
      @action2 = CCSpeed.create(CCRepeatForever.create(spawn2), 1.0)

      spawn3 = spawn.copy()
      @action3 = CCSpeed.create(CCRepeatForever.create(spawn3), 1.0)

      @grossini.runAction(@action2)
      @tamara.runAction(@action3)
      @kathia.runAction(@action1)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    that.on_enter_or_exit(tag)
                                    if tag == kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end})

      @title_label.setString("Speed action")
      layer
    end
  end

  def initialize
    super
    [SpriteEase,
     SpriteEaseInOut,
     SpriteEaseExponential,
     SpriteEaseExponentialInOut,
     SpriteEaseSine,
     SpriteEaseElastic,
     SpriteEaseElasticInOut,
     SpriteEaseBounce,
     SpriteEaseBounceInOut,
     SpriteEaseBack,
     SpriteEaseBackInOut,
     SpeedTest,
    ].each do |klass|
      register_create_function(klass.new, :create)
    end
  end

  def create
    new_scene
  end
end


