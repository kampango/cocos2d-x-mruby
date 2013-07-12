#ifndef __CC_MRUBY_TABLE_VIEW_DELEGATE_H__
#define __CC_MRUBY_TABLE_VIEW_DELEGATE_H__

#include "mruby.h"
#include "cocoa/CCObject.h"
#include "CCTableView.h"

NS_CC_EXT_BEGIN

class CCMRubyTableViewDelegate : public CCObject, public CCTableViewDelegate
{
public:
    explicit CCMRubyTableViewDelegate(mrb_state *mrb, mrb_value& mrb_delegate);
    virtual ~CCMRubyTableViewDelegate();

    virtual void tableCellTouched(CCTableView* table, CCTableViewCell* cell);
    virtual void tableCellHighlight(CCTableView* table, CCTableViewCell* cell);
    virtual void tableCellUnhighlight(CCTableView* table, CCTableViewCell* cell);
    virtual void tableCellWillRecycle(CCTableView* table, CCTableViewCell* cell);

    virtual void scrollViewDidScroll(CCScrollView* view);
    virtual void scrollViewDidZoom(CCScrollView* view);

protected:
    mrb_value getMRubyDelegate(void);
    mrb_value callMRubyFunc(int num_names, const char **names, CCTableView *table, CCTableViewCell *cell, int *respond);
    mrb_value callMRubyFuncWithArgv(int num_names, const char **names, int argc, mrb_value *argv, int *respond);
    mrb_value getMRubyCell(CCTableViewCell *cell);

private:
    mrb_state *mrb_;

public:
    static CCMRubyTableViewDelegate *create(mrb_state *mrb, mrb_value& mrb_delegate);
};

NS_CC_EXT_END

#endif /* __CC_MRUBY_TABLE_VIEW_DELEGATE_H__ */
