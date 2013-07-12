#ifndef __COCOS_DENSHION_BRIDGE_H__
#define __COCOS_DENSHION_BRIDGE_H__

#include "mruby.h"
#include "SimpleAudioEngine.h"

#if defined(__cplusplus)
extern "C" {
#endif

void mrb_init_CocosDenshion(mrb_state *mrb);

#if defined(__cplusplus)
}  /* extern "C" { */
#endif

#endif /* __COCOS_DENSHION_BRIDGE_H__ */
