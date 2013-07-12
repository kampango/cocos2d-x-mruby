#ifndef __CC_MRUBY_EDIT_BOX_DELEGATE_H__
#define __CC_MRUBY_EDIT_BOX_DELEGATE_H__

#include "CCMRubyObjectProxy.h"
#include "GUI/CCEditBox/CCEditBox.h"
#include "mruby.h"

NS_CC_EXT_BEGIN

class CCMRubyEditBoxDelegate
    : public CCMRubyObjectProxy
    , public cocos2d::extension::CCEditBoxDelegate
{
public:
    CCMRubyEditBoxDelegate(mrb_state *mrb, mrb_value& item)
        : CCMRubyObjectProxy(mrb, item)
    {};
    virtual ~CCMRubyEditBoxDelegate() {};

    virtual void editBoxEditingDidBegin(CCEditBox* editBox);
    virtual void editBoxEditingDidEnd(CCEditBox* editBox);
    virtual void editBoxTextChanged(CCEditBox* editBox, const std::string& text);
    virtual void editBoxReturn(CCEditBox* editBox);

protected:
    mrb_value getMRubyEditBox(CCEditBox *editBox);

public:
    static CCMRubyEditBoxDelegate *create(mrb_state *mrb, mrb_value& item);
};

NS_CC_EXT_END
#endif /* __CC_MRUBY_EDIT_BOX_DELEGATE_H__ */
