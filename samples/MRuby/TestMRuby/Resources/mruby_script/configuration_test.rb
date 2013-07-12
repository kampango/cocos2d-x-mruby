require "mruby_script/test_base"

class ConfigurationTest < TestBase
  extend TestBaseExt
  self.supported = true

  class ConfigurationBase < TestBase
    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end

    def initialize
      super
      @conf = CCConfiguration.sharedConfiguration()
    end

    def title
      "Configuration Test"
    end
    def subtitle
      ""
    end

    def init_with_layer(layer)
      super(layer)

      @title_label.setString(self.title)
      @subtitle_label.setString(self.subtitle)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    elsif tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      @layer = layer
      @layer
    end

    def onEnter
    end
    def onExit
    end
  end

  class ConfigurationLoadConfig < ConfigurationBase
    def onEnter
      super
      @conf.loadConfigFile("configs/config-test-ok.plist")
      @conf.dumpInfo()
    end

    def subtitle
      "Loading config file manually. See console"
    end
  end

  class ConfigurationQuery < ConfigurationBase
    def onEnter
      super

      #TODO: pass nil as second param
      cclog("cocos2d version: %s", @conf.getCString("cocos2d.x.version", "") )
      cclog("OpenGL version: %s", @conf.getCString("gl.version", "") )
    end

    def subtitle
      "Using getCString(). Check the console"
    end
  end

  class ConfigurationInvalid < ConfigurationBase
    def onEnter
      super
      @conf.loadConfigFile("configs/config-test-invalid.plist")
    end

    def subtitle
      "Loading an invalid config file"
    end
  end

  class ConfigurationDefault < ConfigurationBase
    def onEnter
      super
      c_value = @conf.getCString("invalid.key", "no key")
      if c_value != "no key"
		cclog("1. Test failed!")
      else
		cclog("1. Test OK!")
      end

      b_value = @conf.getBool("invalid.key", true)
      if !b_value
		cclog("2. Test failed!")
      else
		cclog("2. Test OK!")
      end

      d_value = @conf.getNumber("invalid.key", 42.42)
      if d_value != 42.42
		cclog("3. Test failed!")
      else
		cclog("3. Test OK!")
      end
    end

    def subtitle
      "Tests defaults values"
    end
  end

  class ConfigurationSet < ConfigurationBase
    def onEnter
      super
      @conf.setObject("this.is.an.int.value", CCInteger.create(10) )
      @conf.setObject("this.is.a.bool.value", CCBool.create(true) )
      @conf.setObject("this.is.a.string.value", CCString.create("hello world") )
      @conf.dumpInfo()
    end

    def subtitle
      "Tests setting values manually"
    end
  end

  def initialize
    super
    [
     ConfigurationLoadConfig,
     ConfigurationQuery,
     ConfigurationInvalid,
     ConfigurationDefault,
     ConfigurationSet,
    ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end
