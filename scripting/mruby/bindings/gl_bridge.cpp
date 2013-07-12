/*
 * mruby binding: Cocos2d
 * Generated automatically by gen_mrb_bridge.rb on 2013-09-13 11:45:04 +0900.
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
#include "gl_bridge.h"

#include "CCGL.h"

#define DONE mrb_gc_arena_restore(mrb, 0)

typedef cocos2d::CCImage::EImageFormat EImageFormat;
typedef cocos2d::CCImage::ETextAlign ETextAlign;
typedef cocos2d::extension::CCHttpRequest::HttpRequestType HttpRequestType;
typedef bool _Bool;
typedef char __va_list_tag;

/* XXX */
#define GL

using namespace cocos2d;

template<typename T>
static inline T _cast_as_func(void *vp)
{
    T func;
    *(reinterpret_cast< void ** >(&func)) = vp;
    return func;
}

static struct RClass *_define_class_GL(mrb_state *mrb);

static struct RClass *
_define_class_GL(mrb_state *mrb)
{
  if (cc_mrb_class_defined(mrb, "GL") != 0) {
    return cc_mrb_class_get(mrb, "GL");
  }

  struct RClass *rc = NULL;
  rc = mrb_define_module(mrb, "GL");
  assert(rc);
  cc_mrb_class_register(mrb, rc, "GL");
  return rc;
}

