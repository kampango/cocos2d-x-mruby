require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class KeypadTest < TestBase
  extend TestBaseExt
  self.supported = true

  def initialize
    super()
    register_create_function(self, :keypad_main_layer)
  end

  def keypad_main_layer
    layer = CCLayer.create
    init_with_layer(layer)

    s = CCDirector.sharedDirector.getWinSize

    @title_label.setString("Keypad Test")
    layer.setKeypadEnabled(true)
    # create a label to display the trip string
    label_tip = CCLabelTTF.create("Please press any key...", "Arial", 22)
    label_tip.setPosition(ccp(s.width / 2, s.height / 2))
    layer.addChild(label_tip, 0)

    #label_tip.retain()

    keypad_handler = ->(event_type) {
      p event_type
      case event_type
      when Cocos2d::kTypeBackClicked
        label_tip.setString("BACK clicked!")
      when Cocos2d::kTypeMenuClicked
        label_tip.setString("MENU clicked!")
      else
        p "unknown keypad event:#{event_type}"
      end
    }

    layer.registerScriptKeypadHandler(keypad_handler)
    layer
  end

  def create
    p self.class.to_s
    scene = CCScene.create
    scene.addChild(keypad_main_layer)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end
