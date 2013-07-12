require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class SchedulerTest < TestBase
  extend TestBaseExt
  self.supported = true

  class SchedulerTestBase < TestBase
    include Cocos2d::Extension

    # Priority level reserved for system services.
    def kCCPrioritySystem
      #INT_MIN
      0x7fffffff * -1 #OK?
    end

    # Minimum priority level for user scheduling.
    def kCCPriorityNonSystemMin
      kCCPrioritySystem + 1
    end

    def find_ccobject(selector)
      # exprerimental!
      hash = $G_CCMRubyCallbackWrapper
      keys = unless hash.nil? then hash.keys else [] end
      target = nil
      keys.each do |oid|
        if hash[oid][:__target__] == self && hash[oid][:__selector__] == selector
          target = CC.ccobject_find_by_id(oid)
          break
        end
      end

      target
    end

    def find_ccobjects
      # exprerimental!
      hash = $G_CCMRubyCallbackWrapper
      keys = unless hash.nil? then hash.keys else [] end
      targets = []
      keys.each do |oid|
        if hash[oid][:__target__] == self
          target = CC.ccobject_find_by_id(oid)
          next if target.nil?
          targets << target
        end
      end

      targets
    end

    def initialize
      super
      @scheduler = CCDirector.sharedDirector.getScheduler
    end

    def init_with_layer(layer)
      super(layer)
      @title_label.setString(self.title)
      @subtitle_label.setString(self.subtitle)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.node_event_handler(tag)})

      @layer = layer
      @layer
    end

    def onEnter
    end

    def onExit
      find_ccobjects.each do |target|
        @scheduler.unscheduleAllForTarget(target)
      end
    end

    def node_event_handler(tag)
      case tag
      when kCCNodeOnEnter
        onEnter
      when kCCNodeOnExit
        onExit
      end
    end

    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end
  end

  class SchedulerTimeScale < SchedulerTestBase
    def sliderCtl
      slider = CCControlSlider.create("extensions/sliderTrack2.png",
                                      "extensions/sliderProgress2.png",
                                      "extensions/sliderThumb.png")

      slider.addTargetWithActionForControlEvents(self, :sliderAction,
                                                  CCControlEventValueChanged)

      slider.setMinimumValue(-3.0)
      slider.setMaximumValue(3.0)
      slider.setValue(1.0)
      slider
    end

    def sliderAction(pSliderCtl, controlEvent)
      scale = pSliderCtl.getValue()
      CCDirector.sharedDirector().getScheduler().setTimeScale(scale)
    end

    def onEnter
      super
      s = @@size

      # rotate and jump
      jump1 = CCJumpBy.create(4, ccp(-s.width+80,0), 100, 4)
      jump2 = jump1.reverse()
      rot1 = CCRotateBy.create(4, 360*2)
      rot2 = rot1.reverse()

      arr = CCArray.create
      arr << jump2
      arr << jump1
      seq3_1 = CCSequence.create(arr)
      
      arr = CCArray.create
      arr << rot1
      arr << rot2
      seq3_2 = CCSequence.create(arr)

      arr = CCArray.create
      arr << seq3_1
      arr << seq3_2
      spawn = CCSpawn.create(arr)
      action = CCRepeat.create(spawn, 50)

      action2 = action.copy()
      action3 = action.copy()

      grossini = CCSprite.create("Images/grossini.png")
      tamara = CCSprite.create("Images/grossinis_sister1.png")
      kathia = CCSprite.create("Images/grossinis_sister2.png")

      grossini.setPosition(ccp(40,80))
      tamara.setPosition(ccp(40,80))
      kathia.setPosition(ccp(40,80))

      @layer.addChild(grossini)
      @layer.addChild(tamara)
      @layer.addChild(kathia)

      grossini.runAction(CCSpeed.create(action, 0.5))
      tamara.runAction(CCSpeed.create(action2, 1.5))
      kathia.runAction(CCSpeed.create(action3, 1.0))

      @emitter = CCParticleFireworks.create()
      @emitter.setTexture( CCTextureCache.sharedTextureCache().addImage($s_stars1) )
      @layer.addChild(@emitter)

      @pSliderCtl = sliderCtl()
      @pSliderCtl.setPosition(ccp(s.width / 2.0, s.height / 3.0))

      @layer.addChild(@pSliderCtl)
    end

    def onExit
      p "onExit"
      CCTextureCache.sharedTextureCache().removeTextureForKey($s_stars1)
      # restore scale
      CCDirector.sharedDirector().getScheduler().setTimeScale(1)
      @layer = nil
      super
    end

    def title
      "Scheduler timeScale Test"
    end

    def subtitle
      "Fast-forward and rewind using scheduler.timeScale"
    end
  end

  class TwoSchedulers < SchedulerTestBase
    def sliderCtl
      # frame = CGRectMake(12.0, 12.0, 120.0, 7.0)
      slider = CCControlSlider.create("extensions/sliderTrack2.png",
                                      "extensions/sliderProgress2.png",
                                      "extensions/sliderThumb.png")
      #[[UISlider alloc] initWithFrame:frame];
      slider.addTargetWithActionForControlEvents(self, :sliderAction,
                                                 CCControlEventValueChanged)

      # in case the parent view draws with a custom color or gradient, use a transparent color
      #slider.backgroundColor = [UIColor clearColor];

      slider.setMinimumValue(0.0)
      slider.setMaximumValue(2.0)
      #slider.continuous = YES;
      slider.setValue(1.0)

      slider
    end

    def sliderAction(slider, controlEvent)
      scale = slider.getValue()

      if slider == @sliderCtl1
        @sched1.setTimeScale(scale)
      else
        @sched2.setTimeScale(scale)
      end
    end

    def onEnter
      super
      s = @@size

      # rotate and jump
      jump1 = CCJumpBy.create(4, ccp(0,0), 100, 4)
      jump2 = jump1.reverse()

      arr = CCArray.create
      arr << jump2
      arr << jump1
      seq = CCSequence.create(arr)
      action = CCRepeatForever.create(seq)

      #
      # Center
      #
      grossini = CCSprite.create("Images/grossini.png")
      @layer.addChild(grossini)
      grossini.setPosition(ccp(s.width/2,100))
      grossini.runAction(action.copy())

      defaultScheduler = CCDirector.sharedDirector().getScheduler()

      #
      # Left:
      #

      # Create a new scheduler, and link it to the main scheduler
      @sched1 = CCScheduler.new

      defaultScheduler.scheduleUpdateForTarget(@sched1, 0, false)

      # Create a new ActionManager, and link it to the new scheudler
      actionManager1 = CCActionManager.new
      @sched1.scheduleUpdateForTarget(actionManager1, 0, false)

      10.times do |i|
        sprite = CCSprite.create("Images/grossinis_sister1.png")

        # IMPORTANT: Set the actionManager running any action
        sprite.setActionManager(actionManager1)

        @layer.addChild(sprite)
        sprite.setPosition(ccp(30+15*i,100))

        sprite.runAction(action.copy())
      end


      #
      # Right:
      #

      # Create a new scheduler, and link it to the main scheduler
      @sched2 = CCScheduler.new
      defaultScheduler.scheduleUpdateForTarget(@sched2, 0, false)

      # Create a new ActionManager, and link it to the new scheudler
      actionManager2 = CCActionManager.new
      @sched2.scheduleUpdateForTarget(actionManager2, 0, false)

      10.times do |i|
        sprite = CCSprite.create("Images/grossinis_sister2.png")

        # IMPORTANT: Set the actionManager running any action
        sprite.setActionManager(actionManager2)

        @layer.addChild(sprite)
        sprite.setPosition(ccp(s.width-30-15*i,100))

        sprite.runAction(action.copy())
      end

      @sliderCtl1 = sliderCtl()
      @layer.addChild(@sliderCtl1)
      @sliderCtl1.setPosition(ccp(s.width / 4.0, VisibleRect.top().y - 20))

      @sliderCtl2 = sliderCtl()
      @layer.addChild(@sliderCtl2)
      @sliderCtl2.setPosition(ccp(s.width / 4.0*3.0, VisibleRect.top().y-20))
    end

    def onExit
      defaultScheduler = CCDirector.sharedDirector().getScheduler()
      defaultScheduler.unscheduleAllForTarget(@sched1)
      defaultScheduler.unscheduleAllForTarget(@sched2)
      super
    end

    def title
      "Two custom schedulers"
    end

    def subtitle
      "Three schedulers. 2 custom + 1 default. Two different time scales"
    end
  end

  class SchedulerAutoremove < SchedulerTestBase
    def onEnter
      super
      @entries = {}
      that = self
      @entries[:autoremove] = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.autoremove(dt)}, 0.5, false)
      @entries[:tick] = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.tick(dt)}, 0.5, false)
      @accum = 0
    end

    def onExit
      @entries.values.each do |entry|
        @scheduler.unscheduleScriptEntry(entry)
      end
      super
    end

    def autoremove(dt)
      @accum += dt
      cclog("Time: #{@accum}")

      if @accum > 3
        @scheduler.unscheduleScriptEntry(@entries[:autoremove])
        @entries.delete(:autoremove)
        cclog("scheduler removed")
      end
    end

    def tick(dt)
      cclog("This scheduler should not be removed")
    end

    def title
      "Self-remove an scheduler"
    end

    def subtitle
      "1 scheduler will be autoremoved in 3 seconds. See console"
    end
  end

  class SchedulerPauseResume < SchedulerTestBase
    def onEnter
      super
      that = self
      @scheduler.scheduleSelector(:tick1, self, 0.5, false)
      @scheduler.scheduleSelector(:tick2, self, 1.0, false)
      @scheduler.scheduleSelector(:pause, self, 3, false)
    end

    def tick1(dt)
      cclog("tick1")
    end
    def tick2(dt)
      cclog("tick2")
    end

    def pause(dt)
      find_ccobjects.each do |target|
        @scheduler.pauseTarget(target)
      end
    end

    def title
      "Pause / Resume"
    end
    def subtitle
      "Scheduler should be paused after 3 seconds. See console"
    end
  end

  class SchedulerPauseResumeAll < SchedulerTestBase
    def init_with_layer(layer)
      super(layer)
      @pPausedTargets = nil
      layer
    end

    def onEnter
      super

      sprite = CCSprite.create("Images/grossinis_sister1.png")
      sprite.setPosition(VisibleRect.center())
      @layer.addChild(sprite)
      sprite.runAction(CCRepeatForever.create(CCRotateBy.create(3.0, 360)))

      #@layer.scheduleUpdate()
      that = self
      @layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)
      @scheduler.scheduleSelector(:tick1, self, 0.5, false)
      @scheduler.scheduleSelector(:tick2, self, 1.0, false)
      @scheduler.scheduleSelector(:pause, self, 3.0, false)
    end

    def update(delta)
      # do nothing
    end

    def onExit
      unless @resume_entry.nil?
        @scheduler.unscheduleScriptEntry(@resume_entry)
        @resume_entry = nil
      end

      @pPausedTargets = nil # don't forget.

      @layer.unscheduleUpdate()
      super
    end

    def tick1(dt)
      cclog("tick1")
    end

    def tick2(dt)
      cclog("tick2")
    end

    def pause(dt)
      cclog("Pausing")
      @pPausedTargets = @scheduler.pauseAllTargets()
      c = @pPausedTargets.count()

      #if c > 2
      #  # should have only 2 items: CCActionManager, self
      #  cclog("Error: pausedTargets should have only 2 items, and not #{c}")
      #end

      if c != 5
        #should have 5 items: CCActionManager, @layre, self :tick1, self :tick2, self, :pause
        cclog("Error: pausedTargets should have 5 items, and not #{c}")
      end

      that = self
      @resume_entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.resume(dt)}, 2.0, false)
    end

    def resume(dt)
      cclog("Resuming")
      @scheduler.unscheduleScriptEntry(@resume_entry)
      @resume_entry = nil

      unless @pPausedTargets.nil?
        @scheduler.resumeTargets(@pPausedTargets)
        @pPausedTargets = nil
      end
    end

    def title
      "Pause / Resume"
    end

    def subtitle
      "Everything will pause after 3s, then resume at 5s. See console"
    end
  end

  class SchedulerPauseResumeAllUser < SchedulerTestBase
    def init_with_layer(layer)
      super(layer)
      @pPausedTargets = nil
      layer
    end

    def onEnter
      super
      s = @@size

      sprite = CCSprite.create("Images/grossinis_sister1.png")
      sprite.setPosition(ccp(s.width/2, s.height/2))
      @layer.addChild(sprite)
      sprite.runAction(CCRepeatForever.create(CCRotateBy.create(3.0, 360)))

      @scheduler.scheduleSelector(:tick1, self, 0.5, false)
      @scheduler.scheduleSelector(:tick2, self, 0.5, false)
      @scheduler.scheduleSelector(:pause, self, 3.0, 0, 0, false)
      #TODO: [self performSelector:@selector(resume) withObject:nil afterDelay:5];
    end

    def onExit
      unless @pPausedTargets.nil?
        @scheduler.resumeTargets(@pPausedTargets)
      end

      @pPausedTargets = nil

      @layer.unscheduleUpdate()
      super
    end

    def tick1(dt)
      cclog("tick1")
    end

    def tick2(dt)
      cclog("tick2")
    end

    def pause(dt)
      cclog("Pausing")
      @pPausedTargets = @scheduler.pauseAllTargetsWithMinPriority(kCCPriorityNonSystemMin)
      that = self
      @resume_entry = @scheduler
        .scheduleScriptFunc(Proc.new {|dt| that.resume(dt)}, 2.0, false)
    end

    def resume(dt)
      cclog("Resuming")
      @scheduler.unscheduleScriptEntry(@resume_entry)
      @resume_entry = nil

      if @pPausedTargets
        @scheduler.resumeTargets(@pPausedTargets)
        @pPausedTargets = nil
      end
    end

    def title
      "Pause / Resume"
    end

    def subtitle
      "Everything will pause after 3s, then resume at 5s. See console"
    end
  end

  class SchedulerUnscheduleAll < SchedulerTestBase
    def onEnter
      super

      @scheduler.scheduleSelector(:tick1, self, 0.5, false)
      @scheduler.scheduleSelector(:tick2, self, 1.0, false)
      @scheduler.scheduleSelector(:tick3, self, 1.5, false)
      @scheduler.scheduleSelector(:tick4, self, 1.5, false)
      @scheduler.scheduleSelector(:unscheduleAll, self, 4, false)
    end

    def tick1(dt)
      cclog("tick1")
    end

    def tick2(dt)
      cclog("tick2")
    end

    def tick3(dt)
      cclog("tick3")
    end

    def tick4(dt)
      cclog("tick4")
    end

    def unscheduleAll(dt)
      find_ccobjects.each do |target|
        @scheduler.unscheduleAllForTarget(target)
      end
      #@layer.unscheduleAllSelectors()
    end

    def title
      "Unschedule All selectors"
    end

    def subtitle
      "All scheduled selectors will be unscheduled in 4 seconds. See console"
    end
  end

  class SchedulerUnscheduleAllHard < SchedulerTestBase
    def onEnter
      super
      s = @@size

      sprite = CCSprite.create("Images/grossinis_sister1.png")
      sprite.setPosition(ccp(s.width/2, s.height/2))
      @layer.addChild(sprite)
      sprite.runAction(CCRepeatForever.create(CCRotateBy.create(3.0, 360)))

      @bActionManagerActive = true

      @scheduler.scheduleSelector(:tick1, self, 0.5, false)
      @scheduler.scheduleSelector(:tick2, self, 1.0, false)
      @scheduler.scheduleSelector(:tick3, self, 1.5, false)
      @scheduler.scheduleSelector(:tick4, self, 1.5, false)
      @scheduler.scheduleSelector(:unscheduleAll, self, 4, false)
    end

    def onExit
      director = CCDirector.sharedDirector
      unless @bActionManagerActive
        # Restore the director's action manager.
        @scheduler.scheduleUpdateForTarget(director.getActionManager(),
                                           kCCPrioritySystem, false)
      end
      super
    end

    def tick1(dt)
      cclog("tick1")
    end

    def tick2(dt)
      cclog("tick2")
    end

    def tick3(dt)
      cclog("tick3")
    end

    def tick4(dt)
      cclog("tick4")
    end

    def unscheduleAll(dt)
      @scheduler.unscheduleAll()
      @bActionManagerActive = false
    end

    def title
      "Unschedule All selectors (HARD)"
    end

    def subtitle
      "Unschedules all user selectors after 4s. Action will stop. See console"
    end
  end

  class SchedulerUnscheduleAllUserLevel < SchedulerTestBase
    def onEnter
      super
      s = @@size

      sprite = CCSprite.create("Images/grossinis_sister1.png")
      sprite.setPosition(ccp(s.width/2, s.height/2))
      @layer.addChild(sprite)
      sprite.runAction(CCRepeatForever.create(CCRotateBy.create(3.0, 360)))

      @scheduler.scheduleSelector(:tick1, self, 0.5, false)
      @scheduler.scheduleSelector(:tick2, self, 1.0, false)
      @scheduler.scheduleSelector(:tick3, self, 1.5, false)
      @scheduler.scheduleSelector(:tick4, self, 1.5, false)
      @scheduler.scheduleSelector(:unscheduleAll, self, 4, false)
    end

    def tick1(dt)
      cclog("tick1")
    end

    def tick2(dt)
      cclog("tick2")
    end

    def tick3(dt)
      cclog("tick3")
    end

    def tick4(dt)
      cclog("tick4")
    end

    def unscheduleAll(dt)
      @scheduler.unscheduleAllWithMinPriority(kCCPriorityNonSystemMin)
    end

    def title
      "Unschedule All user selectors"
    end

    def subtitle
      "Unschedules all user selectors after 4s. Action should not stop. See console"
    end
  end

  class SchedulerSchedulesAndRemove < SchedulerTestBase
    def onEnter
     super

      @scheduler.scheduleSelector(:tick1, self, 0.5, false)
      @scheduler.scheduleSelector(:tick2, self, 1.0, false)
      @scheduler.scheduleSelector(:scheduleAndUnschedule, self, 4.0, false)
    end

    def tick1(dt)
      cclog("tick1")
    end

    def tick2(dt)
      cclog("tick2")
    end

    def tick3(dt)
      cclog("tick3")
    end

    def tick4(dt)
      cclog("tick4")
    end

    def title
      "Schedule from Schedule"
    end

    def subtitle
      "Will unschedule and schedule selectors in 4s. See console"
    end

    def unschedule(selector)
      target = find_ccobject(selector)
      @scheduler.unscheduleAllForTarget(target)
    end

    def schedule(selector, interval)
      @scheduler.scheduleSelector(selector, self, interval, false)
    end

    def scheduleAndUnschedule(dt)
      cclog("scheduleAndUnschedule")
      unschedule(:tick1)
      unschedule(:tick2)
      unschedule(:scheduleAndUnschedule)

      schedule(:tick3, 1.0)
      schedule(:tick4, 1.0)
    end
  end

  class SchedulerUpdate < SchedulerTestBase

    class TestNode < CCNode
      include Cocos2d

      def initWithString(str, priority)
        init
        @pstring = str
        that = self
        scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, priority)
        registerScriptHandler(Proc.new {|tag| that.on_node_event(tag)})
      end

      def on_node_event(tag)
        if tag == kCCNodeOnExit
          unscheduleUpdate
        end
      end

      def update(dt)
        cclog("#{@pstring}")
      end
    end

    def onEnter
      super

      d = TestNode.new
      pStr = "---"
      d.initWithString(pStr, 50)
      @layer.addChild(d)

      b = TestNode.new
      pStr = "3rd"
      b.initWithString(pStr, 0)
      @layer.addChild(b)

      a = TestNode.new
      pStr = "1st"
      a.initWithString(pStr, -10)
      @layer.addChild(a)

      c = TestNode.new
      pStr = "4th"
      c.initWithString(pStr, 10)
      @layer.addChild(c)

      e = TestNode.new
      pStr = "5th"
      e.initWithString(pStr, 20)
      @layer.addChild(e)

      f = TestNode.new
      pStr = "2nd"
      f.initWithString(pStr, -5)
      @layer.addChild(f)

      @scheduler.scheduleSelector(:removeUpdates, self, 4.0, false)
    end

    def removeUpdates(dt)
      #cclog("removeUpdates")
      children = @layer.getChildren()
      children.each do |pNode|
        break if pNode.nil?
        pNode.unscheduleAllSelectors()
      end
    end

    def title
      "Schedule update with priority"
    end

    def subtitle
      "3 scheduled updates. Priority should work. Stops in 4s. See console"
    end
  end

  class SchedulerUpdateAndCustom < SchedulerTestBase
    def onEnter
      super

      that = self
      @layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)
      @scheduler.scheduleSelector(:tick, self, 0, false)
      @scheduler.scheduleSelector(:stopSelectors, self, 0.4, false)
    end

    def onExit
      stopSelectors(0)
      super
    end

    def update(dt)
      cclog("update called:#{dt}")
    end

    def tick(dt)
      cclog("custom selector called:#{dt}")
    end

    def stopSelectors(dt)
      find_ccobjects.each do |target|
        @scheduler.unscheduleAllForTarget(target)
      end
      #@layer.unscheduleAllSelectors()
      @layer.unscheduleUpdate()
    end

    def title
      "Schedule Update + custom selector"
    end

    def subtitle
      "Update + custom selector at the same time. Stops in 4s. See console"
    end
  end

  class SchedulerUpdateFromCustom < SchedulerTestBase
    def onEnter
      super
      @scheduler.scheduleSelector(:schedUpdate, self, 2.0, false)
    end

    def onExit
      stopUpdate(0)
      super
    end

    def update(dt)
      cclog("update called:#{dt}")
    end

    def schedUpdate(dt)
      target = find_ccobject(:schedUpdate)
      @scheduler.unscheduleAllForTarget(target)
      that = self
      @layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)
      @scheduler.scheduleSelector(:stopUpdate, self, 2.0, false)
    end

    def stopUpdate(dt)
      @layer.unscheduleUpdate()
      target = find_ccobject(:schedUpdate)
      @scheduler.unscheduleAllForTarget(target) if target
      target = find_ccobject(:stopUpdate)
      @scheduler.unscheduleAllForTarget(target) if target
    end

    def title
      "Schedule Update in 2 sec"
    end

    def subtitle
      "Update schedules in 2 secs. Stops 2 sec later. See console";
    end
  end

  class RescheduleSelector < SchedulerTestBase
    def onEnter()
      super

      @fInterval = 1.0
      @nTicks    = 0
      that = self
      @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.update(dt)}, 0.5, false)
      @scheduler.scheduleSelector(:schedUpdate, self, @fInterval, false)
      @targets_to_stop = []
    end

    def onExit
      @scheduler.unscheduleScriptEntry(@entry)
      @entry = nil

      while target = @targets_to_stop.shift
        @scheduler.unscheduleAllForTarget(target)
      end

      super
    end

    def title()
      "Reschedule Selector"
    end

    def subtitle
      "Interval is 1 second, then 2, then 3...\nNOT SUPPORTED RESCHEDULE!"
    end

    def update(dt)
      while target = @targets_to_stop.shift
        @scheduler.unscheduleAllForTarget(target)
      end
    end

    def schedUpdate(dt)
      @nTicks += 1
      cclog("schedUpdate: %.4f", dt)
      if @nTicks > 3
        target = find_ccobject(:schedUpdate)
        raise "panic!" if target.nil?
        @targets_to_stop << target
        @fInterval += 1.0
        #schedule(schedule_selector(RescheduleSelector::schedUpdate), m_fInterval);
        @scheduler.scheduleSelector(:schedUpdate, self, @fInterval, false)
        @nTicks = 0
      end
    end
  end

  class SchedulerDelayAndRepeat < SchedulerTestBase
    def onEnter
      super
      @scheduler.scheduleSelector(:update, self, 0, 4 , 3.0, false)
      cclog("update is scheduled should begin after 3 seconds")
    end

    def title
      "Schedule with delay of 3 sec, repeat 4 times"
    end

    def subtitle
      "After 5 x executed, method unscheduled. See console"
    end

    def update(dt)
      cclog("update called:%f", dt)
    end
  end

  def initialize
    super
    [SchedulerTimeScale,
     TwoSchedulers,
     SchedulerAutoremove,
     SchedulerPauseResume,
     SchedulerPauseResumeAll,
     SchedulerPauseResumeAllUser,
     SchedulerUnscheduleAll,
     SchedulerUnscheduleAllHard,
     SchedulerUnscheduleAllUserLevel,
     SchedulerSchedulesAndRemove,
     SchedulerUpdate,
     SchedulerUpdateAndCustom,
     SchedulerUpdateFromCustom,
     RescheduleSelector,
     SchedulerDelayAndRepeat,
     #SchedulerIssue2268,
    ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end

