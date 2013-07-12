module Cocos2d
  module VisibleRect
    extend CCTypeHelper

    @@visible_rect = CCRect.new

    def self.lazy_init
      if @@visible_rect.size.width == 0 && @@visible_rect.size.height == 0
        egl_view = CCEGLView.sharedOpenGLView
        @@visible_rect.origin = egl_view.getVisibleOrigin
        @@visible_rect.size = egl_view.getVisibleSize
      end
    end

    def self.get_visible_rect
      lazy_init
      CCRectMake(@@visible_rect.origin.x, @@visible_rect.origin.y, @@visible_rect.size.width, @@visible_rect.size.height)
    end

    def self.getVisibleRect
      get_visible_rect
    end

    def self.left
      lazy_init
      ccp(@@visible_rect.origin.x, @@visible_rect.origin.y + @@visible_rect.size.height / 2)
    end

    def self.right
      lazy_init
      ccp(@@visible_rect.origin.x + @@visible_rect.size.width, @@visible_rect.origin.y + @@visible_rect.size.height / 2)
    end

    def self.top
      lazy_init
      ccp(@@visible_rect.origin.x + @@visible_rect.size.width / 2, @@visible_rect.origin.y + @@visible_rect.size.height)
    end

    def self.bottom
      lazy_init
      ccp(@@visible_rect.origin.x + @@visible_rect.size.width / 2, @@visible_rect.origin.y)
    end

    def self.center
      lazy_init
      ccp(@@visible_rect.origin.x + @@visible_rect.size.width / 2, @@visible_rect.origin.y + @@visible_rect.size.height / 2)
    end

    def self.left_top
      lazy_init
      ccp(@@visible_rect.origin.x, @@visible_rect.origin.y + @@visible_rect.size.height)
    end

    def self.leftTop
      left_top
    end

    def self.right_top
      lazy_init
      ccp(@@visible_rect.origin.x + @@visible_rect.size.width, @@visible_rect.origin.y + @@visible_rect.size.height)
    end

    def self.rightTop
      right_top
    end

    def self.left_bottom
      lazy_init
      @@visible_rect.origin
    end

    def self.leftBottom
      left_bottom
    end

    def self.right_bottom
      lazy_init
      ccp(@@visible_rect.origin.x + @@visible_rect.size.width, @@visible_rect.origin.y)
    end

    def self.rightBottom
      right_bottom
    end
  end
end
