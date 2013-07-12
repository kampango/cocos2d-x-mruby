require "mruby_script/test_resource"
require "mruby_script/gl_constant"
require "mruby_script/test_base"

class NodeTest < TestBase
  extend TestBaseExt
  self.supported = true

  class NodeTestBase < TestBase
    include GLConstant
    def initialize
      super
      @scheduler = CCDirector.sharedDirector.getScheduler
    end

    def kTagSprite1
      1
    end
    def kTagSprite2
      2
    end
    def kTagSprite3
      3
    end
    def kTagSlider
      4
    end

    def create
      layer = CCLayer.create
      init_with_layer(layer)
      layer
    end
  end

  class CameraCenterTest < NodeTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size

      # LEFT-TOP
      sprite = CCSprite.create("Images/white-512x512.png")
      layer.addChild(sprite, 0)
      sprite.setPosition(CCPointMake(s.width / 5 * 1, s.height / 5 * 1))
      sprite.setColor(ccc3(255, 0, 0))
      sprite.setTextureRect(CCRectMake(0, 0, 120, 50))
      orbit = CCOrbitCamera.create(10, 1, 0, 0, 360, 0, 0)
      sprite.runAction(CCRepeatForever.create(orbit))

      # LEFT-BOTTOM
      sprite = CCSprite.create("Images/white-512x512.png")
      layer.addChild(sprite, 0, 40)
      sprite.setPosition(CCPointMake(s.width / 5 * 1, s.height / 5 * 4))
      sprite.setColor(ccc3(0, 0, 255))
      sprite.setTextureRect(CCRectMake(0, 0, 120, 50))
      orbit = CCOrbitCamera.create(10, 1, 0, 0, 360, 0, 0)
      sprite.runAction(CCRepeatForever.create(orbit))

      # RIGHT-TOP
      sprite = CCSprite.create("Images/white-512x512.png")
      layer.addChild(sprite, 0)
      sprite.setPosition(CCPointMake(s.width / 5 * 4, s.height / 5 * 1))
      sprite.setColor(ccc3(255, 255, 0))
      sprite.setTextureRect(CCRectMake(0, 0, 120, 50))
      orbit = CCOrbitCamera.create(10, 1, 0, 0, 360, 0, 0)
      sprite.runAction(CCRepeatForever.create(orbit))

      # RIGHT-BOTTOM
      sprite = CCSprite.create("Images/white-512x512.png")
      layer.addChild(sprite, 0, 40)
      sprite.setPosition(CCPointMake(s.width / 5 * 4, s.height / 5 * 4))
      sprite.setColor(ccc3(0, 255, 0))
      sprite.setTextureRect(CCRectMake(0, 0, 120, 50))
      orbit = CCOrbitCamera.create(10, 1, 0, 0, 360, 0, 0)
      sprite.runAction(CCRepeatForever.create(orbit))

      # CENTER
      sprite = CCSprite.create("Images/white-512x512.png")
      layer.addChild(sprite, 0, 40)
      sprite.setPosition(CCPointMake(s.width / 2, s.height / 2))
      sprite.setColor(ccc3(255, 255, 255))
      sprite.setTextureRect(CCRectMake(0, 0, 120, 50))
      orbit = CCOrbitCamera.create(10, 1, 0, 0, 360, 0, 0)
      sprite.runAction(CCRepeatForever.create(orbit))

      @title_label.setString("Camera Center test")
      @subtitle_label.setString("Sprites should rotate at the same speed")
      layer
    end
  end

  class Test2 < NodeTestBase
    def init_with_layer(layer)
      super(layer)

      s = @@size

      sp1 = CCSprite.create($s_pPathSister1)
      sp2 = CCSprite.create($s_pPathSister2)
      sp3 = CCSprite.create($s_pPathSister1)
      sp4 = CCSprite.create($s_pPathSister2)

      sp1.setPosition(CCPointMake(100, s.height / 2))
      sp2.setPosition(CCPointMake(380, s.height / 2))
      layer.addChild(sp1)
      layer.addChild(sp2)

      sp3.setScale(0.25)
      sp4.setScale(0.25)
      sp1.addChild(sp3)
      sp2.addChild(sp4)

      a1 = CCRotateBy.create(2, 360)
      a2 = CCScaleBy.create(2, 2)

      array1 = CCArray.create
      array1.addObject(a1)
      array1.addObject(a2)
      array1.addObject(a2.reverse)
      action1 = CCRepeatForever.create(CCSequence.create(array1))

      array2 = CCArray.create
      array2.addObject(a1.copy)
      array2.addObject(a2.copy)
      array2.addObject(a2.reverse)
      action2 = CCRepeatForever.create(CCSequence.create(array2))

      sp2.setAnchorPoint(CCPointMake(0, 0))

      sp1.runAction(action1)
      sp2.runAction(action2)

      @title_label.setString("anchorPoint and children")
      layer
    end
  end

  class Test4 < NodeTestBase
    def initialize
      super
      @layer = nil
      @delay2Entry = nil
      @delay4Entry = nil
    end

    def delay2(dt)
      node = @layer.getChildByTag(2)
      action1 = CCRotateBy.create(1, 360)
      node.runAction(action1)
    end

    def delay4(dt)
      @scheduler.unscheduleScriptEntry(@delay4Entry)
      @layer.removeChildByTag(3, false)
    end

    def on_enter_or_exit(tag)
      if tag == kCCNodeOnEnter
        that = self
        @delay2Entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.delay2(dt)},
                                                     2.0, false)
        @delay4Entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.delay4(dt)},
                                                     4.0, false)
      elsif tag == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@delay2Entry)
        @scheduler.unscheduleScriptEntry(@delay4Entry)
      end
    end

    def init_with_layer(layer)
      super(layer)

      sp1 = CCSprite.create($s_pPathSister1)
      sp2 = CCSprite.create($s_pPathSister2)
      sp1.setPosition(CCPointMake(100, 160))
      sp2.setPosition(CCPointMake(380, 160))

      layer.addChild(sp1, 0, 2)
      layer.addChild(sp2, 0, 3)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    that.on_enter_or_exit(tag)
                                    if tag == Cocos2d.kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end})
                                  

      @title_label.setString("tags")
      @layer = layer
      @layer
    end
  end

  class Test5 < NodeTestBase
    def initialize
      super
      @entry = nil
      @layer = nil
    end

    def add_and_remove(dt)
      sp1 = @layer.getChildByTag(kTagSprite1)
      sp2 = @layer.getChildByTag(kTagSprite2)

      sp1.retain
      sp2.retain

      @layer.removeChild(sp1, false)
      @layer.removeChild(sp2, true)

      @layer.addChild(sp1, 0, kTagSprite1)
      @layer.addChild(sp2, 0, kTagSprite2)

      sp1.release
      sp2.release
    end

    def on_enter_or_exit(tag)
      if tag == kCCNodeOnEnter
        that = self
        @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.add_and_remove(dt)},
                                              2.0, false)
      elsif tag == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@entry)
      end
    end

    def init_with_layer(layer)
      super(layer)

      sp1 = CCSprite.create($s_pPathSister1)
      sp2 = CCSprite.create($s_pPathSister2)

      sp1.setPosition(CCPointMake(100, 160))
      sp2.setPosition(CCPointMake(380, 160))

      rot = CCRotateBy.create(2, 360)
      rot_back = rot.reverse
      forever = CCRepeatForever.create(CCSequence.createWithTwoActions(rot, rot_back))

      rot2 = CCRotateBy.create(2, 360)
      rot2_back = rot2.reverse
      forever2 = CCRepeatForever.create(CCSequence.createWithTwoActions(rot2, rot2_back))

      forever.setTag(101)
      forever2.setTag(102)

      layer.addChild(sp1, 0, kTagSprite1)
      layer.addChild(sp2, 0, kTagSprite2)

      sp1.runAction(forever)
      sp2.runAction(forever2)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    that.on_enter_or_exit(tag)
                                    if tag == Cocos2d.kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end})

      @title_label.setString("remove and cleanup")
      @layer = layer
      @layer
    end
  end

  class Test6 < NodeTestBase
    def initialize
      super
      @entry = nil
      @layer = nil
    end

    def add_and_remove(dt)
      sp1 = @layer.getChildByTag(kTagSprite1)
      sp2 = @layer.getChildByTag(kTagSprite2)

      sp1.retain
      sp2.retain

      @layer.removeChild(sp1, false)
      @layer.removeChild(sp2, true)

      @layer.addChild(sp1, 0, kTagSprite1)
      @layer.addChild(sp2, 0, kTagSprite2)

      sp1.release
      sp2.release
    end

    def on_enter_or_exit(tag)
      if tag == kCCNodeOnEnter
        that = self
        @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.add_and_remove(dt)},
                                              2.0, false)
      elsif tag == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@entry)
      end
    end

    def init_with_layer(layer)
      super(layer)

      sp1 = CCSprite.create($s_pPathSister1)
      sp11 = CCSprite.create($s_pPathSister1)

      sp2 = CCSprite.create($s_pPathSister2)
      sp21 = CCSprite.create($s_pPathSister2)

      sp1.setPosition(CCPointMake(100, 160))
      sp2.setPosition(CCPointMake(380, 160))

      rot = CCRotateBy.create(2, 360)
      rot_back = rot.reverse
      forever1 = CCRepeatForever.create(CCSequence.createWithTwoActions(rot, rot_back))
      forever11 = forever1.copy

      forever2 = forever1.copy
      forever21 = forever1.copy

      layer.addChild(sp1, 0, kTagSprite1)
      sp1.addChild(sp11)
      layer.addChild(sp2, 0, kTagSprite2)
      sp2.addChild(sp21)

      sp1.runAction(forever1)
      sp11.runAction(forever11)
      sp2.runAction(forever2)
      sp21.runAction(forever21)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    that.on_enter_or_exit(tag)
                                    if tag == Cocos2d.kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end})

      @title_label.setString("remove/cleanup with children")
      @layer = layer
      @layer
    end
  end


  class StressTest1 < NodeTestBase
    def initialize
      super
      @entry = nil
      @layer = nil
    end

    def remove_me(node)
      parent = @layer.getParent
      parent.removeChild(node, true)
      CCNotificationCenter.sharedNotificationCenter
        .postNotification("next_action", self)
    end

    def should_not_crash(dt)
      @scheduler.unscheduleScriptEntry(@entry)

      # if the node has timers, it crashes
      explosion = CCParticleSun.create
      explosion.setTexture(CCTextureCache.sharedTextureCache.addImage("Images/fire.png"))

      explosion.setPosition(@@size.width / 2, @@size.height / 2)
      
      @layer.setAnchorPoint(ccp(0, 0))
      that = self
      @layer.runAction(CCSequence.createWithTwoActions(CCRotateBy.create(2, 360), CCCallFuncN.create(Proc.new {|*args| that.remove_me(*args)})))

      @layer.addChild(explosion)
    end

    def on_enter_or_exit(tag)
      if tag == kCCNodeOnEnter
        that = self
        @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.should_not_crash(dt)}, 1.0, false)
      elsif tag == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@entry)
      end
    end

    def init_with_layer(layer)
      super(layer)

      s = @@size
      sp1 = CCSprite.create($s_pPathSister1)
      layer.addChild(sp1, 0, kTagSprite1)

      sp1.setPosition(CCPointMake(s.width / 2, s.height / 2))

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    that.on_enter_or_exit(tag)
                                    if tag == Cocos2d.kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end})

      @title_label.setString("stress test #1. no crashes")
      @layer = layer
      @layer
    end
  end

  class StressTest2 < NodeTestBase
    def initialize
      super
      @entry = nil
      @layer = nil
    end

    def should_not_leak(dt)
      @scheduler.unscheduleScriptEntry(@entry)

      sublayer = @layer.getChildByTag(kTagSprite1)
      sublayer.removeAllChildrenWithCleanup(true)
    end

    def on_enter_or_exit(tag)
      if tag == kCCNodeOnEnter
        that = self
        @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.should_not_leak(dt)}, 6.0, false)
      elsif tag == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@entry)
      end
    end

    def init_with_layer(layer)
      super(layer)

      sublayer = CCLayer.create

      s = @@size
      sp1 = CCSprite.create($s_pPathSister1)
      sp1.setPosition(CCPointMake(80, s.height / 2))

      move = CCMoveBy.create(3, CCPointMake(350, 0))
      move_ease_inout3 = CCEaseInOut.create(CCMoveBy.create(3, CCPointMake(350, 0)), 2.0)
      move_ease_inout_back3 = move_ease_inout3.reverse
      seq3 = CCSequence.createWithTwoActions(move_ease_inout3, move_ease_inout_back3)
      sp1.runAction(CCRepeatForever.create(seq3))
      sublayer.addChild(sp1, 1)

      fire = CCParticleFire.create
      fire.setTexture(CCTextureCache.sharedTextureCache.addImage("Images/fire.png"))
      fire.setPosition(80, s.height / 2 - 50)

      copy_seq3 = seq3.copy
      fire.runAction(CCRepeatForever.create(copy_seq3))
      sublayer.addChild(fire, 2)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    that.on_enter_or_exit(tag)
                                    if tag == Cocos2d.kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end})

      layer.addChild(sublayer, 0, kTagSprite1)

      @title_label.setString("stress test #2. no leaks")
      @layer = layer
      layer
    end
  end


  class NodeToWorld < NodeTestBase
    def init_with_layer(layer)
      super(layer)

      # This code tests that nodeToParent works OK.
      #  - It tests different anchor Points
      #  - It tests different children anchor points

      back = CCSprite.create($s_back3)
      layer.addChild(back, -10)
      back.setAnchorPoint(CCPointMake(0, 0))
      back_size = back.getContentSize

      item = CCMenuItemImage.create($s_PlayNormal, $s_PlaySelect)
      menu = CCMenu.create
      menu.addChild(item)
      menu.alignItemsVertically
      menu.setPosition(ccp(back_size.width / 2, back_size.height / 2))
      back.addChild(menu)

      rot = CCRotateBy.create(5, 360)
      fe = CCRepeatForever.create(rot)
      item.runAction(fe)

      move = CCMoveBy.create(3, CCPointMake(200, 0))
      move_back = move.reverse
      seq = CCSequence.createWithTwoActions(move, move_back)
      fe2 = CCRepeatForever.create(seq)
      back.runAction(fe2)

      @title_label.setString("nodeToParent transform")
      layer
    end
  end

  class CameraOrbitTest < NodeTestBase
    def on_enter_or_exit(tag)
      if tag == kCCNodeOnEnter
        CCDirector.sharedDirector.setProjection(kCCDirectorProjection3D)
      elsif tag == kCCNodeOnExit
        CCDirector.sharedDirector.setProjection(kCCDirectorProjection2D)
      end
    end

    def init_with_layer(layer)
      super(layer)

      s = @@size
      p = CCSprite.create($s_back3)
      layer.addChild(p, 0)
      p.setPosition(CCPointMake(s.width / 2, s.height / 2))
      p.setOpacity(128)

      # LEFT
      s = p.getContentSize
      sprite = CCSprite.create($s_pPathGrossini)
      sprite.setScale(0.5)
      p.addChild(sprite, 0)
      sprite.setPosition(CCPointMake(s.width / 4 * 1, s.height / 2))
      cam = sprite.getCamera
      orbit = CCOrbitCamera.create(2, 1, 0, 0, 360, 0, 0)
      sprite.runAction(CCRepeatForever.create(orbit))

      # CENTER
      sprite = CCSprite.create($s_pPathGrossini)
      sprite.setScale(1.0)
      p.addChild(sprite, 0)
      sprite.setPosition(CCPointMake(s.width / 4 * 2, s.height / 2))
      orbit = CCOrbitCamera.create(2, 1, 0, 0, 360, 45, 0)
      sprite.runAction(CCRepeatForever.create(orbit))

      # RIGHT
      sprite = CCSprite.create($s_pPathGrossini)
      sprite.setScale(2.0)
      p.addChild(sprite, 0)
      sprite.setPosition(CCPointMake(s.width / 4 * 3, s.height / 2))
      ss = sprite.getContentSize
      orbit = CCOrbitCamera.create(2, 1, 0, 0, 360, 90, -45)
      sprite.runAction(CCRepeatForever.create(orbit))

      # PARENT
      orbit = CCOrbitCamera.create(10, 1, 0, 0, 360, 0, 90)
      p.runAction(CCRepeatForever.create(orbit))

      layer.setScale(1)

      @title_label.setString("Camera Orbit test")
      layer
    end
  end

  class CameraZoomTest < NodeTestBase
    def initialize
      super
      @z = 0
      @layer = nil
      @entry = nil
    end

    def update(dt)
      @z += dt * 100

      sprite = @layer.getChildByTag(20)
      cam = sprite.getCamera
      cam.setEyeXYZ(0, 0, @z)

      sprite = @layer.getChildByTag(40)
      cam = sprite.getCamera
      cam.setEyeXYZ(0, 0, -@z)
    end

    def on_enter_or_exit(tag)
      if tag == kCCNodeOnEnter
        CCDirector.sharedDirector.setProjection(kCCDirectorProjection3D)
        that = self
        @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.update(dt)}, 0.0, false)
      elsif tag == kCCNodeOnExit
        CCDirector.sharedDirector.setProjection(kCCDirectorProjection2D)
        @scheduler.unscheduleScriptEntry(@entry)
      end
    end

    def init_with_layer(layer)
      super(layer)
      @z = 0

      s = @@size
      # LEFT
      sprite = CCSprite.create($s_pPathGrossini)
      layer.addChild(sprite, 0)
      sprite.setPosition(ccp(s.width / 4 * 1, s.height / 2))
      cam = sprite.getCamera
      cam.setEyeXYZ(0, 0, 415 / 2)
      cam.setCenterXYZ(0, 0, 0)

      # CENTER
      sprite = CCSprite.create($s_pPathGrossini)
      layer.addChild(sprite, 0, 40)
      sprite.setPosition(ccp(s.width / 4 * 2, s.height / 2))

      # RIGHT
      sprite = CCSprite.create($s_pPathGrossini)
      layer.addChild(sprite, 0, 20)
      sprite.setPosition(ccp(s.width / 4 * 3, s.height / 2))

      that = self
      layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)
      layer.registerScriptHandler(Proc.new {|tag|
                                    that.on_enter_or_exit(tag)
                                    if tag == Cocos2d.kCCNodeOnCleanup
                                      layer.unregisterScriptHandler
                                    end})

      @title_label.setString("Camera Zoom test")
      @layer = layer
      @layer
    end
  end

  class ConvertToNode < NodeTestBase
    def initialize
      super
      @layer = nil
    end

    def init_with_layer(layer)
      super(layer)

      rotate = CCRotateBy.create(10, 360)
      action = CCRepeatForever.create(rotate)

      s = @@size

      3.times do |i|
        sprite = CCSprite.create("Images/grossini.png")
        sprite.setPosition(ccp(s.width / 4 * (i + 1), s.height / 2))

        point = CCSprite.create("Images/r1.png")
        point.setScale(0.25)
        point.setPosition(sprite.getPosition)
        layer.addChild(point, 10, 100 + i)

        if i == 0
          sprite.setAnchorPoint(ccp(0, 0))
        elsif i == 1
          sprite.setAnchorPoint(ccp(0.5, 0.5))
        elsif i == 2
          sprite.setAnchorPoint(ccp(1,1))
        end

        point.setPosition(sprite.getPosition)

        copy = action.copy
        sprite.runAction(copy)
        layer.addChild(sprite, i)
      end

      on_touch_ended = Proc.new {|x, y|
        3.times do |i|
          node = layer.getChildByTag(100 + i)
          p1 = node.convertToNodeSpaceAR(Cocos2d::CCPoint.new(x, y))
          p2 = node.convertToNodeSpace(Cocos2d::CCPoint.new(x, y))

          Cocos2d.cclog("AR. x=#{p1.x}, y=#{p1.y} -- Not AR. x=#{p2.x}, y=#{p2.y}")
        end
      }

      on_touch = Proc.new {|event_type, x, y|
        if event_type == CCTOUCHBEGAN
          true
        elsif event_type == CCTOUCHENDED
          on_touch_ended.call(x, y)
        end
      }

      layer.setTouchEnabled(true)
      layer.registerScriptTouchHandler(Proc.new {|*args| on_touch.call(*args)}, false, -1, false)
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnCleanup
                                      layer.unregisterScriptTouchHandler
                                      layer.unregisterScriptHandler
                                    end})

      @title_label.setString("Convert To Node Space")
      @subtitle_label.setString("testing convertToNodeSpace / AR. Touch and see console")
      @layer = layer
      @layer
    end
  end

  class NodeOpaqueTest < NodeTestBase
    def init_with_layer(layer)
      super(layer)

      49.times do |i|
        background = CCSprite.create("Images/background1.png")
        blend_func = CC_ccBlendFunc.new
        blend_func.src = GL_ONE
        blend_func.dst = GL_ONE_MINUS_SRC_ALPHA 
        background.setBlendFunc(blend_func)
        background.setAnchorPoint(ccp(0, 0))
        layer.addChild(background)
      end

      @title_label.setString("Node Opaque Test")
      @subtitle_label.setString("Node rendered with GL_BLEND disabled")
      layer
    end
  end

  class NodeNonOpaqueTest < NodeTestBase
    def init_with_layer(layer)
      super(layer)

      49.times do |i|
        background = CCSprite.create("Images/background1.jpg")
        blend_func = CC_ccBlendFunc.new
        blend_func.src = GL_ONE
        blend_func.dst = GL_ZERO
        background.setBlendFunc(blend_func)
        background.setAnchorPoint(ccp(0, 0))
        layer.addChild(background)
      end

      @title_label.setString("Node Non Opaque Test")
      @subtitle_label.setString("Node rendered with GL_BLEND enabled")
      layer
    end
  end

  def initialize
    super
    [CameraCenterTest,
     Test2,
     Test4,
     Test5,
     Test6,
     StressTest1,
     StressTest2,
     NodeToWorld,
     CameraOrbitTest,
     CameraZoomTest,
     ConvertToNode,
     NodeOpaqueTest,
     NodeNonOpaqueTest,
    ].each do |klass|
      register_create_function(klass.new, :create)
    end

  end

  def new_scene
    scene = super
    that = self
    notification_center = CCNotificationCenter.sharedNotificationCenter
    notification_center.registerScriptObserver(scene,
                                               Proc.new {
                                                 Cocos2d::CCDirector.sharedDirector.replaceScene(that.next_action)
                                               }, "next_action")
    scene.registerScriptHandler(Proc.new {|tag|
                                  if tag == Cocos2d.kCCNodeOnCleanup
                                    notification_center
                                      .unregisterScriptObserver(scene, "next_action")
                                    scene.unregisterScriptHandler
                                  end
                                })
    scene
  end

  def create
    new_scene
  end
end
