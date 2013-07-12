require "mruby_script/test_base"

class CustomTableViewCell < Cocos2d::Extension::CCTableViewCell
end

class TableViewTestLayer < Cocos2d::CCLayer
  include Cocos2d
  include Cocos2d::Extension
  include CCTypeHelper

  def self.create
    layer = super
    layer.init
    layer
  end

  def init
    unless super
      return false
    end

    win_size = CCDirector.sharedDirector.getWinSize

    table_view = CCTableView.create(self, CCSizeMake(250, 60))
    tv0 = table_view
    that = self
    table_view.registerScriptHandler(Proc.new {|tag|
                                       if tag == Cocos2d.kCCNodeOnCleanup
                                         tv0.setDelegate(nil)
                                         tv0.setDataSource(nil)
                                       end
                                     })
    table_view.setDirection(kCCScrollViewDirectionHorizontal)
    table_view.setPosition(ccp(20, win_size.height / 2 - 3))
    table_view.setDelegate(self)
    addChild(table_view)
    table_view.reloadData

    table_view = CCTableView.create(self, CCSizeMake(60, 250))
    tv1 = table_view
    table_view.registerScriptHandler(Proc.new {|tag|
                                       if tag == Cocos2d.kCCNodeOnCleanup
                                         tv1.setDelegate(nil)
                                         tv1.setDataSource(nil)
                                       end
                                     })
    table_view.setDirection(kCCScrollViewDirectionVertical)
    table_view.setPosition(ccp(win_size.width - 150, win_size.height / 2 - 120))
    table_view.setDelegate(self)
    table_view.setVerticalFillOrder(kCCTableViewFillTopDown)
    addChild(table_view)
    table_view.reloadData

    addChild(ExtensionsTest.create_back_menu_item("Back"))
  end


  # CCScrollViewDelegate methods
  #def scrollViewDidScroll(view)
  #  cclog("scrollViewDidScroll")
  #end
  #def scrollViewDidZoom(view)
  #  cclog("scrollViewDidZoom")
  #end

  # CCTableViewDelegate methods
  def tableCellTouched(table, cell)
    cclog("cell touched at index: #{cell.getIdx}")
  end

  #def tableCellHighlight(table, cell)
  #  cclog("cell highlight at index: #{cell.getIdx}")
  #end
  #def tableCellUnhighlight(table, cell)
  #  cclog("cell unhighlight at index: #{cell.getIdx}")
  #end
  #def tableCellWillRecycle(table, cell)
  #  cclog("cell will recycle at index: #{cell.getIdx}")
  #end

  # CCTableViewDataSource methods
  #def cellSizeForTable(table, idx)
  #end

  def tableCellSizeForIndex(table, idx)
    if idx == 2
      CCSizeMake(100, 100)
    else
      CCSizeMake(60, 60)
    end
  end

  def tableCellAtIndex(table, idx)
    string = idx.to_s
    cell = table.dequeueCell
    unless cell
      cell = CustomTableViewCell.new
      sprite = CCSprite.create("Images/Icon.png")
      sprite.setAnchorPoint(CCPointZero)
      sprite.setPosition(ccp(0, 0))
      cell.addChild(sprite)

      label = CCLabelTTF.create(string, "Helvetica", 20.0)
      label.setPosition(CCPointZero)
      label.setAnchorPoint(CCPointZero)
      label.setTag(123)
      cell.addChild(label)
    else
      label = cell.getChildByTag(123)
      label.setString(string)
    end
    cell
  end

  def numberOfCellsInTableView(table)
    20
  end
end

class TableViewTest < TestBase
  extend TestBaseExt
  include Cocos2d::Extension
  self.supported = true

  def create
    scene = CCScene.create
    layer = TableViewTestLayer.create
    scene.addChild(layer)
    scene
  end
end

