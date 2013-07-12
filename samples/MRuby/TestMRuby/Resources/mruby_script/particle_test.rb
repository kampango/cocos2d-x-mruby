require "mruby_script/test_base"

class ParticleTestBase < TestBase
  extend TestBaseExt
  self.supported = true

  @@size = CCDirector.sharedDirector.getWinSize

  def create
    raise "don't call"
  end

  def initialize
    super()
    @base_layer_entry = nil
    @emitter = nil
    @label_atlas = nil
    @delegate = nil
    @background = nil
  end

  def delegate=(delegate)
    @delegate = delegate
  end
  def delegate
    @delegate
  end

  def next_action
    return unless @delegate
    @delegate.next_action
  end

  def back_action
    return unless @delegate
    @delegate.back_action
  end

  def restart_action
    return unless @delegate
    @delegate.restart_action
  end

  def toggle_callback(sender)
    return if @emitter.nil?
    case @emitter.getPositionType()
    when kCCPositionTypeGrouped
      @emitter.setPositionType(kCCPositionTypeFree)
    when kCCPositionTypeFree
      @emitter.setPositionType(kCCPositionTypeRelative)
    when kCCPositionTypeRelative
      @emitter.setPositionType(kCCPositionTypeGrouped)
    end
  end

  def set_emitter_position
    return if @emitter.nil?
    @emitter.setPosition(ccp(@@size.width / 2, @@size.height / 2))
  end

  def update(dt)
    return if @emitter.nil?
    @label_atlas.setString(@emitter.getParticleCount().to_s)
  end

  def on_enter_or_exit(tag)
    scheduler = CCDirector.sharedDirector().getScheduler()
    if tag == kCCNodeOnEnter
      that = self
      @base_layer_entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.update(dt)}, 0, false)
    elsif tag == kCCNodeOnExit
      scheduler.unscheduleScriptEntry(@base_layer_entry)
	end
  end

  def on_touch_ended(x, y)
    return if @emitter.nil?
    pos = unless @background.nil?
            @background.convertToWorldSpace(CCPointMake(0, 0))
          else
            CCPointMake(0, 0)
          end
    
    new_pos = ccpSub(CCPointMake(x, y), pos)
    @emitter.setPosition(new_pos.x, new_pos.y)
  end

  def on_touch(event_type, x, y)
    if event_type == CCTOUCHBEGAN
      return true
    else
      return on_touch_ended(x, y)
    end
  end

  def get_layer
    layer = CCLayerColor.create(ccc4(127,127,127,255))
    @emitter = nil
    init_with_layer(layer)

    title_label.setZOrder(100)
    title_label.setTag(1000)

    subtitle_label.setZOrder(100)

    s = @@size

    item4 = CCMenuItemToggle.create(CCMenuItemFont.create("Free Movement"))
    item4.addSubItem(CCMenuItemFont.create("Relative Movement"))
    item4.addSubItem(CCMenuItemFont.create("Grouped Movement"))
    that = self
    item4.registerScriptTapHandler(Proc.new {|sender| that.toggle_callback(sender)})

    unless @menu
      @menu = create_menu
      layer.addChild(@menu)
    end
    @menu.setZOrder(100)
    @menu.addChild(item4)
    item4.setPosition(ccp(0, 100))
    item4.setAnchorPoint(ccp(0, 0))

    @label_atlas = CCLabelAtlas.create("0000", "fps_images.png", 12, 32, ".".getbyte(0))
    layer.addChild(@label_atlas, 100)
    @label_atlas.setPosition(ccp(s.width - 66, 50))

    # moving background
    @background = CCSprite.create($s_back3)
    layer.addChild(@background, 5)
    @background.setPosition(ccp(s.width / 2, s.height - 180))

    move = CCMoveBy.create(4, ccp(300, 0))
    move_back = move.reverse()
    seq = CCSequence.createWithTwoActions(move, move_back)
    @background.runAction(CCRepeatForever.create(seq))

    that = self
    layer.setTouchEnabled(true)
    layer.registerScriptTouchHandler(Proc.new {|e, x, y| that.on_touch(e, x, y)}, false, -1, false)
    layer.registerScriptHandler(Proc.new {|tag| that.on_enter_or_exit(tag)})
    layer
  end
end

