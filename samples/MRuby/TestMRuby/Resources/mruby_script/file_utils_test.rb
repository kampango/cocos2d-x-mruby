require "mruby_script/test_base"

class FileUtilsTest < TestBase
  extend TestBaseExt
  self.supported = true

  class FileUtilsDemoBase < TestBase
    include Cocos2d

    def title
      "No title"
    end

    def subtitle
      ""
    end

    def initialize
      super
      @sharedFileUtils = CCFileUtils::sharedFileUtils()
    end

    def init_with_layer(layer)
      super(layer)
      @title_label.setString(self.title)
      @subtitle_label.setString(self.subtitle)

      that = self
      layer.registerScriptHandler(Proc.new {|tag| that.node_event_handler(tag)})

      @layer = layer
      @layer
    end

    def node_event_handler(tag)
      if tag == kCCNodeOnEnter
        onEnter
      elsif tag == kCCNodeOnExit
        onExit
      end
    end

    def onEnter
    end
    def onExit
    end

    def self.create
      layer = CCLayer.new
      self.new.init_with_layer(layer)
      layer
    end
  end

  class TestResolutionDirectories < FileUtilsDemoBase
    def onEnter
      super

      @sharedFileUtils.purgeCachedEntries()
      @defaultSearchPathArray = @sharedFileUtils.getSearchPaths()
      searchPaths = @defaultSearchPathArray.clone
      
      searchPaths.unshift("Misc")
      @sharedFileUtils.setSearchPaths(searchPaths)

      @defaultResolutionsOrderArray = @sharedFileUtils.getSearchResolutionsOrder()
      resolutionsOrder = @defaultResolutionsOrderArray.clone

      resolutionsOrder[0, 0] = "resources-ipadhd"
      resolutionsOrder[1, 0] = "resources-ipad"
      resolutionsOrder[2, 0] = "resources-widehd"
      resolutionsOrder[3, 0] = "resources-wide"
      resolutionsOrder[4, 0] = "resources-hd"
      resolutionsOrder[5, 0] = "resources-iphone"

      @sharedFileUtils.setSearchResolutionsOrder(resolutionsOrder)

      5.times do |i|
        filename = "test#{i + 1}.txt"
        ret = @sharedFileUtils.fullPathForFilename(filename)
        cclog("#{filename} -> #{ret}")
      end
    end

    def onExit
      # reset search path
      @sharedFileUtils.setSearchPaths(@defaultSearchPathArray)
      @sharedFileUtils.setSearchResolutionsOrder(@defaultResolutionsOrderArray)
      super
    end

    def title
      "FileUtils: resolutions in directories"
    end

    def subtitle
      "See the console"
    end
  end

  class TestSearchPath < FileUtilsDemoBase
    def onEnter
      super
      @sharedFileUtils.purgeCachedEntries()
      @defaultSearchPathArray = @sharedFileUtils.getSearchPaths()
      searchPaths = @defaultSearchPathArray.clone
      writablePath = @sharedFileUtils.getWritablePath()
      filename = writablePath + "external.txt"
      szBuf = "Hello Cocos2d-x!"

      File.open(filename, "wb") do |f|
        f.write(szBuf)
        cclog("Writing file to writable path succeed.")
      end

      searchPaths[0, 0] = writablePath
      searchPaths[1, 0] = "Misc/searchpath1"
      searchPaths[2, 0] = "Misc/searchpath2"
      @sharedFileUtils.setSearchPaths(searchPaths)

      @defaultResolutionsOrderArray = @sharedFileUtils.getSearchResolutionsOrder()
      resolutionsOrder = @defaultResolutionsOrderArray.clone
    
      resolutionsOrder[0, 0] = "resources-ipad"
      @sharedFileUtils.setSearchResolutionsOrder(resolutionsOrder)

      2.times do |i|
        filename = "file#{i + 1}.txt"
        ret = @sharedFileUtils.fullPathForFilename(filename)
        cclog("#{filename} -> #{ret}")
      end

      # Gets external.txt from writable path
      fullPath = @sharedFileUtils.fullPathForFilename("external.txt")
      cclog("external file path = #{fullPath}")

      if fullPath.length > 0
        File.open(fullPath, "rb") do |f|
          szReadBuf = f.read
          cclog("The content of file from writable path: %s", szReadBuf)
        end
      end
    end

    def onExit
      # reset search path
      @sharedFileUtils.setSearchPaths(@defaultSearchPathArray)
      @sharedFileUtils.setSearchResolutionsOrder(@defaultResolutionsOrderArray)
      super
    end

    def title
      "FileUtils: search path"
    end

    def subtitle
      "See the console"
    end
  end

  class TestFilenameLookup < FileUtilsDemoBase
    def onEnter
      super
      dict = CCDictionary.create()
      dict.setObject(CCString.create("Images/grossini.png"), "grossini.bmp")
      dict.setObject(CCString.create("Images/grossini.png"), "grossini.xcf")

      @sharedFileUtils.setFilenameLookupDictionary(dict)

      # Instead of loading carlitos.xcf, it will load grossini.png
      sprite = CCSprite.create("grossini.xcf")
      @layer.addChild(sprite)
    
      s = @@size
      sprite.setPosition(ccp(s.width/2, s.height/2))
    end

    def onExit
      # reset filename lookup
      @sharedFileUtils.setFilenameLookupDictionary(CCDictionary.create())
      super
    end

    def title
      "FileUtils: filename lookup"
    end

    def subtitle
      "See the console"
    end
  end

  class TestIsFileExist < FileUtilsDemoBase
    def onEnter
      super
      s = @@size

      isExist = @sharedFileUtils.isFileExist("Images/grossini.png")
      pTTF = CCLabelTTF.create(if isExist
                                 "Images/grossini.png exists"
                               else
                                 "Images/grossini.png doesn't exist"
                               end,
                               "", 20)

      pTTF.setPosition(ccp(s.width/2, s.height/3))
      @layer.addChild(pTTF)
    
      isExist = @sharedFileUtils.isFileExist("Images/grossini.xcf")
      pTTF = CCLabelTTF.create(if isExist
                                 "Images/grossini.xcf exists"
                               else
                                 "Images/grossini.xcf doesn't exist"
                               end,
                               "", 20)

      pTTF.setPosition(ccp(s.width/2, s.height/3*2))
      @layer.addChild(pTTF)
    end

    def onExit
      # reset filename lookup
      @sharedFileUtils.setFilenameLookupDictionary(CCDictionary.create())
      super
    end

    def title
      "FileUtils: check whether the file exists"
    end
  end

  class TextWritePlist < FileUtilsDemoBase
    def onEnter
      super
      root = CCDictionary.create()
      string = CCString.create("string element value")
      root.setObject(string, "string element key")

      array = CCArray.create()
    
      dictInArray = CCDictionary.create()
      dictInArray.setObject(CCString.create("string in dictInArray value 0"),
                            "string in dictInArray key 0")
      dictInArray.setObject(CCString.create("string in dictInArray value 1"),
                            "string in dictInArray key 1")
      array.addObject(dictInArray)

      array.addObject(CCString.create("string in array"))
    
      arrayInArray = CCArray.create()
      arrayInArray.addObject(CCString.create("string 0 in arrayInArray"))
      arrayInArray.addObject(CCString.create("string 1 in arrayInArray"))
      array.addObject(arrayInArray)

      root.setObject(array, "array")

      dictInDict = CCDictionary.create()
      dictInDict.setObject(CCString.create("string in dictInDict value"),
                           "string in dictInDict key")

      root.setObject(dictInDict, "dictInDict")

      # end with /
      writablePath = @sharedFileUtils.getWritablePath()
      fullPath = writablePath + "text.plist"
      if root.writeToFile(fullPath)
        cclog("see the plist file at %s", fullPath)
      else
        cclog("write plist file failed")
      end

      label = CCLabelTTF.create(fullPath, "Thonburi", 6)
      @layer.addChild(label)
      winSize = @@size
      label.setPosition(ccp(winSize.width/2, winSize.height/3))
    end

    def title
      "FileUtils: CCDictionary to plist"
    end

    def subtitle
      "See plist file at your writablePath"
    end
  end

  def initialize
    super
    [TestResolutionDirectories,
     TestSearchPath,
     TestFilenameLookup,
     TestIsFileExist,
     TextWritePlist,
    ].each do |klass|
      register_create_function(klass, :create)
    end
  end

  def create
    new_scene
  end
end
