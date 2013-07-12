#include <assert.h>
#include <typeinfo>
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
#include "gl_node_bridge.h"
#include "GLNode.h"

#include "platform/CCCommon.h"

#define DONE mrb_gc_arena_restore(mrb, 0)

USING_NS_CC;

static void
mrb_free_cocos2d_GLNode(mrb_state *mrb, void *ptr)
{
  if (!ptr) {
    CCLog("%s:NULL!", __FUNCTION__);
    return;
  }
  cocos2d::GLNode *obj = static_cast< cocos2d::GLNode * >(ptr);
  cc_mrb_live_value_remove(mrb, obj);
  obj->release();
}

struct mrb_data_type mrb_type_cocos2d_GLNode = {
  "cocos2d::GLNode",
  mrb_free_cocos2d_GLNode
};

static void
mrb_no_free_cocos2d_GLNode(mrb_state *mrb, void *ptr)
{
  cocos2d::GLNode *obj = static_cast< cocos2d::GLNode * >(ptr);
  cc_mrb_live_value_remove(mrb, obj);
}

struct mrb_data_type mrb_no_free_type_cocos2d_GLNode = {
  "cocos2d::GLNode",
  mrb_no_free_cocos2d_GLNode
};

static struct RClass *
_define_class_cocos2d_GLNode(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "Cocos2d::GLNode") != 0) {
    return cc_mrb_class_get(mrb, "Cocos2d::GLNode");
  }
  struct RClass *base_rc = cc_mrb_class_get(mrb, "Cocos2d::CCNode");
  assert(base_rc);
  struct RClass *outer = cc_mrb_class_get(mrb, "Cocos2d");
  assert(outer);
  struct RClass *rc = mrb_define_class_under(mrb, outer, "GLNode", base_rc);
  assert(rc);
  MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
  cc_mrb_class_register(mrb, rc, "Cocos2d::GLNode");
  CC_MRB_CXX_CLASS_MRB_CLASS_MAP_REGISTER(mrb, cocos2d::GLNode, rc);
  return rc;
}

static mrb_value
mrb_cocos2d_GLNode_initialize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    DATA_TYPE(mrb_self) = &mrb_type_cocos2d_GLNode;
    DATA_PTR(mrb_self) = NULL;
    if (0 == _argc_) {
      cocos2d::GLNode * res = new cocos2d::GLNode();
      DATA_PTR(mrb_self) = res;
      cc_mrb_value_register(mrb, res, mrb_self);
      return mrb_self;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "cocos2d::GLNode#initialize");
  return mrb_nil_value();
}

void
mrb_init_cocos2d_GLNode(mrb_state *mrb)
{
  struct RClass *rc = NULL;
  struct RClass *cur_rc = NULL;
  struct RClass *base_rc = NULL;


  cur_rc = cc_mrb_class_get(mrb, "Cocos2d");
  assert(cur_rc);

  rc = _define_class_cocos2d_GLNode(mrb);
  base_rc = mrb->object_class;
  cur_rc = cc_mrb_class_get(mrb, "Cocos2d::GLNode");
  assert(cur_rc);
  mrb_define_method(mrb, cur_rc, "initialize", mrb_cocos2d_GLNode_initialize, MRB_ARGS_NONE());
  DONE;
}