class ParticleTest < TestBase
  extend TestBaseExt
  self.supported = true

  def initialize
    super()
    @cur_obj = nil
    [
     ParticleReorder,
     ParticleBatchHybrid,
     ParticleBatchMultipleEmitters,
     DemoFlower,
     DemoGalaxy,
     DemoFirework,
     DemoSpiral,
     DemoSun,
     DemoMeteor,
     DemoFire,
     DemoSmoke,
     DemoExplosion,
     DemoSnow,
     DemoRain,
     DemoBigFlower,
     DemoRotFlower,
     DemoModernArt,
     DemoRing,
     ParallaxParticle,
     DemoFromFileBoilingFoam,
     DemoFromFileBurstPipe,
     DemoFromFileComet,
     DemoFromFiledebian,
     DemoFromFileExplodingRing,
     DemoFromFileLavaFlow,
     DemoFromFileSpinningPeas,
     DemoFromFileSpookyPeas,
     DemoFromFileUpsidedown,
     DemoFromFileFlower,
     DemoFromFileSpiral,
     DemoFromFileGalaxy,
     DemoFromFilePhoenix,
     DemoFromFilelines,
     RadiusMode1,
     RadiusMode2,
     Issue704,
     Issue870,
     #Issue1201,
     MultipleParticleSystems,
     MultipleParticleSystemsBatched,
     AddAndDeleteParticleSystems,
     ReorderParticleSystems,
     PremultipliedAlphaTest,
     PremultipliedAlphaTest2,
    ].each do |klass|
      register_create_function(klass, :get_layer)
    end
  end

  def new_scene
    scene = CCScene.create
    info = @create_function_table[@index]
    @cur_obj.delegate = nil unless @cur_obj.nil?
    @cur_obj = info[:obj].new
    @cur_obj.delegate = self
    @current_layer = @cur_obj.__send__(info[:symbol])
    scene.addChild(@current_layer)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end

  def create
    p self.class.to_s
    new_scene
  end
end

class ParticleReorder < ParticleTestBase
  def initialize
    super()
    @order = nil
    @entry = nil
    @layer = nil
  end

  def reorder_particles(dt)
    update(dt)

    [0, 1].each do |i|
      parent = @layer.getChildByTag(1000 + i)
      child1 = parent.getChildByTag(1)
      child2 = parent.getChildByTag(2)
      child3 = parent.getChildByTag(3)

      case @order % 3
      when 0
        parent.reorderChild(child1, 1)
        parent.reorderChild(child2, 2)
        parent.reorderChild(child3, 3)

      when 1
        parent.reorderChild(child1, 3)
        parent.reorderChild(child2, 1)
        parent.reorderChild(child3, 2)

      when 2
        parent.reorderChild(child1, 2)
        parent.reorderChild(child2, 3)
        parent.reorderChild(child3, 1)
      end
    end
    @order += 1
  end

  def on_enter_or_exit(tag)
    scheduler = CCDirector.sharedDirector().getScheduler()
    if tag == kCCNodeOnEnter
      that = self
      @entry = scheduler.scheduleScriptFunc(Proc.new {|dt|
                                              p self.to_s
                                              p that.to_s
                                              that.reorder_particles(dt)}, 1.0, false)
    elsif tag == kCCNodeOnExit
      scheduler.unscheduleScriptEntry(@entry)
    end
  end

  def get_layer
    @layer = super()

    @order = 0
    @layer.setColor(ccc3(0, 0, 0))
    @layer.removeChild(@background, true)
    @background = nil

    s = @@size

    ignore = CCParticleSystemQuad.create("Particles/SmallSun.plist")
    parent1 = CCNode.create()
    parent2 = CCParticleBatchNode.createWithTexture(ignore.getTexture(), kCCParticleDefaultCapacity)
    ignore.unscheduleUpdate()

    i = 0
    [parent1, parent2].each do |parent|
      emitter1 = CCParticleSystemQuad.create("Particles/SmallSun.plist")
      emitter1.setStartColor(ccc4f(1,0,0,1))
      emitter1.setBlendAdditive(false)
      emitter2 = CCParticleSystemQuad.create("Particles/SmallSun.plist")
      emitter2.setStartColor(ccc4f(0,1,0,1))
      emitter2.setBlendAdditive(false)
      emitter3 = CCParticleSystemQuad.create("Particles/SmallSun.plist")
      emitter3.setStartColor(ccc4f(0,0,1,1))
      emitter3.setBlendAdditive(false)

      neg = if parent == parent1 then 1 else -1 end

      emitter1.setPosition(ccp( s.width / 2 - 30, s.height / 2 + 60 * neg))
      emitter2.setPosition(ccp( s.width / 2, s.height / 2 + 60 * neg))
      emitter3.setPosition(ccp( s.width / 2 + 30, s.height / 2 + 60 * neg))

      parent.addChild(emitter1, 0, 1)
      parent.addChild(emitter2, 0, 2)
      parent.addChild(emitter3, 0, 3)

      @layer.addChild(parent, 10, 1000 + i)
      i += 1
    end

    that = self
    @layer.registerScriptHandler(Proc.new {|tag| that.on_enter_or_exit(tag)})

    title_label.setString("Reordering particles")
    subtitle_label.setString("Reordering particles with and without batches batches")
    @layer
  end
end

