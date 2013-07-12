/*
 * mruby binding: Cocos2d
 * Generated automatically by gen_mrb_bridge.rb on 2013-08-02 17:48:38 +0900.
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
#include "cocos_denshion_bridge.h"

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

static struct RClass *_define_class_CocosDenshion(mrb_state *mrb);
static struct RClass *_define_class_CocosDenshion_SimpleAudioEngine(mrb_state *mrb);

static struct RClass *
_define_class_CocosDenshion(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "CocosDenshion") != 0) {
    return cc_mrb_class_get(mrb, "CocosDenshion");
  }

  struct RClass *rc = NULL;
  rc = mrb_define_module(mrb, "CocosDenshion");
  assert(rc);
  cc_mrb_class_register(mrb, rc, "CocosDenshion");
  return rc;
}

static void
mrb_free_CocosDenshion_SimpleAudioEngine(mrb_state *mrb, void *ptr)
{
  delete static_cast< CocosDenshion::SimpleAudioEngine * >(ptr);
}

struct mrb_data_type mrb_type_CocosDenshion_SimpleAudioEngine = {
  "CocosDenshion::SimpleAudioEngine",
  mrb_free_CocosDenshion_SimpleAudioEngine
};
static void
mrb_no_free_CocosDenshion_SimpleAudioEngine(mrb_state *mrb, void *ptr)
{
  /* do not free! */
}

