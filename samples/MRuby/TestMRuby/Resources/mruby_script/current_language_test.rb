require "mruby_script/test_base"
require "mruby_script/test_resource"
require "mruby_script/visible_rect"
require "mruby_script/main_menu"

class CurrentLanguageTest < TestBase
  extend TestBaseExt
  self.supported = true

  def init_with_layer(layer)
    super(layer)

    @title_label.setString("Current language Test")

    labelLanguage = CCLabelTTF.create("", "Arial", 20)
    labelLanguage.setPosition(VisibleRect.center())

    currentLanguageType = CCApplication.sharedApplication().getCurrentLanguage()

    str = case currentLanguageType
          when kLanguageEnglish
            "current language is English"
          when kLanguageChinese
            "current language is Chinese"
          when kLanguageFrench
            "current language is French"
          when kLanguageGerman
            "current language is German"
          when kLanguageItalian
            "current language is Italian"
          when kLanguageRussian
            "current language is Russian"
          when kLanguageSpanish
            "current language is Spanish"
          when kLanguageKorean
            "current language is Korean"
          when kLanguageJapanese
            "current language is Japanese"
          when kLanguageHungarian
            "current language is Hungarian"
          when kLanguagePortuguese
            "current language is Portuguese"
          when kLanguageArabic
            "current language is Arabic"
          else
            "unknown language type:#{currentLanguageType}"
          end

    labelLanguage.setString(str)
    layer.addChild(labelLanguage)
    layer
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
