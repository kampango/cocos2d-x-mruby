/*
 * mruby binding: Cocos2d
 * Generated automatically by gen_mrb_bridge.rb on 2013-09-13 09:08:47 +0900.
 */

#include <assert.h>
#include <string>
#include <map>
#include "mruby.h"
#include "mruby/array.h"
#include "mruby/class.h"
#include "mruby/data.h"
#include "mruby/gc.h"
#include "mruby/hash.h"
#include "mruby/string.h"
#include "mruby/value.h"
#include "mruby/variable.h"

#include "mruby_helper.h"
#include "CCMRubyCallbackWrapper.h"

#include "cocos2d.h"
#include "cocos2d_bridge.h"
#include "zip_utils_bridge.h"

#define DONE mrb_gc_arena_restore(mrb, 0)

typedef cocos2d::CCImage::EImageFormat EImageFormat;
typedef cocos2d::CCImage::ETextAlign ETextAlign;
typedef cocos2d::extension::CCHttpRequest::HttpRequestType HttpRequestType;
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

static struct RClass *_define_class_cocos2d(mrb_state *mrb);
static struct RClass *_define_class_cocos2d_ZipUtils(mrb_state *mrb);

static struct RClass *
_define_class_cocos2d(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Cocos2d") != 0) {
    return cc_mrb_class_get(mrb, "Cocos2d");
  }

  struct RClass *rc = NULL;
  rc = mrb_define_module(mrb, "Cocos2d");
  assert(rc);
  cc_mrb_class_register(mrb, rc, "Cocos2d");
  return rc;
}

static void
mrb_free_cocos2d_ZipUtils(mrb_state *mrb, void *ptr)
{
  if (!ptr) {
    CCLog("%s:NULL!", __FUNCTION__);
    return;
  }
  delete static_cast< cocos2d::ZipUtils * >(ptr);
}

struct mrb_data_type mrb_type_cocos2d_ZipUtils = {
  "cocos2d::ZipUtils",
  mrb_free_cocos2d_ZipUtils
};

static void
mrb_no_free_cocos2d_ZipUtils(mrb_state *mrb, void *ptr)
{
  /* do not free! */
}

struct mrb_data_type mrb_no_free_type_cocos2d_ZipUtils = {
  "cocos2d::ZipUtils",
  mrb_no_free_cocos2d_ZipUtils
};

static struct RClass *
_define_class_cocos2d_ZipUtils(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Cocos2d::ZipUtils") != 0) {
    return cc_mrb_class_get(mrb, "Cocos2d::ZipUtils");
  }
  struct RClass *base_rc = mrb->object_class;
  struct RClass *outer = cc_mrb_class_get(mrb, "Cocos2d");
  assert(outer);
  struct RClass *rc = mrb_define_class_under(mrb, outer, "ZipUtils", base_rc);
  assert(rc);
  MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
  cc_mrb_class_register(mrb, rc, "Cocos2d::ZipUtils");
  CC_MRB_CXX_CLASS_MRB_CLASS_MAP_REGISTER(mrb, cocos2d::ZipUtils, rc);
  return rc;
}
/* XXX */
static mrb_value
mrb_cocos2d_ZipUtils_ccInflateCCZFile(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value filename;
    mrb_value out;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "SA", &filename, &out)) {
      unsigned char *cxx_out;
      int res = cocos2d::ZipUtils::ccInflateCCZFile(RSTRING_PTR(filename), &cxx_out);
      cc_mrb_ary_conv_from_c_array(mrb, out, cxx_out, res);
      if (res > 0) { delete[] cxx_out; }
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "cocos2d::ZipUtils::ccInflateCCZFile");
  return mrb_nil_value();
}
/* XXX */
static mrb_value
mrb_cocos2d_ZipUtils_ccInflateGZipFile(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value filename;
    mrb_value out;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "SA", &filename, &out)) {
      unsigned char *cxx_out;
      int res = cocos2d::ZipUtils::ccInflateGZipFile(RSTRING_PTR(filename), &cxx_out);
      cc_mrb_ary_conv_from_c_array(mrb, out, cxx_out, res);
      if (res > 0) { delete[] cxx_out; }
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "cocos2d::ZipUtils::ccInflateGZipFile");
  return mrb_nil_value();
}
/* XXX */
static mrb_value
mrb_cocos2d_ZipUtils_ccInflateMemory(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value in;
    mrb_int inLength;
    mrb_value out;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "AiA", &in, &inLength, &out)) {
      unsigned char cxx_in[inLength]; cc_mrb_ary_conv_to_c_array(mrb, in, cxx_in, inLength);
      unsigned char *cxx_out;
      int res = cocos2d::ZipUtils::ccInflateMemory(cxx_in, inLength, &cxx_out);
      cc_mrb_ary_conv_from_c_array(mrb, out, cxx_out, res);
      if (res > 0) { delete[] cxx_out; }
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "cocos2d::ZipUtils::ccInflateMemory");
  return mrb_nil_value();
}

