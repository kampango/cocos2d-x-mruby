#ifndef __MRUBY_HELPER_H__
#define __MRUBY_HELPER_H__

#include <assert.h>
#include "mruby.h"
#include "mruby/array.h"
#include "mruby/data.h"
#include "mruby/hash.h"
#include "mruby/variable.h"
#include "mruby/string.h"
#include "cocoa/CCObject.h"
#include "cocoa/CCGeometry.h"

#ifndef MRUBY_NO_EXTENSION_BRIDGE
#include "spine/AnimationState.h"
#endif

void cc_mrb_cxx_type_mrb_class_map_register(mrb_state *mrb, const char *type_name, struct RClass *rc);
struct RClass *cc_mrb_class_get_by_cxx_class(mrb_state *mrb, cocos2d::CCObject *obj);

#define CC_MRB_CXX_CLASS_MRB_CLASS_MAP_REGISTER(mrb, CLASS, rc) \
  cc_mrb_cxx_type_mrb_class_map_register(mrb, typeid(CLASS).name(), rc)

void cc_mrb_helper_init(mrb_state *mrb);
void cc_mrb_class_register(mrb_state *mrb, RClass *klass, const char *name);
RClass *cc_mrb_class_get(mrb_state *mrb, const char *name);
int cc_mrb_class_defined(mrb_state *mrb, const char *name);

int cc_mrb_proc_keep(mrb_state *mrb, mrb_value& proc);
void cc_mrb_proc_remove(mrb_state *mrb, int refid);
mrb_value cc_mrb_proc_retrieve(mrb_state *mrb, int refid);

mrb_value cc_mrb_live_value_find_by_id(mrb_state *mrb, unsigned int uID);

void cc_mrb_value_register(mrb_state *mrb, cocos2d::CCObject *obj, mrb_value& value);
mrb_value cc_mrb_value_retrieve(mrb_state *mrb, cocos2d::CCObject *obj);
void cc_mrb_live_value_remove(mrb_state *mrb, cocos2d::CCObject *obj);
void cc_mrb_value_remove(mrb_state *mrb, cocos2d::CCObject *obj);
void cc_mrb_value_keep(mrb_state *mrb, cocos2d::CCObject *obj, mrb_value& value);

void *cc_mrb_data_get_ptr(mrb_state *mrb, mrb_value obj,
                          const mrb_data_type *type0, const mrb_data_type *type1);

void cc_mrb_dump_live_value(mrb_state *mrb);

static inline mrb_value cc_mrb_value_from(mrb_state *mrb, unsigned long v) { return mrb_fixnum_value(v); }
static inline mrb_value cc_mrb_value_from(mrb_state *mrb, unsigned short v) { return mrb_fixnum_value(v); }
static inline mrb_value cc_mrb_value_from(mrb_state *mrb, unsigned int v) { return mrb_fixnum_value(v); }
static inline mrb_value cc_mrb_value_from(mrb_state *mrb, unsigned char v) { return mrb_fixnum_value(v); }

static inline mrb_value cc_mrb_value_from(mrb_state *mrb, long v) { return mrb_fixnum_value(v); }
static inline mrb_value cc_mrb_value_from(mrb_state *mrb, short v) { return mrb_fixnum_value(v); }
static inline mrb_value cc_mrb_value_from(mrb_state *mrb, int v) { return mrb_fixnum_value(v); }
static inline mrb_value cc_mrb_value_from(mrb_state *mrb, char v) { return mrb_fixnum_value(v); }

static inline mrb_value cc_mrb_value_from(mrb_state *mrb, float v) { return mrb_float_value(mrb, v); }
static inline mrb_value cc_mrb_value_from(mrb_state *mrb, double v) { return mrb_float_value(mrb, v); }

static inline mrb_value
cc_mrb_value_from(mrb_state *mrb, const char *cstr) { return mrb_str_new_cstr(mrb, cstr); }

static inline mrb_value
cc_mrb_value_from(mrb_state *mrb, const std::string &s) { return mrb_str_new_cstr(mrb, s.c_str()); }

#if 0
static inline mrb_value
cc_mrb_value_from(mrb_state *mrb, CCObject *obj)
{
    struct cc_mrb_class_info info = cc_mrb_class_info_get(obj->getClassTypeId());
    return mrb_obj_value(Data_Wrap_struct(mrb, info->mrb_class_name, info->mrb_data_type, obj));
}
#endif

// TODO:
mrb_value cc_mrb_value_from(mrb_state *mrb, cocos2d::CCPoint& v);
mrb_value cc_mrb_value_from(mrb_state *mrb, cocos2d::CCPoint *v);

#ifndef MRUBY_NO_EXTENSION_BRIDGE
mrb_value cc_mrb_value_from(mrb_state *mrb, cocos2d::extension::AnimationState *v);
#endif

