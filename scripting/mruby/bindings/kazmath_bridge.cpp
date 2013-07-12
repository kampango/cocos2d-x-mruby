/*
 * mruby binding: Cocos2d
 * Generated automatically by gen_mrb_bridge.rb on 2013-08-02 17:38:18 +0900.
 */

#include <assert.h>
#include <string>
#include <map>
#include "mruby.h"
#include "mruby/array.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "mruby/hash.h"
#include "mruby/string.h"
#include "mruby/value.h"
#include "mruby/variable.h"

#include "mruby_helper.h"

#include "cocos2d.h"
#include "kazmath_bridge.h"
#define Kazmath


#define DONE mrb_gc_arena_restore(mrb, 0)

typedef cocos2d::CCImage::EImageFormat EImageFormat;
typedef cocos2d::CCImage::ETextAlign ETextAlign;
typedef bool _Bool;
typedef char __va_list_tag;

using namespace cocos2d;

template<typename T>
static inline T _cast_as_func(void *vp)
{
    T func;
    *(reinterpret_cast< void ** >(&func)) = vp;
    return func;
}

static struct RClass *_define_class_Kazmath(mrb_state *mrb);
static struct RClass *_define_class_Kazmath_kmMat3(mrb_state *mrb);
static struct RClass *_define_class_Kazmath_kmMat4(mrb_state *mrb);
static struct RClass *_define_class_Kazmath_kmPlane(mrb_state *mrb);
static struct RClass *_define_class_Kazmath_kmQuaternion(mrb_state *mrb);
static struct RClass *_define_class_Kazmath_kmVec3(mrb_state *mrb);
static struct RClass *_define_class_Kazmath_kmVec4(mrb_state *mrb);

static struct RClass *
_define_class_Kazmath(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Kazmath") != 0) {
    return cc_mrb_class_get(mrb, "Kazmath");
  }

  struct RClass *rc = NULL;
  rc = mrb_define_module(mrb, "Kazmath");
  assert(rc);
  cc_mrb_class_register(mrb, rc, "Kazmath");
  return rc;
}

static void
mrb_free_Kazmath_kmMat3(mrb_state *mrb, void *ptr)
{
  delete static_cast< Kazmath::kmMat3 * >(ptr);
}

struct mrb_data_type mrb_type_Kazmath_kmMat3 = {
  "Kazmath::kmMat3",
  mrb_free_Kazmath_kmMat3
};
static void
mrb_no_free_Kazmath_kmMat3(mrb_state *mrb, void *ptr)
{
  /* do not free! */
}

static struct mrb_data_type mrb_no_free_type_Kazmath_kmMat3 = {
  "Kazmath::kmMat3",
  mrb_no_free_Kazmath_kmMat3
};
static struct RClass *
_define_class_Kazmath_kmMat3(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Kazmath::kmMat3") != 0) {
    return cc_mrb_class_get(mrb, "Kazmath::kmMat3");
  }
  struct RClass *base_rc = mrb->object_class;
  /* XXX: First letter should be uppercase in class names. */
  printf("kmMat3 -> CCkmMat3\n");
  struct RClass *outer = cc_mrb_class_get(mrb, "Kazmath");
  assert(outer);
  struct RClass *rc = mrb_define_class_under(mrb, outer, "CCkmMat3", base_rc);
  assert(rc);
  MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
  cc_mrb_class_register(mrb, rc, "Kazmath::kmMat3");
  return rc;
}

static void
mrb_free_Kazmath_kmMat4(mrb_state *mrb, void *ptr)
{
  delete static_cast< Kazmath::kmMat4 * >(ptr);
}

struct mrb_data_type mrb_type_Kazmath_kmMat4 = {
  "Kazmath::kmMat4",
  mrb_free_Kazmath_kmMat4
};
static void
mrb_no_free_Kazmath_kmMat4(mrb_state *mrb, void *ptr)
{
  /* do not free! */
}

static struct mrb_data_type mrb_no_free_type_Kazmath_kmMat4 = {
  "Kazmath::kmMat4",
  mrb_no_free_Kazmath_kmMat4
};
static struct RClass *
_define_class_Kazmath_kmMat4(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Kazmath::kmMat4") != 0) {
    return cc_mrb_class_get(mrb, "Kazmath::kmMat4");
  }
  struct RClass *base_rc = mrb->object_class;
  /* XXX: First letter should be uppercase in class names. */
  printf("kmMat4 -> CCkmMat4\n");
  struct RClass *outer = cc_mrb_class_get(mrb, "Kazmath");
  assert(outer);
  struct RClass *rc = mrb_define_class_under(mrb, outer, "CCkmMat4", base_rc);
  assert(rc);
  MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
  cc_mrb_class_register(mrb, rc, "Kazmath::kmMat4");
  return rc;
}

static void
mrb_free_Kazmath_kmPlane(mrb_state *mrb, void *ptr)
{
  delete static_cast< Kazmath::kmPlane * >(ptr);
}

struct mrb_data_type mrb_type_Kazmath_kmPlane = {
  "Kazmath::kmPlane",
  mrb_free_Kazmath_kmPlane
};
static void
mrb_no_free_Kazmath_kmPlane(mrb_state *mrb, void *ptr)
{
  /* do not free! */
}

static struct mrb_data_type mrb_no_free_type_Kazmath_kmPlane = {
  "Kazmath::kmPlane",
  mrb_no_free_Kazmath_kmPlane
};
static struct RClass *
_define_class_Kazmath_kmPlane(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Kazmath::kmPlane") != 0) {
    return cc_mrb_class_get(mrb, "Kazmath::kmPlane");
  }
  struct RClass *base_rc = mrb->object_class;
  /* XXX: First letter should be uppercase in class names. */
  printf("kmPlane -> CCkmPlane\n");
  struct RClass *outer = cc_mrb_class_get(mrb, "Kazmath");
  assert(outer);
  struct RClass *rc = mrb_define_class_under(mrb, outer, "CCkmPlane", base_rc);
  assert(rc);
  MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
  cc_mrb_class_register(mrb, rc, "Kazmath::kmPlane");
  return rc;
}

static void
mrb_free_Kazmath_kmQuaternion(mrb_state *mrb, void *ptr)
{
  delete static_cast< Kazmath::kmQuaternion * >(ptr);
}

struct mrb_data_type mrb_type_Kazmath_kmQuaternion = {
  "Kazmath::kmQuaternion",
  mrb_free_Kazmath_kmQuaternion
};
static void
mrb_no_free_Kazmath_kmQuaternion(mrb_state *mrb, void *ptr)
{
  /* do not free! */
}

static struct mrb_data_type mrb_no_free_type_Kazmath_kmQuaternion = {
  "Kazmath::kmQuaternion",
  mrb_no_free_Kazmath_kmQuaternion
};
static struct RClass *
_define_class_Kazmath_kmQuaternion(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Kazmath::kmQuaternion") != 0) {
    return cc_mrb_class_get(mrb, "Kazmath::kmQuaternion");
  }
  struct RClass *base_rc = mrb->object_class;
  /* XXX: First letter should be uppercase in class names. */
  printf("kmQuaternion -> CCkmQuaternion\n");
  struct RClass *outer = cc_mrb_class_get(mrb, "Kazmath");
  assert(outer);
  struct RClass *rc = mrb_define_class_under(mrb, outer, "CCkmQuaternion", base_rc);
  assert(rc);
  MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
  cc_mrb_class_register(mrb, rc, "Kazmath::kmQuaternion");
  return rc;
}

static void
mrb_free_Kazmath_kmVec3(mrb_state *mrb, void *ptr)
{
  delete static_cast< Kazmath::kmVec3 * >(ptr);
}

struct mrb_data_type mrb_type_Kazmath_kmVec3 = {
  "Kazmath::kmVec3",
  mrb_free_Kazmath_kmVec3
};
static void
mrb_no_free_Kazmath_kmVec3(mrb_state *mrb, void *ptr)
{
  /* do not free! */
}

