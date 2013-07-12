#ifndef __EXTENSION_BRIDGE_H__
#define __EXTENSION_BRIDGE_H__

#include "mruby.h"

#if defined(__cplusplus)
extern "C" {
#endif

void mrb_init_cocos2d_extension(mrb_state *mrb);

#if defined(__cplusplus)
}  /* extern "C" { */
#endif

extern struct mrb_data_type mrb_type_cocos2d_extension__AnimationState;
extern struct mrb_data_type mrb_type_cocos2d_extension_CCEditBox;
extern struct mrb_data_type mrb_type_cocos2d_extension_CCHttpResponse;
extern struct mrb_data_type mrb_type_cocos2d_extension_CCTableView;
extern struct mrb_data_type mrb_type_cocos2d_extension_CCTableViewCell;
extern struct mrb_data_type mrb_no_free_type_cocos2d_extension_WebSocket;
extern struct mrb_data_type mrb_no_free_type_cocos2d_extension_WebSocket_Data;
#endif /* __EXTENSION_BRIDGE_H__ */
