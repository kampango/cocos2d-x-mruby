module Cocos2d
  def CCRectMake(*args)
    CCRect.new(*args)
  end

  class CCLayer
    alias_method :registerScriptTouchHandler_orig, :registerScriptTouchHandler
    def registerScriptTouchHandler(*args)
      if block_given?
        args.unshift Proc.new { |*args| yield(*args) } #OK?
      end
      
      args[3] = false if args.size <= 3
      args[2] = -1    if args.size <= 2
      args[1] = false if args.size <= 1
      registerScriptTouchHandler_orig(*args)
    end
  end

  class CCMenuItem
    alias_method :registerScriptTapHandler_orig, :registerScriptTapHandler
    def registerScriptTapHandler(*args)
      if block_given?
        args.unshift Proc.new { |*args| yield(*args) } #OK?
      end
      registerScriptTapHandler_orig(*args)
    end
  end

  class CCScheduler
    alias_method :scheduleScriptFunc_orig, :scheduleScriptFunc
    def scheduleScriptFunc(*args)
      if block_given?
        args.unshift Proc.new { |*args| yield(*args) } #OK?
      end
      scheduleScriptFunc_orig(*args)
    end
  end

  class CCSprite
    alias_method :setPosition_orig, :setPosition
    def setPosition(*args)
      if args.size == 2
        args = [CCPoint.new(*args)]
      end
      setPosition_orig(*args)
    end
  end
end