class ParticleBatchHybrid < ParticleTestBase
  def initialize
    super()
    @entry = nil
    @parent1 = @parent2 = nil
  end

  def switch_render(dt)
	update(dt)

    cond = !@emitter.getBatchNode().nil?
    @emitter.removeFromParentAndCleanup(false)
    str = "Particle: Using new parent: "
    newParent = nil
    if cond
      newParent = @parent2
      str += "CCNode"
    else
      newParent = @parent1
      str += "CCParticleBatchNode"
    end
    newParent.addChild(@emitter)
    cclog(str)
  end

  def on_enter_or_exit(tag)
    scheduler = CCDirector.sharedDirector().getScheduler()
    if tag == kCCNodeOnEnter
      that = self
      @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.switch_render(dt)}, 2.0, false)
    elsif tag == kCCNodeOnExit
      scheduler.unscheduleScriptEntry(@entry)
    end
  end

  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    @emitter = CCParticleSystemQuad.create("Particles/LavaFlow.plist")
    batch = CCParticleBatchNode.createWithTexture(@emitter.getTexture(), kCCParticleDefaultCapacity)
    batch.addChild(@emitter)
    layer.addChild(batch, 10)

    node = CCNode.create
    layer.addChild(node)
    @parent1 = batch
    @parent2 = node

    that = self
    layer.registerScriptHandler(Proc.new {|tag| that.on_enter_or_exit(tag)})

    title_label.setString("Paticle Batch")
    subtitle_label.setString("Hybrid: batched and non batched every 2 seconds")
    layer
  end
end

class ParticleBatchMultipleEmitters < ParticleTestBase
  def get_layer
    layer = super()
    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    s = @@size

    emitter1 = CCParticleSystemQuad.create("Particles/LavaFlow.plist")
    emitter1.setStartColor(ccc4f(1,0,0,1))
    emitter2 = CCParticleSystemQuad.create("Particles/LavaFlow.plist")
    emitter2.setStartColor(ccc4f(0,1,0,1))
    emitter3 = CCParticleSystemQuad.create("Particles/LavaFlow.plist")
    emitter3.setStartColor(ccc4f(0,0,1,1))

    emitter1.setPosition(ccp(s.width / 1.25, s.height / 1.25))
    emitter2.setPosition(ccp(s.width / 2, s.height / 2))
    emitter3.setPosition(ccp(s.width / 4, s.height / 4))

    batch = CCParticleBatchNode.createWithTexture(emitter1.getTexture(), kCCParticleDefaultCapacity)

    batch.addChild(emitter1, 0)
    batch.addChild(emitter2, 0)
    batch.addChild(emitter3, 0)

    layer.addChild(batch, 10)

    title_label.setString("Paticle Batch")
    subtitle_label.setString("Multiple emitters. One Batch")
    layer
  end
end

class DemoFlower < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleFlower.create()
    @background.addChild(@emitter, 10)
    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_stars1))

    set_emitter_position()

    title_label.setString("ParticleFlower")
    layer
  end
end

class DemoGalaxy < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleGalaxy.create()
    @background.addChild(@emitter, 10)

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))

    set_emitter_position()

    title_label.setString("ParticleGalaxy")
    layer
  end
end

class DemoFirework < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleFireworks.create()
    @background.addChild(@emitter, 10)

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_stars1))

    set_emitter_position()

    title_label.setString("ParticleFireworks")
    layer
  end
end

class DemoSpiral < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleSpiral.create()
    @background.addChild(@emitter, 10)

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))

    set_emitter_position()

    title_label.setString("ParticleSpiral")
    layer
  end
end

class DemoSun < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleSun.create()
    @background.addChild(@emitter, 10)

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))

    set_emitter_position()

    title_label.setString("ParticleSun")
    layer
  end
end

class DemoMeteor < ParticleTestBase
  def get_layer
    layer = super()

	@emitter = CCParticleMeteor.create()
    @background.addChild(@emitter, 10)

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))

    set_emitter_position()

    title_label.setString("ParticleMeteor")
    layer
  end
end

class DemoFire < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleFire.create()
    @background.addChild(@emitter, 10)

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))
    pos = @emitter.getPosition()
    @emitter.setPosition(pos.x, 100)

    title_label.setString("ParticleFire")
    layer
  end
end

class  DemoSmoke < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleSmoke.create()
    @background.addChild(@emitter, 10)
    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))

    pos = @emitter.getPosition()
    @emitter.setPosition(pos.x, 100)

    set_emitter_position()

    title_label.setString("ParticleSmoke")
    layer
  end
end

class DemoExplosion < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleExplosion.create()
    @background.addChild(@emitter, 10)

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_stars1))

    @emitter.setAutoRemoveOnFinish(true)

    set_emitter_position()

    title_label.setString("ParticleExplosion")
    layer
  end
end

class DemoSnow < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleSnow.create()
    @background.addChild(@emitter, 10)

    pos = @emitter.getPosition()
    @emitter.setPosition(ccp(pos.x, pos.y - 110))
    @emitter.setLife(3)
    @emitter.setLifeVar(1)

    # gravity
    @emitter.setGravity(CCPointMake(0, -10))

    # speed of particles
    @emitter.setSpeed(130)
    @emitter.setSpeedVar(30)

    startColor = @emitter.getStartColor()
    startColor.r = 0.9
    startColor.g = 0.9
    startColor.b = 0.9
    @emitter.setStartColor(startColor)

    startColorVar = @emitter.getStartColorVar()
    startColorVar.b = 0.1
    @emitter.setStartColorVar(startColorVar)

    @emitter.setEmissionRate(@emitter.getTotalParticles() / @emitter.getLife())

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_snow))

    set_emitter_position()

    title_label.setString("ParticleSnow")
    layer
  end
