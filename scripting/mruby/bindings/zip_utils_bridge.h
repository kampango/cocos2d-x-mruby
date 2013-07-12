#ifndef __ZIP_UTILS_BRIDGE_H__
#define __ZIP_UTILS_BRIDGE_H__

#include "mruby.h"
#include "support/zip_support/ZipUtils.h"

#if defined(__cplusplus)
extern "C" {
#endif

void mrb_init_cocos2d_ZipUtils(mrb_state *mrb);

#if defined(__cplusplus)
}  /* extern "C" { */
#endif

#endif /* __ZIP_UTILS_BRIDGE_H__ */
