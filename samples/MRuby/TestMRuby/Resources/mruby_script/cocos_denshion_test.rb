require "mruby_script/visible_rect"
require "mruby_script/test_base"

module AudioEngine
  @@sharedEngine = CocosDenshion::SimpleAudioEngine.sharedEngine()

  def self.stopAllEffects()
    @@sharedEngine.stopAllEffects()
  end

  def self.getMusicVolume
    @@sharedEngine.getBackgroundMusicVolume()
  end

  def self.getEffectsVolume
    @@sharedEngine.getEffectsVolume()
  end

  def self.isMusicPlaying
    @@sharedEngine.isBackgroundMusicPlaying()
  end

  def self.setMusicVolume(volume)
    @@sharedEngine.setBackgroundMusicVolume(volume)
  end

  def self.stopEffect(handle)
    @@sharedEngine.stopEffect(handle)
  end

  def self.stopMusic(isReleaseData = false)
    @@sharedEngine.stopBackgroundMusic(isReleaseData)
  end

  def self.playMusic(filename, isLoop = false)
    @@sharedEngine.playBackgroundMusic(filename, isLoop)
  end

  def self.pauseAllEffects
    @@sharedEngine.pauseAllEffects()
  end

  def self.preloadMusic(filename)
    @@sharedEngine.preloadBackgroundMusic(filename)
  end

  def self.resumeMusic
    @@sharedEngine.resumeBackgroundMusic()
  end

  def self.playEffect(filename, isLoop = false)
    @@sharedEngine.playEffect(filename, isLoop)
  end

  def self.rewindMusic
    @@sharedEngine.rewindBackgroundMusic()
  end

  def self.willPlayMusic
    @@sharedEngine.willPlayBackgroundMusic()
  end

  def self.unloadEffect(filename)
    @@sharedEngine.unloadEffect(filename)
  end

  def self.preloadEffect(filename)
    @@sharedEngine.preloadEffect(filename)
  end

  def self.setEffectsVolume(volume)
    @@sharedEngine.setEffectsVolume(volume)
  end

  def self.pauseEffect(handle)
    @@sharedEngine.pauseEffect(handle)
  end

  def self.resumeAllEffects()
    @@sharedEngine.resumeAllEffects()
  end

  def self.pauseMusic
    @@sharedEngine.pauseBackgroundMusic()
  end

  def self.resumeEffect(handle)
    @@sharedEngine.resumeEffect(handle)
  end
end

