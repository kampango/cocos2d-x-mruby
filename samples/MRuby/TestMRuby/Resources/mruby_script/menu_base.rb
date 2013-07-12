require "mruby_script/cctype_helper"
require "mruby_script/test_resource"

class MenuBase
  include Cocos2d
  include CCTypeHelper

  # back menu callback
  def self.main_menu_callback
    scene = CCScene.create
    scene.addChild(self.new.create_test_menu)
    CCDirector.sharedDirector.replaceScene(scene)
  end

  # add the menu item for back to main menu
  def self.create_back_menu_item(title = "MainMenu", handler = nil, color = nil)
    p "create_back_menu:#{__LINE__}"
    label = CCLabelTTF.create(title, "Arial", 20)
    label.setColor(color) if color
    menu_item = CCMenuItemLabel.create(label)
    that = self
    handler ||= Proc.new {that.main_menu_callback}
    menu_item.registerScriptTapHandler(handler)
                                         
    s = CCDirector.sharedDirector.getWinSize
    menu = CCMenu.create
    menu.addChild(menu_item)
    menu.setPosition(0, 0)
    menu_item.setPosition(s.width - 50, 25)
    menu
  end

  @@LINE_SPACE = 40
  def self.LINE_SPACE
    @@LINE_SPACE
  end

  def initialize
    super
    @main_menu = CCMenu.create
    @cur_pos = Cocos2d::CCPoint.new(0, 0)
    @begin_pos = Cocos2d::CCPoint.new(0, 0)

    @all_tests = []
  end

  def tests_count
    @all_tests.size
  end

  # create scene
  def create_test_scene(idx)
    CCDirector.sharedDirector.purgeCachedData
    p "create_test_scene:#{idx}:#{@all_tests[idx].to_s}"
    @all_tests[idx].new.create
  end

  # handling touch events
  def on_touch_began(x, y)
    @begin_pos.x = x
    @begin_pos.y = y
    # CCTOUCHBEGAN event must return true
    true
  end

  def on_touch_moved(x, y)
    move_y = y - @begin_pos.y
    pos = @main_menu.getPosition
    cur_pos_x = pos.x
    cur_pos_y = pos.y
    next_pos_y = cur_pos_y + move_y
    win_size = CCDirector.sharedDirector.getWinSize
    if next_pos_y < 0
      @main_menu.setPosition(0, 0)
      return
    end

    if (tests_count + 1) * @@LINE_SPACE < win_size.height
      @main_menu.setPosition(0, 0)
      return
    end

    if next_pos_y > (tests_count + 1) * @@LINE_SPACE - win_size.height
      @main_menu.setPosition(0, (tests_count + 1) * @@LINE_SPACE - win_size.height)
      return
    end

    @main_menu.setPosition(cur_pos_x, next_pos_y)
    @begin_pos.x = x
    @begin_pos.y = y
    @cur_pos.x = cur_pos_x
    @cur_pos.y = next_pos_y
    true
  end

  # create menu
  def create_test_menu
    menu_layer = CCLayer.create

    close_callback = Proc.new {
      Cocos2d::CCDirector.sharedDirector.end
    }

    menu_callback = Proc.new { |tag|
      #p tag
      idx = tag.to_i - 10000
      test_scene = create_test_scene(idx)
      unless test_scene.nil?
        Cocos2d::CCDirector.sharedDirector.replaceScene(test_scene)
      end
    }

    # add close menu
    s = CCDirector.sharedDirector.getWinSize
    close_item = CCMenuItemImage.create($s_pPathClose, $s_pPathClose)
    close_item.registerScriptTapHandler(close_callback)
    close_item.setPosition(ccp(s.width - 30, s.height - 30))

    close_menu = CCMenu.create
    close_menu.setPosition(0, 0)
    close_menu.addChild(close_item)
    menu_layer.addChild(close_menu)

    # add menu item for tests
    index = 0
    @all_tests.each do |obj|
      test_label = Cocos2d::CCLabelTTF.create(obj.name, "Arial", 24)
      test_menu_item = Cocos2d::CCMenuItemLabel.create(test_label)
      test_menu_item.setEnabled(obj.supported?)
      test_menu_item.registerScriptTapHandler(menu_callback)
      test_menu_item.setPosition(ccp(s.width / 2, (s.height - (index + 1) * MenuBase.LINE_SPACE)))
      @main_menu.addChild(test_menu_item, index + 10000, index + 10000)
      index += 1
    end

    @main_menu.setContentSize(CCSizeMake(s.width, (tests_count + 1) * @@LINE_SPACE))
    @main_menu.setPosition(@cur_pos.x, @cur_pos.y)
    menu_layer.addChild(@main_menu)

    on_touch = ->(event_type, x, y) {
      #p "on_touch:#{event_type}"
      if event_type == 0 #began
        return on_touch_began(x, y)
      elsif event_type == 1 #moved
        return on_touch_moved(x, y)
      end
    }

    menu_layer.setTouchEnabled(true)
    menu_layer.registerScriptTouchHandler(on_touch, false, -1, false)
    #menu_layer.registerScriptTouchHandler(on_touch) #TODO:
    menu_layer
  end
end
