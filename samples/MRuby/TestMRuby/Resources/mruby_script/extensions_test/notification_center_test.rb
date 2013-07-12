require "mruby_script/test_base"

class NotificationCenterTest < TestBase
  extend TestBaseExt
  self.supported = true

  module NotificationCenterParam
    @@MSG_SWITCH_STATE = "SwitchState"

    def self.kTagLight
      100
    end
    def self.kTagConnect
      200
    end

    def self.MSG_SWITCH_STATE
      @@MSG_SWITCH_STATE
    end
  end

  class Light < CCSprite
    include Cocos2d
    def self.create(path = nil)
      super(path || "Images/Pea.png")
    end

    def initialize
      @is_connected = false
    end
    def connected?
      @is_connected
    end

    def switch_on(on)
      setOpacity(if on && @is_connected then 255 else 50 end)
    end
    def connect(on, handler)
      @is_connected = on
      cclog("come in")
      notification_center = CCNotificationCenter.sharedNotificationCenter
      if @is_connected
        notification_center.registerScriptObserver(self, handler, NotificationCenterParam.MSG_SWITCH_STATE)
      else
        notification_center.unregisterScriptObserver(self, NotificationCenterParam.MSG_SWITCH_STATE)
      end
    end
  end

  def initialize
    super()
    that = self
    @switch_state_changed_handler = Proc.new {
      that.update_light_state
    }
  end

  def update_light_state
    @is_switch_on = @switch_item.getSelectedIndex != 0
    @lights.each do |light|
      light.switch_on(@is_switch_on)
    end
  end

  def connect_to_switch(tag, menu_item)
    idx = menu_item.getTag() - NotificationCenterParam.kTagConnect
    @lights[idx].connect(menu_item.getSelectedIndex != 0, @switch_state_changed_handler)
    update_light_state
  end

  def toggle_switch(tag, toggle_item)
    raise "XXX!:#{toggle_item.class}" unless toggle_item.instance_of? CCMenuItemToggle
    selected_item = if toggle_item.getSelectedIndex == 0 then nil else toggle_item.selectedItem end
    CCNotificationCenter.sharedNotificationCenter
      .postNotification(NotificationCenterParam.MSG_SWITCH_STATE, selected_item)
  end

  def create_to_main_menu
    to_main_layer = Proc.new {
      notification_center = CCNotificationCenter.sharedNotificationCenter
      num_removed = notification_center.removeAllObservers(@layer)
      cclog("All observers were not removed!") if 3 != num_removed
      @lights.each do |light|
        notification_center.unregisterScriptObserver(light, NotificationCenterParam.MSG_SWITCH_STATE)
      end

      @switch_state_changed_handler = nil
      @layer = nil

      scene = ExtensionsTest.new.create
      CCDirector.sharedDirector.replaceScene(scene)
    }
    ExtensionsTest.create_back_menu_item("Back", to_main_layer)
  end

  def init_with_layer(layer)
    super(layer)
    s = CCDirector.sharedDirector.getWinSize

    @switch_item = CCMenuItemToggle.create
    ["off", "on"].map {|v| CCLabelTTF.create("switch #{v}", "Marker Felt", 26) }
      .map {|label| CCMenuItemLabel.create(label) }
      .each do |item| @switch_item.addSubItem(item) end

    that = self
    @switch_item.registerScriptTapHandler(Proc.new {|tag, item| that.toggle_switch(tag, item) })
    # turn on
    @switch_item.setSelectedIndex(1)
    menu = CCMenu.create
    menu.addChild(@switch_item)
    menu.setPosition(ccp(s.width / 2 + 100, s.height / 2))
    layer.addChild(menu)

    menu_connect = CCMenu.create
    menu_connect.setPosition(ccp(0, 0))
    layer.addChild(menu_connect)

    @is_switch_on = false
    i = 0
    @lights = Array.new(3).map { Light.create }
    @lights.each do |light|
      light.setTag(i)
      light.setPosition(ccp(100, s.height / 4 * (i + 1)))
      layer.addChild(light)

      connect_item = CCMenuItemToggle.create
      ["not connected", "connected"].each do |str|
        label = CCLabelTTF.create(str, "Marker Felt", 26)
        item = CCMenuItemLabel.create(label)
        connect_item.addSubItem(item)
      end
      connect_item.setTag(NotificationCenterParam.kTagConnect + i)

      that = self
      connect_item.registerScriptTapHandler(Proc.new{|tag, connect_item| that.connect_to_switch(tag, connect_item)})
      pos = light.getPosition
      connect_item.setPosition(ccp(pos.x, pos.y + 50))

      menu_connect.addChild(connect_item, 0, connect_item.getTag())

      connect_item.setSelectedIndex(if i == 1 then 1 else 0 end)
      light.connect(connect_item.getSelectedIndex() == 1, @switch_state_changed_handler)

      i += 1
    end

    update_light_state

    notification_center = CCNotificationCenter.sharedNotificationCenter
    selected_item = if @switch_item.getSelectedIndex == 0 then nil else @switch_item.selectedItem end
    notification_center.postNotification(NotificationCenterParam.MSG_SWITCH_STATE, selected_item)

    to_main_menu = create_to_main_menu
    to_main_menu.setPosition(ccp(0, 0))
    layer.addChild(to_main_menu, 10)
    @layer = layer

    # for testing removeAllObservers
    do_nothing = Proc.new {}
    [1, 2, 3].each do |v|
      notification_center.registerScriptObserver(@layer, do_nothing, "random-observer#{v}")
    end

    @layer
  end
end
