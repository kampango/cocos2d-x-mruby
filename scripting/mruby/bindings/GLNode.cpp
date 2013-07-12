#include "mruby.h"
#include "mruby/class.h"
#include "mruby/proc.h"
#include "mruby_helper.h"

#include "CCMRubyEngine.h"
#include "GLNode.h"

USING_NS_CC;

GLNode::GLNode()
    : mrb_(0)
{
    CCMRubyEngine *pEngine = dynamic_cast<CCMRubyEngine *>(CCScriptEngineManager::sharedManager()->getScriptEngine());

    mrb_ = pEngine->getMRBState();
}

void GLNode::draw()
{
    mrb_value mrb_self = cc_mrb_value_retrieve(mrb_, this);
    if (mrb_nil_p(mrb_self)) {
        return;
    }

    struct RClass *c = mrb_class(mrb_, mrb_self);
    mrb_sym mid = mrb_intern_cstr(mrb_, "draw");
    struct RProc *p = mrb_method_search_vm(mrb_, &c, mid);
    if (!p || MRB_PROC_CFUNC_P(p)) {
        return;
    }

    int arena_idx = mrb_gc_arena_save(mrb_);
    mrb_funcall_argv(mrb_, mrb_self, mid, 0, NULL);
    mrb_gc_arena_restore(mrb_, arena_idx);

    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
    }
}
