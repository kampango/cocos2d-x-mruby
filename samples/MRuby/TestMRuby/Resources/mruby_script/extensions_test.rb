require "mruby_script/menu_base"
require "mruby_script/test_base"
require "mruby_script/extensions_test/notification_center_test"
require "mruby_script/extensions_test/control_extension_test"
require "mruby_script/extensions_test/cocos_builder_test"
require "mruby_script/extensions_test/http_client_test"
require "mruby_script/extensions_test/web_socket_test"
require "mruby_script/extensions_test/edit_box_test"
require "mruby_script/extensions_test/table_view_test"
require "mruby_script/extensions_test/components_test"
require "mruby_script/extensions_test/armature_test"

class ExtensionsTest < MenuBase
  extend TestBaseExt
  self.supported = true

  def self.main_menu_callback
    scene = CCScene.create
    scene.addChild(self.new.create_test_menu)
    scene.addChild(MainMenu.create_back_menu_item)
    CCDirector.sharedDirector.replaceScene(scene)
  end

  def initialize
    super()
    @all_tests =
      [NotificationCenterTest,
       ControlExtensionTest,
       CocosBuilderTest,
       HttpClientTest,
       WebSocketTest,
       EditBoxTest,
       TableViewTest,
       ComponentsTest,
       ArmatureTest,
      ]
  end

  def create
    p self.class.to_s
    layer = create_test_menu
    scene = CCScene.create()
    scene.addChild(layer)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end
