#include <map>
#include <string>
#include "ccMacros.h"
#include "platform/CCCommon.h"
#include "actions/CCActionInstant.h"
#include "mruby_helper.h"

#include "cocos2d_bridge.h"
#include "extension_bridge.h"

static std::map<std::string, struct RClass *> _class_map;
static std::map<unsigned int, struct RObject *>_ccobj_id_robj_map;
static std::map<const char *, struct RClass *>_cxx_type_mrb_class_map;

static int s_script_handle_refid = 0;

void cc_mrb_helper_init(mrb_state *mrb)
{
    mrb_value hash = mrb_gv_get(mrb, mrb_intern_cstr(mrb, "$G_"));
    if (!mrb_hash_p(hash)) {
        hash = mrb_hash_new(mrb);
        mrb_gv_set(mrb, mrb_intern_cstr(mrb, "$G_"), hash);
    }

    hash = mrb_gv_get(mrb, mrb_intern_cstr(mrb, "$G_SCRIPT_HANDLE_ID_PROC"));
    if (!mrb_hash_p(hash)) {
        hash = mrb_hash_new(mrb);
        mrb_gv_set(mrb, mrb_intern_cstr(mrb, "$G_SCRIPT_HANDLE_ID_PROC"), hash);
    }

    _class_map.clear();
    _ccobj_id_robj_map.clear();
    _cxx_type_mrb_class_map.clear();
    s_script_handle_refid = 0;

    cc_mrb_class_register(mrb, mrb->object_class, "");
}

void cc_mrb_cxx_type_mrb_class_map_register(mrb_state *mrb, const char *type_name, struct RClass* rc)
{
    _cxx_type_mrb_class_map[type_name] = rc;
}

struct RClass *
cc_mrb_class_get_by_cxx_class(mrb_state *mrb, cocos2d::CCObject *obj)
{
    const char *type_name = typeid(*obj).name();
    static std::map<const char *, struct RClass *>::const_iterator itr;
    itr = _cxx_type_mrb_class_map.find(type_name);
    if (itr == _cxx_type_mrb_class_map.end()) {
        return NULL;
    }
    return itr->second;
}


void cc_mrb_class_register(mrb_state *mrb, RClass *klass, const char *name)
{
    _class_map[name] = klass;
}

RClass *cc_mrb_class_get(mrb_state *mrb, const char *name)
{
    std::string nm(name);
    static std::map<std::string, struct RClass *>::const_iterator itr;
    itr = _class_map.find(nm);
    if (itr == _class_map.end()) {
        return NULL;
    }
    return itr->second;
}

int
cc_mrb_class_defined(mrb_state *mrb, const char *name)
{
    if (mrb_class_defined(mrb, name)) {
        return 1;
    }
    return cc_mrb_class_get(mrb, name) != NULL;
}

int
cc_mrb_proc_keep(mrb_state *mrb, mrb_value& proc)
{
    mrb_value hash = mrb_gv_get(mrb, mrb_intern_cstr(mrb, "$G_SCRIPT_HANDLE_ID_PROC"));
    mrb_value key = mrb_fixnum_value(++s_script_handle_refid);
    mrb_hash_set(mrb, hash, key, proc);
    return s_script_handle_refid;
}

void
cc_mrb_proc_remove(mrb_state *mrb, int refid)
{
    mrb_value hash = mrb_gv_get(mrb, mrb_intern_cstr(mrb, "$G_SCRIPT_HANDLE_ID_PROC"));
    mrb_value key = mrb_fixnum_value(refid);
    mrb_hash_delete_key(mrb, hash, key);
}

mrb_value
cc_mrb_proc_retrieve(mrb_state *mrb, int refid)
{
    mrb_value hash = mrb_gv_get(mrb, mrb_intern_cstr(mrb, "$G_SCRIPT_HANDLE_ID_PROC"));
    mrb_value key = mrb_fixnum_value(refid);
    return mrb_hash_get(mrb, hash, key);
}

static inline mrb_value
live_value_retrieve(mrb_state *mrb, cocos2d::CCObject *obj)
{
    return cc_mrb_live_value_find_by_id(mrb, obj->m_uID);
}