static struct mrb_data_type mrb_no_free_type_Kazmath_kmVec3 = {
  "Kazmath::kmVec3",
  mrb_no_free_Kazmath_kmVec3
};
static struct RClass *
_define_class_Kazmath_kmVec3(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Kazmath::kmVec3") != 0) {
    return cc_mrb_class_get(mrb, "Kazmath::kmVec3");
  }
  struct RClass *base_rc = mrb->object_class;
  /* XXX: First letter should be uppercase in class names. */
  printf("kmVec3 -> CCkmVec3\n");
  struct RClass *outer = cc_mrb_class_get(mrb, "Kazmath");
  assert(outer);
  struct RClass *rc = mrb_define_class_under(mrb, outer, "CCkmVec3", base_rc);
  assert(rc);
  MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
  cc_mrb_class_register(mrb, rc, "Kazmath::kmVec3");
  return rc;
}

static void
mrb_free_Kazmath_kmVec4(mrb_state *mrb, void *ptr)
{
  delete static_cast< Kazmath::kmVec4 * >(ptr);
}

struct mrb_data_type mrb_type_Kazmath_kmVec4 = {
  "Kazmath::kmVec4",
  mrb_free_Kazmath_kmVec4
};
static void
mrb_no_free_Kazmath_kmVec4(mrb_state *mrb, void *ptr)
{
  /* do not free! */
}

static struct mrb_data_type mrb_no_free_type_Kazmath_kmVec4 = {
  "Kazmath::kmVec4",
  mrb_no_free_Kazmath_kmVec4
};
static struct RClass *
_define_class_Kazmath_kmVec4(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Kazmath::kmVec4") != 0) {
    return cc_mrb_class_get(mrb, "Kazmath::kmVec4");
  }
  struct RClass *base_rc = mrb->object_class;
  /* XXX: First letter should be uppercase in class names. */
  printf("kmVec4 -> CCkmVec4\n");
  struct RClass *outer = cc_mrb_class_get(mrb, "Kazmath");
  assert(outer);
  struct RClass *rc = mrb_define_class_under(mrb, outer, "CCkmVec4", base_rc);
  assert(rc);
  MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
  cc_mrb_class_register(mrb, rc, "Kazmath::kmVec4");
  return rc;
}