static struct mrb_data_type mrb_no_free_type_CocosDenshion_SimpleAudioEngine = {
  "CocosDenshion::SimpleAudioEngine",
  mrb_no_free_CocosDenshion_SimpleAudioEngine
};
static struct RClass *
_define_class_CocosDenshion_SimpleAudioEngine(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "CocosDenshion::SimpleAudioEngine") != 0) {
    return cc_mrb_class_get(mrb, "CocosDenshion::SimpleAudioEngine");
  }
  struct RClass *base_rc = mrb->object_class;
  struct RClass *outer = cc_mrb_class_get(mrb, "CocosDenshion");
  assert(outer);
  struct RClass *rc = mrb_define_class_under(mrb, outer, "SimpleAudioEngine", base_rc);
  assert(rc);
  MRB_SET_INSTANCE_TT(rc, MRB_TT_DATA);
  cc_mrb_class_register(mrb, rc, "CocosDenshion::SimpleAudioEngine");
  return rc;
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_initialize(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    DATA_TYPE(mrb_self) = &mrb_type_CocosDenshion_SimpleAudioEngine;
    DATA_PTR(mrb_self) = NULL;
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine * res = new CocosDenshion::SimpleAudioEngine();
      DATA_PTR(mrb_self) = res;
      return mrb_self;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#initialize");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_end(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine::end();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine::end");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_getBackgroundMusicVolume(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      float res = obj_self->getBackgroundMusicVolume();
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#getBackgroundMusicVolume");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_getClassTypeInfo(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      long res = obj_self->getClassTypeInfo();
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#getClassTypeInfo");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_getEffectsVolume(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      float res = obj_self->getEffectsVolume();
      return mrb_float_value(mrb, res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#getEffectsVolume");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_isBackgroundMusicPlaying(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      _Bool res = obj_self->isBackgroundMusicPlaying();
      return mrb_bool_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#isBackgroundMusicPlaying");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_pauseAllEffects(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->pauseAllEffects();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#pauseAllEffects");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_pauseBackgroundMusic(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->pauseBackgroundMusic();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#pauseBackgroundMusic");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_pauseEffect(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int nSoundId;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &nSoundId)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->pauseEffect(nSoundId);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#pauseEffect");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_playBackgroundMusic(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pszFilePath;
    mrb_bool bLoop;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "Sb", &pszFilePath, &bLoop)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->playBackgroundMusic(RSTRING_PTR(pszFilePath), bLoop);
      return mrb_nil_value();
    }
  }
  {
    mrb_value pszFilePath;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "S", &pszFilePath)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->playBackgroundMusic(RSTRING_PTR(pszFilePath));
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#playBackgroundMusic");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_playEffect(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pszFilePath;
    mrb_bool bLoop;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "Sb", &pszFilePath, &bLoop)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      unsigned int res = obj_self->playEffect(RSTRING_PTR(pszFilePath), bLoop);
      return mrb_fixnum_value(res);
    }
  }
  {
    mrb_value pszFilePath;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "S", &pszFilePath)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      unsigned int res = obj_self->playEffect(RSTRING_PTR(pszFilePath));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#playEffect");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_preloadBackgroundMusic(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pszFilePath;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "S", &pszFilePath)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->preloadBackgroundMusic(RSTRING_PTR(pszFilePath));
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#preloadBackgroundMusic");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_preloadEffect(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pszFilePath;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "S", &pszFilePath)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->preloadEffect(RSTRING_PTR(pszFilePath));
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#preloadEffect");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_resumeAllEffects(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->resumeAllEffects();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#resumeAllEffects");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_resumeBackgroundMusic(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->resumeBackgroundMusic();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#resumeBackgroundMusic");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_resumeEffect(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int nSoundId;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &nSoundId)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->resumeEffect(nSoundId);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#resumeEffect");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_rewindBackgroundMusic(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->rewindBackgroundMusic();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#rewindBackgroundMusic");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_setBackgroundMusicVolume(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float volume;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "f", &volume)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->setBackgroundMusicVolume(volume);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#setBackgroundMusicVolume");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_setEffectsVolume(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float volume;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "f", &volume)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->setEffectsVolume(volume);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#setEffectsVolume");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_sharedEngine(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      class CocosDenshion::SimpleAudioEngine * res = CocosDenshion::SimpleAudioEngine::sharedEngine();
      return mrb_obj_value(Data_Wrap_Struct(
                       mrb,
                       cc_mrb_class_get(mrb, "CocosDenshion::SimpleAudioEngine"),
                       &mrb_type_CocosDenshion_SimpleAudioEngine,
                       res));
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine::sharedEngine");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_stopAllEffects(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->stopAllEffects();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#stopAllEffects");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_stopBackgroundMusic(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_bool bReleaseData;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "b", &bReleaseData)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->stopBackgroundMusic(bReleaseData);
      return mrb_nil_value();
    }
  }
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->stopBackgroundMusic();
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#stopBackgroundMusic");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_stopEffect(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int nSoundId;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &nSoundId)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->stopEffect(nSoundId);
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#stopEffect");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_unloadEffect(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value pszFilePath;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "S", &pszFilePath)) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      obj_self->unloadEffect(RSTRING_PTR(pszFilePath));
      return mrb_nil_value();
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#unloadEffect");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_SimpleAudioEngine_willPlayBackgroundMusic(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      CocosDenshion::SimpleAudioEngine *obj_self = static_cast< CocosDenshion::SimpleAudioEngine * >(DATA_PTR(mrb_self));
      _Bool res = obj_self->willPlayBackgroundMusic();
      return mrb_bool_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::SimpleAudioEngine#willPlayBackgroundMusic");
  return mrb_nil_value();
}

static mrb_value
mrb_CocosDenshion_getHashCodeByString(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value key;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "S", &key)) {
      unsigned int res = CocosDenshion::getHashCodeByString(RSTRING_PTR(key));
      return mrb_fixnum_value(res);
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "CocosDenshion::getHashCodeByString");
  return mrb_nil_value();
}

