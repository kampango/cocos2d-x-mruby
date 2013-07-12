require "mruby_script/main_menu"
require "mruby_script/test_base"

class SpineTest < TestBase
  extend TestBaseExt
  include Cocos2d::Extension
  self.supported = true

  def init_with_layer(layer)
    super(layer)

	@skeletonNode = CCSkeletonAnimation.createWithFile("spine/spineboy.json",
                                                       "spine/spineboy.atlas",
                                                       1)
    @skeletonNode.setMix("walk", "jump", 0.4, 0)
    @skeletonNode.setMix("jump", "walk", 0.4, 0)
    @skeletonNode.setAnimation("walk", true, 0)

	@skeletonNode.timeScale = 0.3
	@skeletonNode.debugBones = true

    acts = CCArray.create
    [CCFadeOut.create(1), CCFadeIn.create(1), CCDelayTime.create(5)].each do |act|
      acts << act
    end
	@skeletonNode.runAction(CCRepeatForever.create(CCSequence.create(acts)))

	windowSize = @@size
	@skeletonNode.setPosition(ccp(windowSize.width / 2, 20))
	layer.addChild(@skeletonNode)

    that = self
	layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)
    layer
  end

  def update (deltaTime)
    if @skeletonNode.states[0].loop != 0
      if @skeletonNode.states[0].time > 2
        @skeletonNode.setAnimation("jump", false, 0)
      end
    else
      if @skeletonNode.states[0].time > 1
        @skeletonNode.setAnimation("walk", true, 0)
      end
    end
  end

  def create
    scene = CCScene.create
    layer = CCLayer.create
    init_with_layer(layer)
    scene.addChild(layer)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end

