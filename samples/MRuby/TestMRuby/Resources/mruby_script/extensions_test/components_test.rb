require "mruby_script/test_base"

class ComponentsTest < TestBase
  extend TestBaseExt
  include Cocos2d::Extension
  self.supported = true

  class PlayerController < CCComController
    include Cocos2d
    include CCTypeHelper

    def self.create
      controller = super
      controller.initWithName("PlayerController")
      controller
    end

    def on_touch(event, x, y)
      return true if event != CCTOUCHENDED

      projectile = CCSprite.create("components/Projectile.png", CCRectMake(0, 0, 20, 20))
      getOwner.getParent.addChild(projectile, 1, 4)
      com = ProjectileController.create
      com.registerScriptHandler(Proc.new {|tag| com.script_handler(tag)})
      projectile.addComponent(com)
      projectile.registerScriptHandler(Proc.new {|tag|
                                         if tag == Cocos2d.kCCNodeOnExit
                                           projectile.removeAllComponents
                                         elsif tag == Cocos2d.kCCNodeOnCleanup
                                           projectile.removeAllComponents
                                           projectile.unregisterScriptHandler
                                         end
                                       })

      com.move(x, y)
      getOwner.getComponent("Audio").playEffect("pew-pew-lei.wav")
    end
  end

  class SceneController < CCComController
    include Cocos2d
    include CCTypeHelper

    def self.create
      controller = super
      controller.initWithName("SceneController")
      controller
    end

    def script_handler(tag)
      case tag
      when kCCNodeOnEnter
        on_enter
      when kCCNodeOnExit
        on_exit
      end
    end

    def projectiles
      @projectiles
    end

    def targets
      @targets
    end

    def on_enter
      @elapsed_time = 0.0
      @add_target_time = 1.0
      @targets = []
      @projectiles = []

      that = self
      scheduler = CCDirector.sharedDirector().getScheduler()
      @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.update(dt)}, 0, false) 

      getOwner.getComponent("Audio").playBackgroundMusic("background-music-aac.wav", true)
      getOwner.getComponent("ComAttribute").setInt("KillCount", 0)
    end

    def on_exit
      CCDirector.sharedDirector().getScheduler()
        .unscheduleScriptEntry(@entry)
      unregisterScriptHandler
    end

    def update(delta)
      @elapsed_time += delta
      if @elapsed_time > @add_target_time
        add_target
        @elapsed_time = 0.0
      end
    end

    def add_target
      target = CCSprite.create("components/Target.png", CCRectMake(0, 0, 27, 40))
      getOwner.addChild(target, 1, 2)

      enemy_controller = EnemyController.create
      enemy_controller.registerScriptHandler(Proc.new {|tag| enemy_controller.script_handler(tag)})
      target.addComponent(enemy_controller)
      target.registerScriptHandler(Proc.new {|tag|
                                     if tag == Cocos2d.kCCNodeOnExit
                                       target.removeAllComponents
                                     elsif tag == Cocos2d.kCCNodeOnCleanup
                                       target.removeAllComponents
                                       target.unregisterScriptHandler
                                     end
                                   })
      target.setTag(2)
      @targets << target
    end

    def sprite_move_finished(sprite)
      getOwner.removeChild(sprite, true)

      case sprite.getTag
      when 2 #target
        #sprite.getComponent("EnemyController").on_exit
        #sprite.getComponent("EnemyController") #=> nil why?
        @targets.delete(sprite)
        game_over_scene = GameOverScene.create
        game_over_scene.layer.label.setString("You Lose :[")
        CCDirector::sharedDirector.replaceScene(game_over_scene)
      when 3
        #sprite.getComponent("ProjectileController").on_exit
        @projectiles.delete(sprite)
      end
      sprite.removeAllComponents
    end

    def increase_kill_count
      com = getOwner.getComponent("ComAttribute")
      num_destroyed = com.getInt("KillCount") + 1
      com.setInt("KillCount", num_destroyed)
      if num_destroyed >= 5
        game_over_scene = GameOverScene.create
        game_over_scene.layer.label.setString("You Win!")
        CCDirector::sharedDirector.replaceScene(game_over_scene)
      end
    end
  end

  class GameOverScene < CCScene
    include Cocos2d
    include CCTypeHelper

    class GameOverLayer < CCLayerColor
      include Cocos2d
      include CCTypeHelper

      def self.create
        layer = self.new
        layer.init
        layer
      end

      def init
        initWithColor(ccc4(255, 255, 255, 255))

        win_size = CCDirector.sharedDirector.getVisibleSize
        @label = CCLabelTTF.create("", "Artial", 32)
        @label
          .setColor(ccc3(0, 0, 0))
          .setPosition(ccp(win_size.width / 2, win_size.height / 2))
        addChild(@label)

        that = self
        arr = CCArray.new
        arr.addObject(CCDelayTime.create(3))
          .addObject(CCCallFunc.create(Proc.new {that.game_over_done}))
        runAction(CCSequence.create(arr))
        # TODO:
        #runAction(CCSequence.create(CCDelayTime.create(3),
        #                            CCCallFunc.create(Proc.new {that.game_over_done}),
        #                            nil))
        true
      end

      def game_over_done
        stopAllActions
        CCDirector.sharedDirector.replaceScene(ComponentsTest.new.create)
      end

      def label
        @label
      end
    end

    def self.create
      scene = self.new
      scene.init
      scene
    end

    def layer
      @layer
    end

    def init
      @layer = GameOverLayer.create
      addChild(@layer)
      layer = @layer
      addChild(ExtensionsTest.create_back_menu_item("Back", nil, ccc3(0, 0, 0)))
      true
    end
  end

  class EnemyController < CCComController
    include Cocos2d
    include CCTypeHelper

    def self.create
      controller = super
      controller.initWithName("EnemyController")
      controller
    end

    def script_handler(tag)
      case tag
      when kCCNodeOnEnter
        on_enter
      when kCCNodeOnExit
        on_exit
      end
    end

    def on_enter
      win_size = CCDirector.sharedDirector.getVisibleSize

      owner = getOwner
      min_y = owner.getContentSize.height / 2
      max_y = win_size.height - owner.getContentSize.height / 2
      range_y = (max_y - min_y).to_i
      actual_y = rand(range_y) + min_y.to_i

      owner.setPosition(ccp(win_size.width + owner.getContentSize.width / 2,
                            CCDirector.sharedDirector.getVisibleOrigin.y + actual_y))

      min_duration = 2
      max_duration = 4
      range_duration = max_duration - min_duration
      actual_duration = rand(range_duration) + min_duration

      action_move = CCMoveTo.create(actual_duration, ccp(0 - owner.getContentSize.width / 2, actual_y))
      that = owner.getParent.getComponent("SceneController")
      action_move_done = CCCallFuncN.create(Proc.new {|sender| that.sprite_move_finished(sender)})
      arr = CCArray.new
      arr.addObject(action_move)
        .addObject(action_move_done)
      owner.runAction(CCSequence.create(arr))
      #TODO:
      #owner.runAction(CCSequence.create(action_move, action_move_done, nil))
    end

    def on_exit
      unregisterScriptHandler
    end

    def die
      owner = getOwner
      com = owner.getParent.getComponent("SceneController")
      com.targets.delete(owner)
      owner.removeFromParentAndCleanup(true)
      com.increase_kill_count
      on_exit
    end
  end

  class ProjectileController < CCComController
    include Cocos2d
    include CCTypeHelper

    def self.create
      controller = super
      controller.initWithName("ProjectileController")
      controller
    end

    def script_handler(tag)
      case tag
      when kCCNodeOnEnter
        on_enter
      when kCCNodeOnExit
        on_exit
      end
    end


    def on_enter
      win_size = CCDirector.sharedDirector.getVisibleSize
      origin = CCDirector.sharedDirector.getVisibleOrigin
      owner = getOwner
      owner.setPosition(ccp(origin.x + 20, origin.y + win_size.height / 2))
      owner.setTag(3)
      com = owner.getParent.getComponent("SceneController")
      com.projectiles << owner

      that = self
      scheduler = CCDirector.sharedDirector().getScheduler()
      @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.update(dt)}, 0, false)
    end

    def on_exit
      CCDirector.sharedDirector().getScheduler()
        .unscheduleScriptEntry(@entry)
      unregisterScriptHandler
    end

    def update(dt)
      projectile = getOwner
      return unless projectile.getParent #???
      com = projectile.getParent.getComponent("SceneController")
      targets = com.targets

      pos = projectile.getPosition
      sz = projectile.getContentSize
      projectile_rect = CCRectMake(pos.x - sz.width / 2,
                                   pos.y - sz.height / 2,
                                   sz.width, sz.height)

      targets_to_delete = []
      targets.each do |target|
        pos = target.getPosition
        sz = target.getContentSize
        target_rect = CCRectMake(pos.x - sz.width / 2,
                                 pos.y - sz.height / 2,
                                 sz.width, sz.height)

        if projectile_rect.intersectsRect(target_rect)
          targets_to_delete << target
        end
      end

      targets_to_delete.each do |target|
        target.getComponent("EnemyController").die
      end

      die if targets_to_delete.size > 0
    end

    def move(x, y)
      owner = getOwner
      pos = owner.getPosition
      off_x = x - pos.x
      off_y = y - pos.y

      return if off_x < 0

      win_size = CCDirector.sharedDirector.getVisibleSize
      origin = CCDirector.sharedDirector.getVisibleOrigin
      real_x = origin.x + win_size.width + owner.getContentSize.width / 2
      ratio = off_y / off_x
      real_y = real_x * ratio + pos.y
      real_dest = ccp(real_x, real_y)

      off_real_x = real_x - pos.x
      off_real_y = real_y - pos.y

      length = Math.sqrt(off_real_x * off_real_x + off_real_y * off_real_y)
      velocity = 480 / 1 #480pixels/1sec
      real_move_duration = length / velocity

      scene_controller = owner.getParent.getComponent("SceneController")

      arr = CCArray.new
      arr.addObject(CCMoveTo.create(real_move_duration, real_dest))
        .addObject(CCCallFuncN.create(Proc.new {|sender| scene_controller.sprite_move_finished(sender)}))
      owner.runAction(CCSequence.create(arr))

      #TODO:
      #owner.runAction(CCSequence.create(CCMoveTo.create(real_move_duration, real_dest),
      #                                  CCCallFuncN.create(Proc.new {|sender| scene_controller.sprite_move_finished(sender)}),
      #                                  nil))

    end

    def die
      owner = getOwner
      com = owner.getParent.getComponent("SceneController")
      com.projectiles.delete(owner)
      owner.removeFromParentAndCleanup(true)
      on_exit
    end
  end

  def create_layer
    layer = CCLayerColor.new
    layer.initWithColor(ccc4(255, 255, 255, 255))
    root = create_game_scene
    layer.addChild(root, 0, 1)
    player = root.getChildByTag(1)
    player.addComponent(CCComAudio.create)

    player_controller = @player_controller = PlayerController.create
    @player_controller.registerScriptTouchHandler(Proc.new {|event_type, x, y| player_controller.on_touch(event_type, x, y)}, false, -1, false)
    @player_controller.setTouchEnabled(true)
    player.addComponent(@player_controller)

    root.addComponent(CCComAudio.create)
    root.addComponent(CCComAttribute.create)
    scene_controller = SceneController.create
    scene_controller.registerScriptHandler(Proc.new {|tag| scene_controller.script_handler(tag)})
    root.addComponent(scene_controller)
    layer
  end

  def create_game_scene
    director = CCDirector.sharedDirector
    visible_size = director.getVisibleSize
    origin = director.getVisibleOrigin

    player = CCSprite.create("components/Player.png", CCRectMake(0, 0, 27, 40))
    player.setPosition(ccp(origin.x + player.getContentSize.width / 2,
                           origin.y + visible_size.height / 2))

    player.registerScriptHandler(Proc.new {|tag|
                                   if tag == Cocos2d.kCCNodeOnExit
                                     player.removeAllComponents
                                   elsif tag == Cocos2d.kCCNodeOnCleanup
                                     player.removeAllComponents
                                     player.unregisterScriptHandler
                                   end
                                 })

    root = CCNode.create
    root.addChild(player, 1, 1)
    root.registerScriptHandler(Proc.new {|tag|
                                 if tag == Cocos2d.kCCNodeOnExit
                                   @player_controller.unregisterScriptTouchHandler
                                   root.removeAllComponents
                                 elsif tag == Cocos2d.kCCNodeOnCleanup
                                   @player_controller.unregisterScriptTouchHandler
                                   root.removeAllComponents
                                   root.unregisterScriptHandler
                                 end
                               })
    root
  end

  def create
    scene = CCScene.create
    layer = create_layer
    init_with_layer(layer)
    scene.addChild(layer)
    scene.addChild(ExtensionsTest.create_back_menu_item("Back", nil, ccc3(0, 0, 0)))
    scene
  end
end
