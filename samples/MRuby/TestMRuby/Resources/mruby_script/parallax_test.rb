require "mruby_script/cctype_helper"
require "mruby_script/test_base"

class ParallaxTest < TestBase
  extend TestBaseExt
  self.supported = true

  def kTagNode
    0
  end

  module ParallaxNode
    include Cocos2d
    extend CCTypeHelper

    def self.create

      # Top Layer, a simple image
      cocos_image = CCSprite.create($s_Power)
      # scale the image (optional)
      cocos_image.setScale( 2.5 )
      # change the transform anchor point to 0,0 (optional)
      cocos_image.setAnchorPoint( ccp(0,0) )

      # Middle layer: a Tile map atlas
      tilemap = CCTileMapAtlas.create($s_TilesPng, $s_LevelMapTga, 16, 16)
      tilemap.releaseMap()

      # change the transform anchor to 0,0 (optional)
      tilemap.setAnchorPoint( ccp(0, 0) )

      # Anti Aliased images
      tilemap.getTexture().setAntiAliasTexParameters()

      # background layer: another image
      background = CCSprite.create($s_back)
      # scale the image (optional)
      background.setScale( 1.5 )
      # change the transform anchor point (optional)
      background.setAnchorPoint( ccp(0,0) )

      # create a void node, a parent node
      void_node = CCParallaxNode.create()

      # NOW add the 3 layers to the 'void' node

      # background image is moved at a ratio of 0.4x, 0.5y
      void_node.addChild(background, -1, ccp(0.4,0.5), ccp(0,0))

      # tiles are moved at a ratio of 2.2x, 1.0y
      void_node.addChild(tilemap, 1, ccp(2.2,1.0), ccp(0,-200) )

      # top image is moved at a ratio of 3.0x, 2.5y
      void_node.addChild(cocos_image, 2, ccp(3.0,2.5), ccp(200,800) )
      void_node
    end
  end

  def create_parallax1_layer
    layer = CCLayer.create
    init_with_layer(layer)

    @title_label.setString("Parallax: parent and 3 children")
    @subtitle_label.setString("")

    void_node = ParallaxNode.create

    # now create some actions that will move the 'void' node
    # and the children of the 'void' node will move at different
    # speed, thus, simulation the 3D environment
    go_up = CCMoveBy.create(4, ccp(0,-500))
    go_down = go_up.reverse()
    go = CCMoveBy.create(8, ccp(-1000,0))
    go_back = go.reverse()
    arr = CCArray.create()
    arr.addObject(go_up)
    arr.addObject(go)
    arr.addObject(go_down)
    arr.addObject(go_back)
    seq = CCSequence.create(arr)
    void_node.runAction((CCRepeatForever.create(seq)))

    layer.addChild(void_node)
    layer
  end

  def create_parallax2_layer
    layer = CCLayer.create
    init_with_layer(layer)

    @title_label.setString("Parallax: drag screen")
    @subtitle_label.setString("")

    void_node = ParallaxNode.create
    layer.addChild(void_node, 0, kTagNode)

    prev = {:x => 0, :y => 0}
    onTouchEvent = Proc.new {|eventType, x, y|
      if eventType == CCTOUCHBEGAN then
        prev[:x] = x
        prev[:y] = y
      elsif  eventType == CCTOUCHMOVED then
        node  = layer.getChildByTag(kTagNode)
        newX  = node.getPositionX()
        newY  = node.getPositionY()
        diffX = x - prev[:x]
        diffY = y - prev[:y]
        node.setPosition( ccpAdd(ccp(newX, newY), ccp(diffX, diffY)) )
        prev[:x] = x
        prev[:y] = y
      end
      true
    }

    layer.registerScriptTouchHandler(onTouchEvent, false, -1, false)
    layer.setTouchEnabled(true)
    layer
  end

  def initialize
    super
    register_create_function(self, :create_parallax1_layer)
    register_create_function(self, :create_parallax2_layer)
  end
  def create
    new_scene
  end
end