end

class DemoRain < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleRain.create()
    @background.addChild(@emitter, 10)

    pos = @emitter.getPosition()
    @emitter.setPosition(ccp(pos.x, pos.y - 100))
    @emitter.setLife(4)

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))

    set_emitter_position()

    title_label.setString("ParticleRain")
    layer
  end
end

class DemoBigFlower < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleSystemQuad.new()
    @emitter.initWithTotalParticles(50)

    @background.addChild(@emitter, 10)
    @emitter.setTexture( CCTextureCache.sharedTextureCache().addImage($s_stars1) )
    @emitter.setDuration(-1)

    # gravity
    @emitter.setGravity(CCPointMake(0, 0))

    # angle
    @emitter.setAngle(90)
    @emitter.setAngleVar(360)

    # speed of particles
    @emitter.setSpeed(160)
    @emitter.setSpeedVar(20)

    # radial
    @emitter.setRadialAccel(-120)
    @emitter.setRadialAccelVar(0)

    # tagential
    @emitter.setTangentialAccel(30)
    @emitter.setTangentialAccelVar(0)

    # emitter position
    @emitter.setPosition(ccp(160, 240))
    @emitter.setPosVar(ccp(0, 0))

    # life of particles
    @emitter.setLife(4)
    @emitter.setLifeVar(1)

    # spin of particles
    @emitter.setStartSpin(0)
    @emitter.setStartSizeVar(0)
    @emitter.setEndSpin(0)
    @emitter.setEndSpinVar(0)

    # color of particles
    @emitter.setStartColor(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setStartColorVar(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setEndColor(ccc4f(0.1, 0.1, 0.1, 0.2))
    @emitter.setEndColorVar(ccc4f(0.1, 0.1, 0.1, 0.2))

    # size, in pixels
    @emitter.setStartSize(80.0)
    @emitter.setStartSizeVar(40.0)
    @emitter.setEndSize(kParticleStartSizeEqualToEndSize)

    # emits per second
    @emitter.setEmissionRate(@emitter.getTotalParticles() / @emitter.getLife())

    # additive
    @emitter.setBlendAdditive(true)

    set_emitter_position()

    title_label.setString("ParticleBigFlower")
    layer
  end
end

class DemoRotFlower < ParticleTestBase
  def get_layer
    layer = super()

    @emitter = CCParticleSystemQuad.new()
    @emitter.initWithTotalParticles(300)
    @background.addChild(@emitter, 10)
    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_stars2))

    # duration
    @emitter.setDuration(-1)

    # gravity
    @emitter.setGravity(ccp(0, 0))

    # angle
    @emitter.setAngle(90)
    @emitter.setAngleVar(360)

    # speed of particles
    @emitter.setSpeed(160)
    @emitter.setSpeedVar(20)

    # radial
    @emitter.setRadialAccel(-120)
    @emitter.setRadialAccelVar(0)

    # tagential
    @emitter.setTangentialAccel(30)
    @emitter.setTangentialAccelVar(0)

    # emitter position
    @emitter.setPosition(ccp(160, 240))
    @emitter.setPosVar(ccp(0, 0))

    # life of particles
    @emitter.setLife(3)
    @emitter.setLifeVar(1)

    # spin of particles
    @emitter.setStartSpin(0)
    @emitter.setStartSpinVar(0)
    @emitter.setEndSpin(0)
    @emitter.setEndSpinVar(2000)

    # color of particles
	@emitter.setStartColor(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setStartColorVar(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setEndColor(ccc4f(0.1, 0.1, 0.1, 0.2))
    @emitter.setEndColorVar(ccc4f(0.1, 0.1, 0.1, 0.2))

    # size, in pixels
    @emitter.setStartSize(30.0)
    @emitter.setStartSizeVar(0)
    @emitter.setEndSize(kParticleStartSizeEqualToEndSize)

    # emits per second
    @emitter.setEmissionRate(@emitter.getTotalParticles() / @emitter.getLife())

    # additive
    @emitter.setBlendAdditive(false)

    set_emitter_position()

	title_label.setString("ParticleRotFlower")
    layer
  end
end

class DemoModernArt < ParticleTestBase
  def get_layer
    layer = super()

    s = @@size

    @emitter = CCParticleSystemQuad.new()
    @emitter.initWithTotalParticles(1000)
    @background.addChild(@emitter, 10)

    # duration
    @emitter.setDuration(-1)

    # gravity
    @emitter.setGravity(CCPointMake(0,0))

    # angle
    @emitter.setAngle(0)
    @emitter.setAngleVar(360)

    # radial
    @emitter.setRadialAccel(70)
    @emitter.setRadialAccelVar(10)

    # tagential
    @emitter.setTangentialAccel(80)
    @emitter.setTangentialAccelVar(0)

    # speed of particles
    @emitter.setSpeed(50)
    @emitter.setSpeedVar(10)

    # emitter position
    @emitter.setPosition(ccp(s.width / 2, s.height / 2))
    @emitter.setPosVar(ccp(0, 0))

    # life of particles
    @emitter.setLife(2.0)
    @emitter.setLifeVar(0.3)

    # emits per frame
    @emitter.setEmissionRate(@emitter.getTotalParticles() / @emitter.getLife())

    # color of particles
	@emitter.setStartColor(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setStartColorVar(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setEndColor(ccc4f(0.1, 0.1, 0.1, 0.2))
    @emitter.setEndColorVar(ccc4f(0.1, 0.1, 0.1, 0.2))

    # size, in pixels
    @emitter.setStartSize(1.0)
    @emitter.setStartSizeVar(1.0)
    @emitter.setEndSize(32.0)
    @emitter.setEndSizeVar(8.0)

    # texture
    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))

    # additive
    @emitter.setBlendAdditive(false)

    set_emitter_position()

    title_label.setString("Varying size")
    layer
  end
end

class DemoRing < ParticleTestBase
  def get_layer
    layer = super()

    s = @@size

    @emitter = CCParticleFlower.create()
    @background.addChild(@emitter, 10)

    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_stars1))
    @emitter.setLifeVar(0)
    @emitter.setLife(10)
    @emitter.setSpeed(100)
    @emitter.setSpeedVar(0)
    @emitter.setEmissionRate(10000)

    set_emitter_position()

    title_label.setString("Ring Demo")
    layer
  end
