require "mruby_script/cctype_helper"
require "mruby_script/test_resource"
require "mruby_script/menu_base"

require "mruby_script/actions_test"
require "mruby_script/transitions_test"
require "mruby_script/actions_progress_test"
require "mruby_script/effects_test"
require "mruby_script/click_and_move_test"
require "mruby_script/rotate_world_test"
require "mruby_script/particle_test"
require "mruby_script/actions_ease_test"
require "mruby_script/motion_streak_test"
require "mruby_script/draw_primitives_test"
require "mruby_script/node_test"
require "mruby_script/touches_test"
require "mruby_script/menu_test"
require "mruby_script/action_manager_test"
require "mruby_script/layer_test"
require "mruby_script/scene_test"
require "mruby_script/parallax_test"
require "mruby_script/tile_map_test"
require "mruby_script/interval_test"
require "mruby_script/label_test"
#require "mruby_script/text_input_test"
require "mruby_script/sprite_test"
require "mruby_script/scheduler_test"
require "mruby_script/render_texture_test"
require "mruby_script/texture2d_test"
#require "mruby_script/chipmunk_test"
#require "mruby_script/box2d_test"
#require "mruby_script/box2d_test_bed"
require "mruby_script/effect_advanced_test"
require "mruby_script/accelerometer_test"
require "mruby_script/keypad_test"
require "mruby_script/cocos_denshion_test"
require "mruby_script/performance_test"
require "mruby_script/zwoptex_test"
#require "mruby_script/curl_test"
require "mruby_script/user_default_test"
#require "mruby_script/bug_test"
require "mruby_script/font_test"
require "mruby_script/current_language_test"
require "mruby_script/texture_cache_test"
require "mruby_script/extensions_test"
require "mruby_script/shader_test"
require "mruby_script/multi_touch_test"
require "mruby_script/clipping_node_test"
require "mruby_script/file_utils_test"
require "mruby_script/spine_test"
require "mruby_script/texture_packer_encryption"
require "mruby_script/data_visitor_test"
require "mruby_script/configuration_test"

class MainMenu < MenuBase
  def initialize
    super
    p "#{__LINE__}:@main_menu:#{@main_menu.m_uID}:#{@main_menu.retainCount}:#{@main_menu.autoReleaseCount}"
    @all_tests =
      [
       ActionsTest,
       TransitionsTest,
       ActionsProgressTest,
       EffectsTest,
       ClickAndMoveTest,
       RotateWorldTest,
       ParticleTest,
       ActionsEaseTest,
       MotionStreakTest,
       DrawPrimitivesTest,
       NodeTest,
       TouchesTest,
       MenuTest,
       ActionManagerTest,
       LayerTest,
       SceneTest,
       ParallaxTest,
       TileMapTest,
       IntervalTest,
       LabelTest,
#require "mruby_script/text_input_test"
       SpriteTest,
       SchedulerTest,
       RenderTextureTest,
       Texture2dTest,
#require "mruby_script/chipmunk_test"
#require "mruby_script/box2d_test"
#require "mruby_script/box2d_test_bed"
       EffectAdvancedTest,
       AccelerometerTest,
       KeypadTest,
       CocosDenshionTest,
       PerformanceTest,
       ZwoptexTest,
#require "mruby_script/curl_test"
       UserDefaultTest,
#require "mruby_script/bug_test"
       FontTest,
       CurrentLanguageTest,
       TextureCacheTest,
       ExtensionsTest,
       ShaderTest,
       MultiTouchTest,
       ClippingNodeTest,
       FileUtilsTest,
       SpineTest,
       TexturePackerEncryption,
       DataVisitorTest,
       ConfigurationTest,
      ]
  end
end
