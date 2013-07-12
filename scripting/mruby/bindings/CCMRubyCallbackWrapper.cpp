#include "mruby.h"
#include "mruby/data.h"
#include "mruby/hash.h"
#include "mruby/value.h"
#include "mruby/variable.h"

#include "platform/CCCommon.h"
#include "mruby_helper.h"
#include "cocos2d_bridge.h"

#include "CCMRubyCallbackWrapper.h"

#ifndef MRUBY_NO_EXTENSION_BRIDGE
#include "extension_bridge.h"
USING_NS_CC_EXT;
#endif

NS_CC_BEGIN

CCMRubyCallbackWrapper *
CCMRubyCallbackWrapper::create(mrb_state *mrb, mrb_value& mrb_target, mrb_value& mrb_sel_sym)
{
    CCMRubyCallbackWrapper *wrapper = new CCMRubyCallbackWrapper(mrb, mrb_target, mrb_sel_sym);
    if (wrapper) {
        wrapper->autorelease();
    }
    return wrapper;
}

CCMRubyCallbackWrapper::CCMRubyCallbackWrapper(mrb_state *mrb, mrb_value& mrb_target, mrb_value& mrb_selector)
    : mrb_(mrb)
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb, "$G_CCMRubyCallbackWrapper"));
    if (!mrb_hash_p(hash)) {
        hash = mrb_hash_new_capa(mrb_, 1);
        mrb_gv_set(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyCallbackWrapper"), hash);
    }

    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_value iv = mrb_hash_get(mrb_, hash, key);
    if (!mrb_hash_p(iv)) {
        iv = mrb_hash_new_capa(mrb_, 2);
        mrb_hash_set(mrb_, hash, key, iv);
    }
    
    mrb_hash_set(mrb_, iv, mrb_symbol_value(mrb_intern_cstr(mrb_, "__target__")), mrb_target);

    if (mrb_symbol_p(mrb_selector)) {
        sym_selector_ = mrb_symbol(mrb_selector);
    } else if (mrb_string_p(mrb_selector)) {
        sym_selector_ = mrb_intern_str(mrb_, mrb_selector);
    } else {
        mrb_raisef(mrb_, E_TYPE_ERROR, "type mismatch:"); //TODO: set error and return NULL.
    }

    mrb_hash_set(mrb_, iv, mrb_symbol_value(mrb_intern_cstr(mrb_, "__selector__")), mrb_selector);

    mrb_value mrb_self = cc_mrb_value_retrieve(mrb, this);
    if (mrb_nil_p(mrb_self)) {
        mrb_self = mrb_obj_value(Data_Wrap_Struct(
                                     mrb_,
                                     cc_mrb_class_get(mrb_, "Cocos2d::CCObject"),
                                     &mrb_type_cocos2d_CCObject,
                                     this));
        cc_mrb_value_register(mrb_, this, mrb_self);
        this->retain();
    }
}

CCMRubyCallbackWrapper::~CCMRubyCallbackWrapper()
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyCallbackWrapper"));
    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_hash_delete_key(mrb_, hash, key);
    mrb_ = NULL;
}

mrb_value CCMRubyCallbackWrapper::getMRubyTarget()
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyCallbackWrapper"));
    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_value iv = mrb_hash_get(mrb_, hash, key);

    mrb_value target = mrb_hash_get(mrb_, iv, mrb_symbol_value(mrb_intern_cstr(mrb_, "__target__")));
    return target;
}

void CCMRubyCallbackWrapper::SEL_SCHEDULE_Impl(float dt)
{
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    mrb_value mrb_arg = mrb_float_value(mrb_, dt);
    mrb_funcall_argv(mrb_, target, sym_selector_, 1, &mrb_arg);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
}

void CCMRubyCallbackWrapper::SEL_CallFunc_Impl()
{
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    mrb_funcall_argv(mrb_, target, sym_selector_, 0, NULL);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
}

void CCMRubyCallbackWrapper::SEL_CallFuncN_Impl(CCNode *pNode)
{
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    mrb_value mrb_arg = cc_mrb_value_retrieve(mrb_, pNode);
    if (mrb_nil_p(mrb_arg)) {
        mrb_arg = mrb_obj_value(Data_Wrap_Struct(
                                     mrb_,
                                     cc_mrb_class_get_by_cxx_class(mrb_, pNode),
                                     &mrb_type_cocos2d_CCNode,
                                     pNode));
        cc_mrb_value_register(mrb_, pNode, mrb_arg);
        pNode->retain();
    }

    mrb_funcall_argv(mrb_, target, sym_selector_, 1, &mrb_arg);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
}

void CCMRubyCallbackWrapper::SEL_CallFuncND_Impl(CCNode *pNode, void *arg)
{
#if 1
    CCAssert(0, "Not supported yet!");
#else
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    int argc = 2;
    mrb_value argv[argc];
    argv[0] = cc_mrb_value_retrieve(mrb_, pNode);
    if (mrb_nil_p(argv[0])) {
        argv[0] = mrb_obj_value(Data_Wrap_Struct(
                                    mrb_,
                                    cc_mrb_class_get_by_cxx_class(mrb_, pNode),
                                    &mrb_type_cocos2d_CCNode,
                                    pNode));
        cc_mrb_value_register(mrb_, pNode, argv[0]);
        pNode->retain();
    }

    //TODO: argv[1]

    mrb_funcall_argv(mrb_, target, sym_selector_, argc, argv);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
#endif
}