end

class ParallaxParticle < ParticleTestBase
  def get_layer
    layer = super()

    @background.getParent().removeChild(@background, true)
    @background = nil

    p = CCParallaxNode.create()
    layer.addChild(p, 5)

    p1 = CCSprite.create($s_back3)
    p2 = CCSprite.create($s_back3)

    p.addChild(p1, 1, CCPointMake(0.5, 1), CCPointMake(0, 250))
    p.addChild(p2, 2, CCPointMake(1.5, 1), CCPointMake(0, 50))

    @emitter = CCParticleFlower.create()
    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))

    p1.addChild(@emitter, 10)
    @emitter.setPosition(ccp(250, 200))

    par = CCParticleSun.create()
    p2.addChild(par, 10)
    par.setTexture(CCTextureCache.sharedTextureCache().addImage($s_fire))

    move = CCMoveBy.create(4, CCPointMake(300,0))
    move_back = move.reverse()
    seq = CCSequence.createWithTwoActions(move, move_back)
    p.runAction(CCRepeatForever.create(seq))

    title_label.setString("Parallax + Particles")
    layer
  end
end

class DemoFromFileBoilingFoam < ParticleTestBase
  def get_layer
    layer = super()

    name = self.class.to_s["DemoFromFile".size .. -1]

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    @emitter = CCParticleSystemQuad.new()
    filename = "Particles/#{name}.plist"
    @emitter.initWithFile(filename)
    layer.addChild(@emitter, 10)

    set_emitter_position()

    title_label.setString(name)
    layer
  end
end

class DemoFromFileBurstPipe < DemoFromFileBoilingFoam
end
class DemoFromFileComet < DemoFromFileBoilingFoam
end
class DemoFromFiledebian < DemoFromFileBoilingFoam
end
class DemoFromFileExplodingRing < DemoFromFileBoilingFoam
end
class DemoFromFileLavaFlow < DemoFromFileBoilingFoam
end
class DemoFromFileSpinningPeas < DemoFromFileBoilingFoam
end
class DemoFromFileSpookyPeas < DemoFromFileBoilingFoam
end
class DemoFromFileUpsidedown < DemoFromFileBoilingFoam
end
class DemoFromFileFlower < DemoFromFileBoilingFoam
end
class DemoFromFileSpiral < DemoFromFileBoilingFoam
end
class DemoFromFileGalaxy < DemoFromFileBoilingFoam
end
class DemoFromFilePhoenix < DemoFromFileBoilingFoam
end
class DemoFromFilelines < DemoFromFileBoilingFoam
end

