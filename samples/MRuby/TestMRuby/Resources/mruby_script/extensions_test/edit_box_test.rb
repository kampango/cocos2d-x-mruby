require "mruby_script/test_base"

class EditBoxTest < TestBase
  extend TestBaseExt
  include Cocos2d::Extension
  self.supported = true

  def init_with_layer(layer)
    super(layer)

    origin = CCEGLView.sharedOpenGLView.getVisibleOrigin
    size = CCEGLView.sharedOpenGLView.getVisibleSize

    bg = CCSprite.create("Images/HelloWorld.png")
    bg.setPosition(ccp(origin.x + size.width / 2, origin.y + size.height / 2))
    layer.addChild(bg)

    @ttf_show_edit_return = CCLabelTTF.create("No edit control return!", "", 30)
    @ttf_show_edit_return.setPosition(ccp(origin.x + size.width / 2, origin.y + size.height - 50))
    layer.addChild(@ttf_show_edit_return)

    edit_box_size = CCSizeMake(size.width - 100, 60)

    @edit_name = CCEditBox.create(edit_box_size, CCScale9Sprite.create("extensions/green_edit.png"), nil, nil)
    @edit_name.setPosition(ccp(origin.x + size.width / 2, origin.y + size.height * 3 / 4))

    if CC.os == "ios"
      @edit_name.setFontName("Paint Boy")
    else
      @edit_name.setFontName("fonts/Paint Boy.ttf")
    end
    @edit_name
      .setFontSize(25)
      .setFontColor(ccRED)
      .setPlaceHolder("Name:")
      .setPlaceholderFontColor(ccWHITE)
      .setMaxLength(8)
      .setReturnType(kKeyboardReturnTypeDone)
      .setDelegate(self)

    layer.addChild(@edit_name)

    @edit_password = CCEditBox.create(edit_box_size, CCScale9Sprite.create("extensions/orange_edit.png"), nil, nil)
    @edit_password.setPosition(ccp(origin.x + size.width / 2, origin.y + size.height / 2))

    if CC.os == "ios"
      @edit_password.setFont("American Typewriter", 30)
    else
      @edit_password.setFont("fonts/American Typewriter.ttf", 30)
    end
    @edit_password
      .setFontColor(ccGREEN)
      .setPlaceHolder("Password:")
      .setMaxLength(6)
      .setInputFlag(kEditBoxInputFlagPassword)
      .setInputMode(kEditBoxInputModeSingleLine)
      .setDelegate(self)

    layer.addChild(@edit_password)

    @edit_email = CCEditBox.create(edit_box_size, CCScale9Sprite.create("extensions/yellow_edit.png"), nil, nil)
    @edit_email
      .setPosition(ccp(origin.x + size.width / 2, origin.y + size.height / 4))
      .setAnchorPoint(ccp(0.5, 1.0))
      .setPlaceHolder("Email:")
      .setInputMode(kEditBoxInputModeEmailAddr)
      .setDelegate(self)

    layer.addChild(@edit_email)
    layer
  end

  def edit_box_editing_did_begin(edit_box)
    cclog("editBox #{edit_box} DidBegin !")
  end

  def edit_box_editing_did_end(edit_box)
    cclog("editBox #{edit_box} DidEnd !")
  end

  def edit_box_text_changed(edit_box, text)
    cclog("editBox #{edit_box} TextChanged, text: #{text}")
  end

  def edit_box_return(edit_box)
    cclog("editBox #{edit_box} was returned !")
    if @edit_name == edit_box
      @ttf_show_edit_return.setString("Name EditBox return!")
    elsif @edit_password == edit_box
      @ttf_show_edit_return.setString("Password EditBox return!")
    elsif @edit_email == edit_box
      @ttf_show_edit_return.setString("Email EditBox return!")
    end
  end

  def create
    scene = CCScene.create
    layer = CCLayer.create
    init_with_layer(layer)
    scene.addChild(layer)
    scene.addChild(ExtensionsTest.create_back_menu_item("Back"))
    scene
  end
end
