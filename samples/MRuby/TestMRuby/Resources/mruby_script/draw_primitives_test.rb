require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class DrawPrimitivesTest < TestBase
  extend TestBaseExt
  self.supported = true

  class SubTestBase < TestBase
    include CCTypeHelper

    def title
      "No title"
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

    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end
  end

  class DrawPrimitivesTest < SubTestBase
    class DrawPrimitivesNode < GLNode
      include Cocos2d
      include GL
      include CCTypeHelper

      def draw
        CHECK_GL_ERROR_DEBUG()

        # draw a simple line
        # The default state is:
        # Line Width: 1
        # color: 255,255,255,255 (white, non-transparent)
        # Anti-Aliased
        #	glEnable(GL_LINE_SMOOTH)
        ccDrawLine( VisibleRect.leftBottom(), VisibleRect.rightTop() )

        CHECK_GL_ERROR_DEBUG()

        # line: color, width, aliased
        # glLineWidth > 1 and GL_LINE_SMOOTH are not compatible
        # GL_SMOOTH_LINE_WIDTH_RANGE = (1,1) on iPhone
        #	glDisable(GL_LINE_SMOOTH)
        glLineWidth( 5.0 )
        ccDrawColor4B(255,0,0,255)
        ccDrawLine( VisibleRect.leftTop(), VisibleRect.rightBottom() )

        CHECK_GL_ERROR_DEBUG()

        # TIP:
        # If you are going to use always the same color or width, you don't
        # need to call it before every draw
        #
        # Remember: OpenGL is a state-machine.
    
        # draw big point in the center
        ccPointSize(64)
        ccDrawColor4B(0,0,255,128)
        ccDrawPoint( VisibleRect.center() )

        CHECK_GL_ERROR_DEBUG()

        # draw 4 small points
        points = [ccp(60,60), ccp(70,70), ccp(60,70), ccp(70,60)]
        ccPointSize(4)
        ccDrawColor4B(0,255,255,255)
        ccDrawPoints( points, 4)

        CHECK_GL_ERROR_DEBUG()

        # draw a green circle with 10 segments
        glLineWidth(16)
        ccDrawColor4B(0, 255, 0, 255)
        ccDrawCircle( VisibleRect.center(), 100, 0, 10, false)

        CHECK_GL_ERROR_DEBUG()

        # draw a green circle with 50 segments with line to center
        glLineWidth(2)
        ccDrawColor4B(0, 255, 255, 255)
        ccDrawCircle( VisibleRect.center(), 50, CC_DEGREES_TO_RADIANS(90), 50, true)

        CHECK_GL_ERROR_DEBUG()

        # open yellow poly
        ccDrawColor4B(255, 255, 0, 255)
        glLineWidth(10)
        vertices = [ccp(0,0), ccp(50,50), ccp(100,50), ccp(100,100), ccp(50,100)]
        ccDrawPoly( vertices, 5, false)

        CHECK_GL_ERROR_DEBUG()

        # filled poly
        glLineWidth(1)
        filledVertices = [ccp(0,120), ccp(50,120), ccp(50,170), ccp(25,200), ccp(0,170)]
        ccDrawSolidPoly(filledVertices, 5, ccc4f(0.5, 0.5, 1, 1 ) )


        # closed purble poly
        ccDrawColor4B(255, 0, 255, 255)
        glLineWidth(2)
        vertices2 = [ccp(30,130), ccp(30,230), ccp(50,200)]
        ccDrawPoly( vertices2, 3, true)

        CHECK_GL_ERROR_DEBUG()

        # draw quad bezier path
        ccDrawQuadBezier(VisibleRect.leftTop(), VisibleRect.center(), VisibleRect.rightTop(), 50)

        CHECK_GL_ERROR_DEBUG()

        # draw cubic bezier path
        ccDrawCubicBezier(VisibleRect.center(), ccp(VisibleRect.center().x+30,VisibleRect.center().y+50), ccp(VisibleRect.center().x+60,VisibleRect.center().y-50),VisibleRect.right(),100)

        CHECK_GL_ERROR_DEBUG()

        #draw a solid polygon
        vertices3 = [ccp(60,160), ccp(70,190), ccp(100,190), ccp(90,160)]
        ccDrawSolidPoly( vertices3, 4, ccc4f(1,1,0,1) )

        # restore original values
        glLineWidth(1)
        ccDrawColor4B(255,255,255,255)
        ccPointSize(1)

        CHECK_GL_ERROR_DEBUG()
      end
    end

    def title
      "draw primitives"
    end

    def subtitle
      "Drawing Primitives. Use CCDrawNode instead"
    end

    def init_with_layer(layer)
      super(layer)
      #node = DrawPrimitivesNode.create
      node = DrawPrimitivesNode.new
      node.init
      #node.registerScriptDrawHandler(Proc.new {that.draw})
      layer.addChild(node)
      layer
    end
  end

  class DrawNodeTest < SubTestBase
    def init_with_layer(layer)
      super(layer)
      s = @@size

      draw = CCDrawNode.create
      layer.addChild(draw)

      10.times do |i|
        draw.drawDot(ccp(s.width/2, s.height/2), 10*(10-i),
                      ccc4f(CCRANDOM_0_1(), CCRANDOM_0_1(), CCRANDOM_0_1(), 1))
      end

      # Draw polygons
      points = [ccp(s.height/4,0), ccp(s.width,s.height/5),
                ccp(s.width/3*2,s.height)]
      draw.drawPolygon(points, points.size, ccc4f(1,0,0,0.5), 4, ccc4f(0,0,1,1))
    
      # star poly (triggers buggs)
      o=80
      w=20
      h=50
      star = [
              ccp(o+w,o-h), ccp(o+w*2, o), # lower spike
              ccp(o + w*2 + h, o+w ), ccp(o + w*2, o+w*2),  # right spike
              #{o +w, o+w*2+h}, {o,o+w*2},					# top spike
              #{o -h, o+w}, {o,o},							# left spike
             ]
        
      draw.drawPolygon(star, star.size, ccc4f(1,0,0,0.5), 1, ccc4f(0,0,1,1))
    
      # star poly (doesn't trigger bug... order is important un tesselation is supported.
      o = 180
      w = 20
      h = 50
      star = [
              ccp(o, o), ccp(o + w, o - h), ccp(o + w * 2, o),   # lower spike
              ccp(o + w * 2 + h, o + w ), ccp(o + w * 2, o + w * 2), # right spike
              ccp(o + w, o + w * 2 + h), ccp(o, o + w * 2), # top spike
              ccp(o - h, o + w),                       # left spike
             ]

      draw.drawPolygon(star, star.size, ccc4f(1,0,0,0.5), 1, ccc4f(0,0,1,1))

      # Draw segment
      draw.drawSegment(ccp(20,s.height), ccp(20,s.height/2), 10, ccc4f(0, 1, 0, 1))

      draw.drawSegment(ccp(10,s.height/2), ccp(s.width/2, s.height/2),
                       40, ccc4f(1, 0, 1, 0.5))
    end

    def title
      "Test CCDrawNode"
    end

    def subtitle
      "Testing DrawNode - batched draws. Concave polygons are BROKEN"
    end
  end

  def initialize
    super
    [
     DrawPrimitivesTest, #not supported!
     DrawNodeTest,
    ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end
