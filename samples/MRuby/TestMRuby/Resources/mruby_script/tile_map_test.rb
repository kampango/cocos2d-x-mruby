require "mruby_script/test_base"
require "mruby_script/cctype_helper"
require "mruby_script/gl_constant"
require "mruby_script/test_resource"
require "mruby_script/visible_rect"

class Cocos2d::CCCamera
  unless method_defined? :getEyeXYZ_orig
    alias_method :getEyeXYZ_orig, :getEyeXYZ

    def getEyeXYZ(*args)
      x,y,z = if args.size == 0
                [[], [], []]
              else
                args
              end
      getEyeXYZ_orig(x, y, z)
      [x[0], y[0], z[0]]
    end
  end
end

class TileMapTest < TestBase
  extend TestBaseExt
  self.supported = true

  class TileMapTestBase < CCLayer
    include Cocos2d
    include CCTypeHelper

    def self.create(*args)
      layer = super(*args)
      layer.internal_init
      layer
    end

    def kTagTileMap
      1
    end

    def internal_init(title = "No title", subtitle = "drag the screen")
      size = CCDirector.sharedDirector.getWinSize
      @title_label = CCLabelTTF.create(title, "Arial", 28)
      addChild(@title_label, 1)
      @title_label.setPosition(ccp(size.width / 2, size.height - 50))

      @subtitle_label = CCLabelTTF.create(subtitle, "Thonburi", 16)
      addChild(@subtitle_label, 1)
      @subtitle_label.setPosition(ccp(size.width / 2, size.height - 80))

      @scheduler = CCDirector.sharedDirector.getScheduler

      layer = self

      prev = {:x => 0, :y => 0}
      on_touch_event = Proc.new {|event_type, x, y|
        if event_type == CCTOUCHBEGAN
          prev[:x] = x
          prev[:y] = y
          true
        elsif event_type == CCTOUCHMOVED
          node = layer.getChildByTag(kTagTileMap)
          new_x = node.getPositionX
          new_y = node.getPositionY
          diff_x = x - prev[:x]
          diff_y = y - prev[:y]

          node.setPosition(ccpAdd(ccp(new_x, new_y), ccp(diff_x, diff_y)))
          prev[:x] = x
          prev[:y] = y
          nil
        end
      }

      setTouchEnabled(true)
      registerScriptTouchHandler(on_touch_event, false, -1, false)
    end
  end

  class TileMapAtlasTest < TileMapTestBase
    def internal_init
      super("TileMapAtlas")

      map = CCTileMapAtlas.create($s_TilesPng,  $s_LevelMapTga, 16, 16)
      # Convert it to "alias" (GL_LINEAR filtering)
      map.getTexture().setAntiAliasTexParameters()

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      # If you are not going to use the Map, you can free it now
      # NEW since v0.7
      map.releaseMap()

      addChild(map, 0, kTagTileMap)

      map.setAnchorPoint( ccp(0, 0.5) )

      scale = CCScaleBy.create(4, 0.8)
      scaleBack = scale.reverse()
      action_arr = CCArray.create()
      action_arr.addObject(scale)
      action_arr.addObject(scaleBack)

      seq = CCSequence.create(action_arr)

      map.runAction(CCRepeatForever.create(seq))
    end
  end

  class TileMapEditTest < TileMapTestBase

    def update_map
      # If you are not going to use the Map, you can free it now
      # [tilemap releaseMap)
      # And if you are going to use, it you can access the data with.

      # IMPORTANT
      #   The only limitation is that you cannot change an empty, or assign an empty tile to a tile
      #   The value 0 not rendered so don't assign or change a tile with value 0

      tilemap = getChildByTag(kTagTileMap)

      #
      # For example you can iterate over all the tiles
      # using this code, but try to avoid the iteration
      # over all your tiles in every frame. It's very expensive
      #tilemap.getTGAInfo.width.to_i.times do |x|
      #  tilemap.getTGAInfo.height.to_i.times do |y|
      #    c = tilemap.tileAt(cpp(x,y))
      #    if c.r != 0
      #      #cclog("%d,%d = %d", x,y,c.r)
      #    end
      #  end
      #end

      # NEW since v0.7
      c = tilemap.tileAt(ccp(13,21))
      c.r += 1
      c.r %= 50

      if c.r == 0
        c.r = 1
      end
      # NEW since v0.7
      tilemap.setTile(c, ccp(13,21))
    end

    def on_enter
      that = self
      @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new {that.update_map}, 0.2, false)
    end

    def on_exit
      map = getChildByTag(kTagTileMap)
      map.releaseMap
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
    end

    def internal_init
      super("Editable TileMapAtlas")

      map = CCTileMapAtlas.create($s_TilesPng, $s_LevelMapTga, 16, 16)
      # Create an Aliased Atlas
      map.getTexture().setAliasTexParameters()

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      addChild(map, 0, kTagTileMap)

      map.setAnchorPoint( ccp(0, 0) )
      map.setPosition( ccp(-20,-200) )
    end
  end

  class TMXOrthoTest < TileMapTestBase
    def internal_init
      super("TMX Orthogonal test")
      #
      # Test orthogonal with 3d camera and anti-alias textures
      #
      # should not flicker. No artifacts should appear
      #
      #color = CCLayerColor.create( ccc4(64,64,64,255) )
      #addChild(color, -1)

      map = CCTMXTiledMap.create("TileMaps/orthogonal-test2.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      pChildrenArray = map.getChildren()
      len = pChildrenArray.count()
      len.times do |i|
        child = pChildrenArray.objectAtIndex(i)
        unless child.kind_of? CCSpriteBatchNode
          break
        end

        child.getTexture().setAntiAliasTexParameters()

        x = 0
        y = 0
        z = 0
        p map.getCamera
        x, y, z = map.getCamera().getEyeXYZ()
        cclog("before eye x=#{x},y=#{y},z=#{z}")
        map.getCamera().setEyeXYZ(x - 200, y, z + 300)
        x, y, z = map.getCamera().getEyeXYZ()
        cclog("after eye x=#{x},y=#{y},z=#{z}")
      end
    end

    def on_enter
      CCDirector.sharedDirector().setProjection(kCCDirectorProjection3D)
    end
    def on_exit
      CCDirector.sharedDirector().setProjection(kCCDirectorProjection2D)
    end
  end

  class TMXOrthoTest2 < TileMapTestBase
    def internal_init
      super("TMX Ortho test2")

      map = CCTMXTiledMap.create("TileMaps/orthogonal-test1.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      map.getChildren.each do |child|
        break if child.nil?
        child.getTexture().setAntiAliasTexParameters()
      end

      map.runAction( CCScaleBy.create(2, 0.5) )
    end
  end

  class TMXOrthoTest3 < TileMapTestBase
    def internal_init
      super("TMX anchorPoint test")
      map = CCTMXTiledMap.create("TileMaps/orthogonal-test3.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      map.getChildren.each do |child|
        break if child.nil?
        child.getTexture().setAntiAliasTexParameters()
      end

      map.setScale(0.2)
      map.setAnchorPoint( ccp(0.5, 0.5) )
    end
  end

  class TMXOrthoTest4 < TileMapTestBase
    def internal_init
      super("TMX width/height test")
      map = CCTMXTiledMap.create("TileMaps/orthogonal-test4.tmx")
      addChild(map, 0, kTagTileMap)

      s1 = map.getContentSize()
      cclog("ContentSize: %f, %f", s1.width,s1.height)

      map.getChildren.each do |child|
        break if child.nil?
        child.getTexture().setAntiAliasTexParameters()
      end

      map.setAnchorPoint(ccp(0, 0))

      layer  = map.layerNamed("Layer 0")
      s      = layer.getLayerSize()

      sprite = layer.tileAt(ccp(0,0))
      sprite.setScale(2)
      sprite       = layer.tileAt(ccp(s.width-1,0))
      sprite.setScale(2)
      sprite       = layer.tileAt(ccp(0,s.height-1))
      sprite.setScale(2)
      sprite       = layer.tileAt(ccp(s.width-1,s.height-1))
      sprite.setScale(2)

      @schedulerEntry = nil
    end

    def remove_sprite(dt)
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
      @schedulerEntry = nil
      map = getChildByTag(kTagTileMap)
      layer0 = map.layerNamed("Layer 0")
      s = layer0.getLayerSize()

      sprite = layer0.tileAt( ccp(s.width-1,0) )
      layer0.removeChild(sprite, true)
    end

    def on_enter
      that = self
      @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.remove_sprite(dt)}, 2, false)
    end

    def on_exit
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
    end
  end

  class TMXReadWriteTest < TileMapTestBase
    SID_UPDATECOL      = 100
    SID_REPAINTWITHGID = 101
    SID_REMOVETILES    = 102

    def internal_init
      super("TMX Read/Write test")
      @m_gid  = 0
      @m_gid2 = 0
      map = CCTMXTiledMap.create("TileMaps/orthogonal-test2.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)


      layer = map.layerNamed("Layer 0")
      layer.getTexture().setAntiAliasTexParameters()

      map.setScale( 1 )

      tile0 = layer.tileAt(ccp(1,63))
      tile1 = layer.tileAt(ccp(2,63))
      tile2 = layer.tileAt(ccp(3,62)) #ccp(1,62))
      tile3 = layer.tileAt(ccp(2,62))
      tile0.setAnchorPoint( ccp(0.5, 0.5) )
      tile1.setAnchorPoint( ccp(0.5, 0.5) )
      tile2.setAnchorPoint( ccp(0.5, 0.5) )
      tile3.setAnchorPoint( ccp(0.5, 0.5) )

      move = CCMoveBy.create(0.5, ccp(0,160))
      rotate = CCRotateBy.create(2, 360)
      scale = CCScaleBy.create(2, 5)
      opacity = CCFadeOut.create(2)
      fadein = CCFadeIn.create(2)
      scaleback = CCScaleTo.create(1, 1)

      removeSprite = Proc.new {|node|
        cclog("removing tile. #{node}")
        p = node.getParent()

        unless p.nil?
          p.removeChild(node, true)
          cclog("atlas quantity. %d", p.getTextureAtlas().getTotalQuads())
        end
      }


      finish = CCCallFuncN.create(removeSprite)
      arr = CCArray.create()
      arr.addObject(move)
      arr.addObject(rotate)
      arr.addObject(scale)
      arr.addObject(opacity)
      arr.addObject(fadein)
      arr.addObject(scaleback)
      arr.addObject(finish)
      seq0 = CCSequence.create(arr)
      seq1 = seq0.copy()
      seq2 = seq0.copy()
      seq3 = seq0.copy()

      tile0.runAction(seq0)
      tile1.runAction(seq1)
      tile2.runAction(seq2)
      tile3.runAction(seq3)


      @m_gid = layer.tileGIDAt(ccp(0,63))
      cclog("Tile GID at.(0,63) is. %d", @m_gid)
      @updateColScheduler     = nil
      @repainWithGIDScheduler = nil
      @removeTilesScheduler   = nil

      cclog("++++atlas quantity. %d", layer.getTextureAtlas().getTotalQuads())
      cclog("++++children. %d", layer.getChildren().count() )

      @m_gid2 = 0
    end

    def updateCol(dt)
      map = getChildByTag(kTagTileMap)
      layer = map.getChildByTag(0)

      cclog("++++atlas quantity. %d", layer.getTextureAtlas().getTotalQuads())
      cclog("++++children. %d", layer.getChildren().count() )


      s = layer.getLayerSize()
      s.height.to_i.times do |y|
        layer.setTileGID(@m_gid2, ccp(3, y))
      end

      @m_gid2 = (@m_gid2 + 1) % 80
    end

    def repaintWithGID(dt)
      #    unschedule._cmd)
      map = getChildByTag(kTagTileMap)
      layer = map.getChildByTag(0)

      s = layer.getLayerSize()
      s.width.to_i.times do |x|
        y = s.height-1
        tmpgid = layer.tileGIDAt( ccp(x, y) )
        layer.setTileGID(tmpgid+1, ccp(x, y))
      end
    end

    def removeTiles(dt)
      @scheduler.unscheduleScriptEntry(@removeTilesScheduler)
      @removeTilesScheduler = nil
      map = getChildByTag(kTagTileMap)
      layer = map.getChildByTag(0)
      s = layer.getLayerSize()
      s.height.to_i.times do |y|
        layer.removeTileAt( ccp(5.0, y) )
      end
    end

    def on_enter
      that = self
      @updateColScheduler = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.updateCol(dt)}, 2, false)
      @repainWithGIDScheduler = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.repaintWithGID(dt)}, 2.05, false)
      @removeTilesScheduler = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.removeTiles(dt)}, 1.0, false)
    end

    def on_exit
      unless @updateColScheduler.nil?
        @scheduler.unscheduleScriptEntry(@updateColScheduler)
      end

      unless @repainWithGIDScheduler.nil?
        @scheduler.unscheduleScriptEntry(@repainWithGIDScheduler)
      end

      unless @removeTilesScheduler.nil?
        @scheduler.unscheduleScriptEntry(@removeTilesScheduler)
      end
    end
  end

  class TMXHexTest < TileMapTestBase
    def internal_init
      super("TMX Hex tes")
      color = CCLayerColor.create( ccc4(64,64,64,255) )
      addChild(color, -1)

      map = CCTMXTiledMap.create("TileMaps/hexa-test.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)
    end
  end

  class TMXIsoTest < TileMapTestBase
    def internal_init
      super("TMX Isometric test 0")
      color = CCLayerColor.create( ccc4(64,64,64,255) )
      addChild(color, -1)

      map = CCTMXTiledMap.create("TileMaps/iso-test.tmx")
      addChild(map, 0, kTagTileMap)

      # move map to the center of the screen
      ms = map.getMapSize()
      ts = map.getTileSize()
      map.runAction( CCMoveTo.create(1.0, ccp( -ms.width * ts.width/2, -ms.height * ts.height/2 )) )
    end
  end

  class TMXIsoTest1 < TileMapTestBase
    def internal_init
      super("TMX Isometric test + anchorPoint")
      color = CCLayerColor.create( ccc4(64,64,64,255) )
      addChild(color, -1)

      map = CCTMXTiledMap.create("TileMaps/iso-test1.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      map.setAnchorPoint(ccp(0.5, 0.5))
    end
  end

  class TMXIsoTest2 < TileMapTestBase
    def internal_init
      super("TMX Isometric test 2")
      color = CCLayerColor.create( ccc4(64,64,64,255) )
      addChild(color, -1)

      map = CCTMXTiledMap.create("TileMaps/iso-test2.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      # move map to the center of the screen
      ms = map.getMapSize()
      ts = map.getTileSize()
      map.runAction( CCMoveTo.create(1.0, ccp( -ms.width * ts.width/2, -ms.height * ts.height/2 ) ))
    end
  end

  class TMXUncompressedTest < TileMapTestBase
    def internal_init
      super("TMX Uncompressed test")
      color = CCLayerColor.create( ccc4(64,64,64,255) )
      addChild(color, -1)

      map = CCTMXTiledMap.create("TileMaps/iso-test2-uncompressed.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      # move map to the center of the screen
      ms = map.getMapSize()
      ts = map.getTileSize()
      map.runAction(CCMoveTo.create(1.0, ccp( -ms.width * ts.width/2, -ms.height * ts.height/2 ) ))

      # testing release map
      map.getChildren.each do |layer|
        break if layer.nil?
        layer.releaseMap()
      end
    end
  end

  class TMXTilesetTest < TileMapTestBase
    def internal_init
      super("TMX Tileset test")
      map = CCTMXTiledMap.create("TileMaps/orthogonal-test5.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      layer = map.layerNamed("Layer 0")
      layer.getTexture().setAntiAliasTexParameters()

      layer = map.layerNamed("Layer 1")
      layer.getTexture().setAntiAliasTexParameters()

      layer = map.layerNamed("Layer 2")
      layer.getTexture().setAntiAliasTexParameters()
    end
  end

  class TMXOrthoObjectsTest < TileMapTestBase
    def internal_init
      super("TMX Ortho object test", "You should see a white box around the 3 platforms\nNOT SUPPORTED!")
      map = CCTMXTiledMap.create("TileMaps/ortho-objects.tmx")
      addChild(map, -1, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      cclog("---: Iterating over all the group objets")
      group   = map.objectGroupNamed("Object Group 1")
      objects = group.getObjects()

      objects.each do |dict|
        break if dict.nil?
        cclog("object: #{dict}")
      end

      cclog("---: Fetching 1 object by name")
      platform = group.objectNamed("platform")
      cclog("platform: #{platform}")
    end

    def draw
      #never called!
      map = getChildByTag(kTagTileMap)
      group = map.objectGroupNamed("Object Group 1")

      objects = group.getObjects()
      objects.each do |dict|
        p dict
        break if dict.nil?

        key = "x"
        x = dict.objectForKey(key).getCString.to_i
        key = "y"
        y = dict.objectForKey(key).getCString.to_i #dynamic_cast<NSNumber*>(dict:objectForKey("y")):getNumber()
        key = "width"
        width = dict.objectForKey(key).getCString.to_i #dynamic_cast<NSNumber*>(dict:objectForKey("width")):getNumber()
        key = "height"
        height = dict.objectForKey(key).getCString.to_i #dynamic_cast<NSNumber*>(dict:objectForKey("height")):getNumber()

        glLineWidth(3)

        ccDrawLine( ccp(x, y), ccp((x+width), y) )
        ccDrawLine( ccp((x+width), y), ccp((x+width), (y+height)) )
        ccDrawLine( ccp((x+width), (y+height)), ccp(x, (y+height)) )
        ccDrawLine( ccp(x, (y+height)), ccp(x, y) )

        glLineWidth(1)
      end
    end
  end

  class TMXIsoObjectsTest < TileMapTestBase
    def internal_init
      super("TMX Iso object test", "You need to parse them manually. See bug #810\nNOT SUPPORTED!")
      map = CCTMXTiledMap.create("TileMaps/iso-test-objectgroup.tmx")
      addChild(map, -1, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      group = map.objectGroupNamed("Object Group 1")

      #UxMutableArray* objects = group.objects()
      objects = group.getObjects()
      #UxMutableDictionary<std:string>* dict
      objects.each do |dict|
        break if dict.nil?
        cclog("object: #{dict}")
      end
    end

    def draw
      # never called!
      map = getChildByTag(kTagTileMap)
      group = map.objectGroupNamed("Object Group 1")

      objects = group.getObjects()
      objects.each do |dict|
        break if dict.nil?

        key = "x"
        x = dict.objectForKey(key).getCString.to_i #dynamic_cast<NSNumber*>(dict:objectForKey("x")):getNumber()
        key = "y"
        y = dict.objectForKey(key).getCString.to_i #dynamic_cast<NSNumber*>(dict:objectForKey("y")):getNumber()
        key = "width"
        width = dict.objectForKey(key).getCString.to_i #dynamic_cast<NSNumber*>(dict:objectForKey("width")):getNumber()
        key = "height"
        height = dict.objectForKey(key).getCString.to_i #dynamic_cast<NSNumber*>(dict:objectForKey("height")):getNumber()

        glLineWidth(3)

        ccDrawLine( ccp(x,y), ccp(x+width,y) )
        ccDrawLine( ccp(x+width,y), ccp(x+width,y+height) )
        ccDrawLine( ccp(x+width,y+height), ccp(x,y+height) )
        ccDrawLine( ccp(x,y+height), ccp(x,y) )

        glLineWidth(1)
      end
    end
  end

  class TMXResizeTest < TileMapTestBase
    def internal_init
      super("TMX resize test", "Should not crash. Testing issue #740")
      map = CCTMXTiledMap.create("TileMaps/orthogonal-test5.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      layer = map.layerNamed("Layer 0")
      ls = layer.getLayerSize()
      ls.height.to_i.times do |y|
        ls.width.to_i.times do |x|
          layer.setTileGID(1, ccp( x, y ) )
        end
      end
    end
  end

  class TMXIsoZorder < TileMapTestBase
    def internal_init
      super("TMX Iso Zorder", "Sprite should hide behind the trees")
      map = CCTMXTiledMap.create("TileMaps/iso-test-zorder.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)
      map.setPosition(ccp(-s.width/2,0))

      @m_tamara = CCSprite.create($s_pPathSister1)
      map.addChild(@m_tamara, map.getChildren().count() )
      #@m_tamara.retain()
      mapWidth = map.getMapSize().width * map.getTileSize().width
      @m_tamara.setPosition(CC_POINT_PIXELS_TO_POINTS(ccp( mapWidth/2,0)))
      @m_tamara.setAnchorPoint(ccp(0.5,0))

      move = CCMoveBy.create(10, ccp(300,250))
      back = move.reverse()
      arr  = CCArray.create()
      arr.addObject(move)
      arr.addObject(back)
      seq = CCSequence.create(arr)
      @m_tamara.runAction( CCRepeatForever.create(seq) )

      @schedulerEntry = nil
    end

    def repositionSprite(dt)
      p = @m_tamara.getPosition()
      p = CC_POINT_POINTS_TO_PIXELS(p)
      map = getChildByTag(kTagTileMap)

      # there are only 4 layers. (grass and 3 trees layers)
      # if tamara < 48, z=4
      # if tamara < 96, z=3
      # if tamara < 144,z=2

      newZ = 4 - (p.y / 48)
      newZ = [newZ, 0].max

      map.reorderChild(@m_tamara, newZ)
    end

    def on_enter
      that = self
      @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.repositionSprite(dt)}, 0, false)
    end
    def on_exit
      #@m_tamara.release() unless @m_tamara.nil?
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
    end
  end

  class TMXOrthoZorder < TileMapTestBase
    def internal_init
      super("TMX Ortho Zorder", "Sprite should hide behind the trees")
      map = CCTMXTiledMap.create("TileMaps/orthogonal-test-zorder.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      @m_tamara = CCSprite.create($s_pPathSister1)
      map.addChild(@m_tamara,  map.getChildren().count())
      #@m_tamara.retain()
      @m_tamara.setAnchorPoint(ccp(0.5,0))


      move = CCMoveBy.create(10, ccp(400,450))
      back = move.reverse()
      arr = CCArray.create()
      arr.addObject(move)
      arr.addObject(back)
      seq = CCSequence.create(arr)
      @m_tamara.runAction( CCRepeatForever.create(seq))

      @schedulerEntry = nil
    end

    def repositionSprite(dt)
      p = @m_tamara.getPosition()
      p = CC_POINT_POINTS_TO_PIXELS(p)
      map = getChildByTag(kTagTileMap)

      # there are only 4 layers. (grass and 3 trees layers)
      # if tamara < 81, z=4
      # if tamara < 162, z=3
      # if tamara < 243,z=2

      # -10: customization for this particular sample
      newZ = 4 - ( (p.y-10) / 81)
      newZ = [newZ, 0].max
      map.reorderChild(@m_tamara, newZ)
    end

    def on_enter
      that = self
      @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.repositionSprite(dt)}, 0, false)
    end
    def on_exit
      #@m_tamara.release() unless @m_tamara.nil?
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
    end
  end

  class TMXIsoVertexZ < TileMapTestBase
    def internal_init
      super("TMX Iso VertexZ", "Sprite should hide behind the trees")
      map = CCTMXTiledMap.create("TileMaps/iso-test-vertexz.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      map.setPosition( ccp(-s.width/2,0) )
      cclog("ContentSize: %f, %f", s.width,s.height)

      # because I'm lazy, I'm reusing a tile as an sprite, but since this method uses vertexZ, you
      # use any CCSprite and it will work OK.
      layer = map.layerNamed("Trees")
      @m_tamara = layer.tileAt( ccp(29,29) )
      #@m_tamara.retain()
      @offset = @m_tamara.getVertexZ
      p @offset

      move = CCMoveBy.create(10, ccpMult( ccp(300,250), 1/CC_CONTENT_SCALE_FACTOR() ) )
      back = move.reverse()
      arr  = CCArray.create()
      arr.addObject(move)
      arr.addObject(back)
      seq = CCSequence.create(arr)
      @m_tamara.runAction( CCRepeatForever.create(seq) )

      @schedulerEntry = nil
    end

    def repositionSprite(dt)
      # tile height is 64x32
      # map size: 30x30
      p = @m_tamara.getPosition()
      p = CC_POINT_POINTS_TO_PIXELS(p)
      newZ = -(p.y+32) /16
      @m_tamara.setVertexZ( newZ )
    end

    def on_enter
      # TIP. 2d projection should be used
      CCDirector.sharedDirector().setProjection(kCCDirectorProjection2D)
      that = self
      @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.repositionSprite(dt)}, 0, false)
    end
    def on_exit
      # At exit use any other projection.
      #    CCDirector.sharedDirector().setProjection.kCCDirectorProjection3D)
      #@m_tamara.release() unless @m_tamara.nil?
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
    end
  end

  class TMXOrthoVertexZ < TileMapTestBase
    def internal_init
      super("TMX Ortho vertexZ", "Sprite should hide behind the trees")
      map = CCTMXTiledMap.create("TileMaps/orthogonal-test-vertexz.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      # because I'm lazy, I'm reusing a tile as an sprite, but since this method uses vertexZ, you
      # can use any CCSprite and it will work OK.
      layer = map.layerNamed("trees")
      @m_tamara = layer.tileAt(ccp(0,11))
      cclog("vertexZ:#{@m_tamara.getVertexZ}")
      #@m_tamara.retain()

      move = CCMoveBy.create(10, ccpMult( ccp(400,450), 1/CC_CONTENT_SCALE_FACTOR()))
      back = move.reverse()
      arr  = CCArray.create()
      arr.addObject(move)
      arr.addObject(back)
      seq = CCSequence.create(arr)
      @m_tamara.runAction( CCRepeatForever.create(seq))

      @schedulerEntry = nil
    end

    def repositionSprite(dt)
      # tile height is 101x81
      # map size: 12x12
      p = @m_tamara.getPosition()
      p = CC_POINT_POINTS_TO_PIXELS(p)
      @m_tamara.setVertexZ( -( (p.y+81) /81) )
    end

    def on_enter
      # TIP: 2d projection should be used
      CCDirector.sharedDirector().setProjection(kCCDirectorProjection2D)
      that = self
      @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.repositionSprite(dt)}, 0, false)
    end
    def on_exit
      # At exit use any other projection.
      #    CCDirector.sharedDirector().setProjection.kCCDirectorProjection3D)
      #@m_tamara.release() unless @m_tamara.nil?
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
    end
  end

  class TMXIsoMoveLayer < TileMapTestBase
    def internal_init
      super("TMX Iso Move Layer", "Trees should be horizontally aligned")
      map = CCTMXTiledMap.create("TileMaps/iso-test-movelayer.tmx")
      addChild(map, 0, kTagTileMap)

      map.setPosition(ccp(-700,-50))

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)
    end
  end

  class TMXOrthoMoveLayer < TileMapTestBase
    def internal_init
      super("TMX Ortho Move Layer", "Trees should be horizontally aligned")
      map = CCTMXTiledMap.create("TileMaps/orthogonal-test-movelayer.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)
    end
  end

  class TMXTilePropertyTest < TileMapTestBase
    def internal_init
      super("TMX Tile Property Test", "In the console you should see tile properties")
      map = CCTMXTiledMap.create("TileMaps/ortho-tile-property.tmx")
      addChild(map ,0 ,kTagTileMap)

      20.times do |i|
        cclog("GID:#{i + 1}, Properties:#{map.propertiesForGID(i + 1)}")
      end
    end
  end

  class TMXOrthoFlipTest < TileMapTestBase
    def internal_init
      super("TMX tile flip test")
      map = CCTMXTiledMap.create("TileMaps/ortho-rotation-test.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      map.getChildren.each do |child|
        child.getTexture().setAntiAliasTexParameters()
      end

      action = CCScaleBy.create(2, 0.5)
      map.runAction(action)
    end
  end

  class TMXOrthoFlipRunTimeTest < TileMapTestBase
    def internal_init
      super("TMX tile flip run time test", "in 2 sec bottom left tiles will flip")
      map = CCTMXTiledMap.create("TileMaps/ortho-rotation-test.tmx")
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width,s.height)

      map.getChildren.each do |child|
        child.getTexture().setAntiAliasTexParameters()
      end

      action = CCScaleBy.create(2, 0.5)
      map.runAction(action)

      @schedulerEntry = nil
    end

    def flipIt(dt)
      map = getChildByTag(kTagTileMap)
      layer = map.layerNamed("Layer 0")

      #blue diamond
      tileCoord = ccp(1,10)
      flags = 0
      flags_out = []
      gid = layer.tileGIDAt(tileCoord, flags_out)
      # Vertical
      flags = flags_out[0]
      if (flags & kCCTMXTileVerticalFlag) == kCCTMXTileVerticalFlag
        flags &= ~kCCTMXTileVerticalFlag
      else
        flags |= kCCTMXTileVerticalFlag
      end
      layer.setTileGID(gid, tileCoord, flags)

      tileCoord = ccp(1,8)
      gid = layer.tileGIDAt(tileCoord, flags_out)
      # Vertical
      flags = flags_out[0]
      if (flags & kCCTMXTileVerticalFlag) == kCCTMXTileVerticalFlag
        flags &= ~kCCTMXTileVerticalFlag
      else
        flags |= kCCTMXTileVerticalFlag
      end
      layer.setTileGID(gid, tileCoord, flags)

      tileCoord = ccp(2,8)
      gid = layer.tileGIDAt(tileCoord, flags_out)
      # Horizontal
      flags = flags_out[0]
      if (flags & kCCTMXTileHorizontalFlag) == kCCTMXTileHorizontalFlag
        flags &= ~kCCTMXTileHorizontalFlag
      else
        flags |= kCCTMXTileHorizontalFlag
      end
      layer.setTileGID(gid, tileCoord, flags)
    end

    def on_enter
      that = self
      @schedulerEntry = @scheduler.scheduleScriptFunc(Proc.new {|dt| that.flipIt(dt)}, 1.0, false)
    end
    def on_exit
      @scheduler.unscheduleScriptEntry(@schedulerEntry)
    end
  end

  class TMXOrthoFromXMLTest < TileMapTestBase
    def internal_init
      super("TMX created from XML test")
      resources = "TileMaps"        # partial paths are OK as resource paths.
      file = resources + "/orthogonal-test1.tmx"

      str = CCString.createWithContentsOfFile(CCFileUtils.sharedFileUtils().fullPathForFilename(file)).getCString()
      #    CCAssert(str != NULL, "Unable to open file")
      if (str == nil) then
        cclog("Unable to open file")
      end

      map = CCTMXTiledMap.createWithXML(str, resources)
      addChild(map, 0, kTagTileMap)

      s = map.getContentSize()
      cclog("ContentSize: %f, %f", s.width, s.height)

      map.getChildren.each do |child|
        child.getTexture().setAntiAliasTexParameters()
      end

      action = CCScaleBy.create(2, 0.5)
      map.runAction(action)
    end
  end

  class TMXBug987 < TileMapTestBase
    def internal_init
      super("TMX Bug 987", "You should see an square")
      map = CCTMXTiledMap.create("TileMaps/orthogonal-test6.tmx")
      addChild(map, 0, kTagTileMap)

      s1 = map.getContentSize()
      cclog("ContentSize: %f, %f", s1.width,s1.height)

      map.getChildren.each do |pNode|
        break if pNode.nil?
        pNode.getTexture().setAntiAliasTexParameters()
      end

      map.setAnchorPoint(ccp(0, 0))
      layer = map.layerNamed("Tile Layer 1")
      layer.setTileGID(3, ccp(2,2))
    end
  end

  class TMXBug787 < TileMapTestBase
    def internal_init
      super("TMX Bug 787", "You should see a map")
      map = CCTMXTiledMap.create("TileMaps/iso-test-bug787.tmx")
      addChild(map, 0, kTagTileMap)
      map.setScale(0.25)
    end
  end

  def initialize
    super
    [TileMapAtlasTest,
     TileMapEditTest,
     TMXOrthoTest,
     TMXOrthoTest2,
     TMXOrthoTest3,
     TMXOrthoTest4,
     TMXReadWriteTest,
     TMXHexTest,
     TMXIsoTest,
     TMXIsoTest1,
     TMXIsoTest2,
     TMXUncompressedTest,
     TMXTilesetTest,
     TMXOrthoObjectsTest,
     TMXIsoObjectsTest,
     TMXResizeTest,
     TMXIsoZorder,
     TMXOrthoZorder,
     TMXIsoVertexZ,
     TMXOrthoVertexZ,
     TMXIsoMoveLayer,
     TMXOrthoMoveLayer,
     TMXTilePropertyTest,
     TMXOrthoFlipTest,
     TMXOrthoFlipRunTimeTest,
     TMXOrthoFromXMLTest,
     TMXBug987,
     TMXBug787,
    ].each do |klass|
      register_create_function(klass, :create)
    end
    CCDirector.sharedDirector.setDepthTest(true)
  end

  def create
    new_scene
  end
end
