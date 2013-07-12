require "mruby_script/menu_base"
require "mruby_script/test_base"

class PerformanceTest < MenuBase
  extend TestBaseExt
  self.supported = true

  class PerformBase < TestBase
    extend TestBaseExt

    def self.name
      "Performance" + self.to_s.split("::").pop
    end
    def create_back_menu_item
      PerformanceTest.create_back_menu_item("Back")
    end
  end
end

require "mruby_script/performance_test/node_children_test"
require "mruby_script/performance_test/particle_test"
require "mruby_script/performance_test/sprite_test"
require "mruby_script/performance_test/texture_test"
require "mruby_script/performance_test/touches_test"

class PerformanceTest
  def self.main_menu_callback
    scene = CCScene.create
    scene.addChild(self.new.create_test_menu)
    scene.addChild(MainMenu.create_back_menu_item)
    CCDirector.sharedDirector.replaceScene(scene)
  end

  def initialize
    super
    @all_tests = 
      [
       NodeChildrenTest,
       ParticleTest,
       SpriteTest,
       TextureTest,
       TouchesTest,
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
