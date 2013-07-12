require "mruby_script/cctype_helper"
require "mruby_script/test_resource"

class TestBase
  include Cocos2d
  include CCTypeHelper

  @@size = CCDirector.sharedDirector.getWinSize

  def initialize
    @index = 0
    @create_function_table = []
    @current_layer = nil
    @title_label = nil
    @subtitle_label = nil
    @menu = nil
  end

  def menu
    @menu
  end

  def index
    @index
  end

  def register_create_function(obj, sym)
    @create_function_table.push({:obj => obj, :symbol => sym})
  end

  def next_action
    @index += 1
    @index = 0 if @index >= @create_function_table.size
    new_scene
  end
  
  def back_action
    @index -= 1
    @index = @create_function_table.size - 1 if @index < 0
    new_scene
  end
  
  def restart_action
    new_scene
  end

  def new_scene
    scene = CCScene.create

    info = @create_function_table[@index]
    p self if info.nil?
      
    @current_layer = info[:obj].send(info[:symbol])

    @menu.removeFromParent if @menu
    @menu = create_menu
    @current_layer.addChild(@menu, 1)

    scene.addChild(@current_layer)
    back_menu_item = if self.respond_to? :create_back_menu_item
                       self.create_back_menu_item
                     else
                       MainMenu.create_back_menu_item
                     end
    scene.addChild(back_menu_item)

    Cocos2d.dump_gv
    scene
  end

  def title_label
    @title_label
  end
  
  def subtitle_label
    @subtitle_label
  end

  def create_menu
    item1 = CCMenuItemImage.create($s_pPathB1, $s_pPathB2)
    item2 = CCMenuItemImage.create($s_pPathR1, $s_pPathR2)
    item3 = CCMenuItemImage.create($s_pPathF1, $s_pPathF2)
    that = self
    item1.registerScriptTapHandler(
      Proc.new {Cocos2d::CCDirector.sharedDirector.replaceScene(that.back_action)}
    )
    item2.registerScriptTapHandler(
      Proc.new {Cocos2d::CCDirector.sharedDirector.replaceScene(that.restart_action)}
    )
    item3.registerScriptTapHandler(
      Proc.new {Cocos2d::CCDirector.sharedDirector.replaceScene(that.next_action)}
    )

    menu = CCMenu.create
    menu.addChild(item1)
    menu.addChild(item2)
    menu.addChild(item3)
    menu.setPosition(CCPointMake(0, 0))
    item1.setPosition(CCPointMake(@@size.width / 2 - item2.getContentSize.width * 2, item2.getContentSize.height / 2))
    item2.setPosition(CCPointMake(@@size.width / 2, item2.getContentSize.height / 2))
    item3.setPosition(CCPointMake(@@size.width / 2 + item2.getContentSize.width * 2, item2.getContentSize.height / 2))

    if @create_function_table.size == 1
      item1.setVisible(false)
      item3.setVisible(false)
    end
    menu
  end
  
  def init_with_layer(layer)
    @current_layer = layer
    @title_label = CCLabelTTF.create("", "Arial", 28)
    layer.addChild(@title_label, 1)
    @title_label.setPosition(CCPointMake(@@size.width / 2, @@size.height - 50))

    @subtitle_label = CCLabelTTF.create("", "Thonburi", 16)
    layer.addChild(@subtitle_label, 1)
    @subtitle_label.setPosition(CCPointMake(@@size.width / 2, @@size.height - 80))

    background = CCLayer.create
    layer.addChild(background, -10)
    layer
  end

  def create
    cclog(self.class.to_s)
    scene = CCScene.create
    @layer = CCLayer.create

    init_with_layer(@layer)
    scene.addChild(@layer)
    scene
  end
end

module TestBaseExt
  @is_supported = false
  def name
    self.to_s
  end

  def supported?
    @is_supported
  end

  def supported=(is_supported)
    @is_supported = is_supported
  end
end
