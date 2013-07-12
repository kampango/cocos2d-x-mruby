#ifndef __CC_MRUBY_OBJECT_PROXY_H__
#define __CC_MRUBY_OBJECT_PROXY_H__

#include "cocoa/CCObject.h"
#include "ExtensionMacros.h"
#include "mruby.h"


#define CC_MRUBY_OBJECT_PROXY_KEY "$G_CCMRubyObjectProxy"

NS_CC_EXT_BEGIN

class CCMRubyObjectProxy : public cocos2d::CCObject
{
public:
    CCMRubyObjectProxy(mrb_state *mrb, mrb_value& mrb_item);
    virtual ~CCMRubyObjectProxy();
    mrb_value getMRubyItem(void);
    mrb_value callMRubyFuncWithArgv(int num_names, const char **names, int argc, mrb_value *argv, int *respond);

protected:
    mrb_state *mrb_;
};

NS_CC_EXT_END

#endif /* __CC_MRUBY_OBJECT_PROXY_H__ */
