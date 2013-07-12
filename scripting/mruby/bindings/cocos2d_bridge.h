#ifndef __COCOS2D_BRIDGE_H__
#define __COCOS2D_BRIDGE_H__

#include "mruby.h"
#include "mruby/data.h"
#include "mruby/value.h"
#include "cocos2d.h"

#if defined(__cplusplus)
extern "C" {
#endif

void mrb_init_cocos2d(mrb_state *mrb);

#if defined(__cplusplus)
}  /* extern "C" { */
#endif

extern struct mrb_data_type mrb_type_cocos2d_CCAcceleration;
extern struct mrb_data_type mrb_type_cocos2d_CCAffineTransform;
extern struct mrb_data_type mrb_type_cocos2d_CCArray;
extern struct mrb_data_type mrb_type_cocos2d_CCDictionary;
extern struct mrb_data_type mrb_type_cocos2d_CCEvent;
extern struct mrb_data_type mrb_type_cocos2d_CCLabelTTF;
extern struct mrb_data_type mrb_type_cocos2d_CCNode;
extern struct mrb_data_type mrb_type_cocos2d_CCMenuItem;
extern struct mrb_data_type mrb_type_cocos2d_CCObject;
extern struct mrb_data_type mrb_type_cocos2d_CCPoint;
extern struct mrb_data_type mrb_type_cocos2d_CCProgressTimer;
extern struct mrb_data_type mrb_type_cocos2d_CCRect;
extern struct mrb_data_type mrb_type_cocos2d_CCScene;
extern struct mrb_data_type mrb_type_cocos2d_CCSize;
extern struct mrb_data_type mrb_type_cocos2d_CCSprite;
extern struct mrb_data_type mrb_type_cocos2d_CCString;
extern struct mrb_data_type mrb_type_cocos2d_CCTextureAtlas;
extern struct mrb_data_type mrb_type_cocos2d_CCTouch;
extern struct mrb_data_type mrb_type_cocos2d__ccColor3B;
extern struct mrb_data_type mrb_type_cocos2d__ccBlendFunc;

extern struct mrb_data_type mrb_no_free_type_cocos2d_CCAffineTransform;
extern struct mrb_data_type mrb_no_free_type_cocos2d_CCArray;
extern struct mrb_data_type mrb_no_free_type_cocos2d_CCDictionary;
extern struct mrb_data_type mrb_no_free_type_cocos2d_CCPoint;
extern struct mrb_data_type mrb_no_free_type_cocos2d__ccColor3B;
#endif /* __COCOS2D_BRIDGE__ */
