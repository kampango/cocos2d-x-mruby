require "mruby_script/cc_event_type"
require "mruby_script/ccgl_program_constant"
require "mruby_script/test_base"

module GL
  include GLConstant

  def self.getSupportedExtensions
    glGetString(GL_EXTENSIONS).split(" ")
  end

  def self.createTexture
    texture = []
    glGenTextures(1, texture)
    texture[0]
  end

  def self.createBuffer
    buffers = []
    glGenBuffers(1, buffers)
    buffers[0]
  end

  def self.getActiveAttrib(program, index)
    length = []
    size = []
    type = []
    name = ""
    glGetActiveAttrib(program, index, 127, length, size, type, name)
    {:size => size[0], :type => type[0], :name => name}
  end

  def self.getActiveUniform(program, index)
    length = []
    size = []
    type = []
    name =""
    glGetActiveUniform(program, index, 127, length, size, type, name)
    {:size => size[0], :type => type[0], :name => name}
  end

  def self.getAttachedShaders(program)
    count = []
    shaders = []
    glGetAttachedShaders(program, 16, count, shaders)
    #{:count => count[0], :shaders => shaders[0]}
    [count[0], shaders[0]]
  end
end


class ShaderTest < TestBase
  extend TestBaseExt
  self.supported = true

  class ShaderTestDemo < TestBase
    include Cocos2d
    include CCTypeHelper
    include GL

    def init_with_layer(layer)
      super(layer)
      @layer = layer
      @title_label.setString(self.title)
      @title_label.setZOrder(1)
      @title_label.setColor(ccRED)
      @subtitle_label.setString(self.subtitle)
      @subtitle_label.setZOrder(1)
      layer
    end

    def self.create
      layer = CCLayer.create
      self.new.init_with_layer(layer)
      layer
    end
  end

  class ShaderNode < GLNode
    include Cocos2d
    include CCTypeHelper
    include Cocos2d::Extension
    include GL

    SIZE_X = 256
    SIZE_Y = 256

    def CC_NODE_DRAW_SETUP
      ccGLEnable(getGLServerState())
      raise "No shader program set for this node" if getShaderProgram().nil?
      getShaderProgram().use()
      getShaderProgram().setUniformsForBuiltins()
    end

    def initalize
      super
      @center = vertex2(0.0, 0.0)
      @resolution = vertex2(0.0, 0.0)
      @time = 0.0
      @uniformCenter = 0
      @uniformResolution = 0
      @uniformTime = 0
      @vertFileName
      @fragFileName

      that = self
      registerScriptHandler(Proc.new {|tag|
                              if tag == Cocos2d.kCCNodeOnEnter
                                that.onEnter
                              elsif tag == Cocos2d.kCCNodeOnExit
                                that.onExit
                              end})
    end

    def self.shaderNodeWithVertex(vert, frag)
      node = ShaderNode.new
      node.initWithVertex(vert, frag)
      node
    end

    def initWithVertex(vert, frag)
      init
      CCNotificationCenter.sharedNotificationCenter()
        .addObserver(self, :listenBackToForeground,
                     Cocos2d.EVNET_COME_TO_FOREGROUND, nil)

      loadShaderVertex(vert, frag)

      @time = 0
      @resolution = vertex2(SIZE_X, SIZE_Y)

      setContentSize(CCSizeMake(SIZE_X, SIZE_Y))
      setAnchorPoint(ccp(0.5, 0.5))

      @vertFileName = vert
      @fragFileName = frag

      that = self
      scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)
      true
    end

    def onEnter
    end

    def onExit
      CCNotificationCenter.sharedNotificationCenter()
        .removeObserver(self, Cocos2d.EVNET_COME_TO_FOREGROUND)
    end

    def listenBackToForeground(obj)
      setShaderProgram(nil)
      loadShaderVertex(@vertFileName, @fragFileName)
    end

    def loadShaderVertex(vert, frag)
      shader = CCGLProgram.new
      shader.initWithVertexShaderFilename(vert, frag)

      shader.addAttribute("aVertex", kCCVertexAttrib_Position)
      shader.link()

      shader.updateUniforms()

      @uniformCenter = glGetUniformLocation(shader.getProgram(), "center")
      @uniformResolution = glGetUniformLocation(shader.getProgram(), "resolution")
      @uniformTime = glGetUniformLocation(shader.getProgram(), "time")

      setShaderProgram(shader)
    end

    def update(dt)
      @time += dt
      position = getPosition()
      @center = vertex2(position.x * CC_CONTENT_SCALE_FACTOR(),
                        position.y * CC_CONTENT_SCALE_FACTOR())
    end

    def draw
      return if @center.nil?

      CC_NODE_DRAW_SETUP()

      w = SIZE_X
      h = SIZE_Y
      vertices = [0,0, w,0, w,h, 0,0, 0,h, w,h]

      #
      # Uniforms
      #
      getShaderProgram().setUniformLocationWith2f(@uniformCenter, @center.x, @center.y)

      getShaderProgram().setUniformLocationWith2f(@uniformResolution, @resolution.x, @resolution.y)

      # time changes all the time, so it is Ok to call OpenGL directly, and not the "cached" version
      glUniform1f(@uniformTime, @time)

      ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position )

      glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices)

      glDrawArrays(GL_TRIANGLES, 0, 6)
    
      #CC_INCREMENT_GL_DRAWS(1)
    end
  end

  class ShaderMonjori < ShaderTestDemo
    def init_with_layer(layer)
      super(layer)
      sn = ShaderNode.shaderNodeWithVertex("Shaders/example_Monjori.vsh",
                                           "Shaders/example_Monjori.fsh")

      s = @@size
      sn.setPosition(ccp(s.width/2, s.height/2))

      layer.addChild(sn)
      layer
    end

    def title
      "Shader: Frag shader"
    end

    def subtitle
      "Monjori plane deformations"
    end
  end

  class ShaderMandelbrot < ShaderTestDemo
    def init_with_layer(layer)
      super(layer)
      sn = ShaderNode.shaderNodeWithVertex("Shaders/example_Mandelbrot.vsh",
                                           "Shaders/example_Mandelbrot.fsh")

      s = @@size
      sn.setPosition(ccp(s.width/2, s.height/2))

      layer.addChild(sn)
      layer
    end

    def title
      "Shader: Frag shader"
    end

    def subtitle
      "Mandelbrot shader with Zoom"
    end
  end

  class ShaderJulia < ShaderTestDemo
    def init_with_layer(layer)
      super(layer)
      sn = ShaderNode.shaderNodeWithVertex("Shaders/example_Julia.vsh",
                                           "Shaders/example_Julia.fsh")

      s = @@size
      sn.setPosition(ccp(s.width/2, s.height/2))

      layer.addChild(sn)
      layer
    end

    def title
      "Shader: Frag shader"
    end

    def subtitle
      "Julia shader"
    end
  end

  class ShaderHeart < ShaderTestDemo
    def init_with_layer(layer)
      super(layer)
      sn = ShaderNode.shaderNodeWithVertex("Shaders/example_Heart.vsh",
                                           "Shaders/example_Heart.fsh")

      s = @@size
      sn.setPosition(ccp(s.width/2, s.height/2))

      layer.addChild(sn)
      layer
    end

    def title
      "Shader: Frag shader"
    end

    def subtitle
      "Heart"
    end
  end

  class ShaderFlower < ShaderTestDemo
    def init_with_layer(layer)
      super(layer)
      sn = ShaderNode.shaderNodeWithVertex("Shaders/example_Flower.vsh",
                                           "Shaders/example_Flower.fsh")

      s = @@size
      sn.setPosition(ccp(s.width/2, s.height/2))

      layer.addChild(sn)
      layer
    end

    def title
      "Shader: Frag shader"
    end

    def subtitle
      "Flower"
    end
  end

  class ShaderPlasma < ShaderTestDemo
    def init_with_layer(layer)
      super(layer)
      sn = ShaderNode.shaderNodeWithVertex("Shaders/example_Plasma.vsh",
                                           "Shaders/example_Plasma.fsh")

      s = @@size
      sn.setPosition(ccp(s.width/2, s.height/2))

      layer.addChild(sn)
      layer
    end

    def title
      "Shader: Frag shader"
    end

    def subtitle
      "Plasma"
    end
  end

  class ShaderRetroEffect < ShaderTestDemo
    include CCGLProgramConstant

    def initialize
      super
      @pLabel = nil
      @fAccum = 0.0
    end

    def init_with_layer(layer)
      super(layer)
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    elsif tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})

      fragSource = CCString.createWithContentsOfFile(CCFileUtils.sharedFileUtils().fullPathForFilename("Shaders/example_HorizontalColor.fsh")).getCString()

      p = CCGLProgram.new
      p.initWithVertexShaderByteArray(ccPositionTexture_vert, fragSource)

      p.addAttribute(kCCAttributeNamePosition, kCCVertexAttrib_Position)
      p.addAttribute(kCCAttributeNameTexCoord, kCCVertexAttrib_TexCoords)

      p.link()
      p.updateUniforms()

      s = @@size

      @pLabel = CCLabelBMFont.create("RETRO EFFECT", "fonts/west_england-64.fnt")
      @pLabel.setShaderProgram(p)
      @pLabel.setPosition(ccp(s.width/2,s.height/2))

      layer.addChild(@pLabel)
      layer
    end

    def onEnter
      that = self
      @layer.scheduleUpdateWithPriorityLua(Proc.new {|dt| that.update(dt)}, 0)
    end

    def onExit
    end

    def update(dt)
      @fAccum += dt

      i = 0
      pArray = @pLabel.getChildren()
      pArray.each do |sprite|
        i += 1
        oldPosition = sprite.getPosition()
        sprite.setPosition(ccp(oldPosition.x, Math.sin( @fAccum * 2 + i/2.0) * 20))

        # add fabs() to prevent negative scaling
        scaleY = ( Math.sin( @fAccum * 2 + i/2.0 + 0.707) )

        sprite.setScaleY(scaleY)
      end
    end

    def title
      "Shader: Retro test"
    end

    def subtitle
      "sin() effect with moving colors"
    end
  end

  class ShaderFail < ShaderTestDemo
    # ShaderFail
    @@shader_frag_fail =<<EOS
