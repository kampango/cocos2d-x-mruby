#ifndef __KAZMATH_BRIDGE_H__
#define __KAZMATH_BRIDGE_H__

#include "mruby.h"
#include "mruby/data.h"
#include "kazmath/mat3.h"
#include "kazmath/vec4.h"
#include "kazmath/quaternion.h"
#include "kazmath/plane.h"
#include "kazmath/GL/matrix.h"

#if defined(__cplusplus)
extern "C" {
#endif

void mrb_init_Kazmath(mrb_state *mrb);

#if defined(__cplusplus)
}  /* extern "C" { */
#endif

#endif /* __KAZMATH_BRIDGE_H__ */
