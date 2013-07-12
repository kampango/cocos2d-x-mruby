module Cocos2d
  class CCArray
    def push(item)
      addObject(item)
    end

    alias_method :<<, :push

    def [](i)
      len = count()
      i = len + i if i < 0

      return nil unless 0 <= i && i < len

      objectAtIndex(i)
    end

    def each
      len = count()
      i = 0
      while (i < len)
        yield objectAtIndex(i)
        i += 1
      end
    end
  end
end

