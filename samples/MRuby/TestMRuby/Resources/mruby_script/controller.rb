require "mruby_script/cc_array"
require "mruby_script/main_menu"

module Cocos2d
  def CC_CONTENT_SCALE_FACTOR
    CCDirector.sharedDirector().getContentScaleFactor()
  end
  def self.CC_CONTENT_SCALE_FACTOR
    CCDirector.sharedDirector().getContentScaleFactor()
  end

  def CC_POINT_PIXELS_TO_POINTS(__pixels__)
    CCPointMake( __pixels__.x / CC_CONTENT_SCALE_FACTOR(),
                 __pixels__.y / CC_CONTENT_SCALE_FACTOR())
  end
  def self.CC_POINT_PIXELS_TO_POINTS(__pixels__)
    CCPointMake( __pixels__.x / CC_CONTENT_SCALE_FACTOR(),
                 __pixels__.y / CC_CONTENT_SCALE_FACTOR())
  end

  def CC_POINT_POINTS_TO_PIXELS(__points__)
    CCPointMake( __points__.x * CC_CONTENT_SCALE_FACTOR(),
                 __points__.y * CC_CONTENT_SCALE_FACTOR())
  end
  def self.CC_POINT_POINTS_TO_PIXELS(__points__)
    CCPointMake( __points__.x * CC_CONTENT_SCALE_FACTOR(),
                 __points__.y * CC_CONTENT_SCALE_FACTOR())
  end

  def self.CCRANDOM_0_1
    rand()
  end
  def CCRANDOM_0_1
    rand()
  end

  def self.CCRANDOM_MINUS1_1
    rand() * 2.0 - 1
  end
  def CCRANDOM_MINUS1_1
    rand() * 2.0 - 1
  end

  def CC_DEGREES_TO_RADIANS(angle)
    angle * 0.01745329252 # PI / 180
  end

  def self.CC_DEGREES_TO_RADIANS(angle)
    angle * 0.01745329252 # PI / 180
  end

  def CC_RADIANS_TO_DEGREES(angle)
    angle * 57.29577951 # PI * 180
  end

  def self.CC_RADIANS_TO_DEGREES(angle)
    angle * 57.29577951 # PI * 180
  end

  def CHECK_GL_ERROR_DEBUG
    error = glGetError()
    raise sprintf("OpenGL error:0x%04x", error) if error != 0
  end

  def self.CHECK_GL_ERROR_DEBUG()
    error = glGetError()
    raise sprintf("OpenGL error:0x%04x", error) if error != 0
  end

  def self.cclog(fmt, *args)
    CCLog(sprintf(fmt, *args))
  end
  def cclog(fmt, *args)
    CCLog(sprintf(fmt, *args))
  end
  def kCCParticleDefaultCapacity
    500
  end
  def self.kCCParticleDefaultCapacity
    500
  end

  def self.dump_gv
    p "$G_.size=#{$G_.size}"
    $G_.keys.sort.each do |key|
      v = $G_[key]
      p "  #{key}:#{v}:#{if v.respond_to? :retainCount then v.retainCount end}"
    end if false

    p "$G_.size=#{$G_.size}" if false
    p "$G_SCRIPT_HANDLE_ID_PROC.size=#{$G_SCRIPT_HANDLE_ID_PROC.size}"
    $G_SCRIPT_HANDLE_ID_PROC.keys.sort.each do |key|
      v = $G_SCRIPT_HANDLE_ID_PROC[key]
      p "  #{key}:#{v.inspect}"
    end if false

    p "$G_SCRIPT_HANDLE_ID_PROC.size=#{$G_SCRIPT_HANDLE_ID_PROC.size}" if false

    if $G_CCMRubyCallbackWrapper
      p "$G_CCMRubyCallbackWrapper.size=#{$G_CCMRubyCallbackWrapper.size}"
      $G_CCMRubyCallbackWrapper.keys.sort.each do |key|
        v = $G_CCMRubyCallbackWrapper[key]
        p "  #{key}:#{v.inspect}"
      end if false

      p "$G_CCMRubyCallbackWrapper.size=#{$G_CCMRubyCallbackWrapper.size}" if false
    end

    CC.dump_live_value()

  end
  def dump_gv
    self.class.dump_gv
  end
end

module Controller
  include Cocos2d
  def self.run
    Cocos2d.dump_gv
    # run
    scene = CCScene.create
    scene.addChild(MainMenu.new.create_test_menu())
    CCDirector.sharedDirector.runWithScene(scene)
  end
end
