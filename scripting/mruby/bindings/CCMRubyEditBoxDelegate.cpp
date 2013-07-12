#include "mruby.h"

#include "mruby_helper.h"
#include "extension_bridge.h"
#include "CCMRubyEditBoxDelegate.h"

USING_NS_CC_EXT;

mrb_value CCMRubyEditBoxDelegate::getMRubyEditBox(CCEditBox *editBox)
{
    mrb_value mrb_edit_box = cc_mrb_value_retrieve(mrb_, editBox);
    if (mrb_nil_p(mrb_edit_box)) {
        mrb_edit_box = mrb_obj_value(
            Data_Wrap_Struct(
                mrb_,
                cc_mrb_class_get(mrb_, "Cocos2d::Extension::CCEditBox"),
                &mrb_type_cocos2d_extension_CCEditBox,
                editBox));
        editBox->retain();
        cc_mrb_value_register(mrb_, editBox, mrb_edit_box);
    }
    return mrb_edit_box;
}

void CCMRubyEditBoxDelegate::editBoxEditingDidBegin(CCEditBox* editBox)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "edit_box_editing_did_begin";
    names[1] = "editBoxEditingDidBegin";

    int argc = 1;
    mrb_value argv[argc];
    argv[0] = getMRubyEditBox(editBox);

    int respond = 0;
    callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
    if (respond) { return; }

    CCEditBoxDelegate::editBoxEditingDidBegin(editBox);
}

void CCMRubyEditBoxDelegate::editBoxEditingDidEnd(CCEditBox* editBox)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "edit_box_editing_did_end";
    names[1] = "editBoxEditingDidEnd";

    int argc = 1;
    mrb_value argv[argc];
    argv[0] = getMRubyEditBox(editBox);

    int respond = 0;
    callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
    if (respond) { return; }

    CCEditBoxDelegate::editBoxEditingDidEnd(editBox);
}

void CCMRubyEditBoxDelegate::editBoxTextChanged(CCEditBox* editBox, const std::string& text)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "edit_box_text_changed";
    names[1] = "editBoxTextChanged";

    int argc = 2;
    mrb_value argv[argc];
    argv[0] = getMRubyEditBox(editBox);
    argv[1] = mrb_str_new_cstr(mrb_, text.c_str());

    int respond = 0;
    callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
    if (respond) { return; }

    CCEditBoxDelegate::editBoxTextChanged(editBox, text);
}

void CCMRubyEditBoxDelegate::editBoxReturn(CCEditBox* editBox)
{
    int num_names = 2;
    const char *names[num_names];
    names[0] = "edit_box_return";
    names[1] = "editBoxReturn";

    int argc = 1;
    mrb_value argv[argc];
    argv[0] = getMRubyEditBox(editBox);

    int respond = 0;
    callMRubyFuncWithArgv(num_names, names, argc, argv, &respond);
}

CCMRubyEditBoxDelegate*
CCMRubyEditBoxDelegate::create(mrb_state *mrb, mrb_value& item)
{
    CCMRubyEditBoxDelegate *delegate = new CCMRubyEditBoxDelegate(mrb, item);
    delegate->autorelease();
    return delegate;
}
