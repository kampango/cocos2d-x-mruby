#include "mruby.h"
#include "mruby/data.h"
#include "mruby_helper.h"
#include "CCMRubyEngine.h"
#include "extension_bridge.h"
#include "CCMRubyWebSocketDelegate.h"

USING_NS_CC_EXT;

mrb_state *
CCMRubyWebSocketDelegate::getMRBState()
{
    CCMRubyEngine *pEngine = static_cast< CCMRubyEngine * >(CCScriptEngineManager::sharedManager()->getScriptEngine());
    return pEngine->getMRBState();
}

mrb_value
CCMRubyWebSocketDelegate::toScriptObject(WebSocket *ws)
{
    mrb_state *mrb = getMRBState();
    struct RClass *klass = cc_mrb_class_get(mrb, "Cocos2d::Extension::WebSocket");
    return mrb_obj_value(Data_Wrap_Struct(mrb, klass, &mrb_no_free_type_cocos2d_extension_WebSocket, ws));
}

mrb_value
CCMRubyWebSocketDelegate::toScriptObject(const WebSocket::Data& data)
{
    mrb_state *mrb = getMRBState();
    struct RClass *klass = cc_mrb_class_get(mrb, "Cocos2d::Extension::WebSocket::Data");
    return mrb_obj_value(Data_Wrap_Struct(mrb, klass, &mrb_no_free_type_cocos2d_extension_WebSocket_Data, const_cast<WebSocket::Data *>(&data)));
}

mrb_value
CCMRubyWebSocketDelegate::funcall(const char *primary, const char *secondary, int argc, mrb_value *argv)
{
    mrb_state *mrb = getMRBState();
    mrb_value mrb_self = cc_mrb_value_retrieve(mrb, this);

    mrb_int ai = mrb_gc_arena_save(mrb);
    mrb_sym mid = mrb_intern_cstr(mrb, primary);
    mrb_bool respond_to = mrb_respond_to(mrb, mrb_self, mid);
    if (!respond_to) {
        mrb_sym mid2 = mrb_intern_cstr(mrb, secondary);
        respond_to = mrb_respond_to(mrb, mrb_self, mid2);
        if (respond_to) {
            mid = mid2;
        }
    }
    mrb_value res = mrb_funcall_argv(mrb, mrb_self, mid, argc, argv);
    mrb_gc_arena_restore(mrb, ai);

    if (mrb->exc) {
        mrb_print_error(mrb);
        mrb->exc = 0;
        res = mrb_nil_value();
    }
    return res;
}

void CCMRubyWebSocketDelegate::onOpen(WebSocket *ws)
{
    int argc = 1;
    mrb_value argv[argc];
    argv[0] = toScriptObject(ws);
    funcall("on_open", "onOpen", argc, argv);
}

void CCMRubyWebSocketDelegate::onMessage(WebSocket* ws, const WebSocket::Data& data)
{
    int argc = 2;
    mrb_value argv[argc];
    argv[0] = toScriptObject(ws);
    argv[1] = toScriptObject(data);
    funcall("on_message", "onMessage", argc, argv);
}

void CCMRubyWebSocketDelegate::onClose(WebSocket* ws)
{
    int argc = 1;
    mrb_value argv[argc];
    argv[0] = toScriptObject(ws);
    funcall("on_close", "onClose", argc, argv);
}

void CCMRubyWebSocketDelegate::onError(WebSocket* ws, const WebSocket::ErrorCode& error)
{
    int argc = 2;
    mrb_value argv[argc];
    argv[0] = toScriptObject(ws);
    argv[1] = mrb_fixnum_value(error);
    funcall("on_error", "onError", argc, argv);
}