class RadiusMode1 < ParticleTestBase
  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    @emitter = CCParticleSystemQuad.new()
    @emitter.initWithTotalParticles(200)
    layer.addChild(@emitter, 10)
    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage("Images/stars-grayscale.png"))

    s = @@size

    # duration
    @emitter.setDuration(kCCParticleDurationInfinity)

    # radius mode
    @emitter.setEmitterMode(kCCParticleModeRadius)

    # radius mode: start and end radius in pixels
    @emitter.setStartRadius(0)
    @emitter.setStartRadiusVar(0)
    @emitter.setEndRadius(160)
    @emitter.setEndRadiusVar(0)

    # radius mode: degrees per second
    @emitter.setRotatePerSecond(180)
    @emitter.setRotatePerSecondVar(0)


    # angle
    @emitter.setAngle(90)
    @emitter.setAngleVar(0)

    # emitter position
    @emitter.setPosition(ccp(s.width / 2, s.height / 2))
    @emitter.setPosVar(ccp(0, 0))

    # life of particles
    @emitter.setLife(5)
    @emitter.setLifeVar(0)

    # spin of particles
    @emitter.setStartSpin(0)
    @emitter.setStartSpinVar(0)
    @emitter.setEndSpin(0)
    @emitter.setEndSpinVar(0)

    # color of particles
    @emitter.setStartColor(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setStartColorVar(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setEndColor(ccc4f(0.1, 0.1, 0.1, 0.2))
    @emitter.setEndColorVar(ccc4f(0.1, 0.1, 0.1, 0.2))

    # size, in pixels
    @emitter.setStartSize(32)
    @emitter.setStartSizeVar(0)
    @emitter.setEndSize(kCCParticleStartSizeEqualToEndSize)

    # emits per second
    @emitter.setEmissionRate(@emitter.getTotalParticles() / @emitter.getLife())

    # additive
    @emitter.setBlendAdditive(false)

    title_label.setString("Radius Mode: Spiral")
    layer
  end
end

class RadiusMode2 < ParticleTestBase
  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    @emitter = CCParticleSystemQuad.new()
    @emitter.initWithTotalParticles(200)
    layer.addChild(@emitter, 10)
    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage("Images/stars-grayscale.png"))

    s = @@size

    # duration
    @emitter.setDuration(kCCParticleDurationInfinity)

    # radius mode
    @emitter.setEmitterMode(kCCParticleModeRadius)

    # radius mode: start and end radius in pixels
    @emitter.setStartRadius(100)
    @emitter.setStartRadiusVar(0)
    @emitter.setEndRadius(kCCParticleStartRadiusEqualToEndRadius)
    @emitter.setEndRadiusVar(0)

    # radius mode: degrees per second
    @emitter.setRotatePerSecond(45)
    @emitter.setRotatePerSecondVar(0)

    # angle
    @emitter.setAngle(90)
    @emitter.setAngleVar(0)

    # emitter position
    @emitter.setPosition(ccp(s.width / 2, s.height / 2))
    @emitter.setPosVar(ccp(0, 0))

    # life of particles
    @emitter.setLife(4)
    @emitter.setLifeVar(0)

    # spin of particles
    @emitter.setStartSpin(0)
    @emitter.setStartSpinVar(0)
    @emitter.setEndSpin(0)
    @emitter.setEndSpinVar(0)

    # color of particles
    @emitter.setStartColor(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setStartColorVar(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setEndColor(ccc4f(0.1, 0.1, 0.1, 0.2))
    @emitter.setEndColorVar(ccc4f(0.1, 0.1, 0.1, 0.2))

    # size, in pixels
    @emitter.setStartSize(32)
    @emitter.setStartSizeVar(0)
    @emitter.setEndSize(kCCParticleStartSizeEqualToEndSize)

    # emits per second
    @emitter.setEmissionRate(@emitter.getTotalParticles() / @emitter.getLife())

    # additive
    @emitter.setBlendAdditive(false)

    title_label.setString("Radius Mode. Semi Circle")
    layer
  end
end

class Issue704 < ParticleTestBase
  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    @emitter = CCParticleSystemQuad.new()
    @emitter.initWithTotalParticles(100)
    layer.addChild(@emitter, 10)
    @emitter.setTexture(CCTextureCache.sharedTextureCache().addImage("Images/fire.png"))

    s = @@size

    # duration
    @emitter.setDuration(kCCParticleDurationInfinity)

    # radius mode
    @emitter.setEmitterMode(kCCParticleModeRadius)

    # radius mode: start and end radius in pixels
    @emitter.setStartRadius(50)
    @emitter.setStartRadiusVar(0)
    @emitter.setEndRadius(kCCParticleStartRadiusEqualToEndRadius)
    @emitter.setEndRadiusVar(0)

    # radius mode: degrees per second
    @emitter.setRotatePerSecond(0)
    @emitter.setRotatePerSecondVar(0)


    # angle
    @emitter.setAngle(90)
    @emitter.setAngleVar(0)

    # emitter position
    @emitter.setPosition(ccp(s.width / 2, s.height / 2))
    @emitter.setPosVar(ccp(0, 0))

    # life of particles
    @emitter.setLife(5)
    @emitter.setLifeVar(0)

    # spin of particles
    @emitter.setStartSpin(0)
    @emitter.setStartSpinVar(0)
    @emitter.setEndSpin(0)
    @emitter.setEndSpinVar(0)

    # color of particles
    @emitter.setStartColor(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setStartColorVar(ccc4f(0.5, 0.5, 0.5, 1.0))
    @emitter.setEndColor(ccc4f(0.1, 0.1, 0.1, 0.2))
    @emitter.setEndColorVar(ccc4f(0.1, 0.1, 0.1, 0.2))

    # size, in pixels
    @emitter.setStartSize(16)
    @emitter.setStartSizeVar(0)
    @emitter.setEndSize(kCCParticleStartSizeEqualToEndSize)

    # emits per second
    @emitter.setEmissionRate(@emitter.getTotalParticles() / @emitter.getLife())

    # additive
    @emitter.setBlendAdditive(false)

    rot = CCRotateBy.create(16, 360)
    @emitter.runAction(CCRepeatForever.create(rot))

    title_label.setString("Issue 704. Free + Rot")
    subtitle_label.setString("Emitted particles should not rotate")
    layer
  end
end

class Issue870 < ParticleTestBase
  def initialize
    super()
    @x_index = 0
    @entry = nil
  end

  def update_quads(dt)
    update(dt)

    @x_index = (@x_index + 1) % 4
    rect = CCRectMake(@x_index * 32, 0, 32, 32)
    @emitter.setTextureWithRect(@emitter.getTexture(), rect)
  end

  def on_enter_or_exit(tag)
    scheduler = CCDirector.sharedDirector().getScheduler()
	if tag == kCCNodeOnEnter
      that = self
      @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.update_quads(dt)}, 2.0, false)
    elsif tag == kCCNodeOnExit
      scheduler.unscheduleScriptEntry(@entry)
    end
  end

  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    system = CCParticleSystemQuad.new()
    system.initWithFile("Particles/SpinningPeas.plist")
    system.setTextureWithRect(CCTextureCache.sharedTextureCache().addImage("Images/particles.png"), CCRectMake(0,0,32,32))
    layer.addChild(system, 10)
    @emitter = system

    @x_index = 0
    that = self
    layer.registerScriptHandler(Proc.new {|tag| that.on_enter_or_exit(tag)})

    title_label.setString("Issue 870. SubRect")
    subtitle_label.setString("Every 2 seconds the particle should change")
    layer
  end
end

class MultipleParticleSystems < ParticleTestBase
  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    CCTextureCache.sharedTextureCache().addImage("Images/particles.png")

    i = 0
    while (i <= 4)
      particle_system = CCParticleSystemQuad.create("Particles/SpinningPeas.plist")
      particle_system.setPosition(i * 50, i * 50)
      particle_system.setPositionType(kCCPositionTypeGrouped)
      layer.addChild(particle_system)
      i += 1
    end

    @emitter = nil

    title_label.setString("Multiple particle systems")
    subtitle_label.setString("v1.1 test. FPS should be lower than next test")
    layer
  end
end

class MultipleParticleSystemsBatched < ParticleTestBase
  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    batch_node = CCParticleBatchNode.createWithTexture(nil, 3000)
    layer.addChild(batch_node, 1, 2)

    Array.new(4).each_index do |i|
      particle_system = CCParticleSystemQuad.create("Particles/SpinningPeas.plist")
      particle_system.setPositionType(kCCPositionTypeGrouped)
      particle_system.setPosition(i * 50, i * 50)
      batch_node.setTexture(particle_system.getTexture())
      batch_node.addChild(particle_system)
    end

    @emitter = nil

	title_label.setString("Multiple particle systems batched")
	subtitle_label.setString("v1.1 test: should perform better than previous test")
    layer
  end
end

class AddAndDeleteParticleSystems < ParticleTestBase
  def initialize
    super()
    @entry = nil
    @batch_node = nil
  end

  def remove_system(dt)
    update(dt)

    children_count = @batch_node.getChildren().count()
    if children_count > 0
      cclog("remove random system")
      rand = (rand(999998) + 1) % (children_count - 1)
      @batch_node.removeChild(@batch_node.getChildren().objectAtIndex(rand), true)

      # add new
      particle_system = CCParticleSystemQuad.create("Particles/Spiral.plist")
      particle_system.setPositionType(kCCPositionTypeGrouped)
      particle_system.setTotalParticles(200)

      particle_system.setPosition((rand(999998) + 1) % 300, (rand(999998) + 1) % 400)

      cclog("add a new system")
      randZ = (rand() * 100).floor
      that = self
      @batch_node.addChild(particle_system, randZ, -1)
    end
  end

  def on_enter_or_exit(tag)
    scheduler = CCDirector.sharedDirector().getScheduler()
    if tag == kCCNodeOnEnter
      that = self
      @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.remove_system(dt)}, 2.0, false)
    elsif tag == kCCNodeOnExit
      scheduler.unscheduleScriptEntry(@entry)
    end
  end

  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    #adds the texture inside the plist to the texture cache
    @batch_node = CCParticleBatchNode.createWithTexture(nil, 16000)

    layer.addChild(@batch_node, 1, 2)
    
    i = 0
    while (i <= 5)
      particle_system = CCParticleSystemQuad.create("Particles/Spiral.plist")
      @batch_node.setTexture(particle_system.getTexture())

      particle_system.setPositionType(kCCPositionTypeGrouped)
      particle_system.setTotalParticles(200)

      particle_system.setPosition(ccp(i * 15 + 100, i * 15 + 100))

      randZ = (rand() * 100).floor
      @batch_node.addChild(particle_system, randZ, -1)
      i += 1
	end

    that = self
    layer.registerScriptHandler(Proc.new {|tag| that.on_enter_or_exit(tag)})
    @emitter = nil

    title_label.setString("Add and remove Particle System")
    subtitle_label.setString("v1.1 test. every 2 sec 1 system disappear, 1 appears")
    layer
  end