#ifdef GL_ES
precision lowp float;
#endif

varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;

vec4 colors[10];

void main(void)
{
colors[0] = vec4(1,0,0,1);
colors[1] = vec4(0,1,0,1);
colors[2] = vec4(0,0,1,1);
colors[3] = vec4(0,1,1,1);
colors[4] = vec4(1,0,1,1);
colors[5] = vec4(1,1,0,1);
colors[6] = vec4(1,1,1,1);
colors[7] = vec4(1,0.5,0,1);
colors[8] = vec4(1,0.5,0.5,1);
colors[9] = vec4(0.5,0.5,1,1);

int y = int( mod(gl_FragCoord.y / 3.0, 10.0 ) );
gl_FragColor = colors[z] * texture2D(CC_Texture0, v_texCoord);
}
EOS

    

    def init_with_layer(layer)
      super(layer)
      p = CCGLProgram.new
      p.initWithVertexShaderByteArray(ccPositionTexture_vert, @@shader_frag_fail)

      p.addAttribute(kCCAttributeNamePosition, kCCVertexAttrib_Position)
      p.addAttribute(kCCAttributeNameTexCoord, kCCVertexAttrib_TexCoords)

      p.link()
      p.updateUniforms()
      layer
    end

    def title
      "Shader: Invalid shader"
    end

    def subtitle
      "See console for output with useful error log"
    end
  end

  class GLSubTestBase < ShaderTestDemo
    def init_with_layer(layer)
      super(layer)
      that = self
      layer.registerScriptHandler(Proc.new {|tag|
                                    if tag == Cocos2d.kCCNodeOnEnter
                                      that.onEnter
                                    elsif tag == Cocos2d.kCCNodeOnExit
                                      that.onExit
                                    end})
      layer
    end

    def onEnter
      @scheduler = CCDirector.sharedDirector.getScheduler
      that = self
      @entry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.onTest(dt)},
                                             0.5, false)
    end

    def onExit
    end

    def onTest(dt)
      cclog( getCurrentResult() )
      @scheduler.unscheduleScriptEntry(@entry)
      @entry = nil
    end
  end

  class GLGetActiveTest < GLSubTestBase
    def init_with_layer(layer)
      super(layer)
      winSize = @@size
      @sprite = CCSprite.create("Images/grossini.png")
      @sprite.setPosition( ccp(winSize.width/2, winSize.height/2) )
      layer.addChild( @sprite )

      # after auto test
      #layer.scheduleOnce( this.onTest, 0.5 )

      layer
    end

    def title
      "glGetActive***"
    end

    def subtitle
      "Tests glGetActiveUniform / glGetActiveAttrib. See console"
    end

    #
    # Automation
    #
    def getExpectedResult
      # redish pixel
      ret = [{:size => 1, :type => 35666, :name => "a_position"},
             {:size => 1, :type => 35678, :name =>"CC_Texture"},
             [2,3]]
      ret.to_s
    end

    def getCurrentResult
      ret = []
      p = @sprite.getShaderProgram().getProgram()
      ret.push( GL.getActiveAttrib( p, 0 ) )
      ret.push( GL.getActiveUniform( p, 0 ) )
      ret.push( GL.getAttachedShaders( p ) )
      ret.to_s
    end
  end

  class TexImage2DTest < GLSubTestBase
    class TexImageGLNode < GLNode
      include Cocos2d
      include CCTypeHelper
      include GL

      def self.create
        node = self.new
        node.init
        node
      end

      def initialize
        super
        @shader = CCShaderCache.sharedShaderCache
          .programForKey("ShaderPositionTexture")
        raise "no shader" if @shader.nil?
      end

      def my_texutre=(texture)
        @my_texture = texture
      end

      def squareVertexPositionBuffer=(buf)
        @squareVertexPositionBuffer = buf
      end

      def squareVertexTextureBuffer=(buf)
        @squareVertexTextureBuffer = buf
      end

      def draw
        @shader.use()
        @shader.setUniformsForBuiltins()

        glBindTexture(GL_TEXTURE_2D, @my_texture)
        ccGLEnableVertexAttribs( kCCVertexAttribFlag_TexCoords | kCCVertexAttribFlag_Position)

        # Draw fullscreen Square
        glBindBuffer(GL_ARRAY_BUFFER, @squareVertexPositionBuffer)
        glVertexAttribPointer(kCCVertexAttribFlag_Position, 2, GL_FLOAT, GL_FALSE, 0, 0)

        glBindBuffer(GL_ARRAY_BUFFER, @squareVertexTextureBuffer)
        glVertexAttribPointer(kCCVertexAttribFlag_TexCoords, 2, GL_FLOAT, GL_FALSE, 0, 0)

        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4)

        glBindTexture(GL_TEXTURE_2D, 0)
        glBindBuffer(GL_ARRAY_BUFFER, 0)
      end
    end
    
    def init_with_layer(layer)
      super(layer)
      winSize = @@size
      glnode = TexImageGLNode.create
      layer.addChild(glnode,10)

      glnode.setPosition(ccp(winSize.width/2, winSize.height/2))
      glnode.setContentSize(CCSizeMake(128,128))
      glnode.setAnchorPoint(ccp(0.5,0.5))

      initGL()

      glnode.my_texutre = @my_texture
      glnode.squareVertexPositionBuffer = @squareVertexPositionBuffer
      glnode.squareVertexTextureBuffer = @squareVertexTextureBuffer

      layer
    end

    def initGL
      texture = @my_texture = GL.createTexture()
      glBindTexture( GL_TEXTURE_2D, texture )

      #w, h = 32, 32
      w, h = 128, 128
      pixels = Array.new(w * h * 4)
      (w * h).times do |i|
        # RGBA
        n = 4 * i
        pixels[n] = i
        pixels[n + 1] = i >> 2
        pixels[n + 2] = i >> 1
        pixels[n + 3] = 255
      end

      glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, pixels)

      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
      glBindTexture(GL_TEXTURE_2D, 0)

      #
      # Square
      #
      squareVertexPositionBuffer = @squareVertexPositionBuffer = GL.createBuffer()
      glBindBuffer(GL_ARRAY_BUFFER, squareVertexPositionBuffer)
      vertices =
        [
         128,  128,
         0,    128,
         128,  0,
         0.0,  0.0
        ]

      glBufferData(GL_ARRAY_BUFFER, vertices.size, vertices, GL_STATIC_DRAW)

      squareVertexTextureBuffer = @squareVertexTextureBuffer = GL.createBuffer()
      glBindBuffer(GL_ARRAY_BUFFER, squareVertexTextureBuffer)
      texcoords =
        [
         1.0, 1.0,
         0.0, 1.0,
         1.0, 0.0,
         0.0, 0.0
        ]
      glBufferData(GL_ARRAY_BUFFER, texcoords.size, texcoords, GL_STATIC_DRAW)
      #GL.bufferData(GL_ARRAY_BUFFER, texcoords, GL_STATIC_DRAW)
      glBindBuffer(GL_ARRAY_BUFFER, 0)
    end

    def title
      "TexImage2DTest"
    end

    def subtitle
      "Testing Texture creation"
    end

    #
    # Automation
    #
    def getExpectedResult
      # blue, red, blue
      ret = {
        "0" => 239, "1" => 123, "2" => 247, "3" => 255,
        "4" => 239, "5" => 123, "6" => 247, "7" => 255,
        "8" => 240, "9" => 124, "10" => 248, "11" => 255,
        "12" => 240, "13" => 124, "14" => 248, "15" => 255,
        "16" => 239, "17" => 123, "18" => 247, "19" => 255,
        "20" => 239, "21" => 123, "22" => 247, "23" => 255,
        "24" => 240, "25" => 124, "26" => 248, "27" => 255,
        "28" => 240, "29" => 124, "30" => 248, "31" => 255,
        "32" => 15, "33" => 131, "34" => 7, "35" => 255,
        "36" => 15, "37" => 131, "38" => 7, "39" => 255,
        "40" => 16, "41" => 132, "42" => 8, "43" => 255,
        "44" => 16, "45" => 132, "46" => 8, "47" => 255,
        "48" => 15, "49" => 131, "50" => 7, "51" => 255,
        "52" => 15, "53" => 131, "54" => 7, "55" => 255,
        "56" => 16, "57" => 132, "58" => 8, "59" => 255,
        "60" => 16, "61" => 132, "62" => 8, "63" => 255}
      ret
    end

    def getCurrentResult
      #glReadPixels(@@size.width/2-2, @@size.height/2-2,  4, 4)
      pixels = []
      glReadPixels((@@size.width / 2).to_i - 2, (@@size.height / 2).to_i - 2,
                   4, 4, GL_RGBA, GL_UNSIGNED_BYTE, pixels)
      pixels
    end
  end

  class GetSupportedExtensionsTest < GLSubTestBase
    def initialize
      super
      array = glGetString(GL_EXTENSIONS)
      cclog( array )
    end

    def title
      "GetSupportedExtensionsTest"
    end

    def subtitle
      "See console for the supported GL extensions"
    end

    #
    # Automation
    #
    def getExpectedResult
      ["Array", nil]
    end

    def getCurrentResult
      # Extensions varies from machine to machine. Just check for typeof Array
      ext = GL.getSupportedExtensions()
      type = ext.class
      n = nil
      #n = glGetExtension('do_no_exist')
      [type, n]
    end
  end

  class GLReadPixelsTest < GLSubTestBase
    def init_with_layer(layer)
      super(layer)

      winSize = @@size
      x = winSize.width
      y = winSize.height

      blue = CCLayerColor.create(ccc4(0, 0, 255, 255))
      red = CCLayerColor.create(ccc4(255, 0, 0, 255))
      green = CCLayerColor.create(ccc4(0, 255, 0, 255))
      white = CCLayerColor.create(ccc4(255, 255, 255, 255))

      blue.setScale(0.5)
      blue.setPosition(ccp(-x / 4, -y / 4))

      red.setScale(0.5)
      red.setPosition(ccp(x / 4, -y / 4))

      green.setScale(0.5)
      green.setPosition(ccp(-x / 4, y / 4))

      white.setScale(0.5)
      white.setPosition(ccp(x / 4, y / 4))

      layer.addChild(blue,0)
      layer.addChild(white,0)
      layer.addChild(green,0)
      layer.addChild(red,0)
      layer
    end

    def title
       "glReadPixels()"
    end

    def subtitle
      "Tests ReadPixels. See console"
    end

    #
    # Automation
    #
    def getExpectedResult
      # red, green, blue, white
      [[255, 0, 0, 255], [0, 255, 0,255], [0 ,0, 255, 255],[255, 255, 255, 255]]
    end

    def getCurrentResult
      x = @@size.width
      y = @@size.height

      rPixels = Array.new(4)
      gPixels = Array.new(4)
      bPixels = Array.new(4)
      wPixels = Array.new(4)

      # blue
      glReadPixels(0, 0, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, bPixels)

      # red
      glReadPixels(x-1, 0, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, rPixels)

      # green
      glReadPixels(0, y-1, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, gPixels)

      # white
      glReadPixels(x-1, y-1, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, wPixels)

      [rPixels, gPixels, bPixels, wPixels]
    end
  end

  class GLClearTest < GLSubTestBase

    class ClearTestGLNode < GLNode
      include GL
      def draw
        glClear( GL_COLOR_BUFFER_BIT )
      end
    end

    def init_with_layer(layer)
      super(layer)
      blue = CCLayerColor.create(ccc4(0, 0, 255, 255))
      layer.addChild( blue, -1 )

      node = ClearTestGLNode.new
      node.init

      layer.addChild( node, 0 )
      node.setPosition(ccp(@@size.width/2, @@size.height/2))
      layer
    end

    def title
      "glClear(GL_COLOR_BUFFER_BIT)"
    end

    def subtitle
      "Testing glClear() with GLNode"
    end

    #
    # Automation
    #
    def getExpectedResult
      # black pixel, not a blue pixel
      [0, 0, 0, 255]
    end

    def getCurrentResult
      res = []
      glReadPixels(@@size.width/2, @@size.height/2, 1, 1,
                   GL_RGBA, GL_UNSIGNED_BYTE, res)
      res
    end
  end

  class GLNodeCCAPITest < GLSubTestBase
    class TestGLNode < GLNode
      include Cocos2d
      include CCTypeHelper
      include GL

      def self.create
        node = self.new
        node.init
        node
      end

      def initialize
        super
        size = @size = CCDirector.sharedDirector.getWinSize
        setContentSize(size)
        setAnchorPoint(ccp(0.5, 0.5))
      end

      def shader=(shader)
        @shader = shader
      end
      def squareVertexPositionBuffer=(buf)
        @squareVertexPositionBuffer = buf
      end
      def squareVertexColorBuffer=(buf)
        @squareVertexColorBuffer = buf
      end
      def triangleVertexPositionBuffer=(buf)
        @triangleVertexPositionBuffer = buf
      end
      def triangleVertexColorBuffer=(buf)
        @triangleVertexColorBuffer = buf
      end

      def draw
        @shader.use
        @shader.setUniformsForBuiltins()
        ccGLEnableVertexAttribs( kCCVertexAttribFlag_Color | kCCVertexAttribFlag_Position)

        # Draw fullscreen Square
        glBindBuffer(GL_ARRAY_BUFFER, @squareVertexPositionBuffer)
        glVertexAttribPointer(kCCVertexAttribFlag_Position, 2, GL_FLOAT, GL_FALSE, 0, 0)

        glBindBuffer(GL_ARRAY_BUFFER, @squareVertexColorBuffer)
        glVertexAttribPointer(kCCVertexAttribFlag_Color, 4, GL_FLOAT, GL_FALSE, 0, 0)

        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4)

        # Draw fullscreen Triangle
        glBindBuffer(GL_ARRAY_BUFFER, @triangleVertexPositionBuffer)
        glVertexAttribPointer(kCCVertexAttribFlag_Position, 2, GL_FLOAT, GL_FALSE, 0, 0)

        glBindBuffer(GL_ARRAY_BUFFER, @triangleVertexColorBuffer)
        glVertexAttribPointer(kCCVertexAttribFlag_Color, 4, GL_FLOAT, GL_FALSE, 0, 0)

        glDrawArrays(GL_TRIANGLE_STRIP, 0, 3)

        glBindBuffer(GL_ARRAY_BUFFER, 0)

      end
    end

    def init_with_layer(layer)
      super(layer)
      glnode = TestGLNode.create
      layer.addChild(glnode,10)
      glnode.setPosition(ccp(@@size.width/2, @@size.height/2))
      @glnode = glnode

      @shader = CCShaderCache.sharedShaderCache().programForKey("ShaderPositionColor")
      initBuffers()
      glnode.shader = @shader
      glnode.squareVertexPositionBuffer = @squareVertexPositionBuffer
      glnode.squareVertexColorBuffer = @squareVertexColorBuffer
      glnode.triangleVertexPositionBuffer = @triangleVertexPositionBuffer
      glnode.triangleVertexColorBuffer = @triangleVertexColorBuffer 
      layer
    end

    def initBuffers
      winSize = @@size
      #
      # Triangle
      #
      triangleVertexPositionBuffer = @triangleVertexPositionBuffer = GL.createBuffer()
      glBindBuffer(GL_ARRAY_BUFFER, triangleVertexPositionBuffer)
      vertices =
        [
         winSize.width/2,  winSize.height,
         0.0,              0.0,
         winSize.width,    0.0
        ]

      glBufferData(GL_ARRAY_BUFFER, vertices.size, vertices, GL_STATIC_DRAW)

      triangleVertexColorBuffer = @triangleVertexColorBuffer = GL.createBuffer()
      glBindBuffer(GL_ARRAY_BUFFER, triangleVertexColorBuffer)
      colors =
        [
         1.0, 0.0, 0.0, 1.0,
         1.0, 0.0, 0.0, 1.0,
         1.0, 0.0, 0.0, 1.0
        ]
      glBufferData(GL_ARRAY_BUFFER, colors.size, colors, GL_STATIC_DRAW)

      #
      # Square
      #
      squareVertexPositionBuffer = @squareVertexPositionBuffer = GL.createBuffer()
      glBindBuffer(GL_ARRAY_BUFFER, squareVertexPositionBuffer)
      vertices =
        [
         winSize.width,  winSize.height,
         0,              winSize.height,
         winSize.width,  0,
         0,              0
        ]
      glBufferData(GL_ARRAY_BUFFER, vertices.size, vertices, GL_STATIC_DRAW)

      squareVertexColorBuffer = @squareVertexColorBuffer = GL.createBuffer()
      glBindBuffer(GL_ARRAY_BUFFER, squareVertexColorBuffer)
      colors =
        [
         0.0, 0.0, 1.0, 1.0,
         0.0, 0.0, 1.0, 1.0,
         0.0, 0.0, 1.0, 1.0,
         0.0, 0.0, 1.0, 1.0
        ]
      glBufferData(GL_ARRAY_BUFFER, colors.size, colors, GL_STATIC_DRAW)
      glBindBuffer(GL_ARRAY_BUFFER, 0)
    end

    def title
      "GLNode + cocos2d API"
    end

    def subtitle
      "blue background with a red triangle in the middle"
    end

    #
    # Automation
    #
    def getExpectedResult
      # blue, red, blue
      #ret = [{"0":0,"1":0,"2":255,"3":255},{"0":0,"1":0,"2":255,"3":255},{"0":255,"1":0,"2":0,"3":255}];
    end

    def getCurrentResult
      winSize = @@size
      ret1 = []
      glReadPixels(10, winSize.height-1,  1, 1,
                   GL_RGBA, GL_UNSIGNED_BYTE, ret1)
      ret2 = []
      glReadPixels(winSize.width-10, winSize.height-1,  1, 1,
                   GL_RGBA, GL_UNSIGNED_BYTE, ret2)
      ret3 = []
      glReadPixels(winSize.width/2, winSize.height/2,  1, 1,
                   GL_RGBA, GL_UNSIGNED_BYTE, ret3)

      [ret1,ret2,ret3]
    end
  end

  class GLTexParamterTest < GLSubTestBase
    def init_with_layer(layer)
      super(layer)
      cclog( getTexValues() )
    end

    def title
      "GLTexParamterTest"
    end

    def subtitle
      "tests glTexParameter()"
    end

    def getTexValues
      #if sys.platform == "browser"
      #  texture2d = CCTextureCache.sharedTextureCache()
      #    .textureForKey($s_pathGrossini)
      #  glBindTexture(GL_TEXTURE_2D, texture2d.getName())
      #else
        glBindTexture(GL_TEXTURE_2D, 0)
      #end

      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
      glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE )
      glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE )

      mag = []
      glGetTexParameterfv(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, mag)
      min = []
      glGetTexParameterfv(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, min)
      w_s = []
      glGetTexParameterfv(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, w_s)
      w_t = []
      glGetTexParameterfv(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, w_t)

      [mag[0], min[0], w_s[0], w_t[0]]
    end

    #
    # Automation
    #
    def getExpectedResult
      [9728.0, 9728.0, 33071.0, 33071.0]
    end

    def getCurrentResult
      getTexValues()
    end
  end

  class GLGetUniformTest < GLSubTestBase
    def init_with_layer(layer)
      super(layer)
      cclog(runTest)
      layer
    end

    def title
      "GLGetUniformTest"
    end

    def subtitle
      "tests glGetUniform()"
    end

    def runTest
      shader = CCShaderCache.sharedShaderCache()
        .programForKey("ShaderPositionTextureColor")
      program = shader.getProgram()
      shader.use()

      loc = glGetUniformLocation( program, "CC_MVPMatrix")

      @pMatrix = pMatrix = [1,2,3,4, 4,3,2,1, 1,2,4,8, 1.1,1.2,1.3,1.4]

      glUniformMatrix4fv(loc, 1, GL_FALSE, @pMatrix)
      uniform = GL.getActiveUniform( program, loc )
      p uniform
      res = Array.new(uniform[:size] * 4 * 4)
      glGetUniformfv( program, loc, res )
      res
    end

    #
    # Automation
    #
    def getExpectedResult
      [1.0, 2.0, 3.0, 4.0, 4.0, 3.0, 2.0, 1.0, 1.0, 2.0, 4.0, 8.0, 1.1, 1.2, 1.2999999, 1.3999999]
    end

    def getCurrentResult
      runTest
    end
  end

  def initialize
    super
    [
     ShaderMonjori,
     ShaderMandelbrot,
     ShaderJulia,
     ShaderHeart,
     ShaderFlower,
     ShaderPlasma,
     #ShaderBlur, #not supported subclassing
     ShaderRetroEffect,
     #ShaderFail,
     GLGetActiveTest,
     #TexImage2DTest, #broken
     GetSupportedExtensionsTest,
     GLReadPixelsTest,
     GLClearTest,
     #GLNodeWebGLAPITest, #none
     #GLNodeCCAPITest, #broken
     GLTexParamterTest,
     GLGetUniformTest
    ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end