template<typename T>
static inline T cc_mrb_value_to(mrb_state *mrb, mrb_value& v)
{
#if 1
    assert(0);
    T res;
    return res;
#else
    assert(mrb_fixnum_p(v));
    T res = static_cast<T>(mrb_fixnum(v));
    return res;
#endif
}

template<>
inline unsigned char
cc_mrb_value_to(mrb_state *mrb, mrb_value& v)
{
    assert(mrb_fixnum_p(v));
    unsigned char res = mrb_fixnum(v);
    return res;
}

template<>
inline int
cc_mrb_value_to(mrb_state *mrb, mrb_value& v)
{
    assert(mrb_fixnum_p(v));
    unsigned char res = mrb_fixnum(v);
    return res;
}

template<>
inline float
cc_mrb_value_to(mrb_state *mrb, mrb_value& v)
{
    assert(mrb_float_p(v) || mrb_fixnum_p(v));
    float res;
    if (mrb_fixnum_p(v)) {
        res = (float)mrb_fixnum(v);
    } else {
        res = mrb_float(v);
    }
    return res;
}

template<>
inline std::string
cc_mrb_value_to(mrb_state *mrb, mrb_value& v)
{
    std::string s;
    if (mrb_string_p(v)) {
        s = std::string(RSTRING_PTR(v));
    }
    return s;
}

template<>
inline const char *
cc_mrb_value_to(mrb_state *mrb, mrb_value& v)
{
    const char *c = NULL;
    if (mrb_string_p(v)) {
        c = RSTRING_PTR(v);
    }
    return c;
}

template<>
inline cocos2d::CCPoint
cc_mrb_value_to(mrb_state *mrb, mrb_value& v)
{
    cocos2d::CCPoint res = *(static_cast< cocos2d::CCPoint * >(DATA_PTR(v)));
    return res;
}

template<typename T>
static inline T&
cc_mrb_ary_conv_to(mrb_state *mrb, mrb_value& ary, T& cpp_arr)
{
    cpp_arr.clear();
    struct RArray *a = mrb_ary_ptr(ary);
    for (int i = 0; i < a->len; ++i) {
        mrb_value v = mrb_ary_ref(mrb, ary, i);
        typename T::value_type elem
            = cc_mrb_value_to< typename T::value_type >(mrb, v);

        cpp_arr.insert(cpp_arr.end(), elem);
    }
    return cpp_arr;
}

template<typename T>
static inline T *
cc_mrb_ary_conv_to(mrb_state *mrb, mrb_value& ary, T *cpp_arr)
{
    cpp_arr->clear();
    struct RArray *a = mrb_ary_ptr(ary);
    for (int i = 0; i < a->len; ++i) {
        mrb_value v = mrb_ary_ref(mrb, ary, i);
        typename T::value_type elem
            = cc_mrb_value_to< typename T::value_type >(mrb, v);

        cpp_arr->insert(cpp_arr->end(), elem);
    }
    return cpp_arr;
}

template<typename T>
static inline mrb_value
cc_mrb_ary_conv_from(mrb_state *mrb, mrb_value ary, T& cpp_ary)
{
    assert(mrb_array_p(ary));
    //mrb_value ary = mrb_ary_new_capa(mrb, cpp_ary.size());
    int i = 0;
    for (typename T::const_iterator it = cpp_ary.begin();
         it != cpp_ary.end();
         ++i, ++it) {
        mrb_ary_set(mrb, ary, i, cc_mrb_value_from(mrb, *it));
    }
    return ary;
}

template<typename T>
static inline mrb_value
cc_mrb_ary_conv_from(mrb_state *mrb, mrb_value ary, T *cpp_ary)
{
    assert(mrb_array_p(ary));
    //mrb_value ary = mrb_ary_new_capa(mrb, cpp_ary->size());
    int i = 0;
    for (typename T::const_iterator it = cpp_ary->begin();
         it != cpp_ary->end();
         ++i, ++it) {
        mrb_ary_set(mrb, ary, i, cc_mrb_value_from(mrb, *it));
    }
    return ary;
}

template<typename T>
static inline T *
cc_mrb_ary_conv_to_c_array(mrb_state *mrb, mrb_value& ary, T *c_array, size_t len)
{
    memset(c_array, 0, len * sizeof(T));
    struct RArray *a = mrb_ary_ptr(ary);
    for (int i = 0; i < a->len && i < len; ++i) {
        mrb_value v = mrb_ary_ref(mrb, ary, i);
        T elem = cc_mrb_value_to< T >(mrb, v);
        c_array[i] = elem;
    }
    return c_array;
}

template<typename T>
static inline mrb_value
cc_mrb_ary_conv_from_c_array(mrb_state *mrb, mrb_value ary, T *c_array, size_t len)
{
    assert(mrb_array_p(ary));
    //mrb_value ary = mrb_ary_new_capa(mrb, len);
    for (int i = 0; i < len; ++i) {
        mrb_ary_set(mrb, ary, i, cc_mrb_value_from(mrb, c_array[i]));
    }
    return ary;
}

#endif /* __MRUBY_HELPER_H__ */