mrb_value cc_mrb_live_value_find_by_id(mrb_state *mrb, unsigned int uID)
{
    static std::map<unsigned int, struct RObject *>::const_iterator itr;
    itr = _ccobj_id_robj_map.find(uID);
    if (itr == _ccobj_id_robj_map.end()) {
        return mrb_nil_value();
    }
    return mrb_obj_value(itr->second);
}



void cc_mrb_dump_live_value(mrb_state *mrb)
{
    cocos2d::CCLog("live_value:count=%lu",  _ccobj_id_robj_map.size());
#if 0
    int gc_disabled = mrb->gc_disabled;
    mrb->gc_disabled = TRUE;

    int i = 0;
    std::map<unsigned int, struct RObject *>::iterator it;
    for (i = 0, it = _ccobj_id_robj_map.begin();
         it != _ccobj_id_robj_map.end();
         ++it, i += 1) {
        if (is_dead(mrb, it->second)) {
            continue;
        }
        mrb_int ai = mrb_gc_arena_save(mrb);
        if (ai >= MRB_ARENA_SIZE - 4) {
            mrb_gc_arena_restore(mrb, ai);
            cocos2d::CCLog("...");
            break;
        }
        mrb_value obj = mrb_obj_value(it->second);
        mrb_value s = mrb_funcall(mrb, obj, "to_s", 0);
        mrb_int rcnt = -1;
        if (mrb_bool(mrb_funcall(mrb, obj, "respond_to?", 1, mrb_symbol_value(mrb_intern_cstr(mrb, "retainCount"))))) {
            mrb_value retain_count = mrb_funcall(mrb, obj, "retainCount", 0);
            rcnt = mrb_fixnum(retain_count);
        }
        mrb_gc_arena_restore(mrb, ai);
        cocos2d::CCLog("%d:%u:%s:%d", i, it->first, mrb_str_to_cstr(mrb, s), rcnt);
	}
    mrb->gc_disabled = gc_disabled;

    cocos2d::CCLog("live_value:count=%lu",  _ccobj_id_robj_map.size());
#endif
}

void
cc_mrb_value_register(mrb_state *mrb, cocos2d::CCObject *obj, mrb_value& value)
{
    _ccobj_id_robj_map[obj->m_uID] = mrb_obj_ptr(value);
}

mrb_value
cc_mrb_value_retrieve(mrb_state *mrb, cocos2d::CCObject *obj)
{
    //cocos2d::CCLog("%s:%d:%u", __FUNCTION__, __LINE__, obj->m_uID);
    mrb_value hash = mrb_gv_get(mrb, mrb_intern_cstr(mrb, "$G_"));
    mrb_value key = mrb_fixnum_value(obj->m_uID);
    mrb_value res = live_value_retrieve(mrb, obj);
    if (!mrb_nil_p(res)) {
        //cocos2d::CCLog("%s:%d:%u", __FUNCTION__, __LINE__, obj->m_uID);
        //static_cast< cocos2d::CCObject * >(DATA_PTR(res))->retain();
        mrb_hash_delete_key(mrb, hash, key);
        return res;
    }

    res = mrb_hash_delete_key(mrb, hash, key);
    if (!mrb_nil_p(res)) {
        //cocos2d::CCLog("%s:%d:%u", __FUNCTION__, __LINE__, obj->m_uID);
        void *p = DATA_PTR(res);
        if (!p) {
            cocos2d::CCLog("%s:%d:%u:panic!", __FUNCTION__, __LINE__, obj->m_uID);
        } else {
            static_cast< cocos2d::CCObject * >(p)->release();
        }
        obj->retain();
        DATA_PTR(res) = obj;
        cc_mrb_value_register(mrb, obj, res);
    }
    return res;
}

void
cc_mrb_live_value_remove(mrb_state *mrb, cocos2d::CCObject *obj)
{
    //cocos2d::CCLog("%s:%d:%u", __FUNCTION__, __LINE__, obj->m_uID);
    mrb_value live_obj = live_value_retrieve(mrb, obj);
    if (mrb_nil_p(live_obj)) {
        /* it's not created by bridge. */
        return;
    }

    int gc_disabled = mrb->gc_disabled;
    mrb->gc_disabled = TRUE;

    int arena_idx = mrb_gc_arena_save(mrb);
    mrb_value clone = mrb_obj_clone(mrb, live_obj);
    DATA_TYPE(clone) = DATA_TYPE(live_obj);
    //cocos2d::CCLog("%s:%d:%u:rc=%u", __FUNCTION__, __LINE__, obj->m_uID, obj->retainCount());
    //obj->retain(); //XXX: do not call retain().
    mrb_gc_arena_restore(mrb, arena_idx);
    cc_mrb_value_keep(mrb, obj, clone);

    mrb->gc_disabled = gc_disabled;
    _ccobj_id_robj_map.erase(obj->m_uID);
}

