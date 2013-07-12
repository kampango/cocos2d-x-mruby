module Cocos2d
  def CC_PROFILER_DISPLAY_TIMERS()
    CCProfiler.sharedProfiler().displayTimers()
  end
  def CC_PROFILER_PURGE_ALL()
    CCProfiler.sharedProfiler().releaseAllTimers()
  end

  def CC_PROFILER_START(__name__)
    CCProfilingBeginTimingBlock(__name__)
  end
  def CC_PROFILER_STOP(__name__)
    CCProfilingEndTimingBlock(__name__)
  end
  def CC_PROFILER_RESET(__name__)
    CCProfilingResetTimingBlock(__name__)
  end

  def CC_PROFILER_START_CATEGORY(__cat__, __name__)
    CCProfilingBeginTimingBlock(__name__) if __cat__
  end
  def CC_PROFILER_STOP_CATEGORY(__cat__, __name__)
    CCProfilingEndTimingBlock(__name__) if __cat__
  end
  def CC_PROFILER_RESET_CATEGORY(__cat__, __name__)
    CCProfilingResetTimingBlock(__name__) if __cat__
  end

  def CC_PROFILER_START_INSTANCE(__id__, __name__)
    CCProfilingBeginTimingBlock(sprintf("%08X - %s", __id__, __name__))
  end
  def CC_PROFILER_STOP_INSTANCE(__id__, __name__)
    CCProfilingEndTimingBlock(sprintf("%08X - %s", __id__, __name__))
  end
  def CC_PROFILER_RESET_INSTANCE(__id__, __name__)
    CCProfilingResetTimingBlock(sprintf("%08X - %s", __id__, __name__))
  end
end
