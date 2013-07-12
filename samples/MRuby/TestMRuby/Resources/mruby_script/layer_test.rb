require "mruby_script/test_base"
require "mruby_script/gl_constant"
require "mruby_script/test_resource"
require "mruby_script/visible_rect"

class LayerTest < TestBase
  extend TestBaseExt
  self.supported = true

  class LayerTestBase < TestBase
    include GLConstant

    def kLayerIgnoreAnchorPoint
      1000
    end

    def kTagLayer
      1
    end

    def title
      "No Title"
    end
    def subtitle
      ""
    end

    def init_with_layer(layer)
      super(layer)
      @title_label.setString(self.title)
      @subtitle_label.setString(self.subtitle)
      layer
    end

    def setEnableRecursiveCascading(node, enable)
      unless node
        # cclog("node == nil, return directly")
        return
      end

      if node.kind_of? CCLayerRGBA
        node.setCascadeColorEnabled(enable)
        node.setCascadeOpacityEnabled(enable)
      end

      children = node.getChildren()
      unless children
        # cclog("children is nil")
        return
      end

      len = children.count()
      len.times do |i|
        child = children.objectAtIndex(i)
        setEnableRecursiveCascading(child, enable)
      end
    end
  end

  class LayerTestCascadingOpacityA < LayerTestBase
    def title
      "LayerRGBA: cascading opacity"
    end
    def init_with_layer(layer)
      super(layer)
      s = CCDirector.sharedDirector().getWinSize()
      layer1 = CCLayerRGBA.create()

      sister1 = CCSprite.create("Images/grossinis_sister1.png")
      sister2 = CCSprite.create("Images/grossinis_sister2.png")
      label = CCLabelBMFont.create("Test", "fonts/bitmapFontTest.fnt")

      layer1.addChild(sister1)
      layer1.addChild(sister2)
      layer1.addChild(label)
      layer.addChild( layer1, 0, kTagLayer)

      sister1.setPosition( ccp( s.width*1/3, s.height/2))
      sister2.setPosition( ccp( s.width*2/3, s.height/2))
      label.setPosition( ccp( s.width/2, s.height/2))

      arr = CCArray.create()
      arr.addObject(CCFadeTo.create(4, 0))
      arr.addObject(CCFadeTo.create(4, 255))
      arr.addObject(CCDelayTime.create(1))
      layer1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      arr = CCArray.create()
      arr.addObject(CCFadeTo.create(2, 0))
      arr.addObject(CCFadeTo.create(2, 255))
      arr.addObject(CCFadeTo.create(2, 0))
      arr.addObject(CCFadeTo.create(2, 255))
      arr.addObject(CCDelayTime.create(1))
      sister1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      # Enable cascading in scene
      setEnableRecursiveCascading(layer, true)
      layer
    end
  end

  class LayerTestCascadingOpacityB < LayerTestBase
    def title
      "CCLayerColor: cascading opacity"
    end

    def init_with_layer(layer)
      super(layer)
      s = CCDirector.sharedDirector().getWinSize()
      layer1 = CCLayerColor.create(ccc4(192, 0, 0, 255), s.width, s.height/2)
      layer1.setCascadeColorEnabled(false)

      layer1.setPosition( ccp(0, s.height/2))

      sister1 = CCSprite.create("Images/grossinis_sister1.png")
      sister2 = CCSprite.create("Images/grossinis_sister2.png")
      label = CCLabelBMFont.create("Test", "fonts/bitmapFontTest.fnt")

      layer1.addChild(sister1)
      layer1.addChild(sister2)
      layer1.addChild(label)
      layer.addChild( layer1, 0, kTagLayer)

      sister1.setPosition( ccp( s.width*1/3, 0))
      sister2.setPosition( ccp( s.width*2/3, 0))
      label.setPosition( ccp( s.width/2, 0))

      arr = CCArray.create()
      arr.addObject(CCFadeTo.create(4, 0))
      arr.addObject(CCFadeTo.create(4, 255))
      arr.addObject(CCDelayTime.create(1))

      layer1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      arr = CCArray.create()
      arr.addObject(CCFadeTo.create(2, 0))
      arr.addObject(CCFadeTo.create(2, 255))
      arr.addObject(CCFadeTo.create(2, 0))
      arr.addObject(CCFadeTo.create(2, 255))
      arr.addObject(CCDelayTime.create(1))

      sister1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      # Enable cascading in scene
      setEnableRecursiveCascading(layer, true)
      layer
    end
  end

  class LayerTestCascadingOpacityC < LayerTestBase
    def title
      "CCLayerColor: non-cascading opacity"
    end

    def init_with_layer(layer)
      super(layer)
      s = CCDirector.sharedDirector().getWinSize()
      layer1 = CCLayerColor.create(ccc4(192, 0, 0, 255), s.width, s.height/2)
      layer1.setCascadeColorEnabled(false)
      layer1.setCascadeOpacityEnabled(false)

      layer1.setPosition( ccp(0, s.height/2))

      sister1 = CCSprite.create("Images/grossinis_sister1.png")
      sister2 = CCSprite.create("Images/grossinis_sister2.png")
      label = CCLabelBMFont.create("Test", "fonts/bitmapFontTest.fnt")

      layer1.addChild(sister1)
      layer1.addChild(sister2)
      layer1.addChild(label)
      layer.addChild( layer1, 0, kTagLayer)

      sister1.setPosition( ccp( s.width*1/3, 0))
      sister2.setPosition( ccp( s.width*2/3, 0))
      label.setPosition( ccp( s.width/2, 0))

      arr = CCArray.create()
      arr.addObject(CCFadeTo.create(4, 0))
      arr.addObject(CCFadeTo.create(4, 255))
      arr.addObject(CCDelayTime.create(1))

      layer1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      arr = CCArray.create()
      arr.addObject(CCFadeTo.create(2, 0))
      arr.addObject(CCFadeTo.create(2, 255))
      arr.addObject(CCFadeTo.create(2, 0))
      arr.addObject(CCFadeTo.create(2, 255))
      arr.addObject(CCDelayTime.create(1))

      sister1.runAction(CCRepeatForever.create(CCSequence.create(arr)))
      layer
    end
  end

  class LayerTestCascadingColorA < LayerTestBase
    def title
      "LayerRGBA: cascading color"
    end

    def init_with_layer(layer)
      super(layer)
      s = CCDirector.sharedDirector().getWinSize()
      layer1 = CCLayerRGBA.create()

      sister1 = CCSprite.create("Images/grossinis_sister1.png")
      sister2 = CCSprite.create("Images/grossinis_sister2.png")
      label = CCLabelBMFont.create("Test", "fonts/bitmapFontTest.fnt")

      layer1.addChild(sister1)
      layer1.addChild(sister2)
      layer1.addChild(label)
      layer.addChild( layer1, 0, kTagLayer)

      sister1.setPosition( ccp( s.width*1/3, s.height/2))
      sister2.setPosition( ccp( s.width*2/3, s.height/2))
      label.setPosition( ccp( s.width/2, s.height/2))

      arr = CCArray.create()
      arr.addObject(CCTintTo.create(6, 255, 0, 255))
      arr.addObject(CCTintTo.create(6, 255, 255, 255))
      arr.addObject(CCDelayTime.create(1))

      layer1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      arr = CCArray.create()
      arr.addObject(CCTintTo.create(2, 255, 255, 0))
      arr.addObject(CCTintTo.create(2, 255, 255, 255))
      arr.addObject(CCTintTo.create(2, 0, 255, 255))
      arr.addObject(CCTintTo.create(2, 255, 255, 255))
      arr.addObject(CCTintTo.create(2, 255, 0, 255))
      arr.addObject(CCTintTo.create(2, 255, 255, 255))
      arr.addObject(CCDelayTime.create(1))

      sister1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      # Enable cascading in scene
      setEnableRecursiveCascading(layer, true)
      layer
    end
  end

  class LayerTestCascadingColorB < LayerTestBase
    def title
      "CCLayerColor: cascading color"
    end

    def init_with_layer(layer)
      super(layer)

      s = CCDirector.sharedDirector().getWinSize()
      layer1 = CCLayerColor.create(ccc4(255, 255, 255, 255), s.width, s.height/2)

      layer1.setPosition( ccp(0, s.height/2))

      sister1 = CCSprite.create("Images/grossinis_sister1.png")
      sister2 = CCSprite.create("Images/grossinis_sister2.png")
      label = CCLabelBMFont.create("Test", "fonts/bitmapFontTest.fnt")

      layer1.addChild(sister1)
      layer1.addChild(sister2)
      layer1.addChild(label)
      layer.addChild( layer1, 0, kTagLayer)

      sister1.setPosition( ccp( s.width*1/3, 0))
      sister2.setPosition( ccp( s.width*2/3, 0))
      label.setPosition( ccp( s.width/2, 0))

      arr = CCArray.create()
      arr.addObject(CCTintTo.create(6, 255, 0, 255))
      arr.addObject(CCTintTo.create(6, 255, 255, 255))
      arr.addObject(CCDelayTime.create(1))

      layer1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      arr = CCArray.create()
      arr.addObject(CCTintTo.create(2, 255, 255, 0))
      arr.addObject(CCTintTo.create(2, 255, 255, 255))
      arr.addObject(CCTintTo.create(2, 0, 255, 255))
      arr.addObject(CCTintTo.create(2, 255, 255, 255))
      arr.addObject(CCTintTo.create(2, 255, 0, 255))
      arr.addObject(CCTintTo.create(2, 255, 255, 255))
      arr.addObject(CCDelayTime.create(1))

      sister1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      # Enable cascading in scene
      setEnableRecursiveCascading(layer, true)
      layer
    end
  end

  class LayerTestCascadingColorC < LayerTestBase
    def title
      "CCLayerColor: non-cascading color"
    end

    def init_with_layer(layer)
      super(layer)
      s = CCDirector.sharedDirector().getWinSize()
      layer1 = CCLayerColor.create(ccc4(255, 255, 255, 255), s.width, s.height/2)
      layer1.setCascadeColorEnabled(false)
      layer1.setPosition( ccp(0, s.height/2))

      sister1 = CCSprite.create("Images/grossinis_sister1.png")
      sister2 = CCSprite.create("Images/grossinis_sister2.png")
      label = CCLabelBMFont.create("Test", "fonts/bitmapFontTest.fnt")

      layer1.addChild(sister1)
      layer1.addChild(sister2)
      layer1.addChild(label)
      layer.addChild( layer1, 0, kTagLayer)

      sister1.setPosition( ccp( s.width*1/3, 0))
      sister2.setPosition( ccp( s.width*2/3, 0))
      label.setPosition( ccp( s.width/2, 0))

      arr = CCArray.create()
      arr.addObject(CCTintTo.create(6, 255, 0, 255))
      arr.addObject(CCTintTo.create(6, 255, 255, 255))
      arr.addObject(CCDelayTime.create(1))

      layer1.runAction(CCRepeatForever.create(CCSequence.create(arr)))

      arr = CCArray.create()
      arr.addObject(CCTintTo.create(2, 255, 255, 0))
      arr.addObject(CCTintTo.create(2, 255, 255, 255))
      arr.addObject(CCTintTo.create(2, 0, 255, 255))
      arr.addObject(CCTintTo.create(2, 255, 255, 255))
      arr.addObject(CCTintTo.create(2, 255, 0, 255))
      arr.addObject(CCTintTo.create(2, 255, 255, 255))
      arr.addObject(CCDelayTime.create(1))

      sister1.runAction(CCRepeatForever.create(CCSequence.create(arr)))
      layer
    end
  end

  class LayerTest1 < LayerTestBase
    def title
      "ColorLayer resize (tap & move)"
    end

    def updateSize(x, y)
      s = CCDirector.sharedDirector().getWinSize()
      newSize = CCSizeMake( (x - s.width/2).abs() * 2, (y - s.height/2).abs() * 2)
      l = @layer.getChildByTag(kTagLayer)
      l.setContentSize( newSize )
    end

    def onTouchEvent(eventType, x, y)
      if eventType == CCTOUCHBEGAN
        updateSize(x, y)
        true
      else
        updateSize(x, y)
      end
    end

    def init_with_layer(layer)
      super(layer)
      layer.setTouchEnabled(true)

      s = CCDirector.sharedDirector().getWinSize()
      layer1 = CCLayerColor.create( ccc4(0xFF, 0x00, 0x00, 0x80), 200, 200)

      layer1.ignoreAnchorPointForPosition(false)
      layer1.setPosition( ccp(s.width/2, s.height/2) )
      layer.addChild(layer1, 1, kTagLayer)

      that = self
      layer.registerScriptTouchHandler(Proc.new {|*args| that.onTouchEvent(*args)}, false, -1, false)
      @layer = layer
      @layer
    end
  end

  class LayerTest2 < LayerTestBase
    def title
      "ColorLayer: fade and tint"
    end

    def init_with_layer(layer)
      super(layer)

      s = CCDirector.sharedDirector().getWinSize()
      layer1 = CCLayerColor.create( ccc4(255, 255, 0, 80), 100, 300)
      layer1.setPosition(ccp(s.width/3, s.height/2))
      layer1.ignoreAnchorPointForPosition(false)
      layer.addChild(layer1, 1)

      layer2 = CCLayerColor.create( ccc4(0, 0, 255, 255), 100, 300)
      layer2.setPosition(ccp((s.width/3)*2, s.height/2))
      layer2.ignoreAnchorPointForPosition(false)
      layer.addChild(layer2, 1)

      actionTint = CCTintBy.create(2, -255, -127, 0)
      actionTintBack = actionTint.reverse()
      arr = CCArray.create()
      arr.addObject(actionTint)
      arr.addObject(actionTintBack)
      seq1 = CCSequence.create(arr)
      layer1.runAction(seq1)

      actionFade = CCFadeOut.create(2.0)
      actionFadeBack = actionFade.reverse()
      arr = CCArray.create()
      arr.addObject(actionFade)
      arr.addObject(actionFadeBack)
      seq2 = CCSequence.create(arr)
      layer2.runAction(seq2)
      layer
    end
  end

  class LayerTestBlend < LayerTestBase
    def initialize
      super
      @scheduler = CCDirector.sharedDirector.getScheduler
    end
    def title
      "ColorLayer: blend"
    end

    def newBlend(dt)
      layer = @layer.getChildByTag(kTagLayer)

      src = 0
      dst = 0

      if  layer.getBlendFunc().dst == GL_ZERO then
        src = GL_SRC_ALPHA
        dst = GL_ONE_MINUS_SRC_ALPHA
      else
        src = GL_ONE_MINUS_DST_COLOR
        dst = GL_ZERO
      end

      bf = CC_ccBlendFunc.new()
      bf.src = src
      bf.dst = dst
      layer.setBlendFunc( bf )
    end

    def onNodeEvent(event)
      if event == kCCNodeOnEnter
        that = self
        @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new{|dt| that.newBlend(dt)}, 1.0, false)
      elsif event == kCCNodeOnExit
        @scheduler.unscheduleScriptEntry(@schedulerEntry)
      end
    end

    def init_with_layer(layer)
      super(layer)
      s = CCDirector.sharedDirector().getWinSize()
      layer1 = CCLayerColor.create( ccc4(255, 255, 255, 80) )

      sister1 = CCSprite.create($s_pPathSister1)
      sister2 = CCSprite.create($s_pPathSister2)

      layer.addChild(sister1)
      layer.addChild(sister2)
      layer.addChild(layer1, 100, kTagLayer)

      sister1.setPosition( ccp( s.width*1/3, s.height/2) )
      sister2.setPosition( ccp( s.width*2/3, s.height/2) )

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.onNodeEvent(tag)})
      layer
    end
  end

  class LayerGradient < LayerTestBase
    def title
      "LayerGradient"
    end
    def subtitle
      "Touch the screen and move your finger"
    end

    def toggleItem(*args)
      # cclog("toggleItem")
      gradient = @layer.getChildByTag(kTagLayer)
      gradient.setCompressedInterpolation(!gradient.isCompressedInterpolation())
    end

    def onTouchEvent(eventType, x, y)
      if eventType == CCTOUCHBEGAN
        true
      elsif eventType == CCTOUCHMOVED
        s = CCDirector.sharedDirector().getWinSize()
        start = ccp(x, y)

        diff = ccpSub( ccp(s.width/2,s.height/2), start)
        diff = ccpNormalize(diff)

        gradient = @layer.getChildByTag(1)
        gradient.setVector(diff)
      end
    end

    def init_with_layer(layer)
      super(layer)
      layer1 = CCLayerGradient.create(ccc4(255,0,0,255), ccc4(0,255,0,255), ccp(0.9, 0.9))
      layer.addChild(layer1, 0, kTagLayer)

      layer.setTouchEnabled(true)

      label1 = CCLabelTTF.create("Compressed Interpolation. Enabled", "Marker Felt", 26)
      label2 = CCLabelTTF.create("Compressed Interpolation. Disabled", "Marker Felt", 26)
      item1 = CCMenuItemLabel.create(label1)
      item2 = CCMenuItemLabel.create(label2)
      item = CCMenuItemToggle.create(item1)
      item.addSubItem(item2)

      that = self
      item.registerScriptTapHandler(Proc.new{|*args| that.toggleItem(*args)})

      menu = CCMenu.createWithItem(item)
      layer.addChild(menu)
      s = CCDirector.sharedDirector().getWinSize()
      menu.setPosition(ccp(s.width / 2, 100))

      layer.registerScriptTouchHandler(Proc.new {|*args| that.onTouchEvent(*args)}, false, -1, false)
      @layer = layer
      @layer
    end
  end

  class LayerIgnoreAnchorPointPos < LayerTestBase
    def title
      "IgnoreAnchorPoint - Position"
    end
    def subtitle
      "Ignoring Anchor Point for position"
    end

    def onToggle(*args)
      pLayer = @layer.getChildByTag(kLayerIgnoreAnchorPoint)
      ignore = pLayer.isIgnoreAnchorPointForPosition()
      pLayer.ignoreAnchorPointForPosition(!ignore)
    end

    def init_with_layer(layer)
      super(layer)
      s = CCDirector.sharedDirector().getWinSize()

      l = CCLayerColor.create(ccc4(255, 0, 0, 255), 150, 150)

      l.setAnchorPoint(ccp(0.5, 0.5))
      l.setPosition(ccp( s.width/2, s.height/2))

      move = CCMoveBy.create(2, ccp(100,2))
      back = move.reverse()
      arr = CCArray.create()
      arr.addObject(move)
      arr.addObject(back)
      seq = CCSequence.create(arr)
      l.runAction(CCRepeatForever.create(seq))
      layer.addChild(l, 0, kLayerIgnoreAnchorPoint)

      child = CCSprite.create("Images/grossini.png")
      l.addChild(child)
      lsize = l.getContentSize()
      child.setPosition(ccp(lsize.width/2, lsize.height/2))

      item = CCMenuItemFont.create("Toggle ignore anchor point")
      that = self
      item.registerScriptTapHandler(Proc.new {|*args| that.onToggle(*args)})

      menu = CCMenu.createWithItem(item)
      layer.addChild(menu)

      menu.setPosition(ccp(s.width/2, s.height/2))
      @layer = layer
      @layer
    end
  end

  class LayerIgnoreAnchorPointRot < LayerTestBase
    def title
      "IgnoreAnchorPoint - Rotation"
    end
    def subtitle
      "Ignoring Anchor Point for rotations"
    end

    def onToggle(*args)
      pLayer = @layer.getChildByTag(kLayerIgnoreAnchorPoint)
      ignore = pLayer.isIgnoreAnchorPointForPosition()
      pLayer.ignoreAnchorPointForPosition(!ignore)
    end

    def init_with_layer(layer)
      super(layer)
      s = CCDirector.sharedDirector().getWinSize()

      l = CCLayerColor.create(ccc4(255, 0, 0, 255), 200, 200)

      l.setAnchorPoint(ccp(0.5, 0.5))
      l.setPosition(ccp( s.width/2, s.height/2))

      layer.addChild(l, 0, kLayerIgnoreAnchorPoint)

      rot = CCRotateBy.create(2, 360)
      l.runAction(CCRepeatForever.create(rot))


      child = CCSprite.create("Images/grossini.png")
      l.addChild(child)
      lsize = l.getContentSize()
      child.setPosition(ccp(lsize.width/2, lsize.height/2))

      item = CCMenuItemFont.create("Toogle ignore anchor point")
      that = self
      item.registerScriptTapHandler(Proc.new {|*args| that.onToggle(*args)})

      menu = CCMenu.createWithItem(item)
      layer.addChild(menu)

      menu.setPosition(ccp(s.width/2, s.height/2))
      @layer = layer
      @layer
    end
  end

  class LayerIgnoreAnchorPointScale < LayerTestBase
    def title
      "IgnoreAnchorPoint - Scale"
    end
    def subtitle
      "Ignoring Anchor Point for scale"
    end

    def onToggle(*args)
      pLayer = @layer.getChildByTag(kLayerIgnoreAnchorPoint)
      ignore = pLayer.isIgnoreAnchorPointForPosition()
      pLayer.ignoreAnchorPointForPosition(!ignore)
    end

    def init_with_layer(layer)
      super(layer)
      s = CCDirector.sharedDirector().getWinSize()

      l = CCLayerColor.create(ccc4(255, 0, 0, 255), 200, 200)

      l.setAnchorPoint(ccp(0.5, 1.0))
      l.setPosition(ccp( s.width/2, s.height/2))


      scale = CCScaleBy.create(2, 2)
      back = scale.reverse()
      arr = CCArray.create()
      arr.addObject(scale)
      arr.addObject(back)
      seq = CCSequence.create(arr)

      l.runAction(CCRepeatForever.create(seq))

      layer.addChild(l, 0, kLayerIgnoreAnchorPoint)

      child = CCSprite.create("Images/grossini.png")
      l.addChild(child)
      lsize = l.getContentSize()
      child.setPosition(ccp(lsize.width/2, lsize.height/2))

      item = CCMenuItemFont.create("Toogle ignore anchor point")
      that = self
      item.registerScriptTapHandler(Proc.new {|*args| that.onToggle(*args)})

      menu = CCMenu.createWithItem(item)
      layer.addChild(menu)

      menu.setPosition(ccp(s.width/2, s.height/2))
      @layer = layer
      @layer
    end
  end


  class LayerExtendedBlendOpacityTest < LayerTestBase
    def title
      "Extended Blend & Opacity"
    end
    def subtitle
      "You should see 3 layers"
    end

    def init_with_layer(layer)
      super(layer)
      layer1 = CCLayerGradient.create(ccc4(255, 0, 0, 255), ccc4(255, 0, 255, 255))
      layer1.setContentSize(CCSizeMake(80, 80))
      layer1.setPosition(ccp(50,50))
      layer.addChild(layer1)

      layer2 = CCLayerGradient.create(ccc4(0, 0, 0, 127), ccc4(255, 255, 255, 127))
      layer2.setContentSize(CCSizeMake(80, 80))
      layer2.setPosition(ccp(100,90))
      layer.addChild(layer2)

      layer3 = CCLayerGradient.create()
      layer3.setContentSize(CCSizeMake(80, 80))
      layer3.setPosition(ccp(150,140))
      layer3.setStartColor(ccc3(255, 0, 0))
      layer3.setEndColor(ccc3(255, 0, 255))
      layer3.setStartOpacity(255)
      layer3.setEndOpacity(255)
      blend = CC_ccBlendFunc.new()
      blend.src = GL_SRC_ALPHA
      blend.dst = GL_ONE_MINUS_SRC_ALPHA
      layer3.setBlendFunc(blend)
      layer.addChild(layer3)
      layer
    end
  end

  def initialize
    super
    [LayerTestCascadingOpacityA,
     LayerTestCascadingOpacityB,
     LayerTestCascadingOpacityC,
     LayerTestCascadingColorA,
     LayerTestCascadingColorB,
     LayerTestCascadingColorC,
     LayerTest1,
     LayerTest2,
     LayerTestBlend,
     LayerGradient,
     LayerIgnoreAnchorPointPos,
     LayerIgnoreAnchorPointRot,
     LayerIgnoreAnchorPointScale,
     LayerExtendedBlendOpacityTest,
    ].each do |klass|
      register_create_function(klass.new, :create)
    end
  end

  def create
    new_scene
  end
end
