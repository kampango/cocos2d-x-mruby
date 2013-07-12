require "mruby_script/test_resource"
require "mruby_script/test_base"
require "mruby_script/gl_constant"

class Array
  def anyObject
    self[0]
  end
end

module Cocos2d
  def CCAffineTransformMake(*args)
    __CCAffineTransformMake(*args)
  end
  def CCPointApplyAffineTransform(*args)
    __CCPointApplyAffineTransform(*args)
  end
  def CCSizeApplyAffineTransform(*args)
    __CCSizeApplyAffineTransform(*args)
  end
end


class ClippingNodeTest < TestBase
  extend TestBaseExt
  include GLConstant

  stencilBits = []
  GL.glGetIntegerv(GL_STENCIL_BITS, stencilBits)
  if stencilBits[0] < 3
    p "Stencil must be enabled for the current CCGLView."
    self.supported = false
  else
    self.supported = true
  end

  class BaseClippingNodeTest < TestBase
    include GL
    include GLConstant
    include CCGLProgramConstant

	def kTagTitleLabel
      1
    end
	def kTagSubtitleLabel
      2
    end
	def kTagStencilNode
      100
    end
	def kTagClipperNode
      101
    end
	def kTagContentNode
      102
    end

    def init_with_layer(layer)
      super(layer)
      @layer = layer

      stencilBits = []
      glGetIntegerv(GL_STENCIL_BITS, stencilBits)
      if stencilBits[0] < 3
        cclog("Stencil must be enabled for the current CCGLView.")
      end

      @title_label.setString(self.title)
      @subtitle_label.setString(self.subtitle)

      background = CCSprite.create($s_back3)
      background.setAnchorPoint( CCPointZero )
      background.setPosition( CCPointZero )
      layer.addChild(background, -1)

      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    case tag
                                    when Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    when Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end
                                  })

      layer.registerScriptTouchHandler(Proc.new {|event, touches|
                                         case event
                                         when CCTOUCHBEGAN
                                           that.ccTouchesBegan(touches)
                                         when CCTOUCHMOVED
                                           that.ccTouchesMoved(touches)
                                         when CCTOUCHENDED
                                           that.ccTouchesEnded(touches)
                                         when CCTOUCHCANCELLED
                                           that.ccTouchesCancelled(touches)
                                         end},
                                       true, -1, false)
      setup()
      layer
    end

    def onEnter
    end

    def onExit
      CCTextureCache.sharedTextureCache().removeUnusedTextures()
    end

    def ccTouchesBegan(pTouches)
      false
    end

    def ccTouchesMoved(pTouches)
    end

    def ccTouchesEnded(pTouches)
    end

    def ccTouchesCancelled(pTouches)
      ccTouchesEnded(pTouches)
    end


    def title
      "Clipping Demo"
    end

    def subtitle
      ""
    end

    def setup
    end

    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end
  end

  class BasicTest < BaseClippingNodeTest
    def title
      "Basic Test"
    end

    def setup
      s = @@size

      stencil = stencil()
      stencil.setTag( kTagStencilNode )
      stencil.setPosition( ccp(50, 50) )
    
      clipper = clipper()
      clipper.setTag( kTagClipperNode )
      clipper.setAnchorPoint(ccp(0.5, 0.5))
      clipper.setPosition( ccp(s.width / 2 - 50, s.height / 2 - 50) )
      clipper.setStencil(stencil)
      @layer.addChild(clipper)
    
      content = content()
      content.setPosition( ccp(50, 50) )
      clipper.addChild(content)
    end

    def actionRotate
      CCRepeatForever::create(CCRotateBy::create(1.0, 90.0))
    end

    def actionScale
      scale = CCScaleBy::create(1.33, 1.5)
      acts = CCArray.create
      acts << scale
      acts << scale.reverse
      CCRepeatForever::create(CCSequence::create(acts))
    end

    def shape
      shape = CCDrawNode.create()
      triangle = []
      triangle[0] = ccp(-100, -100)
      triangle[1] = ccp(100, -100)
      triangle[2] = ccp(0, 100)

      green = ccc4f(0, 1, 0, 1)
      shape.drawPolygon(triangle, 3, green, 0, green)
      shape
    end

    def grossini
      grossini = CCSprite.create($s_pPathGrossini)
      grossini.setScale( 1.5 )
      grossini
    end

    def stencil
      nil
    end

    def clipper
      CCClippingNode.create()
    end

    def content
      nil
    end
  end

  class ScrollViewDemo < BasicTest
    def title
      "Scroll View Demo"
    end

    def subtitle
      "Move/drag to scroll the content"
    end

    def setup
      clipper = CCClippingNode.create()
      clipper.setTag( kTagClipperNode )
      clipper.setContentSize(  CCSizeMake(200, 200) )
      clipper.setAnchorPoint(  ccp(0.5, 0.5) )
      clipper.setPosition( ccp(@layer.getContentSize().width / 2,
                               @layer.getContentSize().height / 2) )
      clipper.runAction(CCRepeatForever.create(CCRotateBy.create(1, 45)))
      @layer.addChild(clipper)

      sz = clipper.getContentSize

      stencil = CCDrawNode.create()
      rectangle = []
      rectangle[0] = ccp(0, 0)
      rectangle[1] = ccp(clipper.getContentSize().width, 0)
      rectangle[2] = ccp(clipper.getContentSize().width,
                         clipper.getContentSize().height)
      rectangle[3] = ccp(0, clipper.getContentSize().height)
    
      white = ccc4f(1.0, 1.0, 1.0, 1.0)
      stencil.drawPolygon(rectangle, rectangle.size, white, 1, white)
      clipper.setStencil(stencil)

      content = CCSprite.create($s_back2)
      content.setTag( kTagContentNode )
      content.setAnchorPoint(  ccp(0.5, 0.5) )
      content.setPosition( ccp(clipper.getContentSize().width / 2,
                               clipper.getContentSize().height / 2) )
      clipper.addChild(content, -1)
    
      @bScrolling = false

      @layer.setTouchEnabled(true)
    end

    def ccTouchesBegan(pTouches)
      touch = pTouches.anyObject()
      clipper = @layer.getChildByTag(kTagClipperNode)
      point = clipper.convertToNodeSpace(CCDirector.sharedDirector().convertToGL(touch.getLocationInView()))
      rect = CCRectMake(0, 0, clipper.getContentSize().width, clipper.getContentSize().height)
      @bScrolling = rect.containsPoint(point)
      @lastPoint = point
    end

    def ccTouchesMoved(pTouches)
      return unless @bScrolling

      touch = pTouches.anyObject()
      clipper = @layer.getChildByTag(kTagClipperNode)
      point = clipper.convertToNodeSpace(CCDirector.sharedDirector().convertToGL(touch.getLocationInView()))
      diff = ccpSub(point, @lastPoint)
      content = clipper.getChildByTag(kTagContentNode)
      content.setPosition( ccpAdd(content.getPosition(), diff) )
      @lastPoint = point
    end

    def ccTouchesEnded(pTouches)
      return unless @bScrolling
      @bScrolling = false
    end
  end

  class ShapeTest < BasicTest
    def title
      "Shape Basic Test"
    end

    def subtitle
      "A DrawNode as stencil and Sprite as content"
    end

    def stencil
      node = shape()
      node.runAction(actionRotate())
      node
    end

    def content
      node = grossini()
      node.runAction(actionScale())
      node
    end
  end

  class ShapeInvertedTest < ShapeTest
    def title
      "Shape Inverted Basic Test"
    end

    def subtitle
      "A DrawNode as stencil and Sprite as content, inverted"
    end

    def clipper
      clipper = super
      clipper.setInverted(true)
      clipper
    end
  end

  class HoleDemo < BaseClippingNodeTest
    def title
      "Hole Demo"
    end

    def subtitle
      "Touch/click to poke holes"
    end

    def setup
      target = CCSprite.create($s_pPathBlock)
      target.setAnchorPoint(CCPointZero)
      target.setScale(3)
    
      @pOuterClipper = CCClippingNode.create()
      tranform = CCAffineTransformMakeIdentity()
      tranform = CCAffineTransformScale(tranform, target.getScale(), target.getScale())

      @pOuterClipper.setContentSize( CCSizeApplyAffineTransform(target.getContentSize(), tranform))
      @pOuterClipper.setAnchorPoint( ccp(0.5, 0.5) )
      @pOuterClipper.setPosition( ccpMult(ccpFromSize(@layer.getContentSize()), 0.5) )
      @pOuterClipper.runAction(CCRepeatForever.create(CCRotateBy.create(1, 45)))

      @pOuterClipper.setStencil( target )
    
      holesClipper = CCClippingNode.create()
      holesClipper.setInverted(true)
      holesClipper.setAlphaThreshold( 0.05 )
    
      holesClipper.addChild(target)
    
      @pHoles = CCNode.create()
    
      holesClipper.addChild(@pHoles)
    
      @pHolesStencil = CCNode.create()
    
      holesClipper.setStencil( @pHolesStencil)
    
      @pOuterClipper.addChild(holesClipper)
    
      @layer.addChild(@pOuterClipper)
        
      @layer.setTouchEnabled(true)
    end

    def pokeHoleAtPoint(point)
      scale = CCRANDOM_0_1() * 0.2 + 0.9
      rotation = CCRANDOM_0_1() * 360
    
      hole = CCSprite.create("Images/hole_effect.png")
      hole.setPosition( point )
      hole.setRotation( rotation )
      hole.setScale( scale )
    
      @pHoles.addChild(hole)
    
      holeStencil = CCSprite.create("Images/hole_stencil.png")
      holeStencil.setPosition( point )
      holeStencil.setRotation( rotation )
      holeStencil.setScale( scale )
    
      @pHolesStencil.addChild(holeStencil)

      @pOuterClipper.runAction(CCSequence.createWithTwoActions(CCScaleBy.create(0.05, 0.95), CCScaleTo.create(0.125, 1)))
    end

    def ccTouchesBegan(touches)
      touch = touches.anyObject()
      point = @pOuterClipper.convertToNodeSpace(CCDirector.sharedDirector().convertToGL(touch.getLocationInView()))
      rect = CCRectMake(0, 0, @pOuterClipper.getContentSize().width, @pOuterClipper.getContentSize().height)

      return if !rect.containsPoint(point)
      pokeHoleAtPoint(point)
    end
  end

  class SpriteTest < BasicTest
    def title
      "Sprite Basic Test"
    end

    def subtitle
      "A Sprite as stencil and DrawNode as content"
    end

    def stencil
      node = grossini()
      node.runAction(actionRotate())
      node
    end

    def clipper
      clipper = super
      clipper.setAlphaThreshold(0.05)
      clipper
    end

    def content
      node = shape()
      node.runAction(actionScale())
      node
    end
  end

  class SpriteNoAlphaTest < SpriteTest
    def title
      "Sprite No Alpha Basic Test"
    end

    def subtitle
      "A Sprite as stencil and DrawNode as content, no alpha"
    end

    def clipper
      clipper = super
      clipper.setAlphaThreshold(1)
      clipper
    end
  end

  class SpriteInvertedTest < SpriteTest
    def title
      "Sprite Inverted Basic Test"
    end

    def subtitle
      "A Sprite as stencil and DrawNode as content, inverted"
    end

    def clipper
      clipper = super
      clipper.setAlphaThreshold(0.05)
      clipper.setInverted(true)
      clipper
    end
  end

  class NestedTest < BaseClippingNodeTest
    @@depth = 9

    def title
      "Nested Test"
    end

    def subtitle
      "Nest 9 Clipping Nodes, max is usually 8"
    end

    def setup
      parent = @layer

      @@depth.times do |i|
        size = (225 - i * (225 / (@@depth * 2))).to_i

        clipper = CCClippingNode.create()
        clipper.setContentSize(CCSizeMake(size, size))
        clipper.setAnchorPoint(ccp(0.5, 0.5))
        clipper.setPosition( ccp(parent.getContentSize().width / 2, parent.getContentSize().height / 2) )
        clipper.setAlphaThreshold(0.05)
        clipper.runAction(CCRepeatForever.create(CCRotateBy.create(
          if i % 3 != 0 then 1.33 else 1.66 end,
          if i % 2 != 0 then 90 else -90 end)))

        parent.addChild(clipper)
        
        stencil = CCSprite.create($s_pPathGrossini)
        stencil.setScale( 2.5 - (i * (2.5 / @@depth)) )
        stencil.setAnchorPoint( ccp(0.5, 0.5) )
        stencil.setPosition( ccp(clipper.getContentSize().width / 2, clipper.getContentSize().height / 2) )
        stencil.setVisible(false)
        stencil.runAction(CCSequence.createWithTwoActions(CCDelayTime.create(i), CCShow.create()))
        clipper.setStencil(stencil)

        clipper.addChild(stencil)
        
        parent = clipper
      end
    end
  end

  class RawStencilBufferTest < BaseClippingNodeTest
    include Kazmath

    @@alphaThreshold = 0.05
    @@planeCount = 8
    @@planeColor = nil
    @@winSize = CCDirector.sharedDirector().getWinSize()

    class Node < GLNode
      def delegate=(delegate)
        @delegate = delegate
      end

      def draw
        @delegate.draw if @delegate
      end
    end

    def title
      "Raw Stencil Tests"
    end

    def subtitle
      "1:Default"
    end

    def setup
      if @@planeColor.nil?
        @@planeColor = [ccc4f(0, 0, 0, 0.65),
                        ccc4f(0.7, 0, 0, 0.6),
                        ccc4f(0, 0.7, 0, 0.55),
                        ccc4f(0, 0, 0.7, 0.5),
                        ccc4f(0.7, 0.7, 0, 0.45),
                        ccc4f(0, 0.7, 0.7, 0.4),
                        ccc4f(0.7, 0, 0.7, 0.35),
                        ccc4f(0.7, 0.7, 0.7, 0.3),
                       ]
      end

      CCDirector.sharedDirector().setAlphaBlending(true)
      node = Node.new
      node.init
      node.delegate = self
      @layer.addChild(node)

      @pSprite = CCSprite.create($s_pPathGrossini)
      @pSprite.retain() #XXX
      @pSprite.setAnchorPoint( ccp(0.5, 0) )
      @pSprite.setScale( 2.5 )
    end

    def onExit
      @pSprite.release()
      super
    end

    def draw
      winPoint = ccpFromSize(@@winSize)
      planeSize = ccpMult(winPoint, 1.0 / @@planeCount)
    
      glEnable(GL_STENCIL_TEST)
      CHECK_GL_ERROR_DEBUG()

      @@planeCount.times do |i|
        stencilPoint = ccpMult(planeSize, @@planeCount - i)
        stencilPoint.x = winPoint.x
        
        spritePoint = ccpMult(planeSize, i)
        spritePoint.x += planeSize.x / 2
        spritePoint.y = 0
        @pSprite.setPosition( spritePoint )

        self.setupStencilForClippingOnPlane(i)
        CHECK_GL_ERROR_DEBUG()

        ccDrawSolidRect(CCPointZero, stencilPoint, ccc4f(1, 1, 1, 1))

        kmGLPushMatrix()
        @layer.transform()
        @pSprite.visit()
        kmGLPopMatrix()

        self.setupStencilForDrawingOnPlane(i)
        CHECK_GL_ERROR_DEBUG()
        
        ccDrawSolidRect(CCPointZero, winPoint, @@planeColor[i])

        kmGLPushMatrix()
        @layer.transform()
        @pSprite.visit()
        kmGLPopMatrix()
      end

      glDisable(GL_STENCIL_TEST)
      CHECK_GL_ERROR_DEBUG()
    end

    def setupStencilForClippingOnPlane(plane)
      planeMask = 0x1 << plane
      glStencilMask(planeMask)
      glClearStencil(0x0)
      glClear(GL_STENCIL_BUFFER_BIT)
      glFlush()
      glStencilFunc(GL_NEVER, planeMask, planeMask)
      glStencilOp(GL_REPLACE, GL_KEEP, GL_KEEP)
    end

    def setupStencilForDrawingOnPlane(plane)
      planeMask = 0x1 << plane
      equalOrLessPlanesMask = planeMask | (planeMask - 1)
      glStencilFunc(GL_EQUAL, equalOrLessPlanesMask, equalOrLessPlanesMask)
      glStencilOp(GL_KEEP, GL_KEEP, GL_KEEP)
    end
  end

  class RawStencilBufferTest2 < RawStencilBufferTest
    def subtitle
      "2:DepthMask:FALSE"
    end

    def setupStencilForClippingOnPlane(plane)
      super(plane)
      glDepthMask(GL_FALSE)
    end

    def setupStencilForDrawingOnPlane(plane)
      glDepthMask(GL_TRUE)
      super(plane)
    end
  end

  class RawStencilBufferTest3 < RawStencilBufferTest
    def subtitle
      "3:DepthTest:DISABLE,DepthMask:FALSE"
    end

    def setupStencilForClippingOnPlane(plane)
      super(plane)
      glDisable(GL_DEPTH_TEST)
      glDepthMask(GL_FALSE)
    end

    def setupStencilForDrawingOnPlane(plane)
      glDepthMask(GL_TRUE)
      #glEnable(GL_DEPTH_TEST)
      super(plane)
    end
  end

  class RawStencilBufferTest4 < RawStencilBufferTest
    def subtitle
      "4:DepthMask:FALSE,AlphaTest:ENABLE"
    end

    def setupStencilForClippingOnPlane(plane)
      super(plane)
      glDepthMask(GL_FALSE)

      case CC.os
      when "windows", "linux", "osx"
        glEnable(GL_ALPHA_TEST)
        glAlphaFunc(GL_GREATER, @@alphaThreshold)
      else
        program = CCShaderCache.sharedShaderCache().programForKey(kCCShader_PositionTextureColorAlphaTest)
        alphaValueLocation = glGetUniformLocation(program.getProgram(), kCCUniformAlphaTestValue)
        program.setUniformLocationWith1f(alphaValueLocation, @alphaThreshold)
        @pSprite.setShaderProgram(program)
      end
    end

    def setupStencilForDrawingOnPlane(plane)
      case CC.os
      when "windows", "linux", "osx"
        glDisable(GL_ALPHA_TEST)
      else
        glDepthMask(GL_TRUE)
      end
      super(plane)
    end
  end

  class RawStencilBufferTest5 < RawStencilBufferTest
    def subtitle
      "5:DepthTest:DISABLE,DepthMask:FALSE,AlphaTest:ENABLE"
    end

    def setupStencilForClippingOnPlane(plane)
      super(plane)
      glDisable(GL_DEPTH_TEST)
      glDepthMask(GL_FALSE)

      case CC.os
      when "windows", "linux", "osx"
        glEnable(GL_ALPHA_TEST)
        glAlphaFunc(GL_GREATER, @alphaThreshold)
      else
        program = CCShaderCache.sharedShaderCache().programForKey(kCCShader_PositionTextureColorAlphaTest)
        alphaValueLocation = glGetUniformLocation(program.getProgram(), kCCUniformAlphaTestValue)
        program.setUniformLocationWith1f(alphaValueLocation, @alphaThreshold)
        @pSprite.setShaderProgram( program )
      end
    end

    def setupStencilForDrawingOnPlane(plane)
      case CC.os
      when "windows", "linux", "osx"
        glDisable(GL_ALPHA_TEST)
      else
        glDepthMask(GL_TRUE)
        #glEnable(GL_DEPTH_TEST)
      end
      super(plane)
    end
  end

  class RawStencilBufferTest6 < RawStencilBufferTest
  end

  def initialize
    super
    [
     ScrollViewDemo,
     HoleDemo,
     ShapeTest,
     ShapeInvertedTest,
     SpriteTest,
     SpriteNoAlphaTest,
     SpriteInvertedTest,
     NestedTest,
     RawStencilBufferTest,
     RawStencilBufferTest2,
     RawStencilBufferTest3,
     RawStencilBufferTest4,
     RawStencilBufferTest5,
     RawStencilBufferTest6,
    ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end