void
cc_mrb_value_remove(mrb_state *mrb, cocos2d::CCObject *obj)
{
    //cocos2d::CCLog("%s:%d:%u", __FUNCTION__, __LINE__, obj->m_uID);
    _ccobj_id_robj_map.erase(obj->m_uID);
    mrb_value hash = mrb_gv_get(mrb, mrb_intern_cstr(mrb, "$G_"));
    mrb_value key = mrb_fixnum_value(obj->m_uID);
    mrb_hash_delete_key(mrb, hash, key);
}

void cc_mrb_value_keep(mrb_state *mrb, cocos2d::CCObject *obj, mrb_value& value)
{
    //cocos2d::CCLog("%s:%d:%u", __FUNCTION__, __LINE__, obj->m_uID);
    DATA_PTR(value) = new cocos2d::CCObject(); //XXX: dummy object.
    mrb_value hash = mrb_gv_get(mrb, mrb_intern_cstr(mrb, "$G_"));
    mrb_value key = mrb_fixnum_value(obj->m_uID);
    mrb_hash_set(mrb, hash, key, value);
}

void *
cc_mrb_data_get_ptr(mrb_state *mrb, mrb_value obj,
                    const mrb_data_type *type0, const mrb_data_type *type1)
{
#if 0
    const mrb_data_type *types[] = {type0, type1};
    for (int i = 0; i < sizeof(types) / sizeof(mrb_data_type *); ++i) {
        if (!types[i]) {
            continue;
        }
        void *p = mrb_data_get_ptr(mrb, obj, types[i]);
        if (p) {
            return p;
        }
    }
    return NULL;
#else
  if (mrb_special_const_p(obj) || (mrb_type(obj) != MRB_TT_DATA)) {
    return NULL;
  }
  //if (DATA_TYPE(obj) != type) {
  //  return NULL;
  //}
  return DATA_PTR(obj);
#endif
}

mrb_value cc_mrb_value_from(mrb_state *mrb, cocos2d::CCPoint& v)
{
    struct RClass *rc = cc_mrb_class_get(mrb, "Cocos2d::CCPoint");
    CCAssert(rc, "");
    cocos2d::CCPoint *pos = new cocos2d::CCPoint();
    *pos = v;
    mrb_value mrb_res = mrb_obj_value(Data_Wrap_Struct(mrb, rc, &mrb_type_cocos2d_CCPoint, pos));
    return mrb_res;
}

mrb_value cc_mrb_value_from(mrb_state *mrb, cocos2d::CCPoint *v)
{
    struct RClass *rc = cc_mrb_class_get(mrb, "Cocos2d::CCPoint");
    CCAssert(rc, "");
    cocos2d::CCPoint *pos = new cocos2d::CCPoint();
    *pos = *v;
    mrb_value mrb_res = mrb_obj_value(Data_Wrap_Struct(mrb, rc, &mrb_type_cocos2d_CCPoint, pos));
    return mrb_res;
}

#ifndef MRUBY_NO_EXTENSION_BRIDGE
mrb_value cc_mrb_value_from(mrb_state *mrb, cocos2d::extension::AnimationState *v)
{
    struct RClass *rc = cc_mrb_class_get(mrb, "Cocos2d::Extension::CC_AnimationState");
    CCAssert(rc, "");
    cocos2d::extension::AnimationState *res = new cocos2d::extension::AnimationState();
    *res = *v;
    mrb_value mrb_res = mrb_obj_value(Data_Wrap_Struct(mrb, rc, &mrb_type_cocos2d_extension__AnimationState, res));
    return mrb_res;
    
}
#endif /* !MRUBY_NO_EXTENSION_BRIDGE */
