#ifndef __CC_MRUBY_TABLE_VIEW_DATA_SOUCE_H__
#define __CC_MRUBY_TABLE_VIEW_DATA_SOUCE_H__

#include "mruby.h"
#include "cocoa/CCObject.h"
#include "CCTableView.h"

NS_CC_EXT_BEGIN

class CCMRubyTableViewDataSource : public CCObject, public CCTableViewDataSource
{
public:
    explicit CCMRubyTableViewDataSource(mrb_state *mrb, mrb_value& mrb_data_source);
    virtual ~CCMRubyTableViewDataSource();

    virtual CCSize tableCellSizeForIndex(CCTableView *table, unsigned int idx);
    virtual CCSize cellSizeForTable(CCTableView *table);
    virtual CCTableViewCell* tableCellAtIndex(CCTableView *table, unsigned int idx);
    virtual unsigned int numberOfCellsInTableView(CCTableView *table);

protected:
    mrb_value getMRubyDataSource(void);
    mrb_value getMRubyTableView(CCTableView *table);
    mrb_value callMRubyFuncWithArgv(int num_names, const char **names, int argc, mrb_value *argv, int *respond);

private:
    mrb_state *mrb_;
    mrb_sym sym_data_source_;

public:
    static CCMRubyTableViewDataSource *create(mrb_state *mrb, mrb_value& mrb_data_source);
};

NS_CC_EXT_END

#endif /* __CC_MRUBY_TABLE_VIEW_DATA_SOUCE_H__ */
