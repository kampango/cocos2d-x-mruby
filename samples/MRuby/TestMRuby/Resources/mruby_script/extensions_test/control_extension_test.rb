require "mruby_script/test_base"
require "mruby_script/visible_rect"

class ControlExtensionTest < TestBase
  include Cocos2d::Extension
  extend TestBaseExt
  self.supported = true

  module ControlExtentionsTestEnum
    def self.kCCControlSliderTest
      0
    end
    def self.kCCControlColourPickerTest
      1
    end
    def self.kCCControlSwitchTest
      2
    end
    def self.kCCControlButtonTest_HelloVariableSize
      3
    end
    def self.kCCControlButtonTest_Event
      4
    end
    def self.kCCControlButtonTest_Styling
      5
    end
    def self.kCCControlPotentiometerTest
      6
    end
    def self.kCCControlStepperTest
      7
    end
    def self.kCCControlTestMax
      8
    end
  end

  class ControlTestBase < TestBase
    include Cocos2d::Extension
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

    def init_with_layer(layer)
      super(layer)

      # Add the generated background
      background = CCSprite.create("extensions/background.png")
      background.setPosition(VisibleRect.center)
      layer.addChild(background)

      # Add the ribbon
      ribbon = CCScale9Sprite.create("extensions/ribbon.png", CCRectMake(1, 1, 48, 55))
      ribbon.setContentSize(CCSizeMake(VisibleRect.get_visible_rect.size.width, 57))
      ribbon.setPosition(ccp(VisibleRect.center.x, VisibleRect.top.y - ribbon.getContentSize.height / 2.0))
      layer.addChild(ribbon)

      # Add the title
      @title_label.setString(self.class.to_s)
      @title_label.setFontSize(12)
      @title_label.setPosition(ccp(VisibleRect.center.x, VisibleRect.top.y - @title_label.getContentSize.height / 2 - 5))
      @title_label.setZOrder(1)

      unless @menu
        @menu = create_menu
        layer.addChild(@menu)
      end

      layer
    end
  end

  class CCControlSliderTest < ControlTestBase
    include Cocos2d::Extension

    def init_with_layer(layer)
      super(layer)

      s = CCDirector.sharedDirector.getWinSize
      display_value_label = CCLabelTTF.create("Move the slider thumb!\nThe lower slider is restricted." ,"Marker Felt", 32)
      #display_value_label.retain
      display_value_label.setAnchorPoint(ccp(0.5, -1.0))
      display_value_label.setPosition(ccp(s.width / 1.7, s.height / 2.0))
      layer.addChild(display_value_label)

      value_changed = Proc.new {|event_name, control|
        return if control.nil? || display_value_label.nil?
        fmt = if control.getTag() == 1
                sprintf("Upper slider value = %.02f", control.getValue())
              elsif control.getTag() == 2
                sprintf("Lower slider value = %.02f", control.getValue())
              else
                nil
              end

        display_value_label.setString(fmt) unless fmt.nil?
      }

      # Add the slider
      slider = CCControlSlider.create("extensions/sliderTrack.png", "extensions/sliderProgress.png", "extensions/sliderThumb.png")
      slider.setAnchorPoint(ccp(0.5, 1.0))
      slider.setMinimumValue(0.0)
      slider.setMaximumValue(5.0)
      slider.setPosition(ccp(s.width / 2.0, s.height / 2.0 + 16))
      slider.setTag(1)

      # When the value of the slider will change, the given selector will be call
      slider.addHandleOfControlEvent(value_changed, CCControlEventValueChanged)

      restrict_slider = CCControlSlider.create("extensions/sliderTrack.png", "extensions/sliderProgress.png", "extensions/sliderThumb.png")
      restrict_slider.setAnchorPoint(ccp(0.5, 1.0))
      restrict_slider.setMinimumValue(0.0)
      restrict_slider.setMaximumValue(5.0)
      restrict_slider.setMaximumAllowedValue(4.0)
      restrict_slider.setMinimumAllowedValue(1.5)
      restrict_slider.setValue(3.0)
      restrict_slider.setPosition(ccp(s.width / 2.0, s.height / 2.0 - 24))
      restrict_slider.setTag(2)

      # same with restricted
      restrict_slider.addHandleOfControlEvent(value_changed, CCControlEventValueChanged)

      #layer.registerScriptHandler(Proc.new {|tag|
      #                              if tag == kCCNodeOnCleanup
      #                                [slider, restrict_slider].each do |control|
      #                                  control.removeHandleOfControlEvent(CCControlEventValueChanged)
      #                                end
      #                                layer.unregisterScriptHandler
      #                              end
      #                            })

      layer.addChild(slider)
      layer.addChild(restrict_slider)
      layer
    end
  end

  class CCControlColourPickerTest < ControlTestBase
    include Cocos2d::Extension

    def init_with_layer(layer)
      super(layer)

      size = CCDirector.sharedDirector.getWinSize

      node = CCNode.create
      node.setPosition(ccp(size.width / 2, size.height / 2))
      layer.addChild(node)

      width = 0

      color_label = nil
      colour_value_changed = Proc.new {|event, picker|
        unless picker.nil?
          color = picker.getColor
          color_label.setString(sprintf("#%02X%02X%02X", color.r, color.g, color.b))
        end
      }

      picker = CCControlColourPicker.create
      picker.setColor(ccc3(37, 46, 252))
      picker.setPosition(ccp(picker.getContentSize.width / 2, 0))
      picker.addHandleOfControlEvent(colour_value_changed, CCControlEventValueChanged)
      node.addChild(picker)

      width += picker.getContentSize.width

      background = CCScale9Sprite.create("extensions/buttonBackground.png")
      background.setContentSize(CCSizeMake(150, 50))
      background.setPosition(ccp(width + background.getContentSize.width / 2.0, 0))
      node.addChild(background)

      width += background.getContentSize.width

      color_label = CCLabelTTF.create("#color", "Marker Felt", 30)
      color_label.setPosition(background.getPosition)
      node.addChild(color_label)

      #Set the layer size
      node.setContentSize(CCSizeMake(width, 0))
      node.setAnchorPoint(ccp(0.5, 0.5))

      #Update the color text
      colour_value_changed.call(nil, picker)
      layer
    end
  end

  class CCControlSwitchTest < ControlTestBase
    include Cocos2d::Extension

    def init_with_layer(layer)
      super(layer)

      size = CCDirector.sharedDirector.getWinSize

      node = CCNode.create
      node.setPosition(ccp(size.width / 2, size.height / 2))
      layer.addChild(node, 1)

      width = 0

      #Add the black background for the text
      background = CCScale9Sprite.create("extensions/buttonBackground.png")
      background.setContentSize(CCSizeMake(80, 50))
      background.setPosition(ccp(width + background.getContentSize.width / 2.0, 0))
      node.addChild(background)
      width += background.getContentSize.width

      display_value_label  = CCLabelTTF.create("#color" ,"Marker Felt", 30)
      display_value_label.setPosition(background.getPosition())
      node.addChild(display_value_label)

      #Create the switch
      value_changed = Proc.new {|event, control|
        unless control.nil?
          display_value_label.setString(if control.isOn then "On" else "Off" end)
        end
      }

      switch_control = CCControlSwitch.create(CCSprite.create("extensions/switch-mask.png"),
                                              CCSprite.create("extensions/switch-on.png"),
                                              CCSprite.create("extensions/switch-off.png"),
                                              CCSprite.create("extensions/switch-thumb.png"),
                                              CCLabelTTF.create("On", "Arial-BoldMT", 16),
                                              CCLabelTTF.create("Off", "Arial-BoldMT", 16))

      switch_control.setPosition(ccp(width + 10 + switch_control.getContentSize.width / 2, 0))
      node.addChild(switch_control)
      switch_control.addHandleOfControlEvent(value_changed, CCControlEventValueChanged)

      #Set the layer size
      node.setContentSize(CCSizeMake(width, 0))
      node.setAnchorPoint(ccp(0.5, 0.5))

      #Update the value label
      value_changed.call(nil, switch_control)
      layer
    end
  end

  class CCControlButtonHelloVariableSizeTest < ControlTestBase
    include Cocos2d::Extension

    def create_hvs_standard_button_with_title(title)
      # Creates and return a button with a default background and title color.
      background_button = CCScale9Sprite.create("extensions/button.png")
      background_highlighted_button = CCScale9Sprite.create("extensions/buttonHighlighted.png")

      title_button = CCLabelTTF.create(title, "Marker Felt", 30)
      title_button.setColor(ccc3(159, 168, 176))

      button = CCControlButton.create(title_button, background_button)
      button.setBackgroundSpriteForState(background_highlighted_button, CCControlStateHighlighted)
      button.setTitleColorForState(ccc3(255,255,255), CCControlStateHighlighted)
      button
    end

    def init_with_layer(layer)
      super(layer)

      size = CCDirector.sharedDirector.getWinSize

      node = CCNode.create
      layer.addChild(node, 1)

      total_width = 0
      height = 0
      ["Hello", "Variable", "Size", "!"].each do |title|
        #Creates a button with layer string as title
        button = create_hvs_standard_button_with_title(title)
        button.setPosition(ccp(total_width + button.getContentSize.width / 2, button.getContentSize.height / 2))
        node.addChild(button)

        #Compute the size of the layer
        height = button.getContentSize.height if height < button.getContentSize.height
        total_width += button.getContentSize.width
      end

      node.setAnchorPoint(ccp(0.5, 0.5))
      node.setContentSize(CCSizeMake(total_width, height))
      node.setPosition(ccp(size.width / 2.0, size.height / 2.0))

      #Add the black background
      background = CCScale9Sprite.create("extensions/buttonBackground.png")
      background.setContentSize(CCSizeMake(total_width + 14, height + 14))
      background.setPosition(ccp(size.width / 2.0, size.height / 2.0))
      layer.addChild(background)

      layer
    end
  end

  class CCControlButtonStylingTest < ControlTestBase
    include Cocos2d::Extension

	def styling_standard_button_with_title(title)
      background_button = CCScale9Sprite.create("extensions/button.png")
      background_button.setPreferredSize(CCSizeMake(45, 45))
      background_highlighted_button = CCScale9Sprite.create("extensions/buttonHighlighted.png")
      background_highlighted_button.setPreferredSize(CCSizeMake(45, 45))

      title_button = CCLabelTTF.create(title, "Marker Felt", 30)
      title_button.setColor(ccc3(159, 168, 176))

      button = CCControlButton.create(title_button, background_button)
      button.setBackgroundSpriteForState(background_highlighted_button, CCControlStateHighlighted)
      button.setTitleColorForState(ccc3(255,255,255), CCControlStateHighlighted)
      button
    end

    def init_with_layer(layer)
      super(layer)

      size = CCDirector.sharedDirector.getWinSize

      node = CCNode.create()
      layer.addChild(node, 1)

      space = 10

      max_w = 0
      max_h = 0
      3.times do |i|
        3.times do |j|
          #Add the buttons
          button = styling_standard_button_with_title("#{rand(32767) % 30}")
          button.setAdjustBackgroundImage(false)
          button.setPosition(ccp(button.getContentSize().width / 2 + (button.getContentSize().width + space) * i,
                                 button.getContentSize().height / 2 + (button.getContentSize().height + space) * j))

          node.addChild(button)

          max_w = [button.getContentSize().width * (i + 1) + space  * i, max_w].max
          max_h = [button.getContentSize().height * (j + 1) + space * j, max_h].max
        end
      end

      node.setAnchorPoint(ccp(0.5, 0.5))
      node.setContentSize(CCSizeMake(max_w, max_h))
      node.setPosition(ccp(size.width / 2.0, size.height / 2.0))
      #Add the black background
      background_button = CCScale9Sprite.create("extensions/buttonBackground.png")
      background_button.setContentSize(CCSizeMake(max_w + 14, max_h + 14))
      background_button.setPosition(ccp(size.width / 2.0, size.height / 2.0))
      layer.addChild(background_button)
      layer
    end
  end

  class CCControlButtonEventTest < ControlTestBase
    include Cocos2d::Extension

    def init_with_layer(layer)
      super(layer)
      size = CCDirector.sharedDirector.getWinSize

      #Add a label in which the button events will be displayed
      display_value_label = nil
      display_value_label = CCLabelTTF.create("No Event", "Marker Felt", 32)
      display_value_label.setAnchorPoint(ccp(0.5, -1))
      display_value_label.setPosition(ccp(size.width / 2.0, size.height / 2.0))
      layer.addChild(display_value_label, 1)

      #Add the button
      background_button             = CCScale9Sprite.create("extensions/button.png")
      background_highlighted_button = CCScale9Sprite.create("extensions/buttonHighlighted.png")

      title_button_label = CCLabelTTF.create("Touch Me!", "Marker Felt", 30)
      title_button_label.setColor(ccc3(159, 168, 176))

      control_button = CCControlButton.create(title_button_label, background_button)
      touch_down_action = Proc.new { display_value_label.setString("Touch Down") }
      touch_drag_inside_action = Proc.new { display_value_label.setString("Drag Inside") }
      touch_drag_outside_action = Proc.new { display_value_label.setString("Drag Outside") }
      touch_drag_enter_action = Proc.new { display_value_label.setString("Drag Enter") }
      touch_drag_exit_action = Proc.new { display_value_label.setString("Drag Exit") }
      touch_up_inside_action = Proc.new { display_value_label.setString("Touch Up Inside.") }
      touch_up_outside_action = Proc.new { display_value_label.setString("Touch Up Outside.") }
      touch_cancel_action = Proc.new { display_value_label.setString("Touch Cancel") }

      control_button.setBackgroundSpriteForState(background_highlighted_button, CCControlStateHighlighted)
      control_button.setTitleColorForState(ccc3(255, 255, 255), CCControlStateHighlighted)
      control_button.setAnchorPoint(ccp(0.5, 1))
      control_button.setPosition(ccp(size.width / 2.0, size.height / 2.0))
      control_button.addHandleOfControlEvent(touch_down_action,CCControlEventTouchDown)
      control_button.addHandleOfControlEvent(touch_drag_inside_action,CCControlEventTouchDragInside)
      control_button.addHandleOfControlEvent(touch_drag_outside_action,CCControlEventTouchDragOutside)
      control_button.addHandleOfControlEvent(touch_drag_enter_action,CCControlEventTouchDragEnter)
      control_button.addHandleOfControlEvent(touch_drag_exit_action,CCControlEventTouchDragExit)
      control_button.addHandleOfControlEvent(touch_up_inside_action,CCControlEventTouchUpInside)
      control_button.addHandleOfControlEvent(touch_up_outside_action,CCControlEventTouchUpOutside)
      control_button.addHandleOfControlEvent(touch_cancel_action,CCControlEventTouchCancel)
      layer.addChild(control_button, 1)

      #Add the black background
      background_button = CCScale9Sprite.create("extensions/buttonBackground.png")
      background_button.setContentSize(CCSizeMake(300, 170))
      background_button.setPosition(ccp(size.width / 2.0, size.height / 2.0))
      layer.addChild(background_button)
      layer
    end
  end

  class CCPotentiometerTest < ControlTestBase
    include Cocos2d::Extension

    def init_with_layer(layer)
      super(layer)
      size = CCDirector.sharedDirector.getWinSize

      node = CCNode.create()
      node.setPosition(ccp(size.width / 2, size.height / 2))
      layer.addChild(node, 1)

      width = 0

      # Add the black background for the text
      background  = CCScale9Sprite.create("extensions/buttonBackground.png")
      background.setContentSize(CCSizeMake(80, 50))
      background.setPosition(ccp(width + background.getContentSize().width / 2.0, 0))
      node.addChild(background)

      width += background.getContentSize().width

      display_value_label = CCLabelTTF.create("", "HelveticaNeue-Bold", 30)
      display_value_label.setPosition(background.getPosition())
      node.addChild(display_value_label)

      # Add the slider
      value_changed = Proc.new {|event, control|
        display_value_label.setString(sprintf("%0.2f",control.getValue))
      }
      potentiometer = CCControlPotentiometer.create("extensions/potentiometerTrack.png",
                                                    "extensions/potentiometerProgress.png",
                                                    "extensions/potentiometerButton.png")
      potentiometer.setPosition(ccp(width + 10 + potentiometer.getContentSize().width / 2, 0))

      # When the value of the slider will change, the given selector will be call
      potentiometer.addHandleOfControlEvent(value_changed, CCControlEventValueChanged)

      node.addChild(potentiometer)

      width += potentiometer.getContentSize().width

      # Set the layer size
      node.setContentSize(CCSizeMake(width, 0))
      node.setAnchorPoint(ccp(0.5, 0.5))

      # Update the value label
      value_changed.call(nil, potentiometer)
      layer
    end
  end

  class CCStepperTest < ControlTestBase
    include Cocos2d::Extension

    def init_with_layer(layer)
      super(layer)
      size = CCDirector.sharedDirector.getWinSize

      node = CCNode.create()
      node.setPosition(ccp(size.width / 2, size.height / 2))
      layer.addChild(node, 1)

      layer_width = 0

      # Add the black background for the text
      background = CCScale9Sprite.create("extensions/buttonBackground.png")
      background.setContentSize(CCSizeMake(100, 50))
      background.setPosition(ccp(layer_width + background.getContentSize().width / 2.0, 0))
      node.addChild(background)

      display_value_label =  CCLabelTTF.create("0", "HelveticaNeue-Bold", 30)
      display_value_label.setPosition(background.getPosition())
      node.addChild(display_value_label)

      layer_width += background.getContentSize().width

      minus_sprite = CCSprite.create("extensions/stepper-minus.png")
      plus_sprite  = CCSprite.create("extensions/stepper-plus.png")

      value_changed = Proc.new {|event, control|
        display_value_label.setString(sprintf("%0.02f", control.getValue))
      }

      stepper = CCControlStepper.create(minus_sprite, plus_sprite)
      stepper.setPosition(ccp(layer_width + 10 + stepper.getContentSize().width / 2, 0))
      stepper.addHandleOfControlEvent(value_changed, CCControlEventValueChanged)
      node.addChild(stepper)

      layer_width += stepper.getContentSize().width

      # Set the layer size
      node.setContentSize(CCSizeMake(layer_width, 0))
      node.setAnchorPoint(ccp(0.5, 0.5))

      # Update the value label
      value_changed.call(nil, stepper)
      layer
    end
  end

  def initialize
    super()
    [CCControlSliderTest,
     CCControlColourPickerTest,
     CCControlSwitchTest,
     CCControlButtonHelloVariableSizeTest,
     CCControlButtonEventTest,
     CCControlButtonStylingTest,
     CCPotentiometerTest,
     CCStepperTest,
    ].each do |klass|
      register_create_function(klass, :create)
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
    scene.addChild(ExtensionsTest.create_back_menu_item("Back"))
    scene
  end

  def create
    new_scene
  end
end