static mrb_value
mrb_Kazmath_kmAlmostEqual(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float lhs;
    mrb_float rhs;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ff", &lhs, &rhs)) {
      unsigned char res = Kazmath::kmAlmostEqual(lhs, rhs);
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmAlmostEqual");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmDegreesToRadians(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float degrees;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "f", &degrees)) {
      float res = Kazmath::kmDegreesToRadians(degrees);
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmDegreesToRadians");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLFreeAll(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      Kazmath::kmGLFreeAll();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLFreeAll");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLGetMatrix(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int mode;
    mrb_value pOut;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "io", &mode, &pOut)) {
      Kazmath::kmGLGetMatrix(mode, static_cast< struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLGetMatrix");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLLoadIdentity(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      Kazmath::kmGLLoadIdentity();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLLoadIdentity");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLLoadMatrix(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      Kazmath::kmGLLoadMatrix(static_cast< const struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLLoadMatrix");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLMatrixMode(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int mode;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &mode)) {
      Kazmath::kmGLMatrixMode(mode);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLMatrixMode");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLMultMatrix(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      Kazmath::kmGLMultMatrix(static_cast< const struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLMultMatrix");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLPopMatrix(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      Kazmath::kmGLPopMatrix();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLPopMatrix");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLPushMatrix(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      Kazmath::kmGLPushMatrix();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLPushMatrix");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLRotatef(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float angle;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "ffff", &angle, &x, &y, &z)) {
      Kazmath::kmGLRotatef(angle, x, y, z);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLRotatef");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLScalef(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float x;
    mrb_float y;
    mrb_float z;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "fff", &x, &y, &z)) {
      Kazmath::kmGLScalef(x, y, z);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLScalef");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmGLTranslatef(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float x;
    mrb_float y;
    mrb_float z;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "fff", &x, &y, &z)) {
      Kazmath::kmGLTranslatef(x, y, z);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmGLTranslatef");
  return mrb_nil_value();
}
static mrb_value
mrb_Kazmath_kmMat3__get_mat(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmMat3 *obj_self = static_cast< Kazmath::kmMat3 * >(DATA_PTR(mrb_self));
  size_t sz = sizeof(obj_self->mat) / sizeof(obj_self->mat[0]);
  mrb_value res = mrb_ary_new_capa(mrb, sz);
  for (size_t i = 0; i < sz; ++i) {
      mrb_ary_set(mrb, res, i, mrb_float_value(mrb, obj_self->mat[i]));
  }
  return res;
}
static mrb_value
mrb_Kazmath_kmMat3__set_mat(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value mat;
  if (1 == mrb_get_args(mrb, "A", &mat)) {
    Kazmath::kmMat3 *obj_self = static_cast< Kazmath::kmMat3 * >(DATA_PTR(mrb_self));
    size_t sz = sizeof(obj_self->mat) / sizeof(obj_self->mat[0]);
    for (size_t i = 0; i < sz; ++i) {
        mrb_value v = mrb_ary_ref(mrb, mat, i);
        obj_self->mat[i] = mrb_float_p(v) ? mrb_float(v) : 0.0;
    }
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3#mat");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3_initialize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    DATA_TYPE(mrb_self) = &mrb_type_Kazmath_kmMat3;
    DATA_PTR(mrb_self) = NULL;
    if (0 == _argc_) {
      Kazmath::kmMat3 * res = new Kazmath::kmMat3();
      DATA_PTR(mrb_self) = res;
      return mrb_self;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3#initialize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Adjugate(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmMat3 * res = Kazmath::kmMat3Adjugate(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Adjugate");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3AreEqual(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pM1;
    mrb_value pM2;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pM1, &pM2)) {
      const int res = Kazmath::kmMat3AreEqual(static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pM1, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pM2, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3AreEqual");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Assign(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmMat3 * res = Kazmath::kmMat3Assign(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Assign");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Determinant(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      const float res = Kazmath::kmMat3Determinant(static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Determinant");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Fill(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pMat;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oA", &pOut, &pMat)) {
      float cxx_pMat[1]; cc_mrb_ary_conv_to_c_array< float >(mrb, pMat, cxx_pMat, 1);
      kmMat3 * res = Kazmath::kmMat3Fill(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), cxx_pMat);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Fill");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Identity(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pOut)) {
      kmMat3 * res = Kazmath::kmMat3Identity(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Identity");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Inverse(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float pDeterminate;
    mrb_value pM;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ofo", &pOut, &pDeterminate, &pM)) {
      kmMat3 * res = Kazmath::kmMat3Inverse(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), pDeterminate, static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Inverse");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3IsIdentity(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      const int res = Kazmath::kmMat3IsIdentity(static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3IsIdentity");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Multiply(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pM1;
    mrb_value pM2;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pM1, &pM2)) {
      kmMat3 * res = Kazmath::kmMat3Multiply(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pM1, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pM2, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Multiply");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Rotation(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float radians;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "of", &pOut, &radians)) {
      kmMat3 * res = Kazmath::kmMat3Rotation(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Rotation");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3RotationAxisAngle(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value axis;
    mrb_float radians;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oof", &pOut, &axis, &radians)) {
      kmMat3 * res = Kazmath::kmMat3RotationAxisAngle(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, axis, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  {
    mrb_value pOut;
    mrb_value axis;
    mrb_float radians;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oof", &pOut, &axis, &radians)) {
      kmMat3 * res = Kazmath::kmMat3RotationAxisAngle(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, axis, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3RotationAxisAngle");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3RotationQuaternion(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmMat3 * res = Kazmath::kmMat3RotationQuaternion(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const struct kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3RotationQuaternion");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3RotationToAxisAngle(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pAxis;
    mrb_value radians;
    mrb_value pIn;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oAo", &pAxis, &radians, &pIn)) {
      float cxx_radians[1]; cc_mrb_ary_conv_to_c_array< float >(mrb, radians, cxx_radians, 1);
      struct kmVec3 * res = Kazmath::kmMat3RotationToAxisAngle(static_cast< struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pAxis, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), cxx_radians, static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  {
    mrb_value pAxis;
    mrb_value radians;
    mrb_value pIn;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oAo", &pAxis, &radians, &pIn)) {
      float cxx_radians[1]; cc_mrb_ary_conv_to_c_array< float >(mrb, radians, cxx_radians, 1);
      struct kmVec3 * res = Kazmath::kmMat3RotationToAxisAngle(static_cast< struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pAxis, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), cxx_radians, static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3RotationToAxisAngle");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3RotationX(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float radians;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "of", &pOut, &radians)) {
      kmMat3 * res = Kazmath::kmMat3RotationX(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3RotationX");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3RotationY(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float radians;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "of", &pOut, &radians)) {
      kmMat3 * res = Kazmath::kmMat3RotationY(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3RotationY");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3RotationZ(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float radians;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "of", &pOut, &radians)) {
      kmMat3 * res = Kazmath::kmMat3RotationZ(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3RotationZ");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3ScalarMultiply(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pM;
    mrb_float pFactor;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oof", &pOut, &pM, &pFactor)) {
      kmMat3 * res = Kazmath::kmMat3ScalarMultiply(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), pFactor);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3ScalarMultiply");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Scaling(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float x;
    mrb_float y;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "off", &pOut, &x, &y)) {
      kmMat3 * res = Kazmath::kmMat3Scaling(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), x, y);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Scaling");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Translation(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float x;
    mrb_float y;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "off", &pOut, &x, &y)) {
      kmMat3 * res = Kazmath::kmMat3Translation(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), x, y);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Translation");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat3Transpose(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmMat3 * res = Kazmath::kmMat3Transpose(static_cast< kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const kmMat3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat3Transpose");
  return mrb_nil_value();
}
static mrb_value
mrb_Kazmath_kmMat4__get_mat(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmMat4 *obj_self = static_cast< Kazmath::kmMat4 * >(DATA_PTR(mrb_self));
  size_t sz = sizeof(obj_self->mat) / sizeof(obj_self->mat[0]);
  mrb_value res = mrb_ary_new_capa(mrb, sz);
  for (size_t i = 0; i < sz; ++i) {
      mrb_ary_set(mrb, res, i, mrb_float_value(mrb, obj_self->mat[i]));
  }
  return res;
}
static mrb_value
mrb_Kazmath_kmMat4__set_mat(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value mat;
  if (1 == mrb_get_args(mrb, "A", &mat)) {
    Kazmath::kmMat4 *obj_self = static_cast< Kazmath::kmMat4 * >(DATA_PTR(mrb_self));
    size_t sz = sizeof(obj_self->mat) / sizeof(obj_self->mat[0]);
    for (size_t i = 0; i < sz; ++i) {
        mrb_value v = mrb_ary_ref(mrb, mat, i);
        obj_self->mat[i] = mrb_float_p(v) ? mrb_float(v) : 0.0;
    }
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4#mat");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4_initialize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    DATA_TYPE(mrb_self) = &mrb_type_Kazmath_kmMat4;
    DATA_PTR(mrb_self) = NULL;
    if (0 == _argc_) {
      Kazmath::kmMat4 * res = new Kazmath::kmMat4();
      DATA_PTR(mrb_self) = res;
      return mrb_self;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4#initialize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4AreEqual(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pM1;
    mrb_value pM2;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pM1, &pM2)) {
      const int res = Kazmath::kmMat4AreEqual(static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM1, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM2, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4AreEqual");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4Assign(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmMat4 * res = Kazmath::kmMat4Assign(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4Assign");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4ExtractPlane(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    mrb_int plane;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooi", &pOut, &pIn, &plane)) {
      struct kmPlane * res = Kazmath::kmMat4ExtractPlane(static_cast< struct kmPlane * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), plane);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmPlane"),
                       &mrb_type_Kazmath_kmPlane,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4ExtractPlane");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4ExtractRotation(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      struct kmMat3 * res = Kazmath::kmMat4ExtractRotation(static_cast< struct kmMat3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat3"),
                       &mrb_type_Kazmath_kmMat3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4ExtractRotation");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4Fill(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pMat;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oA", &pOut, &pMat)) {
      float cxx_pMat[1]; cc_mrb_ary_conv_to_c_array< float >(mrb, pMat, cxx_pMat, 1);
      kmMat4 * res = Kazmath::kmMat4Fill(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), cxx_pMat);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4Fill");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4GetForwardVec3(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      struct kmVec3 * res = Kazmath::kmMat4GetForwardVec3(static_cast< struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4GetForwardVec3");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4GetRightVec3(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      struct kmVec3 * res = Kazmath::kmMat4GetRightVec3(static_cast< struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4GetRightVec3");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4GetUpVec3(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      struct kmVec3 * res = Kazmath::kmMat4GetUpVec3(static_cast< struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4GetUpVec3");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4Identity(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pOut)) {
      kmMat4 * res = Kazmath::kmMat4Identity(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4Identity");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4Inverse(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pM;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pM)) {
      kmMat4 * res = Kazmath::kmMat4Inverse(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4Inverse");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4IsIdentity(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      const int res = Kazmath::kmMat4IsIdentity(static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4IsIdentity");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4LookAt(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pEye;
    mrb_value pCenter;
    mrb_value pUp;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "oooo", &pOut, &pEye, &pCenter, &pUp)) {
      kmMat4 * res = Kazmath::kmMat4LookAt(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pEye, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pCenter, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pUp, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4LookAt");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4Multiply(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pM1;
    mrb_value pM2;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pM1, &pM2)) {
      kmMat4 * res = Kazmath::kmMat4Multiply(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM1, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM2, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4Multiply");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4OrthographicProjection(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float left;
    mrb_float right;
    mrb_float bottom;
    mrb_float top;
    mrb_float nearVal;
    mrb_float farVal;
    if (7 == _argc_ && 7 == mrb_get_args(mrb, "offffff", &pOut, &left, &right, &bottom, &top, &nearVal, &farVal)) {
      kmMat4 * res = Kazmath::kmMat4OrthographicProjection(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), left, right, bottom, top, nearVal, farVal);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4OrthographicProjection");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4PerspectiveProjection(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float fovY;
    mrb_float aspect;
    mrb_float zNear;
    mrb_float zFar;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "offff", &pOut, &fovY, &aspect, &zNear, &zFar)) {
      kmMat4 * res = Kazmath::kmMat4PerspectiveProjection(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), fovY, aspect, zNear, zFar);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4PerspectiveProjection");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4RotationAxisAngle(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value axis;
    mrb_float radians;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oof", &pOut, &axis, &radians)) {
      kmMat4 * res = Kazmath::kmMat4RotationAxisAngle(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, axis, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4RotationAxisAngle");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4RotationPitchYawRoll(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float pitch;
    mrb_float yaw;
    mrb_float roll;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "offf", &pOut, &pitch, &yaw, &roll)) {
      kmMat4 * res = Kazmath::kmMat4RotationPitchYawRoll(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), pitch, yaw, roll);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4RotationPitchYawRoll");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4RotationQuaternion(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pQ;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pQ)) {
      kmMat4 * res = Kazmath::kmMat4RotationQuaternion(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const struct kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pQ, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4RotationQuaternion");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4RotationToAxisAngle(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pAxis;
    mrb_value radians;
    mrb_value pIn;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oAo", &pAxis, &radians, &pIn)) {
      float cxx_radians[1]; cc_mrb_ary_conv_to_c_array< float >(mrb, radians, cxx_radians, 1);
      struct kmVec3 * res = Kazmath::kmMat4RotationToAxisAngle(static_cast< struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pAxis, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), cxx_radians, static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4RotationToAxisAngle");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4RotationTranslation(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value rotation;
    mrb_value translation;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &rotation, &translation)) {
      kmMat4 * res = Kazmath::kmMat4RotationTranslation(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const struct kmMat3 * >(cc_mrb_data_get_ptr(mrb, rotation, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, translation, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4RotationTranslation");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4RotationX(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float radians;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "of", &pOut, &radians)) {
      kmMat4 * res = Kazmath::kmMat4RotationX(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4RotationX");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4RotationY(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float radians;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "of", &pOut, &radians)) {
      kmMat4 * res = Kazmath::kmMat4RotationY(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4RotationY");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4RotationZ(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float radians;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "of", &pOut, &radians)) {
      kmMat4 * res = Kazmath::kmMat4RotationZ(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), radians);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4RotationZ");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4Scaling(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "offf", &pOut, &x, &y, &z)) {
      kmMat4 * res = Kazmath::kmMat4Scaling(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), x, y, z);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4Scaling");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4Translation(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "offf", &pOut, &x, &y, &z)) {
      kmMat4 * res = Kazmath::kmMat4Translation(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), x, y, z);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4Translation");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMat4Transpose(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmMat4 * res = Kazmath::kmMat4Transpose(static_cast< kmMat4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), static_cast< const kmMat4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmMat4"),
                       &mrb_type_Kazmath_kmMat4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMat4Transpose");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMax(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float lhs;
    mrb_float rhs;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ff", &lhs, &rhs)) {
      float res = Kazmath::kmMax(lhs, rhs);
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMax");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmMin(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float lhs;
    mrb_float rhs;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ff", &lhs, &rhs)) {
      float res = Kazmath::kmMin(lhs, rhs);
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmMin");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlane__get_a(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmPlane *obj_self = static_cast< Kazmath::kmPlane * >(DATA_PTR(mrb_self));
  float res = obj_self->a;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmPlane__set_a(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float a;
  if (1 == mrb_get_args(mrb, "f", &a)) {
    Kazmath::kmPlane *obj_self = static_cast< Kazmath::kmPlane * >(DATA_PTR(mrb_self));
    
    obj_self->a = a;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlane#a");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlane__get_b(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmPlane *obj_self = static_cast< Kazmath::kmPlane * >(DATA_PTR(mrb_self));
  float res = obj_self->b;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmPlane__set_b(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float b;
  if (1 == mrb_get_args(mrb, "f", &b)) {
    Kazmath::kmPlane *obj_self = static_cast< Kazmath::kmPlane * >(DATA_PTR(mrb_self));
    
    obj_self->b = b;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlane#b");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlane__get_c(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmPlane *obj_self = static_cast< Kazmath::kmPlane * >(DATA_PTR(mrb_self));
  float res = obj_self->c;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmPlane__set_c(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float c;
  if (1 == mrb_get_args(mrb, "f", &c)) {
    Kazmath::kmPlane *obj_self = static_cast< Kazmath::kmPlane * >(DATA_PTR(mrb_self));
    
    obj_self->c = c;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlane#c");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlane__get_d(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmPlane *obj_self = static_cast< Kazmath::kmPlane * >(DATA_PTR(mrb_self));
  float res = obj_self->d;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmPlane__set_d(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float d;
  if (1 == mrb_get_args(mrb, "f", &d)) {
    Kazmath::kmPlane *obj_self = static_cast< Kazmath::kmPlane * >(DATA_PTR(mrb_self));
    
    obj_self->d = d;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlane#d");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlane_initialize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    DATA_TYPE(mrb_self) = &mrb_type_Kazmath_kmPlane;
    DATA_PTR(mrb_self) = NULL;
    if (0 == _argc_) {
      Kazmath::kmPlane * res = new Kazmath::kmPlane();
      DATA_PTR(mrb_self) = res;
      return mrb_self;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlane#initialize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlaneClassifyPoint(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    mrb_value pP;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pIn, &pP)) {
      const POINT_CLASSIFICATION res = Kazmath::kmPlaneClassifyPoint(static_cast< const kmPlane * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pP, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlaneClassifyPoint");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlaneDot(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pP;
    mrb_value pV;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pP, &pV)) {
      const float res = Kazmath::kmPlaneDot(static_cast< const kmPlane * >(cc_mrb_data_get_ptr(mrb, pP, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const struct kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlaneDot");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlaneDotCoord(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pP;
    mrb_value pV;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pP, &pV)) {
      const float res = Kazmath::kmPlaneDotCoord(static_cast< const kmPlane * >(cc_mrb_data_get_ptr(mrb, pP, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlaneDotCoord");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlaneDotNormal(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pP;
    mrb_value pV;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pP, &pV)) {
      const float res = Kazmath::kmPlaneDotNormal(static_cast< const kmPlane * >(cc_mrb_data_get_ptr(mrb, pP, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlaneDotNormal");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlaneFromPointNormal(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pPoint;
    mrb_value pNormal;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pPoint, &pNormal)) {
      kmPlane * res = Kazmath::kmPlaneFromPointNormal(static_cast< kmPlane * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pPoint, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pNormal, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmPlane"),
                       &mrb_type_Kazmath_kmPlane,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlaneFromPointNormal");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlaneFromPoints(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value p1;
    mrb_value p2;
    mrb_value p3;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "oooo", &pOut, &p1, &p2, &p3)) {
      kmPlane * res = Kazmath::kmPlaneFromPoints(static_cast< kmPlane * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, p1, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, p2, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, p3, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmPlane"),
                       &mrb_type_Kazmath_kmPlane,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlaneFromPoints");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlaneIntersectLine(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pP;
    mrb_value pV1;
    mrb_value pV2;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "oooo", &pOut, &pP, &pV1, &pV2)) {
      struct kmVec3 * res = Kazmath::kmPlaneIntersectLine(static_cast< struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmPlane * >(cc_mrb_data_get_ptr(mrb, pP, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV2, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlaneIntersectLine");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlaneNormalize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pP;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pP)) {
      kmPlane * res = Kazmath::kmPlaneNormalize(static_cast< kmPlane * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const kmPlane * >(cc_mrb_data_get_ptr(mrb, pP, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmPlane"),
                       &mrb_type_Kazmath_kmPlane,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlaneNormalize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmPlaneScale(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pP;
    mrb_float s;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oof", &pOut, &pP, &s)) {
      kmPlane * res = Kazmath::kmPlaneScale(static_cast< kmPlane * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), static_cast< const kmPlane * >(cc_mrb_data_get_ptr(mrb, pP, &mrb_type_Kazmath_kmPlane, &mrb_type_Kazmath_kmPlane)), s);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmPlane"),
                       &mrb_type_Kazmath_kmPlane,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmPlaneScale");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternion__get_w(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmQuaternion *obj_self = static_cast< Kazmath::kmQuaternion * >(DATA_PTR(mrb_self));
  float res = obj_self->w;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmQuaternion__set_w(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float w;
  if (1 == mrb_get_args(mrb, "f", &w)) {
    Kazmath::kmQuaternion *obj_self = static_cast< Kazmath::kmQuaternion * >(DATA_PTR(mrb_self));
    
    obj_self->w = w;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternion#w");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternion__get_x(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmQuaternion *obj_self = static_cast< Kazmath::kmQuaternion * >(DATA_PTR(mrb_self));
  float res = obj_self->x;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmQuaternion__set_x(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float x;
  if (1 == mrb_get_args(mrb, "f", &x)) {
    Kazmath::kmQuaternion *obj_self = static_cast< Kazmath::kmQuaternion * >(DATA_PTR(mrb_self));
    
    obj_self->x = x;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternion#x");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternion__get_y(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmQuaternion *obj_self = static_cast< Kazmath::kmQuaternion * >(DATA_PTR(mrb_self));
  float res = obj_self->y;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmQuaternion__set_y(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float y;
  if (1 == mrb_get_args(mrb, "f", &y)) {
    Kazmath::kmQuaternion *obj_self = static_cast< Kazmath::kmQuaternion * >(DATA_PTR(mrb_self));
    
    obj_self->y = y;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternion#y");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternion__get_z(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmQuaternion *obj_self = static_cast< Kazmath::kmQuaternion * >(DATA_PTR(mrb_self));
  float res = obj_self->z;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmQuaternion__set_z(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float z;
  if (1 == mrb_get_args(mrb, "f", &z)) {
    Kazmath::kmQuaternion *obj_self = static_cast< Kazmath::kmQuaternion * >(DATA_PTR(mrb_self));
    
    obj_self->z = z;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternion#z");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternion_initialize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    DATA_TYPE(mrb_self) = &mrb_type_Kazmath_kmQuaternion;
    DATA_PTR(mrb_self) = NULL;
    if (0 == _argc_) {
      Kazmath::kmQuaternion * res = new Kazmath::kmQuaternion();
      DATA_PTR(mrb_self) = res;
      return mrb_self;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternion#initialize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionAdd(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pQ1;
    mrb_value pQ2;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pQ1, &pQ2)) {
      kmQuaternion * res = Kazmath::kmQuaternionAdd(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pQ1, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pQ2, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionAdd");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionAssign(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmQuaternion * res = Kazmath::kmQuaternionAssign(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionAssign");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionConjugate(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmQuaternion * res = Kazmath::kmQuaternionConjugate(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionConjugate");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionDot(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value q1;
    mrb_value q2;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &q1, &q2)) {
      const float res = Kazmath::kmQuaternionDot(static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, q1, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, q2, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionDot");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionExp(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmQuaternion * res = Kazmath::kmQuaternionExp(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionExp");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionIdentity(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pOut)) {
      kmQuaternion * res = Kazmath::kmQuaternionIdentity(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionIdentity");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionInverse(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmQuaternion * res = Kazmath::kmQuaternionInverse(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionInverse");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionIsIdentity(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      int res = Kazmath::kmQuaternionIsIdentity(static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionIsIdentity");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionLength(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      float res = Kazmath::kmQuaternionLength(static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionLength");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionLengthSq(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      float res = Kazmath::kmQuaternionLengthSq(static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionLengthSq");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionLn(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmQuaternion * res = Kazmath::kmQuaternionLn(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionLn");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionMultiply(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value q1;
    mrb_value q2;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &q1, &q2)) {
      kmQuaternion * res = Kazmath::kmQuaternionMultiply(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, q1, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, q2, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionMultiply");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionMultiplyVec3(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value q;
    mrb_value v;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &q, &v)) {
      struct kmVec3 * res = Kazmath::kmQuaternionMultiplyVec3(static_cast< struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, q, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, v, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionMultiplyVec3");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionNormalize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmQuaternion * res = Kazmath::kmQuaternionNormalize(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionNormalize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionRotationAxis(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV;
    mrb_float angle;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oof", &pOut, &pV, &angle)) {
      kmQuaternion * res = Kazmath::kmQuaternionRotationAxis(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), angle);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionRotationAxis");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionRotationBetweenVec3(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value vec1;
    mrb_value vec2;
    mrb_value fallback;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "oooo", &pOut, &vec1, &vec2, &fallback)) {
      kmQuaternion * res = Kazmath::kmQuaternionRotationBetweenVec3(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, vec1, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, vec2, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, fallback, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionRotationBetweenVec3");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionRotationMatrix(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmQuaternion * res = Kazmath::kmQuaternionRotationMatrix(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const struct kmMat3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmMat3, &mrb_type_Kazmath_kmMat3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionRotationMatrix");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionRotationYawPitchRoll(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float yaw;
    mrb_float pitch;
    mrb_float roll;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "offf", &pOut, &yaw, &pitch, &roll)) {
      kmQuaternion * res = Kazmath::kmQuaternionRotationYawPitchRoll(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), yaw, pitch, roll);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionRotationYawPitchRoll");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionScale(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    mrb_float s;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oof", &pOut, &pIn, &s)) {
      kmQuaternion * res = Kazmath::kmQuaternionScale(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), s);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionScale");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionSlerp(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value q1;
    mrb_value q2;
    mrb_float t;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "ooof", &pOut, &q1, &q2, &t)) {
      kmQuaternion * res = Kazmath::kmQuaternionSlerp(static_cast< kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, q1, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, q2, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), t);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmQuaternion"),
                       &mrb_type_Kazmath_kmQuaternion,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionSlerp");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmQuaternionToAxisAngle(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    mrb_value pVector;
    mrb_value pAngle;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooA", &pIn, &pVector, &pAngle)) {
      float cxx_pAngle[1]; cc_mrb_ary_conv_to_c_array< float >(mrb, pAngle, cxx_pAngle, 1);
      Kazmath::kmQuaternionToAxisAngle(static_cast< const kmQuaternion * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmQuaternion, &mrb_type_Kazmath_kmQuaternion)), static_cast< struct kmVec3 * >(cc_mrb_data_get_ptr(mrb, pVector, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), cxx_pAngle);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmQuaternionToAxisAngle");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmRadiansToDegrees(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float radians;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "f", &radians)) {
      float res = Kazmath::kmRadiansToDegrees(radians);
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmRadiansToDegrees");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmSQR(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float s;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "f", &s)) {
      float res = Kazmath::kmSQR(s);
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmSQR");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3__get_x(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmVec3 *obj_self = static_cast< Kazmath::kmVec3 * >(DATA_PTR(mrb_self));
  float res = obj_self->x;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmVec3__set_x(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float x;
  if (1 == mrb_get_args(mrb, "f", &x)) {
    Kazmath::kmVec3 *obj_self = static_cast< Kazmath::kmVec3 * >(DATA_PTR(mrb_self));
    
    obj_self->x = x;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3#x");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3__get_y(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmVec3 *obj_self = static_cast< Kazmath::kmVec3 * >(DATA_PTR(mrb_self));
  float res = obj_self->y;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmVec3__set_y(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float y;
  if (1 == mrb_get_args(mrb, "f", &y)) {
    Kazmath::kmVec3 *obj_self = static_cast< Kazmath::kmVec3 * >(DATA_PTR(mrb_self));
    
    obj_self->y = y;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3#y");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3__get_z(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmVec3 *obj_self = static_cast< Kazmath::kmVec3 * >(DATA_PTR(mrb_self));
  float res = obj_self->z;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmVec3__set_z(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float z;
  if (1 == mrb_get_args(mrb, "f", &z)) {
    Kazmath::kmVec3 *obj_self = static_cast< Kazmath::kmVec3 * >(DATA_PTR(mrb_self));
    
    obj_self->z = z;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3#z");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3_initialize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    DATA_TYPE(mrb_self) = &mrb_type_Kazmath_kmVec3;
    DATA_PTR(mrb_self) = NULL;
    if (0 == _argc_) {
      Kazmath::kmVec3 * res = new Kazmath::kmVec3();
      DATA_PTR(mrb_self) = res;
      return mrb_self;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3#initialize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Add(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV1;
    mrb_value pV2;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV1, &pV2)) {
      kmVec3 * res = Kazmath::kmVec3Add(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV2, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Add");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3AreEqual(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value p1;
    mrb_value p2;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &p1, &p2)) {
      int res = Kazmath::kmVec3AreEqual(static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, p1, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, p2, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3AreEqual");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Assign(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmVec3 * res = Kazmath::kmVec3Assign(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Assign");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Cross(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV1;
    mrb_value pV2;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV1, &pV2)) {
      kmVec3 * res = Kazmath::kmVec3Cross(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV2, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Cross");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Dot(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pV1;
    mrb_value pV2;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pV1, &pV2)) {
      float res = Kazmath::kmVec3Dot(static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV2, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Dot");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Fill(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "offf", &pOut, &x, &y, &z)) {
      kmVec3 * res = Kazmath::kmVec3Fill(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), x, y, z);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Fill");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3InverseTransform(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV;
    mrb_value pM;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV, &pM)) {
      kmVec3 * res = Kazmath::kmVec3InverseTransform(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3InverseTransform");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3InverseTransformNormal(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pVect;
    mrb_value pM;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pVect, &pM)) {
      kmVec3 * res = Kazmath::kmVec3InverseTransformNormal(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pVect, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3InverseTransformNormal");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Length(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      float res = Kazmath::kmVec3Length(static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Length");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3LengthSq(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      float res = Kazmath::kmVec3LengthSq(static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3LengthSq");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Normalize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmVec3 * res = Kazmath::kmVec3Normalize(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Normalize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Scale(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    mrb_float s;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oof", &pOut, &pIn, &s)) {
      kmVec3 * res = Kazmath::kmVec3Scale(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), s);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Scale");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Subtract(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV1;
    mrb_value pV2;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV1, &pV2)) {
      kmVec3 * res = Kazmath::kmVec3Subtract(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV2, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Subtract");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Transform(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV1;
    mrb_value pM;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV1, &pM)) {
      kmVec3 * res = Kazmath::kmVec3Transform(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Transform");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3TransformCoord(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV;
    mrb_value pM;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV, &pM)) {
      kmVec3 * res = Kazmath::kmVec3TransformCoord(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3TransformCoord");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3TransformNormal(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV;
    mrb_value pM;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV, &pM)) {
      kmVec3 * res = Kazmath::kmVec3TransformNormal(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const kmVec3 * >(cc_mrb_data_get_ptr(mrb, pV, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)), static_cast< const struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3TransformNormal");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec3Zero(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pOut)) {
      kmVec3 * res = Kazmath::kmVec3Zero(static_cast< kmVec3 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec3, &mrb_type_Kazmath_kmVec3)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec3"),
                       &mrb_type_Kazmath_kmVec3,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec3Zero");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4__get_w(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmVec4 *obj_self = static_cast< Kazmath::kmVec4 * >(DATA_PTR(mrb_self));
  float res = obj_self->w;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmVec4__set_w(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float w;
  if (1 == mrb_get_args(mrb, "f", &w)) {
    Kazmath::kmVec4 *obj_self = static_cast< Kazmath::kmVec4 * >(DATA_PTR(mrb_self));
    
    obj_self->w = w;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4#w");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4__get_x(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmVec4 *obj_self = static_cast< Kazmath::kmVec4 * >(DATA_PTR(mrb_self));
  float res = obj_self->x;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmVec4__set_x(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float x;
  if (1 == mrb_get_args(mrb, "f", &x)) {
    Kazmath::kmVec4 *obj_self = static_cast< Kazmath::kmVec4 * >(DATA_PTR(mrb_self));
    
    obj_self->x = x;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4#x");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4__get_y(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmVec4 *obj_self = static_cast< Kazmath::kmVec4 * >(DATA_PTR(mrb_self));
  float res = obj_self->y;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmVec4__set_y(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float y;
  if (1 == mrb_get_args(mrb, "f", &y)) {
    Kazmath::kmVec4 *obj_self = static_cast< Kazmath::kmVec4 * >(DATA_PTR(mrb_self));
    
    obj_self->y = y;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4#y");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4__get_z(mrb_state *mrb, mrb_value mrb_self)
{
  Kazmath::kmVec4 *obj_self = static_cast< Kazmath::kmVec4 * >(DATA_PTR(mrb_self));
  float res = obj_self->z;
  return mrb_float_value(mrb, res);
}

static mrb_value
mrb_Kazmath_kmVec4__set_z(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_float z;
  if (1 == mrb_get_args(mrb, "f", &z)) {
    Kazmath::kmVec4 *obj_self = static_cast< Kazmath::kmVec4 * >(DATA_PTR(mrb_self));
    
    obj_self->z = z;
    return mrb_nil_value();
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4#z");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4_initialize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    DATA_TYPE(mrb_self) = &mrb_type_Kazmath_kmVec4;
    DATA_PTR(mrb_self) = NULL;
    if (0 == _argc_) {
      Kazmath::kmVec4 * res = new Kazmath::kmVec4();
      DATA_PTR(mrb_self) = res;
      return mrb_self;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4#initialize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Add(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV1;
    mrb_value pV2;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV1, &pV2)) {
      kmVec4 * res = Kazmath::kmVec4Add(static_cast< kmVec4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV2, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec4"),
                       &mrb_type_Kazmath_kmVec4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Add");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4AreEqual(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value p1;
    mrb_value p2;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &p1, &p2)) {
      int res = Kazmath::kmVec4AreEqual(static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, p1, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, p2, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4AreEqual");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Assign(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmVec4 * res = Kazmath::kmVec4Assign(static_cast< kmVec4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec4"),
                       &mrb_type_Kazmath_kmVec4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Assign");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Dot(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pV1;
    mrb_value pV2;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pV1, &pV2)) {
      float res = Kazmath::kmVec4Dot(static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV2, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Dot");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Fill(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    mrb_float w;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "offff", &pOut, &x, &y, &z, &w)) {
      kmVec4 * res = Kazmath::kmVec4Fill(static_cast< kmVec4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), x, y, z, w);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec4"),
                       &mrb_type_Kazmath_kmVec4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Fill");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Length(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      float res = Kazmath::kmVec4Length(static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Length");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4LengthSq(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pIn;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "o", &pIn)) {
      float res = Kazmath::kmVec4LengthSq(static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)));
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4LengthSq");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Lerp(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV1;
    mrb_value pV2;
    mrb_float t;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "ooof", &pOut, &pV1, &pV2, &t)) {
      kmVec4 * res = Kazmath::kmVec4Lerp(static_cast< kmVec4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV2, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), t);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec4"),
                       &mrb_type_Kazmath_kmVec4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Lerp");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Normalize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "oo", &pOut, &pIn)) {
      kmVec4 * res = Kazmath::kmVec4Normalize(static_cast< kmVec4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec4"),
                       &mrb_type_Kazmath_kmVec4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Normalize");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Scale(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pIn;
    mrb_float s;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "oof", &pOut, &pIn, &s)) {
      kmVec4 * res = Kazmath::kmVec4Scale(static_cast< kmVec4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pIn, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), s);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec4"),
                       &mrb_type_Kazmath_kmVec4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Scale");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Subtract(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV1;
    mrb_value pV2;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV1, &pV2)) {
      kmVec4 * res = Kazmath::kmVec4Subtract(static_cast< kmVec4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV1, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV2, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec4"),
                       &mrb_type_Kazmath_kmVec4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Subtract");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4Transform(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_value pV;
    mrb_value pM;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "ooo", &pOut, &pV, &pM)) {
      kmVec4 * res = Kazmath::kmVec4Transform(static_cast< kmVec4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), static_cast< const struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)));
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec4"),
                       &mrb_type_Kazmath_kmVec4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4Transform");
  return mrb_nil_value();
}

static mrb_value
mrb_Kazmath_kmVec4TransformArray(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pOut;
    mrb_int outStride;
    mrb_value pV;
    mrb_int vStride;
    mrb_value pM;
    mrb_int count;
    if (6 == _argc_ && 6 == mrb_get_args(mrb, "oioioi", &pOut, &outStride, &pV, &vStride, &pM, &count)) {
      kmVec4 * res = Kazmath::kmVec4TransformArray(static_cast< kmVec4 * >(cc_mrb_data_get_ptr(mrb, pOut, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), outStride, static_cast< const kmVec4 * >(cc_mrb_data_get_ptr(mrb, pV, &mrb_type_Kazmath_kmVec4, &mrb_type_Kazmath_kmVec4)), vStride, static_cast< const struct kmMat4 * >(cc_mrb_data_get_ptr(mrb, pM, &mrb_type_Kazmath_kmMat4, &mrb_type_Kazmath_kmMat4)), count);
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "Kazmath::kmVec4"),
                       &mrb_type_Kazmath_kmVec4,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "Kazmath::kmVec4TransformArray");
  return mrb_nil_value();
}

void
mrb_init_Kazmath(mrb_state *mrb)
{
  struct RClass *rc = NULL;
  struct RClass *cur_rc = NULL;
  struct RClass *base_rc = NULL;


  rc = _define_class_Kazmath(mrb);
  cur_rc = cc_mrb_class_get(mrb, "Kazmath");
  assert(cur_rc);
  mrb_define_module_function(mrb, cur_rc, "kmAlmostEqual", mrb_Kazmath_kmAlmostEqual, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmDegreesToRadians", mrb_Kazmath_kmDegreesToRadians, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmGLFreeAll", mrb_Kazmath_kmGLFreeAll, MRB_ARGS_NONE());
  mrb_define_module_function(mrb, cur_rc, "kmGLGetMatrix", mrb_Kazmath_kmGLGetMatrix, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmGLLoadIdentity", mrb_Kazmath_kmGLLoadIdentity, MRB_ARGS_NONE());
  mrb_define_module_function(mrb, cur_rc, "kmGLLoadMatrix", mrb_Kazmath_kmGLLoadMatrix, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmGLMatrixMode", mrb_Kazmath_kmGLMatrixMode, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmGLMultMatrix", mrb_Kazmath_kmGLMultMatrix, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmGLPopMatrix", mrb_Kazmath_kmGLPopMatrix, MRB_ARGS_NONE());
  mrb_define_module_function(mrb, cur_rc, "kmGLPushMatrix", mrb_Kazmath_kmGLPushMatrix, MRB_ARGS_NONE());
  mrb_define_module_function(mrb, cur_rc, "kmGLRotatef", mrb_Kazmath_kmGLRotatef, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmGLScalef", mrb_Kazmath_kmGLScalef, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmGLTranslatef", mrb_Kazmath_kmGLTranslatef, MRB_ARGS_REQ(3));

  /* base_rc = mrb->object_class; */
  rc = _define_class_Kazmath_kmMat3(mrb);
  base_rc = mrb->object_class;
  cur_rc = cc_mrb_class_get(mrb, "Kazmath::kmMat3");
  assert(cur_rc);
  mrb_define_method(mrb, cur_rc, "mat", mrb_Kazmath_kmMat3__get_mat, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "mat=", mrb_Kazmath_kmMat3__set_mat, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "initialize", mrb_Kazmath_kmMat3_initialize, MRB_ARGS_NONE());
  cur_rc = cc_mrb_class_get(mrb, "Kazmath");
  assert(cur_rc);
  DONE;
  mrb_define_module_function(mrb, cur_rc, "kmMat3Adjugate", mrb_Kazmath_kmMat3Adjugate, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat3AreEqual", mrb_Kazmath_kmMat3AreEqual, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Assign", mrb_Kazmath_kmMat3Assign, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Determinant", mrb_Kazmath_kmMat3Determinant, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Fill", mrb_Kazmath_kmMat3Fill, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Identity", mrb_Kazmath_kmMat3Identity, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Inverse", mrb_Kazmath_kmMat3Inverse, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat3IsIdentity", mrb_Kazmath_kmMat3IsIdentity, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Multiply", mrb_Kazmath_kmMat3Multiply, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Rotation", mrb_Kazmath_kmMat3Rotation, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat3RotationAxisAngle", mrb_Kazmath_kmMat3RotationAxisAngle, MRB_ARGS_ANY());
  mrb_define_module_function(mrb, cur_rc, "kmMat3RotationQuaternion", mrb_Kazmath_kmMat3RotationQuaternion, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat3RotationToAxisAngle", mrb_Kazmath_kmMat3RotationToAxisAngle, MRB_ARGS_ANY());
  mrb_define_module_function(mrb, cur_rc, "kmMat3RotationX", mrb_Kazmath_kmMat3RotationX, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat3RotationY", mrb_Kazmath_kmMat3RotationY, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat3RotationZ", mrb_Kazmath_kmMat3RotationZ, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat3ScalarMultiply", mrb_Kazmath_kmMat3ScalarMultiply, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Scaling", mrb_Kazmath_kmMat3Scaling, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Translation", mrb_Kazmath_kmMat3Translation, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat3Transpose", mrb_Kazmath_kmMat3Transpose, MRB_ARGS_REQ(2));

  /* base_rc = mrb->object_class; */
  rc = _define_class_Kazmath_kmMat4(mrb);
  base_rc = mrb->object_class;
  cur_rc = cc_mrb_class_get(mrb, "Kazmath::kmMat4");
  assert(cur_rc);
  mrb_define_method(mrb, cur_rc, "mat", mrb_Kazmath_kmMat4__get_mat, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "mat=", mrb_Kazmath_kmMat4__set_mat, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "initialize", mrb_Kazmath_kmMat4_initialize, MRB_ARGS_NONE());
  cur_rc = cc_mrb_class_get(mrb, "Kazmath");
  assert(cur_rc);
  DONE;
  mrb_define_module_function(mrb, cur_rc, "kmMat4AreEqual", mrb_Kazmath_kmMat4AreEqual, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4Assign", mrb_Kazmath_kmMat4Assign, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4ExtractPlane", mrb_Kazmath_kmMat4ExtractPlane, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat4ExtractRotation", mrb_Kazmath_kmMat4ExtractRotation, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4Fill", mrb_Kazmath_kmMat4Fill, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4GetForwardVec3", mrb_Kazmath_kmMat4GetForwardVec3, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4GetRightVec3", mrb_Kazmath_kmMat4GetRightVec3, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4GetUpVec3", mrb_Kazmath_kmMat4GetUpVec3, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4Identity", mrb_Kazmath_kmMat4Identity, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmMat4Inverse", mrb_Kazmath_kmMat4Inverse, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4IsIdentity", mrb_Kazmath_kmMat4IsIdentity, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmMat4LookAt", mrb_Kazmath_kmMat4LookAt, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmMat4Multiply", mrb_Kazmath_kmMat4Multiply, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat4OrthographicProjection", mrb_Kazmath_kmMat4OrthographicProjection, MRB_ARGS_REQ(7));
  mrb_define_module_function(mrb, cur_rc, "kmMat4PerspectiveProjection", mrb_Kazmath_kmMat4PerspectiveProjection, MRB_ARGS_REQ(5));
  mrb_define_module_function(mrb, cur_rc, "kmMat4RotationAxisAngle", mrb_Kazmath_kmMat4RotationAxisAngle, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat4RotationPitchYawRoll", mrb_Kazmath_kmMat4RotationPitchYawRoll, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmMat4RotationQuaternion", mrb_Kazmath_kmMat4RotationQuaternion, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4RotationToAxisAngle", mrb_Kazmath_kmMat4RotationToAxisAngle, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat4RotationTranslation", mrb_Kazmath_kmMat4RotationTranslation, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmMat4RotationX", mrb_Kazmath_kmMat4RotationX, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4RotationY", mrb_Kazmath_kmMat4RotationY, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4RotationZ", mrb_Kazmath_kmMat4RotationZ, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMat4Scaling", mrb_Kazmath_kmMat4Scaling, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmMat4Translation", mrb_Kazmath_kmMat4Translation, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmMat4Transpose", mrb_Kazmath_kmMat4Transpose, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMax", mrb_Kazmath_kmMax, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmMin", mrb_Kazmath_kmMin, MRB_ARGS_REQ(2));

  /* base_rc = mrb->object_class; */
  rc = _define_class_Kazmath_kmPlane(mrb);
  base_rc = mrb->object_class;
  cur_rc = cc_mrb_class_get(mrb, "Kazmath::kmPlane");
  assert(cur_rc);
  mrb_define_method(mrb, cur_rc, "a", mrb_Kazmath_kmPlane__get_a, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "a=", mrb_Kazmath_kmPlane__set_a, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "b", mrb_Kazmath_kmPlane__get_b, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "b=", mrb_Kazmath_kmPlane__set_b, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "c", mrb_Kazmath_kmPlane__get_c, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "c=", mrb_Kazmath_kmPlane__set_c, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "d", mrb_Kazmath_kmPlane__get_d, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "d=", mrb_Kazmath_kmPlane__set_d, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "initialize", mrb_Kazmath_kmPlane_initialize, MRB_ARGS_NONE());
  cur_rc = cc_mrb_class_get(mrb, "Kazmath");
  assert(cur_rc);
  DONE;
  mrb_define_module_function(mrb, cur_rc, "kmPlaneClassifyPoint", mrb_Kazmath_kmPlaneClassifyPoint, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmPlaneDot", mrb_Kazmath_kmPlaneDot, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmPlaneDotCoord", mrb_Kazmath_kmPlaneDotCoord, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmPlaneDotNormal", mrb_Kazmath_kmPlaneDotNormal, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmPlaneFromPointNormal", mrb_Kazmath_kmPlaneFromPointNormal, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmPlaneFromPoints", mrb_Kazmath_kmPlaneFromPoints, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmPlaneIntersectLine", mrb_Kazmath_kmPlaneIntersectLine, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmPlaneNormalize", mrb_Kazmath_kmPlaneNormalize, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmPlaneScale", mrb_Kazmath_kmPlaneScale, MRB_ARGS_REQ(3));

  /* base_rc = mrb->object_class; */
  rc = _define_class_Kazmath_kmQuaternion(mrb);
  base_rc = mrb->object_class;
  cur_rc = cc_mrb_class_get(mrb, "Kazmath::kmQuaternion");
  assert(cur_rc);
  mrb_define_method(mrb, cur_rc, "w", mrb_Kazmath_kmQuaternion__get_w, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "w=", mrb_Kazmath_kmQuaternion__set_w, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "x", mrb_Kazmath_kmQuaternion__get_x, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "x=", mrb_Kazmath_kmQuaternion__set_x, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "y", mrb_Kazmath_kmQuaternion__get_y, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "y=", mrb_Kazmath_kmQuaternion__set_y, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "z", mrb_Kazmath_kmQuaternion__get_z, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "z=", mrb_Kazmath_kmQuaternion__set_z, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "initialize", mrb_Kazmath_kmQuaternion_initialize, MRB_ARGS_NONE());
  cur_rc = cc_mrb_class_get(mrb, "Kazmath");
  assert(cur_rc);
  DONE;
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionAdd", mrb_Kazmath_kmQuaternionAdd, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionAssign", mrb_Kazmath_kmQuaternionAssign, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionConjugate", mrb_Kazmath_kmQuaternionConjugate, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionDot", mrb_Kazmath_kmQuaternionDot, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionExp", mrb_Kazmath_kmQuaternionExp, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionIdentity", mrb_Kazmath_kmQuaternionIdentity, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionInverse", mrb_Kazmath_kmQuaternionInverse, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionIsIdentity", mrb_Kazmath_kmQuaternionIsIdentity, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionLength", mrb_Kazmath_kmQuaternionLength, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionLengthSq", mrb_Kazmath_kmQuaternionLengthSq, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionLn", mrb_Kazmath_kmQuaternionLn, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionMultiply", mrb_Kazmath_kmQuaternionMultiply, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionMultiplyVec3", mrb_Kazmath_kmQuaternionMultiplyVec3, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionNormalize", mrb_Kazmath_kmQuaternionNormalize, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionRotationAxis", mrb_Kazmath_kmQuaternionRotationAxis, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionRotationBetweenVec3", mrb_Kazmath_kmQuaternionRotationBetweenVec3, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionRotationMatrix", mrb_Kazmath_kmQuaternionRotationMatrix, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionRotationYawPitchRoll", mrb_Kazmath_kmQuaternionRotationYawPitchRoll, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionScale", mrb_Kazmath_kmQuaternionScale, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionSlerp", mrb_Kazmath_kmQuaternionSlerp, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmQuaternionToAxisAngle", mrb_Kazmath_kmQuaternionToAxisAngle, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmRadiansToDegrees", mrb_Kazmath_kmRadiansToDegrees, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmSQR", mrb_Kazmath_kmSQR, MRB_ARGS_REQ(1));

  /* base_rc = mrb->object_class; */
  rc = _define_class_Kazmath_kmVec3(mrb);
  base_rc = mrb->object_class;
  cur_rc = cc_mrb_class_get(mrb, "Kazmath::kmVec3");
  assert(cur_rc);
  mrb_define_method(mrb, cur_rc, "x", mrb_Kazmath_kmVec3__get_x, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "x=", mrb_Kazmath_kmVec3__set_x, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "y", mrb_Kazmath_kmVec3__get_y, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "y=", mrb_Kazmath_kmVec3__set_y, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "z", mrb_Kazmath_kmVec3__get_z, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "z=", mrb_Kazmath_kmVec3__set_z, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "initialize", mrb_Kazmath_kmVec3_initialize, MRB_ARGS_NONE());
  cur_rc = cc_mrb_class_get(mrb, "Kazmath");
  assert(cur_rc);
  DONE;
  mrb_define_module_function(mrb, cur_rc, "kmVec3Add", mrb_Kazmath_kmVec3Add, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec3AreEqual", mrb_Kazmath_kmVec3AreEqual, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Assign", mrb_Kazmath_kmVec3Assign, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Cross", mrb_Kazmath_kmVec3Cross, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Dot", mrb_Kazmath_kmVec3Dot, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Fill", mrb_Kazmath_kmVec3Fill, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmVec3InverseTransform", mrb_Kazmath_kmVec3InverseTransform, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec3InverseTransformNormal", mrb_Kazmath_kmVec3InverseTransformNormal, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Length", mrb_Kazmath_kmVec3Length, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmVec3LengthSq", mrb_Kazmath_kmVec3LengthSq, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Normalize", mrb_Kazmath_kmVec3Normalize, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Scale", mrb_Kazmath_kmVec3Scale, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Subtract", mrb_Kazmath_kmVec3Subtract, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Transform", mrb_Kazmath_kmVec3Transform, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec3TransformCoord", mrb_Kazmath_kmVec3TransformCoord, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec3TransformNormal", mrb_Kazmath_kmVec3TransformNormal, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec3Zero", mrb_Kazmath_kmVec3Zero, MRB_ARGS_REQ(1));

  /* base_rc = mrb->object_class; */
  rc = _define_class_Kazmath_kmVec4(mrb);
  base_rc = mrb->object_class;
  cur_rc = cc_mrb_class_get(mrb, "Kazmath::kmVec4");
  assert(cur_rc);
  mrb_define_method(mrb, cur_rc, "w", mrb_Kazmath_kmVec4__get_w, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "w=", mrb_Kazmath_kmVec4__set_w, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "x", mrb_Kazmath_kmVec4__get_x, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "x=", mrb_Kazmath_kmVec4__set_x, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "y", mrb_Kazmath_kmVec4__get_y, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "y=", mrb_Kazmath_kmVec4__set_y, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "z", mrb_Kazmath_kmVec4__get_z, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "z=", mrb_Kazmath_kmVec4__set_z, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "initialize", mrb_Kazmath_kmVec4_initialize, MRB_ARGS_NONE());
  cur_rc = cc_mrb_class_get(mrb, "Kazmath");
  assert(cur_rc);
  DONE;
  mrb_define_module_function(mrb, cur_rc, "kmVec4Add", mrb_Kazmath_kmVec4Add, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec4AreEqual", mrb_Kazmath_kmVec4AreEqual, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmVec4Assign", mrb_Kazmath_kmVec4Assign, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmVec4Dot", mrb_Kazmath_kmVec4Dot, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmVec4Fill", mrb_Kazmath_kmVec4Fill, MRB_ARGS_REQ(5));
  mrb_define_module_function(mrb, cur_rc, "kmVec4Length", mrb_Kazmath_kmVec4Length, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmVec4LengthSq", mrb_Kazmath_kmVec4LengthSq, MRB_ARGS_REQ(1));
  mrb_define_module_function(mrb, cur_rc, "kmVec4Lerp", mrb_Kazmath_kmVec4Lerp, MRB_ARGS_REQ(4));
  mrb_define_module_function(mrb, cur_rc, "kmVec4Normalize", mrb_Kazmath_kmVec4Normalize, MRB_ARGS_REQ(2));
  mrb_define_module_function(mrb, cur_rc, "kmVec4Scale", mrb_Kazmath_kmVec4Scale, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec4Subtract", mrb_Kazmath_kmVec4Subtract, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec4Transform", mrb_Kazmath_kmVec4Transform, MRB_ARGS_REQ(3));
  mrb_define_module_function(mrb, cur_rc, "kmVec4TransformArray", mrb_Kazmath_kmVec4TransformArray, MRB_ARGS_REQ(6));
}
