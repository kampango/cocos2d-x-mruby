require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class FontTest < TestBase
  extend TestBaseExt
  self.supported = true

  FONT_LIST = if CC.os == "ios"
                # custom ttf files are defined in Test-info.plist
                ["American Typewriter",
                 "Marker Felt",
                 "A Damn Mess",
                 "Abberancy",
                 "Abduction",
                 "Paint Boy",
                 "Schwarzwald Regular",
                 "Scissor Cuts"]
              else
                ["fonts/A Damn Mess.ttf",
                 "fonts/Abberancy.ttf",
                 "fonts/Abduction.ttf",
                 "fonts/Paint Boy.ttf",
                 "fonts/Schwarzwald Regular.ttf",
                 "fonts/Scissor Cuts.ttf"]
              end

  def kTagLabel1
    0
  end
  def kTagLabel2
    1
  end
  def kTagLabel3
    2
  end
  def kTagLabel4
    3
  end
  def kTagColor1
    4
  end
  def kTagColor2
    5
  end
  def kTagColor3
    6
  end

  VerticalAlignment = [Cocos2d.kCCVerticalTextAlignmentTop,
                       Cocos2d.kCCVerticalTextAlignmentCenter,
                       Cocos2d.kCCVerticalTextAlignmentBottom]

  def create_layer
    @layer = CCLayer.create
    init_with_layer(@layer)
    that = self
    @layer.registerScriptHandler(Proc.new {|tag|
                                   if tag == Cocos2d.kCCNodeOnEnter
                                     that.onEnter
                                     elsif tag == Cocos2d.kCCNodeOnExit
                                     that.onExit
                                   end})
    showFont(FONT_LIST[@index])
    @vAlignIdx += 1
    @vAlignIdx %= VerticalAlignment.size
    @layer
  end

  def showFont(pFont)
    s = @@size

    blockSize = CCSizeMake(s.width/3, 200)
    fontSize = 26

    top = CCLabelTTF.create(pFont, pFont, 24)
    left = CCLabelTTF.create("alignment left", pFont, fontSize,
                             blockSize, kCCTextAlignmentLeft,
                             VerticalAlignment[@vAlignIdx])
    center = CCLabelTTF.create("alignment center", pFont, fontSize,
                               blockSize, kCCTextAlignmentCenter,
                               VerticalAlignment[@vAlignIdx])
    right = CCLabelTTF.create("alignment right", pFont, fontSize,
                              blockSize, kCCTextAlignmentRight,
                              VerticalAlignment[@vAlignIdx])

    leftColor = CCLayerColor.create(ccc4(100, 100, 100, 255),
                                    blockSize.width, blockSize.height)
    centerColor = CCLayerColor.create(ccc4(200, 100, 100, 255),
                                      blockSize.width, blockSize.height)
    rightColor = CCLayerColor.create(ccc4(100, 100, 200, 255),
                                     blockSize.width, blockSize.height)

    leftColor.ignoreAnchorPointForPosition(false)
    centerColor.ignoreAnchorPointForPosition(false)
    rightColor.ignoreAnchorPointForPosition(false)


    top.setAnchorPoint(ccp(0.5, 1))
    left.setAnchorPoint(ccp(0,0.5))
    leftColor.setAnchorPoint(ccp(0,0.5))
    center.setAnchorPoint(ccp(0,0.5))
    centerColor.setAnchorPoint(ccp(0,0.5))
    right.setAnchorPoint(ccp(0,0.5))
    rightColor.setAnchorPoint(ccp(0,0.5))

    top.setPosition(ccp(s.width/2,s.height-20))
    left.setPosition(ccp(0,s.height/2))
    leftColor.setPosition(left.getPosition())
    center.setPosition(ccp(blockSize.width, s.height/2))
    centerColor.setPosition(center.getPosition())
    right.setPosition(ccp(blockSize.width*2, s.height/2))
    rightColor.setPosition(right.getPosition())

    @layer.addChild(leftColor, -1, kTagColor1)
    @layer.addChild(left, 0, kTagLabel1)
    @layer.addChild(rightColor, -1, kTagColor2)
    @layer.addChild(right, 0, kTagLabel2)
    @layer.addChild(centerColor, -1, kTagColor3)
    @layer.addChild(center, 0, kTagLabel3)
    @layer.addChild(top, 0, kTagLabel4)
  end

  def onEnter
  end
  def onExit
  end

  def initialize
    super
    FONT_LIST.each do
      register_create_function(self, :create_layer)
    end
    @vAlignIdx = 0
  end

  def create
    new_scene
  end
end
