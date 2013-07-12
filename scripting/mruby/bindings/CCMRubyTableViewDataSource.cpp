#include "mruby.h"
#include "mruby/data.h"
#include "mruby/hash.h"
#include "mruby/variable.h"

#include "platform/CCCommon.h"
#include "mruby_helper.h"
#include "extension_bridge.h"

#include "CCMRubyTableViewDataSource.h"

USING_NS_CC;

NS_CC_EXT_BEGIN

CCMRubyTableViewDataSource *
CCMRubyTableViewDataSource::create(mrb_state *mrb, mrb_value& mrb_data_source)
{
    CCMRubyTableViewDataSource *source = new CCMRubyTableViewDataSource(mrb, mrb_data_source);
    if (!source) {
        return NULL;
    }
    source->autorelease();
    return source;
}

CCMRubyTableViewDataSource::CCMRubyTableViewDataSource(mrb_state *mrb, mrb_value& mrb_data_source)
    : mrb_(mrb)
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyTableViewDataSource"));
    if (!mrb_hash_p(hash)) {
        hash = mrb_hash_new_capa(mrb_, 1);
        mrb_gv_set(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyTableViewDataSource"), hash);
    }

    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_value iv = mrb_hash_get(mrb_, hash, key);
    if (!mrb_hash_p(iv)) {
        iv = mrb_hash_new_capa(mrb_, 2);
        mrb_hash_set(mrb_, hash, key, iv);
    }
    
    sym_data_source_ = mrb_intern_cstr(mrb_, "data_source");
    mrb_hash_set(mrb_, iv, mrb_symbol_value(sym_data_source_), mrb_data_source);
}

CCMRubyTableViewDataSource::~CCMRubyTableViewDataSource()
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyTableViewDataSource"));
    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_hash_delete_key(mrb_, hash, key);
    mrb_ = NULL;
}

mrb_value
CCMRubyTableViewDataSource::getMRubyDataSource()
{
    mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, "$G_CCMRubyTableViewDataSource"));
    mrb_value key = mrb_fixnum_value(this->m_uID);
    mrb_value iv = mrb_hash_get(mrb_, hash, key);
    return mrb_hash_get(mrb_, iv, mrb_symbol_value(sym_data_source_));
}

mrb_value
CCMRubyTableViewDataSource::callMRubyFuncWithArgv(int num_names, const char **names, int argc, mrb_value *argv, int *respond)
{
    mrb_value mrb_obj = getMRubyDataSource();
    CCAssert(!mrb_nil_p(mrb_obj), "");

    if (respond) { *respond = NULL; }

    for (int i = 0; i < num_names; ++i) {
        mrb_sym sym = mrb_intern(mrb_, names[i]);
        if (mrb_respond_to(mrb_, mrb_obj, sym)) {
            if (respond) { *respond = 1; }
            mrb_int ai = mrb_gc_arena_save(mrb_);

            mrb_value res = mrb_funcall_argv(mrb_, mrb_obj, sym, argc, argv);
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

mrb_value
CCMRubyTableViewDataSource::getMRubyTableView(CCTableView *table)
{
    mrb_value mrb_res = cc_mrb_value_retrieve(mrb_, table);
    if (mrb_nil_p(mrb_res)) {
        mrb_res = mrb_obj_value(Data_Wrap_Struct(
                                    mrb_,
                                    cc_mrb_class_get(mrb_, "Cocos2d::Extension::CCTableView"),
                                    &mrb_type_cocos2d_extension_CCTableView,
                                    table));
        cc_mrb_value_register(mrb_, table, mrb_res);
        table->retain();
    }
    return mrb_res;
}

CCSize
CCMRubyTableViewDataSource::tableCellSizeForIndex(CCTableView *table, unsigned int idx)
{
    mrb_value mrb_table = getMRubyTableView(table);

    mrb_int argc = 2;
    mrb_value argv[argc];
    argv[0] = mrb_table;
    argv[1] = mrb_fixnum_value(idx);

    int num_names = 2;
    const char *names[num_names];
    names[0] = "table_cell_size_for_index";
    names[1] = "tableCellSizeForIndex";

    int respond = 0;
    mrb_value mrb_res = callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
    if (respond) {
        return *(static_cast< CCSize * >(DATA_PTR(mrb_res)));
    }
    return CCTableViewDataSource::tableCellSizeForIndex(table, idx);
}

CCSize
CCMRubyTableViewDataSource::cellSizeForTable(CCTableView *table)
{
    mrb_value mrb_table = getMRubyTableView(table);

    mrb_int argc = 1;
    mrb_value argv[argc];
    argv[0] = mrb_table;

    int num_names = 2;
    const char *names[num_names];
    names[0] = "cell_size_for_table";
    names[1] = "cellSizeForTable";

    int respond = 0;
    mrb_value mrb_res = callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
    if (respond) {
        return *(static_cast< CCSize * >(DATA_PTR(mrb_res)));
    }
    return CCTableViewDataSource::cellSizeForTable(table);
}

CCTableViewCell* 
CCMRubyTableViewDataSource::tableCellAtIndex(CCTableView *table, unsigned int idx)
{
    mrb_value mrb_table = getMRubyTableView(table);

    mrb_int argc = 2;
    mrb_value argv[argc];
    argv[0] = mrb_table;
    argv[1] = mrb_fixnum_value(idx);

    int num_names = 2;
    const char *names[num_names];
    names[0] = "table_cell_at_index";
    names[1] = "tableCellAtIndex";

    int respond = 0;
    mrb_value mrb_res = callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
    if (respond && !mrb_nil_p(mrb_res)) {
        CCTableViewCell *res = static_cast< CCTableViewCell * >(DATA_PTR(mrb_res));
        res->retain();
        res->autorelease();
        return res;
    }
    return NULL;
}

unsigned int
CCMRubyTableViewDataSource::numberOfCellsInTableView(CCTableView *table)
{
    mrb_value mrb_table = getMRubyTableView(table);

    mrb_int argc = 1;
    mrb_value argv[argc];
    argv[0] = mrb_table;

    int num_names = 2;
    const char *names[num_names];
    names[0] = "number_of_cells_in_table_view";
    names[1] = "numberOfCellsInTableView";

    int respond = 0;
    mrb_value mrb_res = callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
    if (respond) {
        return mrb_fixnum(mrb_res);
    }
    return 0;
}

NS_CC_EXT_END
