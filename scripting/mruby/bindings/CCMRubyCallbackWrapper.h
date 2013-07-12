#ifndef __CC_MRUBY_CALLBACK_WRAPPER_H__
#define __CC_MRUBY_CALLBACK_WRAPPER_H__

#include "mruby.h"
#include "cocoa/CCObject.h"

#ifndef MRUBY_NO_EXTENSION_BRIDGE
#include "network/HttpClient.h"
#include "network/HttpRequest.h"
#include "GUI/CCControlExtension/CCInvocation.h"
#endif

NS_CC_BEGIN

class CCMRubyCallbackWrapper : public CCObject
{
public:
    explicit CCMRubyCallbackWrapper(mrb_state *mrb, mrb_value& mrb_target, mrb_value& mrb_sym_sel);
    virtual ~CCMRubyCallbackWrapper();
    void SEL_SCHEDULE_Impl(float);
    void SEL_CallFunc_Impl(void);
    void SEL_CallFuncN_Impl(CCNode*);
    void SEL_CallFuncND_Impl(CCNode*, void*);
    void SEL_CallFuncO_Impl(CCObject*);
    void SEL_MenuHandler_Impl(CCObject*);
    void SEL_EventHandler_Impl(CCEvent*);
    int SEL_Compare_Impl(CCObject*);

#ifndef MRUBY_NO_EXTENSION_BRIDGE
    void SEL_HttpResponse_Impl(extension::CCHttpClient* client, extension::CCHttpResponse* response);
    void SEL_CCControlHandler_Impl(CCObject*, extension::CCControlEvent);
#endif /* !MRUBY_NO_EXTENSION_BRIDGE */

public:
    static CCMRubyCallbackWrapper *create(mrb_state *mrb, mrb_value& mrb_target, mrb_value& mrb_selector);

protected:
    mrb_value getMRubyTarget(void);

private:
    mrb_state *mrb_;
    mrb_sym sym_selector_;
};

NS_CC_END

#endif /* __CC_MRUBY_CALLBACK_WRAPPER_H__ */