/* XXX */
static mrb_value
mrb_cocos2d_ZipUtils_ccInflateMemoryWithHint(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value in;
    mrb_int inLength;
    mrb_value out;
    mrb_int outLenghtHint;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "AiAi", &in, &inLength, &out, &outLenghtHint)) {
      unsigned char cxx_in[inLength]; cc_mrb_ary_conv_to_c_array(mrb, in, cxx_in, inLength);
      unsigned char *cxx_out;
      int res = cocos2d::ZipUtils::ccInflateMemoryWithHint(cxx_in, inLength, &cxx_out, outLenghtHint);
      cc_mrb_ary_conv_from_c_array(mrb, out, cxx_out, res);
      if (res > 0) { delete[] cxx_out; }
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "cocos2d::ZipUtils::ccInflateMemoryWithHint");
  return mrb_nil_value();
}

static mrb_value
mrb_cocos2d_ZipUtils_ccSetPvrEncryptionKey(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int keyPart1;
    mrb_int keyPart2;
    mrb_int keyPart3;
    mrb_int keyPart4;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &keyPart1, &keyPart2, &keyPart3, &keyPart4)) {
      cocos2d::ZipUtils::ccSetPvrEncryptionKey(keyPart1, keyPart2, keyPart3, keyPart4);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "cocos2d::ZipUtils::ccSetPvrEncryptionKey");
  return mrb_nil_value();
}

static mrb_value
mrb_cocos2d_ZipUtils_ccSetPvrEncryptionKeyPart(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int index;
    mrb_int value;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &index, &value)) {
      cocos2d::ZipUtils::ccSetPvrEncryptionKeyPart(index, value);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "cocos2d::ZipUtils::ccSetPvrEncryptionKeyPart");
  return mrb_nil_value();
}

static mrb_value
mrb_cocos2d_ZipUtils_initialize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    DATA_TYPE(mrb_self) = &mrb_type_cocos2d_ZipUtils;
    DATA_PTR(mrb_self) = NULL;
    if (0 == _argc_) {
      cocos2d::ZipUtils *res = new cocos2d::ZipUtils();
      DATA_PTR(mrb_self) = res;
      return mrb_self;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "cocos2d::ZipUtils#initialize");
  return mrb_nil_value();
}

void
mrb_init_cocos2d_ZipUtils(mrb_state *mrb)
{
  struct RClass *rc = NULL;
  struct RClass *cur_rc = NULL;
  struct RClass *base_rc = NULL;


  rc = _define_class_cocos2d(mrb);
  cur_rc = cc_mrb_class_get(mrb, "Cocos2d");
  assert(cur_rc);

  /* base_rc = mrb->object_class; */
  rc = _define_class_cocos2d_ZipUtils(mrb);
  base_rc = mrb->object_class;
  cur_rc = cc_mrb_class_get(mrb, "Cocos2d::ZipUtils");
  assert(cur_rc);
  mrb_define_class_method(mrb, cur_rc, "ccInflateCCZFile", mrb_cocos2d_ZipUtils_ccInflateCCZFile, MRB_ARGS_REQ(2));
  mrb_define_class_method(mrb, cur_rc, "ccInflateGZipFile", mrb_cocos2d_ZipUtils_ccInflateGZipFile, MRB_ARGS_REQ(2));
  mrb_define_class_method(mrb, cur_rc, "ccInflateMemory", mrb_cocos2d_ZipUtils_ccInflateMemory, MRB_ARGS_REQ(3));
  mrb_define_class_method(mrb, cur_rc, "ccInflateMemoryWithHint", mrb_cocos2d_ZipUtils_ccInflateMemoryWithHint, MRB_ARGS_REQ(4));
  mrb_define_class_method(mrb, cur_rc, "ccSetPvrEncryptionKey", mrb_cocos2d_ZipUtils_ccSetPvrEncryptionKey, MRB_ARGS_REQ(4));
  mrb_define_class_method(mrb, cur_rc, "ccSetPvrEncryptionKeyPart", mrb_cocos2d_ZipUtils_ccSetPvrEncryptionKeyPart, MRB_ARGS_REQ(2));
  mrb_define_method(mrb, cur_rc, "initialize", mrb_cocos2d_ZipUtils_initialize, MRB_ARGS_NONE());
  cur_rc = cc_mrb_class_get(mrb, "Cocos2d");
  assert(cur_rc);
  DONE;
  DONE;
}
