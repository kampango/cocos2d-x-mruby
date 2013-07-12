# -*- coding: utf-8 -*-
require "mruby_script/test_base"

class WebSocketTest < TestBase
  extend TestBaseExt
  include Cocos2d::Extension
  self.supported = true

  class WSDelegate < CCMRubyWebSocketDelegate
    include Cocos2d

    def initialize
      super
      @receive_times = 0
    end

    def name=(name)
      @name = name || "no named"
    end
    def name
      @name
    end

    def label_status=(label)
      @label_status = label
    end

    def on_exit
      @label_status = nil
    end

    def on_close(ws)
      cclog("#{self.class} instance closed. #{name}")
    end

    def on_error(ws, error_code)
      cclog("#{self.class.to_s} Error was fired. name=#{name}:error_code=#{error_code}")
      @label_status.setString("an error was fired, code:#{error_code}")
    end

    def on_open(ws)
      @label_status.setString("#{name} was opened.")
    end

    def on_message(ws, data)
      if data.isBinary
        on_binary_message(data.bytes)
      else
        on_text_message(data.bytes)
      end
    end

    def on_text_message(str)
      @receive_times += 1
      @label_status.setString("response text msg: #{str}, #{@receive_times}")
    end

    def on_binary_message(param_table)
      len = param_table.size
      str_info = "response bin msg:"
      param_table.each do |param|
        str_info += if param == 0 then "\'\\0\'" else param.chr end
      end
      @receive_times += 1
      str_info += ", " + @receive_times.to_s
      @label_status.setString(str_info)
    end
  end

  def on_exit
    @wsockets.each do |ws|
      ws.close
    end
    @delegates.each do |deleg|
      deleg.on_exit
    end
  end

  def on_menu_send_text_clicked(*args)
    cclog("on_menu_send_text_clicked")
    @wsockets[0].send("Hello WebSocket中文, I'm a text message.")
  end

  def on_menu_send_binary_clicked(*args)
    cclog("on_menu_send_binary_clicked")
    msg = "Hello WebSocket中文--,\0 I'm\0 a\0 binary\0 message\0."
    bm = msg.bytes
    @wsockets[1].send(bm, bm.size)
  end

  def init_with_layer(layer)
    super(layer)

    MARGIN = 40
    SPACE = 35

    win_size = CCDirector.sharedDirector.getWinSize
    @title_label.setString("WebSocket Test")
    @title_label.setFontSize(28)
    @title_label.setPosition(ccp(win_size.width / 2, win_size.height - MARGIN))
    @title_label.setZOrder(0)

    menu_request = CCMenu.create
    menu_request.setPosition(ccp(0, 0))
    layer.addChild(menu_request)

    that = self
    infos = [{:text => "Send Text",   :proc => Proc.new {|*args| that.on_menu_send_text_clicked(*args)}},
             {:text => "Send Binary", :proc => Proc.new {|*args| that.on_menu_send_binary_clicked(*args)}}]
    infos.each_index do |i|
      info = infos[i]
      label = CCLabelTTF.create(info[:text], "Arial", 22)
      item = CCMenuItemLabel.create(label)
      item.registerScriptTapHandler(info[:proc])
      item.setPosition(ccp(win_size.width / 2, win_size.height - MARGIN - (i + 1) * SPACE))
      menu_request.addChild(item)
    end

    @delegates = [] #XXX: see WebSocket.cpp
    @wsockets = []
    infos = [{:name =>"Send Text WS",   :url => "ws://echo.websocket.org"},
             {:name =>"Send Binary WS", :url => "ws://echo.websocket.org"},
             {:name => "Error WS",      :url => "ws://invalid.url.com"}]
    infos.each_index do |i|
      info = infos[i]
      label = CCLabelTTF.create(info[:name] + " is waiting...", "Arial", 14, CCSizeMake(160, 100),
                                kCCVerticalTextAlignmentCenter,kCCVerticalTextAlignmentTop)
      label.setAnchorPoint(ccp(0, 0))
      label.setPosition(ccp(i * 160, 25))
      layer.addChild(label)

      delegate = WSDelegate.new
      delegate.name = info[:name]
      delegate.label_status = label
      @delegates << delegate

      ws = WebSocket.new
      ws.init(delegate, info[:url])
      @wsockets << ws
    end

    layer.registerScriptHandler(Proc.new {|tag|
                                  case tag
                                  when kCCNodeOnExit
                                    that.on_exit
                                  when kCCNodeOnCleanup
                                    layer.unregisterScriptHandler
                                  end
                                })

    layer
  end

  def create
    layer = CCLayer.new
    init_with_layer(layer)
    scene = CCScene.new
    scene.addChild(layer)
    scene.addChild(ExtensionsTest.create_back_menu_item("Back"))
    scene
  end
end