end

#---------------------------------
#--  ReorderParticleSystems *
#--    problem
#---------------------------------
class ReorderParticleSystems < ParticleTestBase
  def initialize
    super()
    @entry = nil
    @batch_node = nil
  end

  def reorder_system(dt)
    update(dt)

    child = @batch_node.getChildren().randomObject()
    # problem: there's no getZOrder() for CCObject
    #@batch_node.reorderChild(child, child.getZOrder() - 1)
    @batch_node.reorderChild(child, rand(99999))
  end

  def on_enter_or_exit(tag)
    scheduler = CCDirector.sharedDirector().getScheduler()
    if tag == kCCNodeOnEnter
      that = self
      @entry = scheduler.scheduleScriptFunc(Proc.new {|dt| that.reorder_system(dt)}, 2.0, false)
    elsif tag == kCCNodeOnExit
      scheduler.unscheduleScriptEntry(@entry)
    end
  end

  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    @batch_node = CCParticleBatchNode.create("Images/stars-grayscale.png", 3000)

    layer.addChild(@batch_node, 1, 2)

    Array.new(3).each_index do |i|
      particle_system = CCParticleSystemQuad.new()
      particle_system.initWithTotalParticles(200)
      particle_system.setTexture(@batch_node.getTexture())

      # duration
      particle_system.setDuration(kCCParticleDurationInfinity)

      # radius mode
      particle_system.setEmitterMode(kCCParticleModeRadius)

      # radius mode: 100 pixels from center
      particle_system.setStartRadius(100)
      particle_system.setStartRadiusVar(0)
      particle_system.setEndRadius(kCCParticleStartRadiusEqualToEndRadius)
      particle_system.setEndRadiusVar(0)    # not used when start == end

      # radius mode: degrees per second
      # 45 * 4 seconds of life = 180 degrees
      particle_system.setRotatePerSecond(45)
      particle_system.setRotatePerSecondVar(0)

      # angle
      particle_system.setAngle(90)
      particle_system.setAngleVar(0)

      # emitter position
      particle_system.setPosVar(ccp(0, 0))

      # life of particles
      particle_system.setLife(4)
      particle_system.setLifeVar(0)

      # spin of particles
      particle_system.setStartSpin(0)
      particle_system.setStartSpinVar(0)
      particle_system.setEndSpin(0)
      particle_system.setEndSpinVar(0)

      # color of particles
      start_color = CC_ccColor4F.new()
      start_color.r = 0
      start_color.g = 0
      start_color.b = 0
      start_color.a = 1
      if i == 0 then start_color.r = 1
      elsif i == 1 then start_color.g = 1
      elsif i == 2 then start_color.b = 1
      end

      particle_system.setStartColor(start_color)
      particle_system.setStartColorVar(ccc4f(0, 0, 0, 0))

      end_color = start_color
      particle_system.setEndColor(end_color)
      particle_system.setEndColorVar(ccc4f(0, 0, 0, 0))

      # size, in pixels
      particle_system.setStartSize(32)
      particle_system.setStartSizeVar(0)
      particle_system.setEndSize(kCCParticleStartSizeEqualToEndSize)

      # emits per second
      particle_system.setEmissionRate(particle_system.getTotalParticles() / particle_system.getLife())

      # additive
      particle_system.setPosition(i * 10 + 120, 200)

      @batch_node.addChild(particle_system)
      particle_system.setPositionType(kCCPositionTypeFree)
    end

    that = self
    layer.registerScriptHandler(Proc.new {|tag| that.on_enter_or_exit(tag)})
    @emitter = nil

    title_label.setString("reorder systems")
    subtitle_label.setString("changes every 2 seconds")
    layer
  end
