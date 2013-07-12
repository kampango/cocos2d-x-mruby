
p "Hello mruby!"
print "os:#{CC.os}\n"
print "version:#{CC.version}\n"

require "hello2"
p "result is #{Utils.myadd(3, 5)}"

module A
  include Cocos2d
  include CocosDenshion

  @@visible_size = CCDirector.sharedDirector().getVisibleSize()
  @@origin = CCDirector.sharedDirector().getVisibleOrigin()

  class SpriteDog < CCSprite
    include Cocos2d
    @@visible_size = CCDirector.sharedDirector().getVisibleSize()
    @@origin = CCDirector.sharedDirector().getVisibleOrigin()

    def self.createWithSpriteFrame(frame)
      sprite = self.new
      sprite.initWithSpriteFrame(frame)
      sprite
    end
    def is_paused
      @is_paused
    end
    def is_paused=(v)
      @is_paused = !!v
    end
        
    def tick
      return if @is_paused
      pos = getPosition()
      x = pos.x
      if x > @@origin.x + @@visible_size.width
        x = @@origin.x
      else
        x += 1
      end
      pos.x = x
      setPosition(pos)
    end
  end


  def self.create_dog
    f_w = 105
    f_h = 95

    texture_dog = CCTextureCache.sharedTextureCache().addImage("dog.png")
    
    pos = CCPoint.new
    pos.x = 0
    pos.y = 0
    sz = CCSize.new
    sz.width = f_w
    sz.height = f_h
    rect = CCRect.new
    rect.origin = pos
    rect.size = sz
    frame0 = CCSpriteFrame.createWithTexture(texture_dog, rect)
    pos.x = f_w
    pos.y = 0
    rect.origin = pos
    sz.width = f_w
    sz.height = f_h
    rect.size = sz
    frame1 = CCSpriteFrame.createWithTexture(texture_dog, rect)

    #sprite_dog = CCSprite.createWithSpriteFrame(frame0)
    sprite_dog = SpriteDog.createWithSpriteFrame(frame0)
    sprite_dog.is_paused = false

    pos.x = @@origin.x
    pos.y = @@origin.y + @@visible_size.height / 4 * 3
    sprite_dog.setPosition(pos)

    anim_frames = CCArray.create()
    anim_frames.addObject(frame0)
    anim_frames.addObject(frame1)

    animation = CCAnimation.createWithSpriteFrames(anim_frames, 0.5)
    animate = CCAnimate.create(animation)
    sprite_dog.runAction(CCRepeatForever.create(animate))

    sched = CCDirector.sharedDirector().getScheduler()
    sched.scheduleScriptFunc(Proc.new { sprite_dog.tick() }, 0, false)

    sprite_dog
  end

  def self.create_layer_farm
    layer_farm = CCLayer.create()
    bg = CCSprite.create("farm.jpg")

    pos = CCPoint.new
    pos.x = @@origin.x + @@visible_size.width / 2 + 80
    pos.y = @@origin.y + @@visible_size.height / 2

    bg.setPosition(pos)
    layer_farm.addChild(bg)

    i = 0
    while (i <= 3)
      j = 0
      while (j <= 1)
        sprite_land = CCSprite.create("land.png")
        pos = CCPoint.new
        pos.x = 200 + j * 180 - i % 2 * 90
        pos.y = 10 + i * 95 / 2
        sprite_land.setPosition(pos)
        layer_farm.addChild(sprite_land)
        j += 1
      end
      i += 1
    end

    rect = CCRect.new
    pos = CCPoint.new
    pos.x = 0
    pos.y = 0
    rect.origin = pos
    sz = CCSize.new
    sz.width = 105
    sz.height = 95
    rect.size = sz

    frame_crop = CCSpriteFrame.create("crop.png", rect)
    i = 0
    while (i <= 3)
      j = 0
      while (j <= 1)
        sprite_crop = CCSprite.createWithSpriteFrame(frame_crop)
        pos = CCPoint.new
        pos.x = 10 + 200 + j * 180 - i % 2 * 90
        pos.y = 30 + 10 + i * 95 / 2
        sprite_crop.setPosition(pos)
        layer_farm.addChild(sprite_crop)
        j += 1
      end
      i += 1
    end

    sprite_dog = create_dog()
    layer_farm.addChild(sprite_dog)

    touch_begin_point = nil
    on_touch_began = ->(x, y) {
      printf("on_touch_began: %0.2f, %0.2f\n", x, y)
      touch_begin_point = Cocos2d::CCPoint.new
      touch_begin_point.x = x
      touch_begin_point.y = y
      sprite_dog.is_paused = true
      true
    }

    on_touch_moved = ->(x, y) {
      printf("on_touch_moved: %0.2f, %0.2f\n", x, y)
      unless touch_begin_point.nil?
        c = layer_farm.getPosition()
        pos = Cocos2d::CCPoint.new
        pos.x = c.x + x - touch_begin_point.x
        pos.y = c.y + y - touch_begin_point.y
        layer_farm.setPosition(pos)
        touch_begin_point.x = x
        touch_begin_point.y = y
      end
      true
    }

    on_touch_ended = ->(x, y) {
      printf("on_touch_ended: %0.2f, %0.2f\n", x, y)
      touch_begin_point = nil
      sprite_dog.is_paused = false
      true
    }

    on_touch = ->(event_type, x, y) {
      #printf("on_touch:#{event_type}\n")
      case event_type
      when 0
        return on_touch_began.call(x, y)
      when 1
        return on_touch_moved.call(x, y)
      when 2
        return on_touch_ended.call(x, y)
      end
      false
    }

    layer_farm.registerScriptTouchHandler(on_touch, false, 0, false)
    layer_farm.setTouchEnabled(true)
    layer_farm
  end

  def self.create_layer_menu
    layer_menu = CCLayer.create()
    menu_popup = nil
    effect_id = 0
    menu_callback_close_popup = Proc.new {|tag|
      CocosDenshion::SimpleAudioEngine.sharedEngine().stopEffect(effect_id)
      menu_popup.setVisible(false)
    }

    menu_callback_open_popup = Proc.new {|tag|
      effect_path = Cocos2d::CCFileUtils.sharedFileUtils().fullPathForFilename("effect1.wav")
      effect_id = CocosDenshion::SimpleAudioEngine.sharedEngine().playEffect(effect_path)
      menu_popup.setVisible(true)
    }

    pos = CCPoint.new
    menu_popup_item = CCMenuItemImage.create("menu2.png", "menu2.png")
    pos.x = 0
    pos.y = 0
    menu_popup_item.setPosition(pos)
    menu_popup_item.registerScriptTapHandler(menu_callback_close_popup)
    menu_popup = CCMenu.createWithItem(menu_popup_item)
    pos.x = @@origin.x + @@visible_size.width / 2
    pos.y = @@origin.y + @@visible_size.height / 2
    menu_popup.setPosition(pos)
    menu_popup.setVisible(false)
    layer_menu.addChild(menu_popup)

    menu_tools_item = CCMenuItemImage.create("menu1.png", "menu1.png")
    pos.x = 0
    pos.y = 0
    menu_tools_item.setPosition(pos)
    menu_tools_item.registerScriptTapHandler(menu_callback_open_popup)
    menu_tools = CCMenu.createWithItem(menu_tools_item)

    item_sz = menu_tools_item.getContentSize()
    pos.x = @@origin.x + item_sz.width / 2
    pos.y = @@origin.y + item_sz.height / 2
    menu_tools.setPosition(pos)
    layer_menu.addChild(menu_tools)

    layer_menu
  end

  bg_music_path = CCFileUtils.sharedFileUtils().fullPathForFilename("background.mp3")
  SimpleAudioEngine.sharedEngine().playBackgroundMusic(bg_music_path, true)
  effect_path = CCFileUtils.sharedFileUtils().fullPathForFilename("effect1.wav")
  SimpleAudioEngine.sharedEngine().preloadEffect(effect_path)

  @scene_game = CCScene.create()
  @scene_game.addChild(create_layer_farm())
  @scene_game.addChild(create_layer_menu())
  CCDirector::sharedDirector().runWithScene(@scene_game)
end