void CCMRubyCallbackWrapper::SEL_CallFuncO_Impl(CCObject *pObject)
{
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    mrb_value mrb_arg = cc_mrb_value_retrieve(mrb_, pObject);
    if (mrb_nil_p(mrb_arg)) {
        mrb_arg = mrb_obj_value(Data_Wrap_Struct(
                                    mrb_,
                                    cc_mrb_class_get_by_cxx_class(mrb_, pObject),
                                    &mrb_type_cocos2d_CCObject,
                                    pObject));
        cc_mrb_value_register(mrb_, pObject, mrb_arg);
        pObject->retain();
    }

    mrb_funcall_argv(mrb_, target, sym_selector_, 1, &mrb_arg);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
}

void CCMRubyCallbackWrapper::SEL_MenuHandler_Impl(CCObject *pObject)
{
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    mrb_value mrb_arg = cc_mrb_value_retrieve(mrb_, pObject);
    if (mrb_nil_p(mrb_arg)) {
        mrb_arg = mrb_obj_value(Data_Wrap_Struct(
                                    mrb_,
                                    cc_mrb_class_get_by_cxx_class(mrb_, pObject),
                                    &mrb_type_cocos2d_CCObject,
                                    pObject));
        cc_mrb_value_register(mrb_, pObject, mrb_arg);
        pObject->retain();
    }

    mrb_funcall_argv(mrb_, target, sym_selector_, 1, &mrb_arg);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
}

void CCMRubyCallbackWrapper::SEL_EventHandler_Impl(CCEvent *pEvent)
{
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    mrb_value mrb_arg = cc_mrb_value_retrieve(mrb_, pEvent);
    if (mrb_nil_p(mrb_arg)) {
        mrb_arg = mrb_obj_value(Data_Wrap_Struct(
                                    mrb_,
                                    cc_mrb_class_get_by_cxx_class(mrb_, pEvent),
                                    &mrb_type_cocos2d_CCEvent,
                                    pEvent));
        cc_mrb_value_register(mrb_, pEvent, mrb_arg);
        pEvent->retain();
    }

    mrb_funcall_argv(mrb_, target, sym_selector_, 1, &mrb_arg);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
}

int CCMRubyCallbackWrapper::SEL_Compare_Impl(CCObject *pObject)
{
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    mrb_value mrb_arg = cc_mrb_value_retrieve(mrb_, pObject);
    if (mrb_nil_p(mrb_arg)) {
        mrb_arg = mrb_obj_value(Data_Wrap_Struct(
                                    mrb_,
                                    cc_mrb_class_get_by_cxx_class(mrb_, pObject),
                                    &mrb_type_cocos2d_CCObject,
                                    pObject));
        cc_mrb_value_register(mrb_, pObject, mrb_arg);
        pObject->retain();
    }

    int res = 0;
    mrb_value mrb_res = mrb_funcall_argv(mrb_, target, sym_selector_, 1, &mrb_arg);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0; //XXX
    } else {
        res = mrb_fixnum(mrb_res);
    }
    return res;
}

#ifndef MRUBY_NO_EXTENSION_BRIDGE
void CCMRubyCallbackWrapper::SEL_HttpResponse_Impl(CCHttpClient *client, CCHttpResponse *response)
{
    this->retain();
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value mrb_sender = cc_mrb_value_retrieve(mrb_, client);
    CCAssert(!mrb_nil_p(mrb_sender), "");

    mrb_value mrb_response = cc_mrb_value_retrieve(mrb_, response);
    if (mrb_nil_p(mrb_response)) {
        mrb_response = mrb_obj_value(Data_Wrap_Struct(
                                         mrb_,
                                         cc_mrb_class_get_by_cxx_class(mrb_, response),
                                         &mrb_type_cocos2d_extension_CCHttpResponse,
                                         response));
        cc_mrb_value_register(mrb_, response, mrb_response);
        response->retain();
    }

    mrb_value argv[2];
    argv[0] = mrb_sender;
    argv[1] = mrb_response;

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    mrb_funcall_argv(mrb_, target, sym_selector_, 2, argv);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
    this->release();
}

void CCMRubyCallbackWrapper::SEL_CCControlHandler_Impl(CCObject *pObject, extension::CCControlEvent event)
{
    mrb_int ai = mrb_gc_arena_save(mrb_);

    mrb_value target = getMRubyTarget();
    CCAssert(!mrb_nil_p(target), "");

    int argc = 2;
    mrb_value argv[argc];

    argv[0] = cc_mrb_value_retrieve(mrb_, pObject);
    if (mrb_nil_p(argv[0])) {
        argv[0] = mrb_obj_value(Data_Wrap_Struct(
                                    mrb_,
                                    cc_mrb_class_get_by_cxx_class(mrb_, pObject),
                                    &mrb_type_cocos2d_CCObject,
                                    pObject));
        cc_mrb_value_register(mrb_, pObject, argv[0]);
        pObject->retain();
    }

    argv[1] = mrb_fixnum_value(event);

    mrb_funcall_argv(mrb_, target, sym_selector_, argc, argv);
    mrb_gc_arena_restore(mrb_, ai);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
}
#endif /* !MRUBY_NO_EXTENSION_BRIDGE */

NS_CC_END
