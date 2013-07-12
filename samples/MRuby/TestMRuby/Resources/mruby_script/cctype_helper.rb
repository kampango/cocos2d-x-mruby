module CCTypeHelper
  def CCPointMake(x, y)
    Cocos2d::CCPoint.new(x, y)
  end
  def CCSizeMake(width, height)
    Cocos2d::CCSize.new(width, height)
  end
  def CCRectMake(x, y, width, height)
    Cocos2d::CCRect.new(x, y, width, height)
  end
  def ccp(x, y = nil)
    if x.class == Cocos2d::CCPoint
      y = x.y
      x = x.x
    end
    CCPointMake(x, y)
  end

  #alias :cc_point_make, :CCPointMake
  #alias :cc_size_make, :CCSizeMake
  #alias :cc_rect_make, :CCRectMake
end

#Cocos2d.define_method(:CCPointMake) {|x, y| Cocos2d::CCPoint.new(x, y)}
#Cocos2d.define_method(:CCSizeMake) {|w, h| Cocos2d::CCSize.new(w, h)}
#Cocos2d.define_method(:CCRectMake) {|x, y, w, h| Cocos2d::CCRect.new(x, y, w, h)}
#Cocos2d.define_method(:ccp) {|x, y| CCPointMake(x, y)}