#ifndef NO_USE_mrb_GL_glActiveShaderProgramEXT
static mrb_value
mrb_GL_glActiveShaderProgramEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pipeline;
    mrb_int program;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &pipeline, &program)) {
      GL::glActiveShaderProgramEXT(pipeline, program);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glActiveShaderProgramEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glActiveTexture
static mrb_value
mrb_GL_glActiveTexture(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int texture;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &texture)) {
      GL::glActiveTexture(texture);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glActiveTexture");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glAttachShader
static mrb_value
mrb_GL_glAttachShader(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int shader;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &program, &shader)) {
      GL::glAttachShader(program, shader);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glAttachShader");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBeginQueryEXT
static mrb_value
mrb_GL_glBeginQueryEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int id;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &target, &id)) {
      GL::glBeginQueryEXT(target, id);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBeginQueryEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBindAttribLocation
static mrb_value
mrb_GL_glBindAttribLocation(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int index;
    mrb_value name;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiS", &program, &index, &name)) {
      GL::glBindAttribLocation(program, index, RSTRING_PTR(name));
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBindAttribLocation");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBindBuffer
static mrb_value
mrb_GL_glBindBuffer(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int buffer;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &target, &buffer)) {
      GL::glBindBuffer(target, buffer);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBindBuffer");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBindFramebuffer
static mrb_value
mrb_GL_glBindFramebuffer(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int framebuffer;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &target, &framebuffer)) {
      GL::glBindFramebuffer(target, framebuffer);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBindFramebuffer");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBindProgramPipelineEXT
static mrb_value
mrb_GL_glBindProgramPipelineEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pipeline;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &pipeline)) {
      GL::glBindProgramPipelineEXT(pipeline);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBindProgramPipelineEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBindRenderbuffer
static mrb_value
mrb_GL_glBindRenderbuffer(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int renderbuffer;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &target, &renderbuffer)) {
      GL::glBindRenderbuffer(target, renderbuffer);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBindRenderbuffer");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBindTexture
static mrb_value
mrb_GL_glBindTexture(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int texture;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &target, &texture)) {
      GL::glBindTexture(target, texture);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBindTexture");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBindVertexArrayOES
static mrb_value
mrb_GL_glBindVertexArrayOES(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int array;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &array)) {
      GL::glBindVertexArrayOES(array);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBindVertexArrayOES");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBlendColor
static mrb_value
mrb_GL_glBlendColor(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float red;
    mrb_float green;
    mrb_float blue;
    mrb_float alpha;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "ffff", &red, &green, &blue, &alpha)) {
      GL::glBlendColor(red, green, blue, alpha);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBlendColor");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBlendEquation
static mrb_value
mrb_GL_glBlendEquation(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int mode;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &mode)) {
      GL::glBlendEquation(mode);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBlendEquation");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBlendEquationSeparate
static mrb_value
mrb_GL_glBlendEquationSeparate(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int modeRGB;
    mrb_int modeAlpha;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &modeRGB, &modeAlpha)) {
      GL::glBlendEquationSeparate(modeRGB, modeAlpha);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBlendEquationSeparate");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBlendFunc
static mrb_value
mrb_GL_glBlendFunc(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int sfactor;
    mrb_int dfactor;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &sfactor, &dfactor)) {
      GL::glBlendFunc(sfactor, dfactor);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBlendFunc");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBlendFuncSeparate
static mrb_value
mrb_GL_glBlendFuncSeparate(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int srcRGB;
    mrb_int dstRGB;
    mrb_int srcAlpha;
    mrb_int dstAlpha;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &srcRGB, &dstRGB, &srcAlpha, &dstAlpha)) {
      GL::glBlendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBlendFuncSeparate");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBufferData
static mrb_value
mrb_GL_glBufferData(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int size;
    mrb_value data;
    mrb_int usage;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiAi", &target, &size, &data, &usage)) {
      GLfloat *cxx_data = new GLfloat[size];
      cc_mrb_ary_conv_to_c_array(mrb, data, cxx_data, size);
      GL::glBufferData(target, size, cxx_data, usage);
      delete[] cxx_data;
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBufferData");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glBufferSubData
static mrb_value
mrb_GL_glBufferSubData(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int offset;
    mrb_int size;
    mrb_value data;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &target, &offset, &size, &data)) {
      GLvoid cxx_data[1]; cc_mrb_ary_conv_to_c_array(mrb, data, reinterpret_cast< void * >(cxx_data), 1);
      GL::glBufferSubData(target, offset, size, cxx_data);
      cc_mrb_ary_conv_from_c_array(mrb, data, reinterpret_cast< GLvoid * >(cxx_data), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glBufferSubData");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCheckFramebufferStatus
static mrb_value
mrb_GL_glCheckFramebufferStatus(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &target)) {
      GLenum res = GL::glCheckFramebufferStatus(target);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCheckFramebufferStatus");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glClear
static mrb_value
mrb_GL_glClear(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int mask;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &mask)) {
      GL::glClear(mask);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glClear");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glClearColor
static mrb_value
mrb_GL_glClearColor(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float red;
    mrb_float green;
    mrb_float blue;
    mrb_float alpha;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "ffff", &red, &green, &blue, &alpha)) {
      GL::glClearColor(red, green, blue, alpha);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glClearColor");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glClearDepthf
static mrb_value
mrb_GL_glClearDepthf(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float depth;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "f", &depth)) {
      GL::glClearDepthf(depth);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glClearDepthf");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glClearStencil
static mrb_value
mrb_GL_glClearStencil(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int s;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &s)) {
      GL::glClearStencil(s);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glClearStencil");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glClientWaitSyncAPPLE
static mrb_value
mrb_GL_glClientWaitSyncAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value sync;
    mrb_int flags;
    mrb_int timeout;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "Aii", &sync, &flags, &timeout)) {
      GLsync cxx_sync[1]; cc_mrb_ary_conv_to_c_array(mrb, sync, reinterpret_cast< struct __GLsync * >(cxx_sync), 1);
      GLenum res = GL::glClientWaitSyncAPPLE(cxx_sync, flags, timeout);
      cc_mrb_ary_conv_from_c_array(mrb, sync, reinterpret_cast< GLsync * >(cxx_sync), 1);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glClientWaitSyncAPPLE");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glColorMask
static mrb_value
mrb_GL_glColorMask(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int red;
    mrb_int green;
    mrb_int blue;
    mrb_int alpha;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &red, &green, &blue, &alpha)) {
      GL::glColorMask(red, green, blue, alpha);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glColorMask");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCompileShader
static mrb_value
mrb_GL_glCompileShader(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int shader;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &shader)) {
      GL::glCompileShader(shader);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCompileShader");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCompressedTexImage2D
static mrb_value
mrb_GL_glCompressedTexImage2D(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int level;
    mrb_int internalformat;
    mrb_int width;
    mrb_int height;
    mrb_int border;
    mrb_int imageSize;
    mrb_value data;
    if (8 == _argc_ && 8 == mrb_get_args(mrb, "iiiiiiiA", &target, &level, &internalformat, &width, &height, &border, &imageSize, &data)) {
      GLvoid cxx_data[1]; cc_mrb_ary_conv_to_c_array(mrb, data, reinterpret_cast< void * >(cxx_data), 1);
      GL::glCompressedTexImage2D(target, level, internalformat, width, height, border, imageSize, cxx_data);
      cc_mrb_ary_conv_from_c_array(mrb, data, reinterpret_cast< GLvoid * >(cxx_data), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCompressedTexImage2D");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCompressedTexSubImage2D
static mrb_value
mrb_GL_glCompressedTexSubImage2D(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int level;
    mrb_int xoffset;
    mrb_int yoffset;
    mrb_int width;
    mrb_int height;
    mrb_int format;
    mrb_int imageSize;
    mrb_value data;
    if (9 == _argc_ && 9 == mrb_get_args(mrb, "iiiiiiiiA", &target, &level, &xoffset, &yoffset, &width, &height, &format, &imageSize, &data)) {
      GLvoid cxx_data[1]; cc_mrb_ary_conv_to_c_array(mrb, data, reinterpret_cast< void * >(cxx_data), 1);
      GL::glCompressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, imageSize, cxx_data);
      cc_mrb_ary_conv_from_c_array(mrb, data, reinterpret_cast< GLvoid * >(cxx_data), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCompressedTexSubImage2D");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCopyTexImage2D
static mrb_value
mrb_GL_glCopyTexImage2D(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int level;
    mrb_int internalformat;
    mrb_int x;
    mrb_int y;
    mrb_int width;
    mrb_int height;
    mrb_int border;
    if (8 == _argc_ && 8 == mrb_get_args(mrb, "iiiiiiii", &target, &level, &internalformat, &x, &y, &width, &height, &border)) {
      GL::glCopyTexImage2D(target, level, internalformat, x, y, width, height, border);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCopyTexImage2D");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCopyTexSubImage2D
static mrb_value
mrb_GL_glCopyTexSubImage2D(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int level;
    mrb_int xoffset;
    mrb_int yoffset;
    mrb_int x;
    mrb_int y;
    mrb_int width;
    mrb_int height;
    if (8 == _argc_ && 8 == mrb_get_args(mrb, "iiiiiiii", &target, &level, &xoffset, &yoffset, &x, &y, &width, &height)) {
      GL::glCopyTexSubImage2D(target, level, xoffset, yoffset, x, y, width, height);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCopyTexSubImage2D");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCopyTextureLevelsAPPLE
static mrb_value
mrb_GL_glCopyTextureLevelsAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int destinationTexture;
    mrb_int sourceTexture;
    mrb_int sourceBaseLevel;
    mrb_int sourceLevelCount;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &destinationTexture, &sourceTexture, &sourceBaseLevel, &sourceLevelCount)) {
      GL::glCopyTextureLevelsAPPLE(destinationTexture, sourceTexture, sourceBaseLevel, sourceLevelCount);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCopyTextureLevelsAPPLE");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCreateProgram
static mrb_value
mrb_GL_glCreateProgram(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      GLuint res = GL::glCreateProgram();
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCreateProgram");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCreateShader
static mrb_value
mrb_GL_glCreateShader(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int type;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &type)) {
      GLuint res = GL::glCreateShader(type);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCreateShader");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCreateShaderProgramvEXT
static mrb_value
mrb_GL_glCreateShaderProgramvEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int type;
    mrb_int count;
    mrb_value strings;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &type, &count, &strings)) {
      GLchar * cxx_strings[1]; cc_mrb_ary_conv_to_c_array(mrb, strings, reinterpret_cast< GLchar * * >(cxx_strings), 1);
      GLuint res = GL::glCreateShaderProgramvEXT(type, count, cxx_strings);
      cc_mrb_ary_conv_from_c_array(mrb, strings, reinterpret_cast< GLchar * * >(cxx_strings), 1);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCreateShaderProgramvEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glCullFace
static mrb_value
mrb_GL_glCullFace(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int mode;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &mode)) {
      GL::glCullFace(mode);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glCullFace");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteBuffers
static mrb_value
mrb_GL_glDeleteBuffers(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value buffers;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &buffers)) {
      GLuint cxx_buffers[1]; cc_mrb_ary_conv_to_c_array(mrb, buffers, reinterpret_cast< unsigned int * >(cxx_buffers), 1);
      GL::glDeleteBuffers(n, cxx_buffers);
      cc_mrb_ary_conv_from_c_array(mrb, buffers, reinterpret_cast< GLuint * >(cxx_buffers), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteBuffers");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteFramebuffers
static mrb_value
mrb_GL_glDeleteFramebuffers(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value framebuffers;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &framebuffers)) {
      GLuint cxx_framebuffers[1]; cc_mrb_ary_conv_to_c_array(mrb, framebuffers, reinterpret_cast< unsigned int * >(cxx_framebuffers), 1);
      GL::glDeleteFramebuffers(n, cxx_framebuffers);
      cc_mrb_ary_conv_from_c_array(mrb, framebuffers, reinterpret_cast< GLuint * >(cxx_framebuffers), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteFramebuffers");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteProgram
static mrb_value
mrb_GL_glDeleteProgram(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &program)) {
      GL::glDeleteProgram(program);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteProgram");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteProgramPipelinesEXT
static mrb_value
mrb_GL_glDeleteProgramPipelinesEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value pipelines;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &pipelines)) {
      GLuint cxx_pipelines[1]; cc_mrb_ary_conv_to_c_array(mrb, pipelines, reinterpret_cast< unsigned int * >(cxx_pipelines), 1);
      GL::glDeleteProgramPipelinesEXT(n, cxx_pipelines);
      cc_mrb_ary_conv_from_c_array(mrb, pipelines, reinterpret_cast< GLuint * >(cxx_pipelines), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteProgramPipelinesEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteQueriesEXT
static mrb_value
mrb_GL_glDeleteQueriesEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value ids;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &ids)) {
      GLuint cxx_ids[1]; cc_mrb_ary_conv_to_c_array(mrb, ids, reinterpret_cast< unsigned int * >(cxx_ids), 1);
      GL::glDeleteQueriesEXT(n, cxx_ids);
      cc_mrb_ary_conv_from_c_array(mrb, ids, reinterpret_cast< GLuint * >(cxx_ids), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteQueriesEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteRenderbuffers
static mrb_value
mrb_GL_glDeleteRenderbuffers(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value renderbuffers;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &renderbuffers)) {
      GLuint cxx_renderbuffers[1]; cc_mrb_ary_conv_to_c_array(mrb, renderbuffers, reinterpret_cast< unsigned int * >(cxx_renderbuffers), 1);
      GL::glDeleteRenderbuffers(n, cxx_renderbuffers);
      cc_mrb_ary_conv_from_c_array(mrb, renderbuffers, reinterpret_cast< GLuint * >(cxx_renderbuffers), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteRenderbuffers");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteShader
static mrb_value
mrb_GL_glDeleteShader(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int shader;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &shader)) {
      GL::glDeleteShader(shader);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteShader");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteSyncAPPLE
static mrb_value
mrb_GL_glDeleteSyncAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value sync;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "A", &sync)) {
      GLsync cxx_sync[1]; cc_mrb_ary_conv_to_c_array(mrb, sync, reinterpret_cast< struct __GLsync * >(cxx_sync), 1);
      GL::glDeleteSyncAPPLE(cxx_sync);
      cc_mrb_ary_conv_from_c_array(mrb, sync, reinterpret_cast< GLsync * >(cxx_sync), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteSyncAPPLE");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteTextures
static mrb_value
mrb_GL_glDeleteTextures(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value textures;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &textures)) {
      GLuint cxx_textures[1]; cc_mrb_ary_conv_to_c_array(mrb, textures, reinterpret_cast< unsigned int * >(cxx_textures), 1);
      GL::glDeleteTextures(n, cxx_textures);
      cc_mrb_ary_conv_from_c_array(mrb, textures, reinterpret_cast< GLuint * >(cxx_textures), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteTextures");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDeleteVertexArraysOES
static mrb_value
mrb_GL_glDeleteVertexArraysOES(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value arrays;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &arrays)) {
      GLuint cxx_arrays[1]; cc_mrb_ary_conv_to_c_array(mrb, arrays, reinterpret_cast< unsigned int * >(cxx_arrays), 1);
      GL::glDeleteVertexArraysOES(n, cxx_arrays);
      cc_mrb_ary_conv_from_c_array(mrb, arrays, reinterpret_cast< GLuint * >(cxx_arrays), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDeleteVertexArraysOES");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDepthFunc
static mrb_value
mrb_GL_glDepthFunc(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int func;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &func)) {
      GL::glDepthFunc(func);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDepthFunc");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDepthMask
static mrb_value
mrb_GL_glDepthMask(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int flag;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &flag)) {
      GL::glDepthMask(flag);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDepthMask");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDepthRangef
static mrb_value
mrb_GL_glDepthRangef(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float zNear;
    mrb_float zFar;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ff", &zNear, &zFar)) {
      GL::glDepthRangef(zNear, zFar);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDepthRangef");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDetachShader
static mrb_value
mrb_GL_glDetachShader(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int shader;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &program, &shader)) {
      GL::glDetachShader(program, shader);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDetachShader");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDisable
static mrb_value
mrb_GL_glDisable(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int cap;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &cap)) {
      GL::glDisable(cap);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDisable");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDisableVertexAttribArray
static mrb_value
mrb_GL_glDisableVertexAttribArray(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int index;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &index)) {
      GL::glDisableVertexAttribArray(index);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDisableVertexAttribArray");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDiscardFramebufferEXT
static mrb_value
mrb_GL_glDiscardFramebufferEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int numAttachments;
    mrb_value attachments;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &target, &numAttachments, &attachments)) {
      GLenum cxx_attachments[1]; cc_mrb_ary_conv_to_c_array(mrb, attachments, reinterpret_cast< unsigned int * >(cxx_attachments), 1);
      GL::glDiscardFramebufferEXT(target, numAttachments, cxx_attachments);
      cc_mrb_ary_conv_from_c_array(mrb, attachments, reinterpret_cast< GLenum * >(cxx_attachments), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDiscardFramebufferEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDrawArrays
static mrb_value
mrb_GL_glDrawArrays(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int mode;
    mrb_int first;
    mrb_int count;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iii", &mode, &first, &count)) {
      GL::glDrawArrays(mode, first, count);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDrawArrays");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glDrawElements
static mrb_value
mrb_GL_glDrawElements(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int mode;
    mrb_int count;
    mrb_int type;
    mrb_value indices;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &mode, &count, &type, &indices)) {
      GLvoid cxx_indices[1]; cc_mrb_ary_conv_to_c_array(mrb, indices, reinterpret_cast< void * >(cxx_indices), 1);
      GL::glDrawElements(mode, count, type, cxx_indices);
      cc_mrb_ary_conv_from_c_array(mrb, indices, reinterpret_cast< GLvoid * >(cxx_indices), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glDrawElements");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glEnable
static mrb_value
mrb_GL_glEnable(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int cap;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &cap)) {
      GL::glEnable(cap);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glEnable");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glEnableVertexAttribArray
static mrb_value
mrb_GL_glEnableVertexAttribArray(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int index;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &index)) {
      GL::glEnableVertexAttribArray(index);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glEnableVertexAttribArray");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glEndQueryEXT
static mrb_value
mrb_GL_glEndQueryEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &target)) {
      GL::glEndQueryEXT(target);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glEndQueryEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glFenceSyncAPPLE
static mrb_value
mrb_GL_glFenceSyncAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int condition;
    mrb_int flags;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &condition, &flags)) {
      GLsync res = GL::glFenceSyncAPPLE(condition, flags);
      mrb_value mrb_res = cc_mrb_ary_conv_from_c_array(mrb, mrb_ary_new_capa(mrb, 1), reinterpret_cast< struct __GLsync * >(res), 1);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glFenceSyncAPPLE");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glFinish
static mrb_value
mrb_GL_glFinish(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      GL::glFinish();
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glFinish");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glFlush
static mrb_value
mrb_GL_glFlush(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      GL::glFlush();
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glFlush");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glFlushMappedBufferRangeEXT
static mrb_value
mrb_GL_glFlushMappedBufferRangeEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int offset;
    mrb_int length;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iii", &target, &offset, &length)) {
      GL::glFlushMappedBufferRangeEXT(target, offset, length);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glFlushMappedBufferRangeEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glFramebufferRenderbuffer
static mrb_value
mrb_GL_glFramebufferRenderbuffer(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int attachment;
    mrb_int renderbuffertarget;
    mrb_int renderbuffer;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &target, &attachment, &renderbuffertarget, &renderbuffer)) {
      GL::glFramebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffer);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glFramebufferRenderbuffer");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glFramebufferTexture2D
static mrb_value
mrb_GL_glFramebufferTexture2D(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int attachment;
    mrb_int textarget;
    mrb_int texture;
    mrb_int level;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iiiii", &target, &attachment, &textarget, &texture, &level)) {
      GL::glFramebufferTexture2D(target, attachment, textarget, texture, level);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glFramebufferTexture2D");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glFrontFace
static mrb_value
mrb_GL_glFrontFace(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int mode;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &mode)) {
      GL::glFrontFace(mode);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glFrontFace");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGenBuffers
static mrb_value
mrb_GL_glGenBuffers(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value buffers;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &buffers)) {
      GLuint cxx_buffers[n];
      GL::glGenBuffers(n, cxx_buffers);
      cc_mrb_ary_conv_from_c_array(mrb, buffers, cxx_buffers, n);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGenBuffers");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGenFramebuffers
static mrb_value
mrb_GL_glGenFramebuffers(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value framebuffers;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &framebuffers)) {
      GLuint cxx_framebuffers[1]; cc_mrb_ary_conv_to_c_array(mrb, framebuffers, reinterpret_cast< unsigned int * >(cxx_framebuffers), 1);
      GL::glGenFramebuffers(n, cxx_framebuffers);
      cc_mrb_ary_conv_from_c_array(mrb, framebuffers, reinterpret_cast< GLuint * >(cxx_framebuffers), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGenFramebuffers");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGenProgramPipelinesEXT
static mrb_value
mrb_GL_glGenProgramPipelinesEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value pipelines;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &pipelines)) {
      GLuint cxx_pipelines[1]; cc_mrb_ary_conv_to_c_array(mrb, pipelines, reinterpret_cast< unsigned int * >(cxx_pipelines), 1);
      GL::glGenProgramPipelinesEXT(n, cxx_pipelines);
      cc_mrb_ary_conv_from_c_array(mrb, pipelines, reinterpret_cast< GLuint * >(cxx_pipelines), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGenProgramPipelinesEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGenQueriesEXT
static mrb_value
mrb_GL_glGenQueriesEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value ids;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &ids)) {
      GLuint cxx_ids[1]; cc_mrb_ary_conv_to_c_array(mrb, ids, reinterpret_cast< unsigned int * >(cxx_ids), 1);
      GL::glGenQueriesEXT(n, cxx_ids);
      cc_mrb_ary_conv_from_c_array(mrb, ids, reinterpret_cast< GLuint * >(cxx_ids), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGenQueriesEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGenRenderbuffers
static mrb_value
mrb_GL_glGenRenderbuffers(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value renderbuffers;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &renderbuffers)) {
      GLuint cxx_renderbuffers[1]; cc_mrb_ary_conv_to_c_array(mrb, renderbuffers, reinterpret_cast< unsigned int * >(cxx_renderbuffers), 1);
      GL::glGenRenderbuffers(n, cxx_renderbuffers);
      cc_mrb_ary_conv_from_c_array(mrb, renderbuffers, reinterpret_cast< GLuint * >(cxx_renderbuffers), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGenRenderbuffers");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGenTextures
static mrb_value
mrb_GL_glGenTextures(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value textures;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &textures)) {
      GLuint cxx_textures[1];
      GL::glGenTextures(n, cxx_textures);
      cc_mrb_ary_conv_from_c_array(mrb, textures, cxx_textures, 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGenTextures");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGenVertexArraysOES
static mrb_value
mrb_GL_glGenVertexArraysOES(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value arrays;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &n, &arrays)) {
      GLuint cxx_arrays[1]; cc_mrb_ary_conv_to_c_array(mrb, arrays, reinterpret_cast< unsigned int * >(cxx_arrays), 1);
      GL::glGenVertexArraysOES(n, cxx_arrays);
      cc_mrb_ary_conv_from_c_array(mrb, arrays, reinterpret_cast< GLuint * >(cxx_arrays), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGenVertexArraysOES");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGenerateMipmap
static mrb_value
mrb_GL_glGenerateMipmap(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &target)) {
      GL::glGenerateMipmap(target);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGenerateMipmap");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetActiveAttrib
static mrb_value
mrb_GL_glGetActiveAttrib(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int index;
    mrb_int bufsize;
    mrb_value length;
    mrb_value size;
    mrb_value type;
    mrb_value name;
    if (7 == _argc_ && 7 == mrb_get_args(mrb, "iiiAAAS", &program, &index, &bufsize, &length, &size, &type, &name)) {
      GLsizei cxx_length[1];
      GLint cxx_size[1];
      GLenum cxx_type[1];
      GLchar *cxx_name = new GLchar[bufsize];
      GL::glGetActiveAttrib(program, index, bufsize, cxx_length, cxx_size, cxx_type, cxx_name);
      cc_mrb_ary_conv_from_c_array(mrb, length, cxx_length, 1);
      cc_mrb_ary_conv_from_c_array(mrb, size, cxx_size, 1);
      cc_mrb_ary_conv_from_c_array(mrb, type, cxx_type, 1);
      mrb_str_resize(mrb, name, cxx_length[0]);
      memcpy(RSTRING_PTR(name), cxx_name, cxx_length[0]);
      *(RSTRING_END(name)) = '\0';
      delete[] cxx_name;
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetActiveAttrib");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetActiveUniform
static mrb_value
mrb_GL_glGetActiveUniform(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int index;
    mrb_int bufsize;
    mrb_value length;
    mrb_value size;
    mrb_value type;
    mrb_value name;
    if (7 == _argc_ && 7 == mrb_get_args(mrb, "iiiAAAS", &program, &index, &bufsize, &length, &size, &type, &name)) {
      GLsizei cxx_length[1];
      GLint cxx_size[1];
      GLenum cxx_type[1];
      GLchar *cxx_name = new GLchar[bufsize];
      GL::glGetActiveUniform(program, index, bufsize, cxx_length, cxx_size, cxx_type, cxx_name);
      cc_mrb_ary_conv_from_c_array(mrb, length, cxx_length, 1);
      cc_mrb_ary_conv_from_c_array(mrb, size, cxx_size, 1);
      cc_mrb_ary_conv_from_c_array(mrb, type, cxx_type, 1);
      mrb_str_resize(mrb, name, cxx_length[0]);
      memcpy(RSTRING_PTR(name), cxx_name, cxx_length[0]);
      *(RSTRING_END(name)) = '\0';
      delete[] cxx_name;
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetActiveUniform");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetAttachedShaders
static mrb_value
mrb_GL_glGetAttachedShaders(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int maxcount;
    mrb_value count;
    mrb_value shaders;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiAA", &program, &maxcount, &count, &shaders)) {
      GLsizei cxx_count[1];
      GLuint cxx_shaders[1];
      GL::glGetAttachedShaders(program, maxcount, cxx_count, cxx_shaders);
      cc_mrb_ary_conv_from_c_array(mrb, count, cxx_count, 1);
      cc_mrb_ary_conv_from_c_array(mrb, shaders, cxx_shaders, 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetAttachedShaders");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetAttribLocation
static mrb_value
mrb_GL_glGetAttribLocation(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_value name;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iS", &program, &name)) {
      int res = GL::glGetAttribLocation(program, RSTRING_PTR(name));
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetAttribLocation");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetBooleanv
static mrb_value
mrb_GL_glGetBooleanv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pname;
    mrb_value params;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &pname, &params)) {
      GLboolean cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< unsigned char * >(cxx_params), 1);
      GL::glGetBooleanv(pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLboolean * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetBooleanv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetBufferParameteriv
static mrb_value
mrb_GL_glGetBufferParameteriv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &target, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetBufferParameteriv(target, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetBufferParameteriv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetBufferPointervOES
static mrb_value
mrb_GL_glGetBufferPointervOES(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &target, &pname, &params)) {
      GLvoid * cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< GLvoid * * >(cxx_params), 1);
      GL::glGetBufferPointervOES(target, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLvoid * * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetBufferPointervOES");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetError
static mrb_value
mrb_GL_glGetError(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      GLenum res = GL::glGetError();
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetError");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetFloatv
static mrb_value
mrb_GL_glGetFloatv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pname;
    mrb_value params;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &pname, &params)) {
      GLfloat cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< float * >(cxx_params), 1);
      GL::glGetFloatv(pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLfloat * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetFloatv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetFramebufferAttachmentParameteriv
static mrb_value
mrb_GL_glGetFramebufferAttachmentParameteriv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int attachment;
    mrb_int pname;
    mrb_value params;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &target, &attachment, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetFramebufferAttachmentParameteriv(target, attachment, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetFramebufferAttachmentParameteriv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetInteger64vAPPLE
static mrb_value
mrb_GL_glGetInteger64vAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pname;
    mrb_value params;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &pname, &params)) {
      GLint64 cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< long long * >(cxx_params), 1);
      GL::glGetInteger64vAPPLE(pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint64 * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetInteger64vAPPLE");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetIntegerv
static mrb_value
mrb_GL_glGetIntegerv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pname;
    mrb_value params;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &pname, &params)) {
      GLint cxx_params[1];
      GL::glGetIntegerv(pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, cxx_params, 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetIntegerv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetObjectLabelEXT
static mrb_value
mrb_GL_glGetObjectLabelEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int type;
    mrb_int object;
    mrb_int bufSize;
    mrb_value length;
    mrb_value label;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iiiAS", &type, &object, &bufSize, &length, &label)) {
      GLsizei cxx_length[1]; cc_mrb_ary_conv_to_c_array(mrb, length, reinterpret_cast< int * >(cxx_length), 1);
      GL::glGetObjectLabelEXT(type, object, bufSize, cxx_length, RSTRING_PTR(label));
      cc_mrb_ary_conv_from_c_array(mrb, length, reinterpret_cast< GLsizei * >(cxx_length), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetObjectLabelEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetProgramInfoLog
static mrb_value
mrb_GL_glGetProgramInfoLog(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int bufsize;
    mrb_value length;
    mrb_value infolog;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiAS", &program, &bufsize, &length, &infolog)) {
      GLsizei cxx_length[1]; cc_mrb_ary_conv_to_c_array(mrb, length, reinterpret_cast< int * >(cxx_length), 1);
      GL::glGetProgramInfoLog(program, bufsize, cxx_length, RSTRING_PTR(infolog));
      cc_mrb_ary_conv_from_c_array(mrb, length, reinterpret_cast< GLsizei * >(cxx_length), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetProgramInfoLog");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetProgramPipelineInfoLogEXT
static mrb_value
mrb_GL_glGetProgramPipelineInfoLogEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pipeline;
    mrb_int bufSize;
    mrb_value length;
    mrb_value infoLog;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiAS", &pipeline, &bufSize, &length, &infoLog)) {
      GLsizei cxx_length[1]; cc_mrb_ary_conv_to_c_array(mrb, length, reinterpret_cast< int * >(cxx_length), 1);
      GL::glGetProgramPipelineInfoLogEXT(pipeline, bufSize, cxx_length, RSTRING_PTR(infoLog));
      cc_mrb_ary_conv_from_c_array(mrb, length, reinterpret_cast< GLsizei * >(cxx_length), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetProgramPipelineInfoLogEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetProgramPipelineivEXT
static mrb_value
mrb_GL_glGetProgramPipelineivEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pipeline;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &pipeline, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetProgramPipelineivEXT(pipeline, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetProgramPipelineivEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetProgramiv
static mrb_value
mrb_GL_glGetProgramiv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &program, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetProgramiv(program, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetProgramiv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetQueryObjectuivEXT
static mrb_value
mrb_GL_glGetQueryObjectuivEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int id;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &id, &pname, &params)) {
      GLuint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< unsigned int * >(cxx_params), 1);
      GL::glGetQueryObjectuivEXT(id, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLuint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetQueryObjectuivEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetQueryivEXT
static mrb_value
mrb_GL_glGetQueryivEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &target, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetQueryivEXT(target, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetQueryivEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetRenderbufferParameteriv
static mrb_value
mrb_GL_glGetRenderbufferParameteriv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &target, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetRenderbufferParameteriv(target, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetRenderbufferParameteriv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetShaderInfoLog
static mrb_value
mrb_GL_glGetShaderInfoLog(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int shader;
    mrb_int bufsize;
    mrb_value length;
    mrb_value infolog;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiAS", &shader, &bufsize, &length, &infolog)) {
      GLsizei cxx_length[1]; cc_mrb_ary_conv_to_c_array(mrb, length, reinterpret_cast< int * >(cxx_length), 1);
      GL::glGetShaderInfoLog(shader, bufsize, cxx_length, RSTRING_PTR(infolog));
      cc_mrb_ary_conv_from_c_array(mrb, length, reinterpret_cast< GLsizei * >(cxx_length), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetShaderInfoLog");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetShaderPrecisionFormat
static mrb_value
mrb_GL_glGetShaderPrecisionFormat(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int shadertype;
    mrb_int precisiontype;
    mrb_value range;
    mrb_value precision;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiAA", &shadertype, &precisiontype, &range, &precision)) {
      GLint cxx_range[1]; cc_mrb_ary_conv_to_c_array(mrb, range, reinterpret_cast< int * >(cxx_range), 1);
      GLint cxx_precision[1]; cc_mrb_ary_conv_to_c_array(mrb, precision, reinterpret_cast< int * >(cxx_precision), 1);
      GL::glGetShaderPrecisionFormat(shadertype, precisiontype, cxx_range, cxx_precision);
      cc_mrb_ary_conv_from_c_array(mrb, range, reinterpret_cast< GLint * >(cxx_range), 1);
      cc_mrb_ary_conv_from_c_array(mrb, precision, reinterpret_cast< GLint * >(cxx_precision), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetShaderPrecisionFormat");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetShaderSource
static mrb_value
mrb_GL_glGetShaderSource(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int shader;
    mrb_int bufsize;
    mrb_value length;
    mrb_value source;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiAS", &shader, &bufsize, &length, &source)) {
      GLsizei cxx_length[1]; cc_mrb_ary_conv_to_c_array(mrb, length, reinterpret_cast< int * >(cxx_length), 1);
      GL::glGetShaderSource(shader, bufsize, cxx_length, RSTRING_PTR(source));
      cc_mrb_ary_conv_from_c_array(mrb, length, reinterpret_cast< GLsizei * >(cxx_length), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetShaderSource");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetShaderiv
static mrb_value
mrb_GL_glGetShaderiv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int shader;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &shader, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetShaderiv(shader, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetShaderiv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetString
/* XXX */
static mrb_value
mrb_GL_glGetString(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int name;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &name)) {
      const GLubyte *res = GL::glGetString(name);
      mrb_value mrb_res = mrb_str_new_cstr(mrb, reinterpret_cast<const char *>(res));
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetString");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetSyncivAPPLE
static mrb_value
mrb_GL_glGetSyncivAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value sync;
    mrb_int pname;
    mrb_int bufSize;
    mrb_value length;
    mrb_value values;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "AiiAA", &sync, &pname, &bufSize, &length, &values)) {
      GLsync cxx_sync[1]; cc_mrb_ary_conv_to_c_array(mrb, sync, reinterpret_cast< struct __GLsync * >(cxx_sync), 1);
      GLsizei cxx_length[1]; cc_mrb_ary_conv_to_c_array(mrb, length, reinterpret_cast< int * >(cxx_length), 1);
      GLint cxx_values[1]; cc_mrb_ary_conv_to_c_array(mrb, values, reinterpret_cast< int * >(cxx_values), 1);
      GL::glGetSyncivAPPLE(cxx_sync, pname, bufSize, cxx_length, cxx_values);
      cc_mrb_ary_conv_from_c_array(mrb, sync, reinterpret_cast< GLsync * >(cxx_sync), 1);
      cc_mrb_ary_conv_from_c_array(mrb, length, reinterpret_cast< GLsizei * >(cxx_length), 1);
      cc_mrb_ary_conv_from_c_array(mrb, values, reinterpret_cast< GLint * >(cxx_values), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetSyncivAPPLE");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetTexParameterfv
static mrb_value
mrb_GL_glGetTexParameterfv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &target, &pname, &params)) {
      GLfloat cxx_params[1];
      GL::glGetTexParameterfv(target, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, cxx_params, 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetTexParameterfv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetTexParameteriv
static mrb_value
mrb_GL_glGetTexParameteriv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &target, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetTexParameteriv(target, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetTexParameteriv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetUniformLocation
static mrb_value
mrb_GL_glGetUniformLocation(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_value name;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iS", &program, &name)) {
      int res = GL::glGetUniformLocation(program, RSTRING_PTR(name));
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetUniformLocation");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetUniformfv
static mrb_value
mrb_GL_glGetUniformfv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &program, &location, &params)) {
      int len = mrb_ary_len(mrb, params);
      GLfloat *cxx_params = new GLfloat[len];
      GL::glGetUniformfv(program, location, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, cxx_params, len);
      delete[] cxx_params;
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetUniformfv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetUniformiv
static mrb_value
mrb_GL_glGetUniformiv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &program, &location, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetUniformiv(program, location, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetUniformiv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetVertexAttribPointerv
static mrb_value
mrb_GL_glGetVertexAttribPointerv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int index;
    mrb_int pname;
    mrb_value pointer;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &index, &pname, &pointer)) {
      GLvoid * cxx_pointer[1]; cc_mrb_ary_conv_to_c_array(mrb, pointer, reinterpret_cast< GLvoid * * >(cxx_pointer), 1);
      GL::glGetVertexAttribPointerv(index, pname, cxx_pointer);
      cc_mrb_ary_conv_from_c_array(mrb, pointer, reinterpret_cast< GLvoid * * >(cxx_pointer), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetVertexAttribPointerv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetVertexAttribfv
static mrb_value
mrb_GL_glGetVertexAttribfv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int index;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &index, &pname, &params)) {
      GLfloat cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< float * >(cxx_params), 1);
      GL::glGetVertexAttribfv(index, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLfloat * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetVertexAttribfv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glGetVertexAttribiv
static mrb_value
mrb_GL_glGetVertexAttribiv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int index;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &index, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glGetVertexAttribiv(index, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glGetVertexAttribiv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glHint
static mrb_value
mrb_GL_glHint(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int mode;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &target, &mode)) {
      GL::glHint(target, mode);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glHint");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glInsertEventMarkerEXT
static mrb_value
mrb_GL_glInsertEventMarkerEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int length;
    mrb_value marker;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iS", &length, &marker)) {
      GL::glInsertEventMarkerEXT(length, RSTRING_PTR(marker));
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glInsertEventMarkerEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsBuffer
static mrb_value
mrb_GL_glIsBuffer(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int buffer;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &buffer)) {
      GLboolean res = GL::glIsBuffer(buffer);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsBuffer");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsEnabled
static mrb_value
mrb_GL_glIsEnabled(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int cap;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &cap)) {
      GLboolean res = GL::glIsEnabled(cap);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsEnabled");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsFramebuffer
static mrb_value
mrb_GL_glIsFramebuffer(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int framebuffer;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &framebuffer)) {
      GLboolean res = GL::glIsFramebuffer(framebuffer);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsFramebuffer");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsProgram
static mrb_value
mrb_GL_glIsProgram(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &program)) {
      GLboolean res = GL::glIsProgram(program);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsProgram");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsProgramPipelineEXT
static mrb_value
mrb_GL_glIsProgramPipelineEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pipeline;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &pipeline)) {
      GLboolean res = GL::glIsProgramPipelineEXT(pipeline);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsProgramPipelineEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsQueryEXT
static mrb_value
mrb_GL_glIsQueryEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int id;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &id)) {
      GLboolean res = GL::glIsQueryEXT(id);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsQueryEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsRenderbuffer
static mrb_value
mrb_GL_glIsRenderbuffer(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int renderbuffer;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &renderbuffer)) {
      GLboolean res = GL::glIsRenderbuffer(renderbuffer);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsRenderbuffer");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsShader
static mrb_value
mrb_GL_glIsShader(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int shader;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &shader)) {
      GLboolean res = GL::glIsShader(shader);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsShader");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsSyncAPPLE
static mrb_value
mrb_GL_glIsSyncAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value sync;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "A", &sync)) {
      GLsync cxx_sync[1]; cc_mrb_ary_conv_to_c_array(mrb, sync, reinterpret_cast< struct __GLsync * >(cxx_sync), 1);
      GLboolean res = GL::glIsSyncAPPLE(cxx_sync);
      cc_mrb_ary_conv_from_c_array(mrb, sync, reinterpret_cast< GLsync * >(cxx_sync), 1);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsSyncAPPLE");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsTexture
static mrb_value
mrb_GL_glIsTexture(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int texture;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &texture)) {
      GLboolean res = GL::glIsTexture(texture);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsTexture");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glIsVertexArrayOES
static mrb_value
mrb_GL_glIsVertexArrayOES(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int array;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &array)) {
      GLboolean res = GL::glIsVertexArrayOES(array);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glIsVertexArrayOES");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glLabelObjectEXT
static mrb_value
mrb_GL_glLabelObjectEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int type;
    mrb_int object;
    mrb_int length;
    mrb_value label;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiS", &type, &object, &length, &label)) {
      GL::glLabelObjectEXT(type, object, length, RSTRING_PTR(label));
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glLabelObjectEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glLineWidth
static mrb_value
mrb_GL_glLineWidth(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float width;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "f", &width)) {
      GL::glLineWidth(width);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glLineWidth");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glLinkProgram
static mrb_value
mrb_GL_glLinkProgram(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &program)) {
      GL::glLinkProgram(program);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glLinkProgram");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glPixelStorei
static mrb_value
mrb_GL_glPixelStorei(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pname;
    mrb_int param;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &pname, &param)) {
      GL::glPixelStorei(pname, param);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glPixelStorei");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glPolygonOffset
static mrb_value
mrb_GL_glPolygonOffset(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float factor;
    mrb_float units;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ff", &factor, &units)) {
      GL::glPolygonOffset(factor, units);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glPolygonOffset");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glPopGroupMarkerEXT
static mrb_value
mrb_GL_glPopGroupMarkerEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      GL::glPopGroupMarkerEXT();
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glPopGroupMarkerEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramParameteriEXT
static mrb_value
mrb_GL_glProgramParameteriEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int pname;
    mrb_int value;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iii", &program, &pname, &value)) {
      GL::glProgramParameteriEXT(program, pname, value);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramParameteriEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform1fEXT
static mrb_value
mrb_GL_glProgramUniform1fEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_float x;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iif", &program, &location, &x)) {
      GL::glProgramUniform1fEXT(program, location, x);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform1fEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform1fvEXT
static mrb_value
mrb_GL_glProgramUniform1fvEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &program, &location, &count, &value)) {
      GLfloat cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< float * >(cxx_value), 1);
      GL::glProgramUniform1fvEXT(program, location, count, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLfloat * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform1fvEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform1iEXT
static mrb_value
mrb_GL_glProgramUniform1iEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int x;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iii", &program, &location, &x)) {
      GL::glProgramUniform1iEXT(program, location, x);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform1iEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform1ivEXT
static mrb_value
mrb_GL_glProgramUniform1ivEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &program, &location, &count, &value)) {
      GLint cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< int * >(cxx_value), 1);
      GL::glProgramUniform1ivEXT(program, location, count, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLint * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform1ivEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform2fEXT
static mrb_value
mrb_GL_glProgramUniform2fEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_float x;
    mrb_float y;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiff", &program, &location, &x, &y)) {
      GL::glProgramUniform2fEXT(program, location, x, y);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform2fEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform2fvEXT
static mrb_value
mrb_GL_glProgramUniform2fvEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &program, &location, &count, &value)) {
      GLfloat cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< float * >(cxx_value), 1);
      GL::glProgramUniform2fvEXT(program, location, count, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLfloat * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform2fvEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform2iEXT
static mrb_value
mrb_GL_glProgramUniform2iEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int x;
    mrb_int y;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &program, &location, &x, &y)) {
      GL::glProgramUniform2iEXT(program, location, x, y);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform2iEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform2ivEXT
static mrb_value
mrb_GL_glProgramUniform2ivEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &program, &location, &count, &value)) {
      GLint cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< int * >(cxx_value), 1);
      GL::glProgramUniform2ivEXT(program, location, count, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLint * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform2ivEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform3fEXT
static mrb_value
mrb_GL_glProgramUniform3fEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iifff", &program, &location, &x, &y, &z)) {
      GL::glProgramUniform3fEXT(program, location, x, y, z);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform3fEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform3fvEXT
static mrb_value
mrb_GL_glProgramUniform3fvEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &program, &location, &count, &value)) {
      GLfloat cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< float * >(cxx_value), 1);
      GL::glProgramUniform3fvEXT(program, location, count, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLfloat * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform3fvEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform3iEXT
static mrb_value
mrb_GL_glProgramUniform3iEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int x;
    mrb_int y;
    mrb_int z;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iiiii", &program, &location, &x, &y, &z)) {
      GL::glProgramUniform3iEXT(program, location, x, y, z);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform3iEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform3ivEXT
static mrb_value
mrb_GL_glProgramUniform3ivEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &program, &location, &count, &value)) {
      GLint cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< int * >(cxx_value), 1);
      GL::glProgramUniform3ivEXT(program, location, count, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLint * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform3ivEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform4fEXT
static mrb_value
mrb_GL_glProgramUniform4fEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    mrb_float w;
    if (6 == _argc_ && 6 == mrb_get_args(mrb, "iiffff", &program, &location, &x, &y, &z, &w)) {
      GL::glProgramUniform4fEXT(program, location, x, y, z, w);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform4fEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform4fvEXT
static mrb_value
mrb_GL_glProgramUniform4fvEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &program, &location, &count, &value)) {
      GLfloat cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< float * >(cxx_value), 1);
      GL::glProgramUniform4fvEXT(program, location, count, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLfloat * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform4fvEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform4iEXT
static mrb_value
mrb_GL_glProgramUniform4iEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int x;
    mrb_int y;
    mrb_int z;
    mrb_int w;
    if (6 == _argc_ && 6 == mrb_get_args(mrb, "iiiiii", &program, &location, &x, &y, &z, &w)) {
      GL::glProgramUniform4iEXT(program, location, x, y, z, w);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform4iEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniform4ivEXT
static mrb_value
mrb_GL_glProgramUniform4ivEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &program, &location, &count, &value)) {
      GLint cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< int * >(cxx_value), 1);
      GL::glProgramUniform4ivEXT(program, location, count, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLint * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniform4ivEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniformMatrix2fvEXT
static mrb_value
mrb_GL_glProgramUniformMatrix2fvEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_int transpose;
    mrb_value value;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iiiiA", &program, &location, &count, &transpose, &value)) {
      GLfloat cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< float * >(cxx_value), 1);
      GL::glProgramUniformMatrix2fvEXT(program, location, count, transpose, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLfloat * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniformMatrix2fvEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniformMatrix3fvEXT
static mrb_value
mrb_GL_glProgramUniformMatrix3fvEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_int transpose;
    mrb_value value;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iiiiA", &program, &location, &count, &transpose, &value)) {
      GLfloat cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< float * >(cxx_value), 1);
      GL::glProgramUniformMatrix3fvEXT(program, location, count, transpose, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLfloat * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniformMatrix3fvEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glProgramUniformMatrix4fvEXT
static mrb_value
mrb_GL_glProgramUniformMatrix4fvEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    mrb_int location;
    mrb_int count;
    mrb_int transpose;
    mrb_value value;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iiiiA", &program, &location, &count, &transpose, &value)) {
      GLfloat cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< float * >(cxx_value), 1);
      GL::glProgramUniformMatrix4fvEXT(program, location, count, transpose, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLfloat * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glProgramUniformMatrix4fvEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glPushGroupMarkerEXT
static mrb_value
mrb_GL_glPushGroupMarkerEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int length;
    mrb_value marker;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iS", &length, &marker)) {
      GL::glPushGroupMarkerEXT(length, RSTRING_PTR(marker));
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glPushGroupMarkerEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glReadPixels
static mrb_value
mrb_GL_glReadPixels(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int x;
    mrb_int y;
    mrb_int width;
    mrb_int height;
    mrb_int format;
    mrb_int type;
    mrb_value pixels;
    if (7 == _argc_ && 7 == mrb_get_args(mrb, "iiiiiiA", &x, &y, &width, &height, &format, &type, &pixels)) {
      if (format == GL_RGBA && type == GL_UNSIGNED_BYTE) {
        GLubyte *cxx_pixels = new GLubyte[width * height * 4];
        GL::glReadPixels(x, y, width, height, format, type, cxx_pixels);
        cc_mrb_ary_conv_from_c_array(mrb, pixels, cxx_pixels, width * height * 4);
        delete[] cxx_pixels;
        mrb_value mrb_res = mrb_self;
        return mrb_res;
      }
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glReadPixels");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glReleaseShaderCompiler
static mrb_value
mrb_GL_glReleaseShaderCompiler(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      GL::glReleaseShaderCompiler();
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glReleaseShaderCompiler");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glRenderbufferStorage
static mrb_value
mrb_GL_glRenderbufferStorage(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int internalformat;
    mrb_int width;
    mrb_int height;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &target, &internalformat, &width, &height)) {
      GL::glRenderbufferStorage(target, internalformat, width, height);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glRenderbufferStorage");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glRenderbufferStorageMultisampleAPPLE
static mrb_value
mrb_GL_glRenderbufferStorageMultisampleAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int samples;
    mrb_int internalformat;
    mrb_int width;
    mrb_int height;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iiiii", &target, &samples, &internalformat, &width, &height)) {
      GL::glRenderbufferStorageMultisampleAPPLE(target, samples, internalformat, width, height);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glRenderbufferStorageMultisampleAPPLE");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glResolveMultisampleFramebufferAPPLE
static mrb_value
mrb_GL_glResolveMultisampleFramebufferAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    if (0 == _argc_) {
      GL::glResolveMultisampleFramebufferAPPLE();
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glResolveMultisampleFramebufferAPPLE");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glSampleCoverage
static mrb_value
mrb_GL_glSampleCoverage(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_float value;
    mrb_int invert;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "fi", &value, &invert)) {
      GL::glSampleCoverage(value, invert);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glSampleCoverage");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glScissor
static mrb_value
mrb_GL_glScissor(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int x;
    mrb_int y;
    mrb_int width;
    mrb_int height;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &x, &y, &width, &height)) {
      GL::glScissor(x, y, width, height);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glScissor");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glShaderBinary
static mrb_value
mrb_GL_glShaderBinary(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int n;
    mrb_value shaders;
    mrb_int binaryformat;
    mrb_value binary;
    mrb_int length;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iAiAi", &n, &shaders, &binaryformat, &binary, &length)) {
      GLuint cxx_shaders[1]; cc_mrb_ary_conv_to_c_array(mrb, shaders, reinterpret_cast< unsigned int * >(cxx_shaders), 1);
      GLvoid cxx_binary[1]; cc_mrb_ary_conv_to_c_array(mrb, binary, reinterpret_cast< void * >(cxx_binary), 1);
      GL::glShaderBinary(n, cxx_shaders, binaryformat, cxx_binary, length);
      cc_mrb_ary_conv_from_c_array(mrb, shaders, reinterpret_cast< GLuint * >(cxx_shaders), 1);
      cc_mrb_ary_conv_from_c_array(mrb, binary, reinterpret_cast< GLvoid * >(cxx_binary), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glShaderBinary");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glShaderSource
static mrb_value
mrb_GL_glShaderSource(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int shader;
    mrb_int count;
    mrb_value string;
    mrb_value length;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiAA", &shader, &count, &string, &length)) {
      GLchar * cxx_string[1]; cc_mrb_ary_conv_to_c_array(mrb, string, reinterpret_cast< GLchar * * >(cxx_string), 1);
      GLint cxx_length[1]; cc_mrb_ary_conv_to_c_array(mrb, length, reinterpret_cast< int * >(cxx_length), 1);
      GL::glShaderSource(shader, count, cxx_string, cxx_length);
      cc_mrb_ary_conv_from_c_array(mrb, string, reinterpret_cast< GLchar * * >(cxx_string), 1);
      cc_mrb_ary_conv_from_c_array(mrb, length, reinterpret_cast< GLint * >(cxx_length), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glShaderSource");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glStencilFunc
static mrb_value
mrb_GL_glStencilFunc(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int func;
    mrb_int ref;
    mrb_int mask;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iii", &func, &ref, &mask)) {
      GL::glStencilFunc(func, ref, mask);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glStencilFunc");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glStencilFuncSeparate
static mrb_value
mrb_GL_glStencilFuncSeparate(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int face;
    mrb_int func;
    mrb_int ref;
    mrb_int mask;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &face, &func, &ref, &mask)) {
      GL::glStencilFuncSeparate(face, func, ref, mask);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glStencilFuncSeparate");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glStencilMask
static mrb_value
mrb_GL_glStencilMask(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int mask;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &mask)) {
      GL::glStencilMask(mask);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glStencilMask");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glStencilMaskSeparate
static mrb_value
mrb_GL_glStencilMaskSeparate(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int face;
    mrb_int mask;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &face, &mask)) {
      GL::glStencilMaskSeparate(face, mask);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glStencilMaskSeparate");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glStencilOp
static mrb_value
mrb_GL_glStencilOp(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int fail;
    mrb_int zfail;
    mrb_int zpass;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iii", &fail, &zfail, &zpass)) {
      GL::glStencilOp(fail, zfail, zpass);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glStencilOp");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glStencilOpSeparate
static mrb_value
mrb_GL_glStencilOpSeparate(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int face;
    mrb_int fail;
    mrb_int zfail;
    mrb_int zpass;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &face, &fail, &zfail, &zpass)) {
      GL::glStencilOpSeparate(face, fail, zfail, zpass);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glStencilOpSeparate");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glTexImage2D
static mrb_value
mrb_GL_glTexImage2D(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int level;
    mrb_int internalformat;
    mrb_int width;
    mrb_int height;
    mrb_int border;
    mrb_int format;
    mrb_int type;
    mrb_value pixels;
    if (9 == _argc_ && 9 == mrb_get_args(mrb, "iiiiiiiiA", &target, &level, &internalformat, &width, &height, &border, &format, &type, &pixels)) {
      if (format == GL_RGBA && type == GL_UNSIGNED_BYTE) {
        GLubyte *cxx_pixels = new GLubyte[width * height * 4];
        cc_mrb_ary_conv_to_c_array(mrb, pixels, cxx_pixels, width * height * 4);
        GL::glTexImage2D(target, level, internalformat, width, height, border, format, type, cxx_pixels);
        delete[] cxx_pixels;
        mrb_value mrb_res = mrb_self;
        return mrb_res;
      }
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glTexImage2D");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glTexParameterf
static mrb_value
mrb_GL_glTexParameterf(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_float param;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iif", &target, &pname, &param)) {
      GL::glTexParameterf(target, pname, param);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glTexParameterf");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glTexParameterfv
static mrb_value
mrb_GL_glTexParameterfv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &target, &pname, &params)) {
      GLfloat cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< float * >(cxx_params), 1);
      GL::glTexParameterfv(target, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLfloat * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glTexParameterfv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glTexParameteri
static mrb_value
mrb_GL_glTexParameteri(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_int param;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iii", &target, &pname, &param)) {
      GL::glTexParameteri(target, pname, param);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glTexParameteri");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glTexParameteriv
static mrb_value
mrb_GL_glTexParameteriv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int pname;
    mrb_value params;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &target, &pname, &params)) {
      GLint cxx_params[1]; cc_mrb_ary_conv_to_c_array(mrb, params, reinterpret_cast< int * >(cxx_params), 1);
      GL::glTexParameteriv(target, pname, cxx_params);
      cc_mrb_ary_conv_from_c_array(mrb, params, reinterpret_cast< GLint * >(cxx_params), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glTexParameteriv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glTexStorage2DEXT
static mrb_value
mrb_GL_glTexStorage2DEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int levels;
    mrb_int internalformat;
    mrb_int width;
    mrb_int height;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iiiii", &target, &levels, &internalformat, &width, &height)) {
      GL::glTexStorage2DEXT(target, levels, internalformat, width, height);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glTexStorage2DEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glTexSubImage2D
static mrb_value
mrb_GL_glTexSubImage2D(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    mrb_int level;
    mrb_int xoffset;
    mrb_int yoffset;
    mrb_int width;
    mrb_int height;
    mrb_int format;
    mrb_int type;
    mrb_value pixels;
    if (9 == _argc_ && 9 == mrb_get_args(mrb, "iiiiiiiiA", &target, &level, &xoffset, &yoffset, &width, &height, &format, &type, &pixels)) {
      GLvoid cxx_pixels[1]; cc_mrb_ary_conv_to_c_array(mrb, pixels, reinterpret_cast< void * >(cxx_pixels), 1);
      GL::glTexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, cxx_pixels);
      cc_mrb_ary_conv_from_c_array(mrb, pixels, reinterpret_cast< GLvoid * >(cxx_pixels), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glTexSubImage2D");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform1f
static mrb_value
mrb_GL_glUniform1f(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_float x;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "if", &location, &x)) {
      GL::glUniform1f(location, x);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform1f");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform1fv
static mrb_value
mrb_GL_glUniform1fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_value v;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &location, &count, &v)) {
      GLfloat cxx_v[1]; cc_mrb_ary_conv_to_c_array(mrb, v, reinterpret_cast< float * >(cxx_v), 1);
      GL::glUniform1fv(location, count, cxx_v);
      cc_mrb_ary_conv_from_c_array(mrb, v, reinterpret_cast< GLfloat * >(cxx_v), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform1fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform1i
static mrb_value
mrb_GL_glUniform1i(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int x;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "ii", &location, &x)) {
      GL::glUniform1i(location, x);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform1i");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform1iv
static mrb_value
mrb_GL_glUniform1iv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_value v;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &location, &count, &v)) {
      GLint cxx_v[1]; cc_mrb_ary_conv_to_c_array(mrb, v, reinterpret_cast< int * >(cxx_v), 1);
      GL::glUniform1iv(location, count, cxx_v);
      cc_mrb_ary_conv_from_c_array(mrb, v, reinterpret_cast< GLint * >(cxx_v), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform1iv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform2f
static mrb_value
mrb_GL_glUniform2f(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_float x;
    mrb_float y;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iff", &location, &x, &y)) {
      GL::glUniform2f(location, x, y);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform2f");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform2fv
static mrb_value
mrb_GL_glUniform2fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_value v;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &location, &count, &v)) {
      GLfloat cxx_v[1]; cc_mrb_ary_conv_to_c_array(mrb, v, reinterpret_cast< float * >(cxx_v), 1);
      GL::glUniform2fv(location, count, cxx_v);
      cc_mrb_ary_conv_from_c_array(mrb, v, reinterpret_cast< GLfloat * >(cxx_v), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform2fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform2i
static mrb_value
mrb_GL_glUniform2i(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int x;
    mrb_int y;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iii", &location, &x, &y)) {
      GL::glUniform2i(location, x, y);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform2i");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform2iv
static mrb_value
mrb_GL_glUniform2iv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_value v;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &location, &count, &v)) {
      GLint cxx_v[1]; cc_mrb_ary_conv_to_c_array(mrb, v, reinterpret_cast< int * >(cxx_v), 1);
      GL::glUniform2iv(location, count, cxx_v);
      cc_mrb_ary_conv_from_c_array(mrb, v, reinterpret_cast< GLint * >(cxx_v), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform2iv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform3f
static mrb_value
mrb_GL_glUniform3f(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "ifff", &location, &x, &y, &z)) {
      GL::glUniform3f(location, x, y, z);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform3f");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform3fv
static mrb_value
mrb_GL_glUniform3fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_value v;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &location, &count, &v)) {
      GLfloat cxx_v[1]; cc_mrb_ary_conv_to_c_array(mrb, v, reinterpret_cast< float * >(cxx_v), 1);
      GL::glUniform3fv(location, count, cxx_v);
      cc_mrb_ary_conv_from_c_array(mrb, v, reinterpret_cast< GLfloat * >(cxx_v), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform3fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform3i
static mrb_value
mrb_GL_glUniform3i(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int x;
    mrb_int y;
    mrb_int z;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &location, &x, &y, &z)) {
      GL::glUniform3i(location, x, y, z);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform3i");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform3iv
static mrb_value
mrb_GL_glUniform3iv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_value v;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &location, &count, &v)) {
      GLint cxx_v[1]; cc_mrb_ary_conv_to_c_array(mrb, v, reinterpret_cast< int * >(cxx_v), 1);
      GL::glUniform3iv(location, count, cxx_v);
      cc_mrb_ary_conv_from_c_array(mrb, v, reinterpret_cast< GLint * >(cxx_v), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform3iv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform4f
static mrb_value
mrb_GL_glUniform4f(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    mrb_float w;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iffff", &location, &x, &y, &z, &w)) {
      GL::glUniform4f(location, x, y, z, w);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform4f");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform4fv
static mrb_value
mrb_GL_glUniform4fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_value v;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &location, &count, &v)) {
      int len = mrb_ary_len(mrb, v);
      GLfloat *cxx_v = new GLfloat[len];
      cc_mrb_ary_conv_to_c_array(mrb, v, cxx_v, len);
      GL::glUniform4fv(location, count, cxx_v);
      delete[] cxx_v;
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform4fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform4i
static mrb_value
mrb_GL_glUniform4i(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int x;
    mrb_int y;
    mrb_int z;
    mrb_int w;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iiiii", &location, &x, &y, &z, &w)) {
      GL::glUniform4i(location, x, y, z, w);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform4i");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniform4iv
static mrb_value
mrb_GL_glUniform4iv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_value v;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iiA", &location, &count, &v)) {
      GLint cxx_v[1]; cc_mrb_ary_conv_to_c_array(mrb, v, reinterpret_cast< int * >(cxx_v), 1);
      GL::glUniform4iv(location, count, cxx_v);
      cc_mrb_ary_conv_from_c_array(mrb, v, reinterpret_cast< GLint * >(cxx_v), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniform4iv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniformMatrix2fv
static mrb_value
mrb_GL_glUniformMatrix2fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_int transpose;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &location, &count, &transpose, &value)) {
      GLfloat cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< float * >(cxx_value), 1);
      GL::glUniformMatrix2fv(location, count, transpose, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLfloat * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniformMatrix2fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniformMatrix3fv
static mrb_value
mrb_GL_glUniformMatrix3fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_int transpose;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &location, &count, &transpose, &value)) {
      GLfloat cxx_value[1]; cc_mrb_ary_conv_to_c_array(mrb, value, reinterpret_cast< float * >(cxx_value), 1);
      GL::glUniformMatrix3fv(location, count, transpose, cxx_value);
      cc_mrb_ary_conv_from_c_array(mrb, value, reinterpret_cast< GLfloat * >(cxx_value), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniformMatrix3fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUniformMatrix4fv
static mrb_value
mrb_GL_glUniformMatrix4fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int location;
    mrb_int count;
    mrb_int transpose;
    mrb_value value;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiiA", &location, &count, &transpose, &value)) {
      int len = mrb_ary_len(mrb, value);
      GLfloat *cxx_value = new GLfloat[len];
      cc_mrb_ary_conv_to_c_array(mrb, value, cxx_value, len);
      GL::glUniformMatrix4fv(location, count, transpose, cxx_value);
      delete[] cxx_value;
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUniformMatrix4fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUnmapBufferOES
static mrb_value
mrb_GL_glUnmapBufferOES(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int target;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &target)) {
      GLboolean res = GL::glUnmapBufferOES(target);
      mrb_value mrb_res = mrb_fixnum_value(res);
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUnmapBufferOES");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUseProgram
static mrb_value
mrb_GL_glUseProgram(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &program)) {
      GL::glUseProgram(program);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUseProgram");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glUseProgramStagesEXT
static mrb_value
mrb_GL_glUseProgramStagesEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pipeline;
    mrb_int stages;
    mrb_int program;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iii", &pipeline, &stages, &program)) {
      GL::glUseProgramStagesEXT(pipeline, stages, program);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glUseProgramStagesEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glValidateProgram
static mrb_value
mrb_GL_glValidateProgram(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int program;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &program)) {
      GL::glValidateProgram(program);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glValidateProgram");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glValidateProgramPipelineEXT
static mrb_value
mrb_GL_glValidateProgramPipelineEXT(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int pipeline;
    if (1 == _argc_ && 1 == mrb_get_args(mrb, "i", &pipeline)) {
      GL::glValidateProgramPipelineEXT(pipeline);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glValidateProgramPipelineEXT");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glVertexAttrib1f
static mrb_value
mrb_GL_glVertexAttrib1f(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int indx;
    mrb_float x;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "if", &indx, &x)) {
      GL::glVertexAttrib1f(indx, x);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glVertexAttrib1f");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glVertexAttrib1fv
static mrb_value
mrb_GL_glVertexAttrib1fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int indx;
    mrb_value values;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &indx, &values)) {
      GLfloat cxx_values[1]; cc_mrb_ary_conv_to_c_array(mrb, values, reinterpret_cast< float * >(cxx_values), 1);
      GL::glVertexAttrib1fv(indx, cxx_values);
      cc_mrb_ary_conv_from_c_array(mrb, values, reinterpret_cast< GLfloat * >(cxx_values), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glVertexAttrib1fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glVertexAttrib2f
static mrb_value
mrb_GL_glVertexAttrib2f(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int indx;
    mrb_float x;
    mrb_float y;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "iff", &indx, &x, &y)) {
      GL::glVertexAttrib2f(indx, x, y);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glVertexAttrib2f");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glVertexAttrib2fv
static mrb_value
mrb_GL_glVertexAttrib2fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int indx;
    mrb_value values;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &indx, &values)) {
      GLfloat cxx_values[1]; cc_mrb_ary_conv_to_c_array(mrb, values, reinterpret_cast< float * >(cxx_values), 1);
      GL::glVertexAttrib2fv(indx, cxx_values);
      cc_mrb_ary_conv_from_c_array(mrb, values, reinterpret_cast< GLfloat * >(cxx_values), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glVertexAttrib2fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glVertexAttrib3f
static mrb_value
mrb_GL_glVertexAttrib3f(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int indx;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "ifff", &indx, &x, &y, &z)) {
      GL::glVertexAttrib3f(indx, x, y, z);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glVertexAttrib3f");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glVertexAttrib3fv
static mrb_value
mrb_GL_glVertexAttrib3fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int indx;
    mrb_value values;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &indx, &values)) {
      GLfloat cxx_values[1]; cc_mrb_ary_conv_to_c_array(mrb, values, reinterpret_cast< float * >(cxx_values), 1);
      GL::glVertexAttrib3fv(indx, cxx_values);
      cc_mrb_ary_conv_from_c_array(mrb, values, reinterpret_cast< GLfloat * >(cxx_values), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glVertexAttrib3fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glVertexAttrib4f
static mrb_value
mrb_GL_glVertexAttrib4f(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int indx;
    mrb_float x;
    mrb_float y;
    mrb_float z;
    mrb_float w;
    if (5 == _argc_ && 5 == mrb_get_args(mrb, "iffff", &indx, &x, &y, &z, &w)) {
      GL::glVertexAttrib4f(indx, x, y, z, w);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glVertexAttrib4f");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glVertexAttrib4fv
static mrb_value
mrb_GL_glVertexAttrib4fv(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int indx;
    mrb_value values;
    if (2 == _argc_ && 2 == mrb_get_args(mrb, "iA", &indx, &values)) {
      GLfloat cxx_values[1]; cc_mrb_ary_conv_to_c_array(mrb, values, reinterpret_cast< float * >(cxx_values), 1);
      GL::glVertexAttrib4fv(indx, cxx_values);
      cc_mrb_ary_conv_from_c_array(mrb, values, reinterpret_cast< GLfloat * >(cxx_values), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glVertexAttrib4fv");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glVertexAttribPointer
static mrb_value
mrb_GL_glVertexAttribPointer(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int indx;
    mrb_int size;
    mrb_int type;
    mrb_int normalized;
    mrb_int stride;
    mrb_value ptr;
      int len = 0;
      if (6 == _argc_ && mrb_array_p(_argv_[5])) {
          ptr = _argv_[5];
          len = mrb_ary_len(mrb, ptr);
      }
      mrb_value *_rest_argv_;
      int _rest_argc_;
    if (6 == _argc_ && 6 == mrb_get_args(mrb, "iiiii*", &indx, &size, &type, &normalized, &stride, &_rest_argv_, &_rest_argc_)) {
      if (type == GL_FLOAT) {
        GLfloat *cxx_ptr = (len > 0) ? new GLfloat[len] : NULL;
        cc_mrb_ary_conv_to_c_array(mrb, ptr, cxx_ptr, len);
        GL::glVertexAttribPointer(indx, size, type, normalized, stride, cxx_ptr);
        delete[] cxx_ptr;
        mrb_value mrb_res = mrb_self;
        return mrb_res;
      }
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glVertexAttribPointer");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glViewport
static mrb_value
mrb_GL_glViewport(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_int x;
    mrb_int y;
    mrb_int width;
    mrb_int height;
    if (4 == _argc_ && 4 == mrb_get_args(mrb, "iiii", &x, &y, &width, &height)) {
      GL::glViewport(x, y, width, height);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glViewport");
  return mrb_nil_value();
}
#endif

#ifndef NO_USE_mrb_GL_glWaitSyncAPPLE
static mrb_value
mrb_GL_glWaitSyncAPPLE(mrb_state *mrb, mrb_value mrb_self)
{
  mrb_value *_argv_;
  int _argc_;
  mrb_get_args(mrb, "*", &_argv_, &_argc_);
  {
    mrb_value sync;
    mrb_int flags;
    mrb_int timeout;
    if (3 == _argc_ && 3 == mrb_get_args(mrb, "Aii", &sync, &flags, &timeout)) {
      GLsync cxx_sync[1]; cc_mrb_ary_conv_to_c_array(mrb, sync, reinterpret_cast< struct __GLsync * >(cxx_sync), 1);
      GL::glWaitSyncAPPLE(cxx_sync, flags, timeout);
      cc_mrb_ary_conv_from_c_array(mrb, sync, reinterpret_cast< GLsync * >(cxx_sync), 1);
      mrb_value mrb_res = mrb_self;
      return mrb_res;
    }
  }
  mrb_raise(mrb, E_ARGUMENT_ERROR, "GL::glWaitSyncAPPLE");
  return mrb_nil_value();
}
#endif

void
mrb_init_GL(mrb_state *mrb)
{
  struct RClass *rc = NULL;
  struct RClass *cur_rc = NULL;
  struct RClass *base_rc = NULL;


  rc = _define_class_GL(mrb);
  cur_rc = cc_mrb_class_get(mrb, "GL");
  assert(cur_rc);
#ifndef NO_USE_mrb_GL_glActiveShaderProgramEXT
  mrb_define_module_function(mrb, cur_rc, "glActiveShaderProgramEXT", mrb_GL_glActiveShaderProgramEXT, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glActiveTexture
  mrb_define_module_function(mrb, cur_rc, "glActiveTexture", mrb_GL_glActiveTexture, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glAttachShader
  mrb_define_module_function(mrb, cur_rc, "glAttachShader", mrb_GL_glAttachShader, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glBeginQueryEXT
  mrb_define_module_function(mrb, cur_rc, "glBeginQueryEXT", mrb_GL_glBeginQueryEXT, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glBindAttribLocation
  mrb_define_module_function(mrb, cur_rc, "glBindAttribLocation", mrb_GL_glBindAttribLocation, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glBindBuffer
  mrb_define_module_function(mrb, cur_rc, "glBindBuffer", mrb_GL_glBindBuffer, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glBindFramebuffer
  mrb_define_module_function(mrb, cur_rc, "glBindFramebuffer", mrb_GL_glBindFramebuffer, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glBindProgramPipelineEXT
  mrb_define_module_function(mrb, cur_rc, "glBindProgramPipelineEXT", mrb_GL_glBindProgramPipelineEXT, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glBindRenderbuffer
  mrb_define_module_function(mrb, cur_rc, "glBindRenderbuffer", mrb_GL_glBindRenderbuffer, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glBindTexture
  mrb_define_module_function(mrb, cur_rc, "glBindTexture", mrb_GL_glBindTexture, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glBindVertexArrayOES
  mrb_define_module_function(mrb, cur_rc, "glBindVertexArrayOES", mrb_GL_glBindVertexArrayOES, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glBlendColor
  mrb_define_module_function(mrb, cur_rc, "glBlendColor", mrb_GL_glBlendColor, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glBlendEquation
  mrb_define_module_function(mrb, cur_rc, "glBlendEquation", mrb_GL_glBlendEquation, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glBlendEquationSeparate
  mrb_define_module_function(mrb, cur_rc, "glBlendEquationSeparate", mrb_GL_glBlendEquationSeparate, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glBlendFunc
  mrb_define_module_function(mrb, cur_rc, "glBlendFunc", mrb_GL_glBlendFunc, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glBlendFuncSeparate
  mrb_define_module_function(mrb, cur_rc, "glBlendFuncSeparate", mrb_GL_glBlendFuncSeparate, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glBufferData
  mrb_define_module_function(mrb, cur_rc, "glBufferData", mrb_GL_glBufferData, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glBufferSubData
  mrb_define_module_function(mrb, cur_rc, "glBufferSubData", mrb_GL_glBufferSubData, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glCheckFramebufferStatus
  mrb_define_module_function(mrb, cur_rc, "glCheckFramebufferStatus", mrb_GL_glCheckFramebufferStatus, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glClear
  mrb_define_module_function(mrb, cur_rc, "glClear", mrb_GL_glClear, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glClearColor
  mrb_define_module_function(mrb, cur_rc, "glClearColor", mrb_GL_glClearColor, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glClearDepthf
  mrb_define_module_function(mrb, cur_rc, "glClearDepthf", mrb_GL_glClearDepthf, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glClearStencil
  mrb_define_module_function(mrb, cur_rc, "glClearStencil", mrb_GL_glClearStencil, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glClientWaitSyncAPPLE
  mrb_define_module_function(mrb, cur_rc, "glClientWaitSyncAPPLE", mrb_GL_glClientWaitSyncAPPLE, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glColorMask
  mrb_define_module_function(mrb, cur_rc, "glColorMask", mrb_GL_glColorMask, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glCompileShader
  mrb_define_module_function(mrb, cur_rc, "glCompileShader", mrb_GL_glCompileShader, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glCompressedTexImage2D
  mrb_define_module_function(mrb, cur_rc, "glCompressedTexImage2D", mrb_GL_glCompressedTexImage2D, MRB_ARGS_REQ(8));
#endif
#ifndef NO_USE_mrb_GL_glCompressedTexSubImage2D
  mrb_define_module_function(mrb, cur_rc, "glCompressedTexSubImage2D", mrb_GL_glCompressedTexSubImage2D, MRB_ARGS_REQ(9));
#endif
#ifndef NO_USE_mrb_GL_glCopyTexImage2D
  mrb_define_module_function(mrb, cur_rc, "glCopyTexImage2D", mrb_GL_glCopyTexImage2D, MRB_ARGS_REQ(8));
#endif
#ifndef NO_USE_mrb_GL_glCopyTexSubImage2D
  mrb_define_module_function(mrb, cur_rc, "glCopyTexSubImage2D", mrb_GL_glCopyTexSubImage2D, MRB_ARGS_REQ(8));
#endif
#ifndef NO_USE_mrb_GL_glCopyTextureLevelsAPPLE
  mrb_define_module_function(mrb, cur_rc, "glCopyTextureLevelsAPPLE", mrb_GL_glCopyTextureLevelsAPPLE, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glCreateProgram
  mrb_define_module_function(mrb, cur_rc, "glCreateProgram", mrb_GL_glCreateProgram, MRB_ARGS_NONE());
#endif
#ifndef NO_USE_mrb_GL_glCreateShader
  mrb_define_module_function(mrb, cur_rc, "glCreateShader", mrb_GL_glCreateShader, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glCreateShaderProgramvEXT
  mrb_define_module_function(mrb, cur_rc, "glCreateShaderProgramvEXT", mrb_GL_glCreateShaderProgramvEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glCullFace
  mrb_define_module_function(mrb, cur_rc, "glCullFace", mrb_GL_glCullFace, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glDeleteBuffers
  mrb_define_module_function(mrb, cur_rc, "glDeleteBuffers", mrb_GL_glDeleteBuffers, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glDeleteFramebuffers
  mrb_define_module_function(mrb, cur_rc, "glDeleteFramebuffers", mrb_GL_glDeleteFramebuffers, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glDeleteProgram
  mrb_define_module_function(mrb, cur_rc, "glDeleteProgram", mrb_GL_glDeleteProgram, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glDeleteProgramPipelinesEXT
  mrb_define_module_function(mrb, cur_rc, "glDeleteProgramPipelinesEXT", mrb_GL_glDeleteProgramPipelinesEXT, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glDeleteQueriesEXT
  mrb_define_module_function(mrb, cur_rc, "glDeleteQueriesEXT", mrb_GL_glDeleteQueriesEXT, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glDeleteRenderbuffers
  mrb_define_module_function(mrb, cur_rc, "glDeleteRenderbuffers", mrb_GL_glDeleteRenderbuffers, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glDeleteShader
  mrb_define_module_function(mrb, cur_rc, "glDeleteShader", mrb_GL_glDeleteShader, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glDeleteSyncAPPLE
  mrb_define_module_function(mrb, cur_rc, "glDeleteSyncAPPLE", mrb_GL_glDeleteSyncAPPLE, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glDeleteTextures
  mrb_define_module_function(mrb, cur_rc, "glDeleteTextures", mrb_GL_glDeleteTextures, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glDeleteVertexArraysOES
  mrb_define_module_function(mrb, cur_rc, "glDeleteVertexArraysOES", mrb_GL_glDeleteVertexArraysOES, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glDepthFunc
  mrb_define_module_function(mrb, cur_rc, "glDepthFunc", mrb_GL_glDepthFunc, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glDepthMask
  mrb_define_module_function(mrb, cur_rc, "glDepthMask", mrb_GL_glDepthMask, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glDepthRangef
  mrb_define_module_function(mrb, cur_rc, "glDepthRangef", mrb_GL_glDepthRangef, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glDetachShader
  mrb_define_module_function(mrb, cur_rc, "glDetachShader", mrb_GL_glDetachShader, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glDisable
  mrb_define_module_function(mrb, cur_rc, "glDisable", mrb_GL_glDisable, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glDisableVertexAttribArray
  mrb_define_module_function(mrb, cur_rc, "glDisableVertexAttribArray", mrb_GL_glDisableVertexAttribArray, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glDiscardFramebufferEXT
  mrb_define_module_function(mrb, cur_rc, "glDiscardFramebufferEXT", mrb_GL_glDiscardFramebufferEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glDrawArrays
  mrb_define_module_function(mrb, cur_rc, "glDrawArrays", mrb_GL_glDrawArrays, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glDrawElements
  mrb_define_module_function(mrb, cur_rc, "glDrawElements", mrb_GL_glDrawElements, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glEnable
  mrb_define_module_function(mrb, cur_rc, "glEnable", mrb_GL_glEnable, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glEnableVertexAttribArray
  mrb_define_module_function(mrb, cur_rc, "glEnableVertexAttribArray", mrb_GL_glEnableVertexAttribArray, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glEndQueryEXT
  mrb_define_module_function(mrb, cur_rc, "glEndQueryEXT", mrb_GL_glEndQueryEXT, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glFenceSyncAPPLE
  mrb_define_module_function(mrb, cur_rc, "glFenceSyncAPPLE", mrb_GL_glFenceSyncAPPLE, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glFinish
  mrb_define_module_function(mrb, cur_rc, "glFinish", mrb_GL_glFinish, MRB_ARGS_NONE());
#endif
#ifndef NO_USE_mrb_GL_glFlush
  mrb_define_module_function(mrb, cur_rc, "glFlush", mrb_GL_glFlush, MRB_ARGS_NONE());
#endif
#ifndef NO_USE_mrb_GL_glFlushMappedBufferRangeEXT
  mrb_define_module_function(mrb, cur_rc, "glFlushMappedBufferRangeEXT", mrb_GL_glFlushMappedBufferRangeEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glFramebufferRenderbuffer
  mrb_define_module_function(mrb, cur_rc, "glFramebufferRenderbuffer", mrb_GL_glFramebufferRenderbuffer, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glFramebufferTexture2D
  mrb_define_module_function(mrb, cur_rc, "glFramebufferTexture2D", mrb_GL_glFramebufferTexture2D, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glFrontFace
  mrb_define_module_function(mrb, cur_rc, "glFrontFace", mrb_GL_glFrontFace, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glGenBuffers
  mrb_define_module_function(mrb, cur_rc, "glGenBuffers", mrb_GL_glGenBuffers, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGenFramebuffers
  mrb_define_module_function(mrb, cur_rc, "glGenFramebuffers", mrb_GL_glGenFramebuffers, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGenProgramPipelinesEXT
  mrb_define_module_function(mrb, cur_rc, "glGenProgramPipelinesEXT", mrb_GL_glGenProgramPipelinesEXT, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGenQueriesEXT
  mrb_define_module_function(mrb, cur_rc, "glGenQueriesEXT", mrb_GL_glGenQueriesEXT, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGenRenderbuffers
  mrb_define_module_function(mrb, cur_rc, "glGenRenderbuffers", mrb_GL_glGenRenderbuffers, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGenTextures
  mrb_define_module_function(mrb, cur_rc, "glGenTextures", mrb_GL_glGenTextures, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGenVertexArraysOES
  mrb_define_module_function(mrb, cur_rc, "glGenVertexArraysOES", mrb_GL_glGenVertexArraysOES, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGenerateMipmap
  mrb_define_module_function(mrb, cur_rc, "glGenerateMipmap", mrb_GL_glGenerateMipmap, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glGetActiveAttrib
  mrb_define_module_function(mrb, cur_rc, "glGetActiveAttrib", mrb_GL_glGetActiveAttrib, MRB_ARGS_REQ(7));
#endif
#ifndef NO_USE_mrb_GL_glGetActiveUniform
  mrb_define_module_function(mrb, cur_rc, "glGetActiveUniform", mrb_GL_glGetActiveUniform, MRB_ARGS_REQ(7));
#endif
#ifndef NO_USE_mrb_GL_glGetAttachedShaders
  mrb_define_module_function(mrb, cur_rc, "glGetAttachedShaders", mrb_GL_glGetAttachedShaders, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glGetAttribLocation
  mrb_define_module_function(mrb, cur_rc, "glGetAttribLocation", mrb_GL_glGetAttribLocation, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGetBooleanv
  mrb_define_module_function(mrb, cur_rc, "glGetBooleanv", mrb_GL_glGetBooleanv, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGetBufferParameteriv
  mrb_define_module_function(mrb, cur_rc, "glGetBufferParameteriv", mrb_GL_glGetBufferParameteriv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetBufferPointervOES
  mrb_define_module_function(mrb, cur_rc, "glGetBufferPointervOES", mrb_GL_glGetBufferPointervOES, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetError
  mrb_define_module_function(mrb, cur_rc, "glGetError", mrb_GL_glGetError, MRB_ARGS_NONE());
#endif
#ifndef NO_USE_mrb_GL_glGetFloatv
  mrb_define_module_function(mrb, cur_rc, "glGetFloatv", mrb_GL_glGetFloatv, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGetFramebufferAttachmentParameteriv
  mrb_define_module_function(mrb, cur_rc, "glGetFramebufferAttachmentParameteriv", mrb_GL_glGetFramebufferAttachmentParameteriv, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glGetInteger64vAPPLE
  mrb_define_module_function(mrb, cur_rc, "glGetInteger64vAPPLE", mrb_GL_glGetInteger64vAPPLE, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGetIntegerv
  mrb_define_module_function(mrb, cur_rc, "glGetIntegerv", mrb_GL_glGetIntegerv, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGetObjectLabelEXT
  mrb_define_module_function(mrb, cur_rc, "glGetObjectLabelEXT", mrb_GL_glGetObjectLabelEXT, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glGetProgramInfoLog
  mrb_define_module_function(mrb, cur_rc, "glGetProgramInfoLog", mrb_GL_glGetProgramInfoLog, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glGetProgramPipelineInfoLogEXT
  mrb_define_module_function(mrb, cur_rc, "glGetProgramPipelineInfoLogEXT", mrb_GL_glGetProgramPipelineInfoLogEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glGetProgramPipelineivEXT
  mrb_define_module_function(mrb, cur_rc, "glGetProgramPipelineivEXT", mrb_GL_glGetProgramPipelineivEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetProgramiv
  mrb_define_module_function(mrb, cur_rc, "glGetProgramiv", mrb_GL_glGetProgramiv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetQueryObjectuivEXT
  mrb_define_module_function(mrb, cur_rc, "glGetQueryObjectuivEXT", mrb_GL_glGetQueryObjectuivEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetQueryivEXT
  mrb_define_module_function(mrb, cur_rc, "glGetQueryivEXT", mrb_GL_glGetQueryivEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetRenderbufferParameteriv
  mrb_define_module_function(mrb, cur_rc, "glGetRenderbufferParameteriv", mrb_GL_glGetRenderbufferParameteriv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetShaderInfoLog
  mrb_define_module_function(mrb, cur_rc, "glGetShaderInfoLog", mrb_GL_glGetShaderInfoLog, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glGetShaderPrecisionFormat
  mrb_define_module_function(mrb, cur_rc, "glGetShaderPrecisionFormat", mrb_GL_glGetShaderPrecisionFormat, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glGetShaderSource
  mrb_define_module_function(mrb, cur_rc, "glGetShaderSource", mrb_GL_glGetShaderSource, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glGetShaderiv
  mrb_define_module_function(mrb, cur_rc, "glGetShaderiv", mrb_GL_glGetShaderiv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetString
  mrb_define_module_function(mrb, cur_rc, "glGetString", mrb_GL_glGetString, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glGetSyncivAPPLE
  mrb_define_module_function(mrb, cur_rc, "glGetSyncivAPPLE", mrb_GL_glGetSyncivAPPLE, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glGetTexParameterfv
  mrb_define_module_function(mrb, cur_rc, "glGetTexParameterfv", mrb_GL_glGetTexParameterfv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetTexParameteriv
  mrb_define_module_function(mrb, cur_rc, "glGetTexParameteriv", mrb_GL_glGetTexParameteriv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetUniformLocation
  mrb_define_module_function(mrb, cur_rc, "glGetUniformLocation", mrb_GL_glGetUniformLocation, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glGetUniformfv
  mrb_define_module_function(mrb, cur_rc, "glGetUniformfv", mrb_GL_glGetUniformfv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetUniformiv
  mrb_define_module_function(mrb, cur_rc, "glGetUniformiv", mrb_GL_glGetUniformiv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetVertexAttribPointerv
  mrb_define_module_function(mrb, cur_rc, "glGetVertexAttribPointerv", mrb_GL_glGetVertexAttribPointerv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetVertexAttribfv
  mrb_define_module_function(mrb, cur_rc, "glGetVertexAttribfv", mrb_GL_glGetVertexAttribfv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glGetVertexAttribiv
  mrb_define_module_function(mrb, cur_rc, "glGetVertexAttribiv", mrb_GL_glGetVertexAttribiv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glHint
  mrb_define_module_function(mrb, cur_rc, "glHint", mrb_GL_glHint, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glInsertEventMarkerEXT
  mrb_define_module_function(mrb, cur_rc, "glInsertEventMarkerEXT", mrb_GL_glInsertEventMarkerEXT, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glIsBuffer
  mrb_define_module_function(mrb, cur_rc, "glIsBuffer", mrb_GL_glIsBuffer, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsEnabled
  mrb_define_module_function(mrb, cur_rc, "glIsEnabled", mrb_GL_glIsEnabled, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsFramebuffer
  mrb_define_module_function(mrb, cur_rc, "glIsFramebuffer", mrb_GL_glIsFramebuffer, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsProgram
  mrb_define_module_function(mrb, cur_rc, "glIsProgram", mrb_GL_glIsProgram, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsProgramPipelineEXT
  mrb_define_module_function(mrb, cur_rc, "glIsProgramPipelineEXT", mrb_GL_glIsProgramPipelineEXT, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsQueryEXT
  mrb_define_module_function(mrb, cur_rc, "glIsQueryEXT", mrb_GL_glIsQueryEXT, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsRenderbuffer
  mrb_define_module_function(mrb, cur_rc, "glIsRenderbuffer", mrb_GL_glIsRenderbuffer, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsShader
  mrb_define_module_function(mrb, cur_rc, "glIsShader", mrb_GL_glIsShader, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsSyncAPPLE
  mrb_define_module_function(mrb, cur_rc, "glIsSyncAPPLE", mrb_GL_glIsSyncAPPLE, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsTexture
  mrb_define_module_function(mrb, cur_rc, "glIsTexture", mrb_GL_glIsTexture, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glIsVertexArrayOES
  mrb_define_module_function(mrb, cur_rc, "glIsVertexArrayOES", mrb_GL_glIsVertexArrayOES, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glLabelObjectEXT
  mrb_define_module_function(mrb, cur_rc, "glLabelObjectEXT", mrb_GL_glLabelObjectEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glLineWidth
  mrb_define_module_function(mrb, cur_rc, "glLineWidth", mrb_GL_glLineWidth, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glLinkProgram
  mrb_define_module_function(mrb, cur_rc, "glLinkProgram", mrb_GL_glLinkProgram, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glPixelStorei
  mrb_define_module_function(mrb, cur_rc, "glPixelStorei", mrb_GL_glPixelStorei, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glPolygonOffset
  mrb_define_module_function(mrb, cur_rc, "glPolygonOffset", mrb_GL_glPolygonOffset, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glPopGroupMarkerEXT
  mrb_define_module_function(mrb, cur_rc, "glPopGroupMarkerEXT", mrb_GL_glPopGroupMarkerEXT, MRB_ARGS_NONE());
#endif
#ifndef NO_USE_mrb_GL_glProgramParameteriEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramParameteriEXT", mrb_GL_glProgramParameteriEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform1fEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform1fEXT", mrb_GL_glProgramUniform1fEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform1fvEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform1fvEXT", mrb_GL_glProgramUniform1fvEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform1iEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform1iEXT", mrb_GL_glProgramUniform1iEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform1ivEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform1ivEXT", mrb_GL_glProgramUniform1ivEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform2fEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform2fEXT", mrb_GL_glProgramUniform2fEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform2fvEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform2fvEXT", mrb_GL_glProgramUniform2fvEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform2iEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform2iEXT", mrb_GL_glProgramUniform2iEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform2ivEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform2ivEXT", mrb_GL_glProgramUniform2ivEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform3fEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform3fEXT", mrb_GL_glProgramUniform3fEXT, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform3fvEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform3fvEXT", mrb_GL_glProgramUniform3fvEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform3iEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform3iEXT", mrb_GL_glProgramUniform3iEXT, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform3ivEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform3ivEXT", mrb_GL_glProgramUniform3ivEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform4fEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform4fEXT", mrb_GL_glProgramUniform4fEXT, MRB_ARGS_REQ(6));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform4fvEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform4fvEXT", mrb_GL_glProgramUniform4fvEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform4iEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform4iEXT", mrb_GL_glProgramUniform4iEXT, MRB_ARGS_REQ(6));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniform4ivEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniform4ivEXT", mrb_GL_glProgramUniform4ivEXT, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniformMatrix2fvEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniformMatrix2fvEXT", mrb_GL_glProgramUniformMatrix2fvEXT, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniformMatrix3fvEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniformMatrix3fvEXT", mrb_GL_glProgramUniformMatrix3fvEXT, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glProgramUniformMatrix4fvEXT
  mrb_define_module_function(mrb, cur_rc, "glProgramUniformMatrix4fvEXT", mrb_GL_glProgramUniformMatrix4fvEXT, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glPushGroupMarkerEXT
  mrb_define_module_function(mrb, cur_rc, "glPushGroupMarkerEXT", mrb_GL_glPushGroupMarkerEXT, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glReadPixels
  mrb_define_module_function(mrb, cur_rc, "glReadPixels", mrb_GL_glReadPixels, MRB_ARGS_REQ(7));
#endif
#ifndef NO_USE_mrb_GL_glReleaseShaderCompiler
  mrb_define_module_function(mrb, cur_rc, "glReleaseShaderCompiler", mrb_GL_glReleaseShaderCompiler, MRB_ARGS_NONE());
#endif
#ifndef NO_USE_mrb_GL_glRenderbufferStorage
  mrb_define_module_function(mrb, cur_rc, "glRenderbufferStorage", mrb_GL_glRenderbufferStorage, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glRenderbufferStorageMultisampleAPPLE
  mrb_define_module_function(mrb, cur_rc, "glRenderbufferStorageMultisampleAPPLE", mrb_GL_glRenderbufferStorageMultisampleAPPLE, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glResolveMultisampleFramebufferAPPLE
  mrb_define_module_function(mrb, cur_rc, "glResolveMultisampleFramebufferAPPLE", mrb_GL_glResolveMultisampleFramebufferAPPLE, MRB_ARGS_NONE());
#endif
#ifndef NO_USE_mrb_GL_glSampleCoverage
  mrb_define_module_function(mrb, cur_rc, "glSampleCoverage", mrb_GL_glSampleCoverage, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glScissor
  mrb_define_module_function(mrb, cur_rc, "glScissor", mrb_GL_glScissor, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glShaderBinary
  mrb_define_module_function(mrb, cur_rc, "glShaderBinary", mrb_GL_glShaderBinary, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glShaderSource
  mrb_define_module_function(mrb, cur_rc, "glShaderSource", mrb_GL_glShaderSource, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glStencilFunc
  mrb_define_module_function(mrb, cur_rc, "glStencilFunc", mrb_GL_glStencilFunc, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glStencilFuncSeparate
  mrb_define_module_function(mrb, cur_rc, "glStencilFuncSeparate", mrb_GL_glStencilFuncSeparate, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glStencilMask
  mrb_define_module_function(mrb, cur_rc, "glStencilMask", mrb_GL_glStencilMask, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glStencilMaskSeparate
  mrb_define_module_function(mrb, cur_rc, "glStencilMaskSeparate", mrb_GL_glStencilMaskSeparate, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glStencilOp
  mrb_define_module_function(mrb, cur_rc, "glStencilOp", mrb_GL_glStencilOp, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glStencilOpSeparate
  mrb_define_module_function(mrb, cur_rc, "glStencilOpSeparate", mrb_GL_glStencilOpSeparate, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glTexImage2D
  mrb_define_module_function(mrb, cur_rc, "glTexImage2D", mrb_GL_glTexImage2D, MRB_ARGS_REQ(9));
#endif
#ifndef NO_USE_mrb_GL_glTexParameterf
  mrb_define_module_function(mrb, cur_rc, "glTexParameterf", mrb_GL_glTexParameterf, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glTexParameterfv
  mrb_define_module_function(mrb, cur_rc, "glTexParameterfv", mrb_GL_glTexParameterfv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glTexParameteri
  mrb_define_module_function(mrb, cur_rc, "glTexParameteri", mrb_GL_glTexParameteri, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glTexParameteriv
  mrb_define_module_function(mrb, cur_rc, "glTexParameteriv", mrb_GL_glTexParameteriv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glTexStorage2DEXT
  mrb_define_module_function(mrb, cur_rc, "glTexStorage2DEXT", mrb_GL_glTexStorage2DEXT, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glTexSubImage2D
  mrb_define_module_function(mrb, cur_rc, "glTexSubImage2D", mrb_GL_glTexSubImage2D, MRB_ARGS_REQ(9));
#endif
#ifndef NO_USE_mrb_GL_glUniform1f
  mrb_define_module_function(mrb, cur_rc, "glUniform1f", mrb_GL_glUniform1f, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glUniform1fv
  mrb_define_module_function(mrb, cur_rc, "glUniform1fv", mrb_GL_glUniform1fv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniform1i
  mrb_define_module_function(mrb, cur_rc, "glUniform1i", mrb_GL_glUniform1i, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glUniform1iv
  mrb_define_module_function(mrb, cur_rc, "glUniform1iv", mrb_GL_glUniform1iv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniform2f
  mrb_define_module_function(mrb, cur_rc, "glUniform2f", mrb_GL_glUniform2f, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniform2fv
  mrb_define_module_function(mrb, cur_rc, "glUniform2fv", mrb_GL_glUniform2fv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniform2i
  mrb_define_module_function(mrb, cur_rc, "glUniform2i", mrb_GL_glUniform2i, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniform2iv
  mrb_define_module_function(mrb, cur_rc, "glUniform2iv", mrb_GL_glUniform2iv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniform3f
  mrb_define_module_function(mrb, cur_rc, "glUniform3f", mrb_GL_glUniform3f, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glUniform3fv
  mrb_define_module_function(mrb, cur_rc, "glUniform3fv", mrb_GL_glUniform3fv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniform3i
  mrb_define_module_function(mrb, cur_rc, "glUniform3i", mrb_GL_glUniform3i, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glUniform3iv
  mrb_define_module_function(mrb, cur_rc, "glUniform3iv", mrb_GL_glUniform3iv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniform4f
  mrb_define_module_function(mrb, cur_rc, "glUniform4f", mrb_GL_glUniform4f, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glUniform4fv
  mrb_define_module_function(mrb, cur_rc, "glUniform4fv", mrb_GL_glUniform4fv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniform4i
  mrb_define_module_function(mrb, cur_rc, "glUniform4i", mrb_GL_glUniform4i, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glUniform4iv
  mrb_define_module_function(mrb, cur_rc, "glUniform4iv", mrb_GL_glUniform4iv, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glUniformMatrix2fv
  mrb_define_module_function(mrb, cur_rc, "glUniformMatrix2fv", mrb_GL_glUniformMatrix2fv, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glUniformMatrix3fv
  mrb_define_module_function(mrb, cur_rc, "glUniformMatrix3fv", mrb_GL_glUniformMatrix3fv, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glUniformMatrix4fv
  mrb_define_module_function(mrb, cur_rc, "glUniformMatrix4fv", mrb_GL_glUniformMatrix4fv, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glUnmapBufferOES
  mrb_define_module_function(mrb, cur_rc, "glUnmapBufferOES", mrb_GL_glUnmapBufferOES, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glUseProgram
  mrb_define_module_function(mrb, cur_rc, "glUseProgram", mrb_GL_glUseProgram, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glUseProgramStagesEXT
  mrb_define_module_function(mrb, cur_rc, "glUseProgramStagesEXT", mrb_GL_glUseProgramStagesEXT, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glValidateProgram
  mrb_define_module_function(mrb, cur_rc, "glValidateProgram", mrb_GL_glValidateProgram, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glValidateProgramPipelineEXT
  mrb_define_module_function(mrb, cur_rc, "glValidateProgramPipelineEXT", mrb_GL_glValidateProgramPipelineEXT, MRB_ARGS_REQ(1));
#endif
#ifndef NO_USE_mrb_GL_glVertexAttrib1f
  mrb_define_module_function(mrb, cur_rc, "glVertexAttrib1f", mrb_GL_glVertexAttrib1f, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glVertexAttrib1fv
  mrb_define_module_function(mrb, cur_rc, "glVertexAttrib1fv", mrb_GL_glVertexAttrib1fv, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glVertexAttrib2f
  mrb_define_module_function(mrb, cur_rc, "glVertexAttrib2f", mrb_GL_glVertexAttrib2f, MRB_ARGS_REQ(3));
#endif
#ifndef NO_USE_mrb_GL_glVertexAttrib2fv
  mrb_define_module_function(mrb, cur_rc, "glVertexAttrib2fv", mrb_GL_glVertexAttrib2fv, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glVertexAttrib3f
  mrb_define_module_function(mrb, cur_rc, "glVertexAttrib3f", mrb_GL_glVertexAttrib3f, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glVertexAttrib3fv
  mrb_define_module_function(mrb, cur_rc, "glVertexAttrib3fv", mrb_GL_glVertexAttrib3fv, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glVertexAttrib4f
  mrb_define_module_function(mrb, cur_rc, "glVertexAttrib4f", mrb_GL_glVertexAttrib4f, MRB_ARGS_REQ(5));
#endif
#ifndef NO_USE_mrb_GL_glVertexAttrib4fv
  mrb_define_module_function(mrb, cur_rc, "glVertexAttrib4fv", mrb_GL_glVertexAttrib4fv, MRB_ARGS_REQ(2));
#endif
#ifndef NO_USE_mrb_GL_glVertexAttribPointer
  mrb_define_module_function(mrb, cur_rc, "glVertexAttribPointer", mrb_GL_glVertexAttribPointer, MRB_ARGS_REQ(6));
#endif
#ifndef NO_USE_mrb_GL_glViewport
  mrb_define_module_function(mrb, cur_rc, "glViewport", mrb_GL_glViewport, MRB_ARGS_REQ(4));
#endif
#ifndef NO_USE_mrb_GL_glWaitSyncAPPLE
  mrb_define_module_function(mrb, cur_rc, "glWaitSyncAPPLE", mrb_GL_glWaitSyncAPPLE, MRB_ARGS_REQ(3));
#endif
  DONE;
}
