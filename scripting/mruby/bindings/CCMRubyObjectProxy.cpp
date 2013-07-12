#include "mruby.h"
#include "mruby/data.h"
#include "mruby/hash.h"
#include "mruby/variable.h"

#include "ccMacros.h"
#include "platform/CCCommon.h"
#include "mruby_helper.h"
#include "extension_bridge.h"

#include "CCMRubyObjectProxy.h"

USING_NS_CC_EXT;

CCMRubyObjectProxy::CCMRubyObjectProxy(mrb_state *mrb, mrb_value& mrb_item)
    : mrb_(mrb)
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, CC_MRUBY_OBJECT_PROXY_KEY));
    if (!mrb_hash_p(hash)) {
        hash = mrb_hash_new_capa(mrb_, 1);
        mrb_gv_set(mrb_, mrb_intern_cstr(mrb_, CC_MRUBY_OBJECT_PROXY_KEY), hash);
    }

    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_value iv = mrb_hash_get(mrb_, hash, key);
    if (!mrb_hash_p(iv)) {
        iv = mrb_hash_new_capa(mrb_, 2);
        mrb_hash_set(mrb_, hash, key, iv);
    }
    mrb_hash_set(mrb_, iv, mrb_symbol_value(mrb_intern_cstr(mrb_, "__item__")), mrb_item);
}

CCMRubyObjectProxy::~CCMRubyObjectProxy() {
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, CC_MRUBY_OBJECT_PROXY_KEY));
    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_hash_delete_key(mrb_, hash, key);
    mrb_ = NULL;
}

mrb_value CCMRubyObjectProxy::getMRubyItem() {
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, CC_MRUBY_OBJECT_PROXY_KEY));
    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_value iv = mrb_hash_get(mrb_, hash, key);
    return mrb_hash_get(mrb_, iv, mrb_symbol_value(mrb_intern_cstr(mrb_, "__item__")));
}

mrb_value CCMRubyObjectProxy::callMRubyFuncWithArgv(int num_names, const char **names, int argc, mrb_value *argv, int *respond)
{
    mrb_value mrb_item = getMRubyItem();
    CCAssert(!mrb_nil_p(mrb_item), "");

    if (respond) { *respond = NULL; }

    for (int i = 0; i < num_names; ++i) {
        mrb_sym sym = mrb_intern(mrb_, names[i]);
        if (mrb_respond_to(mrb_, mrb_item, sym)) {
            if (respond) { *respond = 1; }
            mrb_int ai = mrb_gc_arena_save(mrb_);

            mrb_value res = mrb_funcall_argv(mrb_, mrb_item, sym, argc, argv);
            mrb_gc_arena_restore(mrb_, ai);

            if (mrb_->exc) {
                mrb_print_error(mrb_);
                res = mrb_nil_value();
            }
            return res;
        }
    }

    return mrb_nil_value();
}
