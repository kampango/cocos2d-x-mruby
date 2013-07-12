require "mruby_script/cctype_helper"
require "mruby_script/main_menu"
require "mruby_script/test_base"

class UserDefaultTest < TestBase
  extend TestBaseExt
  self.supported = true

  def init_with_layer(layer)
    super(layer)
    @title_label.setString("CCUserDefault test see log")
    layer
  end

  def do_test
    cclog("********************** init value ***********************")

    # set default value
    default = CCUserDefault.sharedUserDefault()

    default.setStringForKey("string", "value1")
    default.setIntegerForKey("integer", 10)
    default.setFloatForKey("float", 2.3)
    default.setDoubleForKey("double", 2.4)
    default.setBoolForKey("bool", true)

    # print value

    ret = default.getStringForKey("string")
    cclog("string is %s", ret)

    d = default.getDoubleForKey("double")
    cclog("double is %f", d)

    i = default.getIntegerForKey("integer")
    cclog("integer is %d", i)

    f = default.getFloatForKey("float")
    cclog("float is %f", f)

    b = default.getBoolForKey("bool")
    if b == true then
        cclog("bool is true")
    else
        cclog("bool is false")
    end

    #default.flush()

    cclog("********************** after change value ***********************")

    # change the value

    default.setStringForKey("string", "value2")
    default.setIntegerForKey("integer", 11)
    default.setFloatForKey("float", 2.5)
    default.setDoubleForKey("double", 2.6)
    default.setBoolForKey("bool", false)

    default.flush()

    # print value

    ret = default.getStringForKey("string")
    cclog("string is %s", ret)

    d = default.getDoubleForKey("double")
    cclog("double is %f", d)

    i = default.getIntegerForKey("integer")
    cclog("integer is %d", i)

    f = default.getFloatForKey("float")
    cclog("float is %f", f)

    b = default.getBoolForKey("bool")
    if b == true then
        cclog("bool is true")
    else
        cclog("bool is false")
    end
  end

  def create
    scene = CCScene.create
    layer = CCLayer.create
    init_with_layer(layer)
    scene.addChild(layer)
    scene.addChild(MainMenu.create_back_menu_item)
    do_test
    scene
  end
end