end

class PremultipliedAlphaTest < ParticleTestBase
  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 255))
    layer.removeChild(@background, true)
    @background = nil

    @emitter = CCParticleSystemQuad.create("Particles/BoilingFoam.plist")

    tBlendFunc = CC_ccBlendFunc.new()
	tBlendFunc.src = 1 #GL_ONE
	tBlendFunc.dst = 0x0303 #GL_ONE_MINUS_SRC_ALPHA
    @emitter.setBlendFunc(tBlendFunc)

    # assert(@emitter.getOpacityModifyRGB(), "Particle texture does not have premultiplied alpha, test is useless")

    @emitter.setStartColor(ccc4f(1, 1, 1, 1))
    @emitter.setEndColor(ccc4f(1, 1, 1, 0))
    @emitter.setStartColorVar(ccc4f(0, 0, 0, 0))
    @emitter.setEndColorVar(ccc4f(0, 0, 0, 0))

    layer.addChild(@emitter, 10)

    title_label.setString("premultiplied alpha")
    subtitle_label.setString("no black halo, particles should fade out")
    layer
  end
end

class PremultipliedAlphaTest2 < ParticleTestBase
  def get_layer
    layer = super()

    layer.setColor(ccc3(0, 0, 0))
    layer.removeChild(@background, true)
    @background = nil

    @emitter = CCParticleSystemQuad.create("Particles/TestPremultipliedAlpha.plist")
    layer.addChild(@emitter, 10)

    title_label.setString("premultiplied alpha 2")
    subtitle_label.setString("Arrows should be faded")
    layer
  end
end