void
mrb_init_CocosDenshion(mrb_state *mrb)
{
  struct RClass *rc = NULL;
  struct RClass *cur_rc = NULL;
  struct RClass *base_rc = NULL;


  rc = _define_class_CocosDenshion(mrb);
  cur_rc = cc_mrb_class_get(mrb, "CocosDenshion");
  assert(cur_rc);

/*
  if (cc_mrb_class_defined(mrb, "CocosDenshion::TypeInfo") == 0) {
    _define_class_CocosDenshion_TypeInfo(mrb);
  }
*/
  /* base_rc = cc_mrb_class_get(mrb, "CocosDenshion::TypeInfo"); */
  /* assert(base_rc); */
  rc = _define_class_CocosDenshion_SimpleAudioEngine(mrb);
  base_rc = mrb->object_class;
  cur_rc = cc_mrb_class_get(mrb, "CocosDenshion::SimpleAudioEngine");
  assert(cur_rc);
  mrb_define_method(mrb, cur_rc, "initialize", mrb_CocosDenshion_SimpleAudioEngine_initialize, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, cur_rc, "end", mrb_CocosDenshion_SimpleAudioEngine_end, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "getBackgroundMusicVolume", mrb_CocosDenshion_SimpleAudioEngine_getBackgroundMusicVolume, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "getClassTypeInfo", mrb_CocosDenshion_SimpleAudioEngine_getClassTypeInfo, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "getEffectsVolume", mrb_CocosDenshion_SimpleAudioEngine_getEffectsVolume, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "isBackgroundMusicPlaying", mrb_CocosDenshion_SimpleAudioEngine_isBackgroundMusicPlaying, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "pauseAllEffects", mrb_CocosDenshion_SimpleAudioEngine_pauseAllEffects, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "pauseBackgroundMusic", mrb_CocosDenshion_SimpleAudioEngine_pauseBackgroundMusic, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "pauseEffect", mrb_CocosDenshion_SimpleAudioEngine_pauseEffect, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "playBackgroundMusic", mrb_CocosDenshion_SimpleAudioEngine_playBackgroundMusic, MRB_ARGS_ANY());
  mrb_define_method(mrb, cur_rc, "playEffect", mrb_CocosDenshion_SimpleAudioEngine_playEffect, MRB_ARGS_ANY());
  mrb_define_method(mrb, cur_rc, "preloadBackgroundMusic", mrb_CocosDenshion_SimpleAudioEngine_preloadBackgroundMusic, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "preloadEffect", mrb_CocosDenshion_SimpleAudioEngine_preloadEffect, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "resumeAllEffects", mrb_CocosDenshion_SimpleAudioEngine_resumeAllEffects, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "resumeBackgroundMusic", mrb_CocosDenshion_SimpleAudioEngine_resumeBackgroundMusic, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "resumeEffect", mrb_CocosDenshion_SimpleAudioEngine_resumeEffect, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "rewindBackgroundMusic", mrb_CocosDenshion_SimpleAudioEngine_rewindBackgroundMusic, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "setBackgroundMusicVolume", mrb_CocosDenshion_SimpleAudioEngine_setBackgroundMusicVolume, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "setEffectsVolume", mrb_CocosDenshion_SimpleAudioEngine_setEffectsVolume, MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb, cur_rc, "sharedEngine", mrb_CocosDenshion_SimpleAudioEngine_sharedEngine, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "stopAllEffects", mrb_CocosDenshion_SimpleAudioEngine_stopAllEffects, MRB_ARGS_NONE());
  mrb_define_method(mrb, cur_rc, "stopBackgroundMusic", mrb_CocosDenshion_SimpleAudioEngine_stopBackgroundMusic, MRB_ARGS_ANY());
  mrb_define_method(mrb, cur_rc, "stopEffect", mrb_CocosDenshion_SimpleAudioEngine_stopEffect, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "unloadEffect", mrb_CocosDenshion_SimpleAudioEngine_unloadEffect, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, cur_rc, "willPlayBackgroundMusic", mrb_CocosDenshion_SimpleAudioEngine_willPlayBackgroundMusic, MRB_ARGS_NONE());
  cur_rc = cc_mrb_class_get(mrb, "CocosDenshion");
  assert(cur_rc);
  DONE;
  cur_rc = cc_mrb_class_get(mrb, "CocosDenshion");
  assert(cur_rc);
  DONE;
  mrb_define_module_function(mrb, cur_rc, "getHashCodeByString", mrb_CocosDenshion_getHashCodeByString, MRB_ARGS_REQ(1));
}