class CocosDenshionTest < TestBase
  extend TestBaseExt
  self.supported = true

  @@EFFECT_FILE = "effect1.wav"
  @@MUSIC_FILE  = "background.mp3"

  @@LINE_SPACE = 40

  def initialize
    @m_pItmeMenu = nil
    @m_tBeginPos = ccp(0, 0)
    @m_nSoundId = 0

    @testItems = ["play background music",
                  "stop background music",
                  "pause background music",
                  "resume background music",
                  "rewind background music",
                  "is background music playing",
                  "play effect",
                  "play effect repeatly",
                  "stop effect",
                  "unload effect",
                  "add background music volume",
                  "sub background music volume",
                  "add effects volume",
                  "sub effects volume",
                  "pause effect",
                  "resume effect",
                  "pause all effects",
                  "resume all effects",
                  "stop all effects"
                 ]
  end

  def menu_callback(tag, pMenuItem)
    nIdx = pMenuItem.getZOrder() - 10000
    # play background music
    if nIdx ==  0 then
      AudioEngine.playMusic(@@MUSIC_FILE, true)
    elsif nIdx == 1 then
      # stop background music
      AudioEngine.stopMusic()
    elsif nIdx == 2 then
      # pause background music
      AudioEngine.pauseMusic()
    elsif nIdx == 3 then
      # resume background music
      AudioEngine.resumeMusic()
      # rewind background music
    elsif nIdx == 4 then
      AudioEngine.rewindMusic()
    elsif nIdx == 5 then
      # is background music playing
      if AudioEngine.isMusicPlaying() then
        cclog("background music is playing")
      else
        cclog("background music is not playing")
      end
    elsif nIdx == 6 then
      # play effect
      @m_nSoundId = AudioEngine.playEffect(@@EFFECT_FILE)
    elsif nIdx == 7 then
      # play effect
      @m_nSoundId = AudioEngine.playEffect(@@EFFECT_FILE, true)
    elsif nIdx == 8 then
      # stop effect
      AudioEngine.stopEffect(@m_nSoundId)
    elsif nIdx == 9 then
      # unload effect
      AudioEngine.unloadEffect(@@EFFECT_FILE)
    elsif nIdx == 10 then
      # add bakcground music volume
      AudioEngine.setMusicVolume(AudioEngine.getMusicVolume() + 0.1)
    elsif nIdx == 11 then
      # sub backgroud music volume
      AudioEngine.setMusicVolume(AudioEngine.getMusicVolume() - 0.1)
    elsif nIdx == 12 then
      # add effects volume
      AudioEngine.setEffectsVolume(AudioEngine.getEffectsVolume() + 0.1)
    elsif nIdx == 13 then
      # sub effects volume
      AudioEngine.setEffectsVolume(AudioEngine.getEffectsVolume() - 0.1)
    elsif nIdx == 14 then
      AudioEngine.pauseEffect(@m_nSoundId)
    elsif nIdx == 15 then
      AudioEngine.resumeEffect(@m_nSoundId)
    elsif nIdx == 16 then
      AudioEngine.pauseAllEffects()
    elsif nIdx == 17 then
      AudioEngine.resumeAllEffects()
    elsif nIdx == 18 then
      AudioEngine.stopAllEffects()
    end
  end

  def on_touch_event(event_type, x, y)
    if event_type == CCTOUCHBEGAN
      @prev[:x] = x
      @prev[:y] = y
      @m_tBeginPos = ccp(x, y)
      return true

    elsif  event_type == CCTOUCHMOVED
      touchLocation = ccp(x, y)
      nMoveY = touchLocation.y - @m_tBeginPos.y
      curPosX, curPosY = @m_pItmeMenu.getPosition()
      curPos = ccp(curPosX, curPosY)
      nextPos = ccp(curPos.x, curPos.y + nMoveY)

      if nextPos.y < 0.0
        @m_pItmeMenu.setPosition(ccp(0, 0))
      end

      if nextPos.y > ((@m_nTestCount + 1)* @@LINE_SPACE - VisibleRect.get_visible_rect().size.height)
        @m_pItmeMenu.setPosition(ccp(0, ((@m_nTestCount + 1)* @@LINE_SPACE - VisibleRect.get_visible_rect().size.height)))
      end

      @m_pItmeMenu.setPosition(nextPos)
      @m_tBeginPos.x = touchLocation.x
      @m_tBeginPos.y = touchLocation.y

      @prev[:x] = x
      @prev[:y] = y
    end
  end

  def cocos_denshion_test
    ret = CCLayer.create

    # add menu items for tests
    @m_pItmeMenu = CCMenu.create

    @m_nTestCount = @testItems.size
    i = 1
    @testItems.each do |item|
      label = CCLabelTTF.create(item, "Arial", 24)
      pMenuItem = CCMenuItemLabel.create(label)
      pMenuItem.registerScriptTapHandler(Proc.new {|tag, menu_item| menu_callback(tag, menu_item)})
      @m_pItmeMenu.addChild(pMenuItem, i + 10000 -1)
      pMenuItem.setPosition( ccp( VisibleRect.center().x, (VisibleRect.top().y - i * @@LINE_SPACE) ))
      i += 1
    end

    @m_pItmeMenu.setContentSize(CCSizeMake(VisibleRect.get_visible_rect().size.width, (@m_nTestCount + 1) * @@LINE_SPACE))
    @m_pItmeMenu.setPosition(ccp(0, 0))
    ret.addChild(@m_pItmeMenu)
    ret.setTouchEnabled(true)

    # preload background music and effect
    AudioEngine.preloadMusic( @@MUSIC_FILE )
    AudioEngine.preloadEffect( @@EFFECT_FILE )

    # set default volume
    AudioEngine.setEffectsVolume(0.5)
    AudioEngine.setMusicVolume(0.5)

    on_node_event = ->(event) {
      if event == kCCNodeOnEnter

      elsif event == kCCNodeOnExit
        # SimpleAudioEngine.sharedEngine().endToLua()
      end
    }

    ret.registerScriptHandler(on_node_event)

    @prev = {:x => 0, :y => 0}

    ret.registerScriptTouchHandler(Proc.new {|event_type, x, y| on_touch_event(event_type, x, y)}, false, -1, false)
    ret
  end

  def create
    cclog(self.class.to_s)
    scene = CCScene.create
    scene.addChild(cocos_denshion_test)
    scene.addChild(MainMenu.create_back_menu_item)
    scene
  end
end