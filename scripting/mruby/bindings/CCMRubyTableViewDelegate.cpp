#include "mruby.h"
#include "mruby/data.h"
#include "mruby/hash.h"
#include "mruby/variable.h"

#include "platform/CCCommon.h"
#include "mruby_helper.h"
#include "extension_bridge.h"

#include "CCMRubyTableViewDelegate.h"

USING_NS_CC;

NS_CC_EXT_BEGIN

CCMRubyTableViewDelegate *
CCMRubyTableViewDelegate::create(mrb_state *mrb, mrb_value& mrb_delegate)
{
    CCMRubyTableViewDelegate *delegate = new CCMRubyTableViewDelegate(mrb, mrb_delegate);
    delegate->autorelease();
    return delegate;
}

CCMRubyTableViewDelegate::CCMRubyTableViewDelegate(mrb_state *mrb, mrb_value& mrb_delegate)
    : mrb_(mrb)
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyTableViewDelegate"));
    if (!mrb_hash_p(hash)) {
        hash = mrb_hash_new_capa(mrb_, 1);
        mrb_gv_set(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyTableViewDelegate"), hash);
    }

    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_value iv = mrb_hash_get(mrb_, hash, key);
    if (!mrb_hash_p(iv)) {
        iv = mrb_hash_new_capa(mrb_, 2);
        mrb_hash_set(mrb_, hash, key, iv);
    }

    mrb_hash_set(mrb_, iv, mrb_symbol_value(mrb_intern_cstr(mrb_, "delegate")), mrb_delegate);
}

CCMRubyTableViewDelegate::~CCMRubyTableViewDelegate()
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyTableViewDelegate"));
    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_hash_delete_key(mrb_, hash, key);
    mrb_ = NULL;
}

void CCMRubyTableViewDelegate::tableCellTouched(CCTableView* table, CCTableViewCell* cell)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "table_cell_touched";
    names[1] = "tableCellTouched";

    int respond = 0;
    callMRubyFunc(num_names, names, table, cell, &respond);
}

void CCMRubyTableViewDelegate::tableCellHighlight(CCTableView* table, CCTableViewCell* cell)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "table_cell_highlight";
    names[1] = "tableCellHighlight";

    int respond = 0;
    callMRubyFunc(num_names, names, table, cell, &respond);
    if (respond) { return; }

    CCTableViewDelegate::tableCellHighlight(table, cell);
}

void CCMRubyTableViewDelegate::tableCellUnhighlight(CCTableView* table, CCTableViewCell* cell)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "table_cell_unhighlight";
    names[1] = "tableCellUnhighlight";

    int respond = 0;
    callMRubyFunc(num_names, names, table, cell, &respond);
    if (respond) { return; }

    CCTableViewDelegate::tableCellUnhighlight(table, cell);
}

void CCMRubyTableViewDelegate::tableCellWillRecycle(CCTableView* table, CCTableViewCell* cell)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "table_cell_will_recycle";
    names[1] = "tableCellWillRecycle";

    int respond = 0;
    callMRubyFunc(num_names, names, table, cell, &respond);
    if (respond) { return; }

    CCTableViewDelegate::tableCellWillRecycle(table, cell);
}

// CCScrollViewDelegate methods
void
CCMRubyTableViewDelegate::scrollViewDidScroll(CCScrollView* view)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "scroll_view_did_scroll";
    names[1] = "scrollViewDidScroll";

    mrb_value mrb_view = cc_mrb_value_retrieve(mrb_, view);
    CCAssert(!mrb_nil_p(mrb_view), "");

    mrb_int argc = 1;
    mrb_value argv[argc];
    argv[0] = mrb_view;

    int respond = 0;
    callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
}

void
CCMRubyTableViewDelegate::scrollViewDidZoom(CCScrollView* view)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "scroll_view_did_zoom";
    names[1] = "scrollViewDidZoom";

    mrb_value mrb_view = cc_mrb_value_retrieve(mrb_, view);
    CCAssert(!mrb_nil_p(mrb_view), "");

    mrb_int argc = 1;
    mrb_value argv[argc];
    argv[0] = mrb_view;

    int respond = 0;
    callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
}

mrb_value
CCMRubyTableViewDelegate::callMRubyFunc(int num_names, const char **names, CCTableView *table, CCTableViewCell *cell, int *respond)
{
    mrb_value mrb_table = cc_mrb_value_retrieve(mrb_, table);
    CCAssert(!mrb_nil_p(mrb_table), "");

    mrb_int argc = 2;
    mrb_value argv[argc];
    argv[0] = mrb_table;
    argv[1] = getMRubyCell(cell);

    return callMRubyFuncWithArgv(num_names, names, argc, argv, respond);
}

mrb_value
CCMRubyTableViewDelegate::callMRubyFuncWithArgv(int num_names, const char **names, int argc, mrb_value *argv, int *respond)
{
    mrb_value mrb_delegate = getMRubyDelegate();
    CCAssert(!mrb_nil_p(mrb_delegate), "");

    if (respond) { *respond = NULL; }

    for (int i = 0; i < num_names; ++i) {
        mrb_sym sym = mrb_intern(mrb_, names[i]);
        if (mrb_respond_to(mrb_, mrb_delegate, sym)) {
            if (respond) { *respond = 1; }
            mrb_int ai = mrb_gc_arena_save(mrb_);

            mrb_value res = mrb_funcall_argv(mrb_, mrb_delegate, sym, argc, argv);
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


mrb_value CCMRubyTableViewDelegate::getMRubyDelegate()
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyTableViewDelegate"));
    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_value iv = mrb_hash_get(mrb_, hash, key);
    return mrb_hash_get(mrb_, iv, mrb_symbol_value(mrb_intern_cstr(mrb_, "delegate")));
}

mrb_value CCMRubyTableViewDelegate::getMRubyCell(CCTableViewCell *cell)
{
    mrb_value mrb_res = cc_mrb_value_retrieve(mrb_, cell);
    if (mrb_nil_p(mrb_res)) {
        mrb_res = mrb_obj_value(Data_Wrap_Struct(
                                    mrb_,
                                    cc_mrb_class_get(mrb_, "Cocos2d::Extension::CCTableViewCell"),
                                    &mrb_type_cocos2d_extension_CCTableViewCell,
                                    cell));
        cc_mrb_value_register(mrb_, cell, mrb_res);
        cell->retain();
    }
    CCAssert(DATA_PTR(mrb_res) == cell, "");
    return mrb_res;
}


NS_CC_EXT_END
