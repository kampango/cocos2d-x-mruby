require "mruby_script/test_base"

class HttpClientTest < TestBase
  extend TestBaseExt
  include Cocos2d::Extension
  self.supported = true

  def initalize
    super
    @label_status_code = nil
  end

  def init_with_layer(layer)
    super(layer)

    MARGIN = 40
    SPACE = 35

    win_size = CCDirector.sharedDirector.getWinSize
    @title_label.setString("Http Request Test")
    @title_label.setFontSize(28)
    @title_label.setPosition(ccp(win_size.width / 2, win_size.height - MARGIN))
    @title_label.setZOrder(0)

    menu_request = CCMenu.create
    menu_request.setPosition(CCPointZero)
    layer.addChild(menu_request)

    that = self
    infos = [["Test Get", :on_menu_get_test_clicked],
             ["Test Post", :on_menu_post_test_clicked],
             ["Test Post Binary", :on_menu_post_binary_test_clicked],
             ["Test Put", :on_menu_put_test_clicked],
             ["Test Delete", :on_menu_delete_test_clicked]]
    infos.each_index do |i|
      info = infos[i]
      label = CCLabelTTF.create(info[0], "Arial", 22)
      item = CCMenuItemLabel.create(label)
      proc = Proc.new {|*args| that.__send__(info[1], *args)}
      item.registerScriptTapHandler(proc)
      item.registerScriptHandler(Proc.new {|tag|
                                   if tag == kCCNodeOnExit
                                     p "onExit!"
                                     item.unregisterScriptTapHandler
                                   elsif tag == kCCNodeOnCleanup
                                     p "onCleanup!"
                                     item.unregisterScriptTapHandler
                                     item.unregisterScriptHandler
                                   end
                                 })
      item.setPosition(ccp(win_size.width / 2, win_size.height - MARGIN - (i + 1) * SPACE))
      menu_request.addChild(item)
    end

    @label_status_code = CCLabelTTF.create("Http Status Code", "Marker Felt", 20)
    @label_status_code.setPosition(ccp(win_size.width / 2, win_size.height - MARGIN - 6 * SPACE))
    layer.addChild(@label_status_code)
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
  
  def send_request(tag, url, method, data = nil, headers = nil)
    request = CCHttpRequest.new
    request.setUrl(url)
    request.setRequestType(method)

    if headers
      request.setHeaders(headers)
    end

    request.setResponseCallback(self, :on_http_request_completed)

    if data
      request.setRequestData(data, data.size) #TODO:
    end

    request.setTag(tag)
    CCHttpClient.getInstance.send(request)
  end

  def send_get_request(tag, url)
    send_request(tag, url, CCHttpRequest.kHttpGet)
  end

  def on_menu_get_test_clicked(*args)
    [["GET test1", "http://just-make-this-request-failed.com"],
     ["GET test2", "http://httpbin.org/ip"],
     ["GET test3", "http://httpbin.org/get"]
    ].each do |args|
      send_get_request(*args)
    end
    @label_status_code.setString("waiting...")
  end

  def send_post_request(tag, url, data, headers = nil)
    send_request(tag, url, CCHttpRequest.kHttpPost, data, headers)
  end

  def on_menu_post_test_clicked(*args)
    [["POST test1", "http://httpbin.org/post", "visitor=cocos2d&TestSuite=Extensions Test/NetworkTest"],
     ["POST test2", "http://httpbin.org/post", "visitor=cocos2d&TestSuite=Extensions Test/NetworkTest",
      ["Content-Type: application/json; charset=utf-8"]],
    ].each do |args|
      send_post_request(*args)
    end
    @label_status_code.setString("waiting...")
  end

  def on_menu_post_binary_test_clicked(*args)
    send_post_request("POST Binary test", "http://httpbin.org/post", "binary=hello\0\0cocos2d")
    @label_status_code.setString("waiting...")
  end

  def send_put_request(tag, url, data, headers = nil)
    send_request(tag, url, CCHttpRequest.kHttpPut, data, headers)
  end

  def on_menu_put_test_clicked(*args)
    [["PUT test1", "http://httpbin.org/put", "visitor=cocos2d&TestSuite=Extensions Test/NetworkTest"],
     ["PUT test2", "http://httpbin.org/put", "visitor=cocos2d&TestSuite=Extensions Test/NetworkTest",
      ["Content-Type: application/json; charset=utf-8"]],
    ].each do |args|
      send_put_request(*args)
    end
    @label_status_code.setString("waiting...")
  end

  def send_delete_request(tag, url)
    send_request(tag, url, CCHttpRequest.kHttpDelete)
  end

  def on_menu_delete_test_clicked(*args)
    [["DELETE test1", "http://just-make-this-request-failed.com"],
     ["DELETE test2", "http://httpbin.org/delete"],
    ].each do |args|
      send_delete_request(*args)
    end
    @label_status_code.setString("waiting...")
  end

  def on_http_request_completed(sender, response)
    #p "on_http_request_completed:#{sender}:#{response}:#{response.m_uID}:#{response.retainCount}"
    return if response.nil?

    response.getHttpRequest.removeResponseCallback

    tag = response.getHttpRequest.getTag
    cclog("#{tag} completed")

    status_code = response.getResponseCode
    @label_status_code.setString("HTTP Status Code: #{status_code}, tag = #{tag}")
    cclog("response code: #{status_code}")

    unless response.isSucceed
      cclog("response failed")
      cclog("error buffer: #{response.getErrorBuffer}")
      return
    end

    buffer = response.getResponseData
    cclog("Http Test, dump data:")
    buffer.each do |v|
      print v.chr
    end
    print "\n"
  end
end
