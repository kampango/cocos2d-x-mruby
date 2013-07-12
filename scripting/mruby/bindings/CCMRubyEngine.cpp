//
//  CCMRubyEngine.cpp
//  
//
//  Created by
//  Copyright (c) 2013
//

#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <vector>
#include <map>

#include "CCMRubyEngine.h"
#include "mruby.h"
#include "mruby/array.h"
#include "mruby/class.h"
#include "mruby/compile.h"
#include "mruby/data.h"
#include "mruby/hash.h"
#include "mruby/proc.h"
#include "mruby/string.h"
#include "mruby/value.h"
#include "mruby/variable.h"

#include "mruby_helper.h"
#include "cocos2d_bridge.h"
#include "cocos_denshion_bridge.h"

#ifndef MRUBY_NO_KAZMATH_BRIDGE
#include "kazmath_bridge.h"
#endif

#ifndef MRUBY_NO_EXTENSION_BRIDGE
#include "extension_bridge.h"
#include "zip_utils_bridge.h"

#include "gl_bridge.h"
#include "GLNode.h"
#include "gl_node_bridge.h"

#include "GUI/CCControlExtension/CCControl.h"
#endif

#include "AppDelegate.h"

// for debug socket
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#include <io.h>
#include <WS2tcpip.h>
#else
#include <sys/socket.h>
#include <unistd.h>
#include <netdb.h>
#endif
#include <pthread.h>

#ifdef ANDROID
#include <android/log.h>
#include <jni/JniHelper.h>
#include <netinet/in.h>
#endif

#ifdef ANDROID
#define  LOG_TAG    "CCMRubyEngine.cpp"
#define  LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
#else
#define  LOGD(...) mruby_log(__VA_ARGS__)
#endif

#if DEBUG
#define TRACE_DEBUGGER_SERVER(...) CCLOG(__VA_ARGS__)
#else
#define TRACE_DEBUGGER_SERVER(...)
#endif // #if DEBUG

#define BYTE_CODE_FILE_EXT ".mrb"

NS_CC_BEGIN

#ifndef MRUBY_NO_EXTENSION_BRIDGE
USING_NS_CC_EXT;
#endif

//using namespace std;

char *_log_buf = NULL;

void _log(const char *format, ...) {
    if (_log_buf == NULL) {
        _log_buf = (char *)calloc(sizeof(char), kMaxLogLen+1);
    }
    va_list vl;
    va_start(vl, format);
    int len = vsnprintf(_log_buf, kMaxLogLen, format, vl);
    va_end(vl);
    if (len) {
        CCLOG("MRUBY: %s\n", _log_buf);
    }
}

static mrb_value
mrb_cc_platform(mrb_state *mrb, mrb_value)
{
    mrb_value *argv;
    int argc;
    mrb_get_args(mrb, "*", &argv, &argc);
    if (argc != 0) {
        mrb_raise(mrb, E_ARGUMENT_ERROR, "Invalid number of arguments");
    }

    mrb_value platform;

    // config.deviceType: Device Type
    // 'mobile' for any kind of mobile devices, 'desktop' for PCs, 'browser' for Web Browsers
    // #if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32) || (CC_TARGET_PLATFORM == CC_PLATFORM_LINUX) || (CC_TARGET_PLATFORM == CC_PLATFORM_MAC)
    //     platform = mrb_str_new_cstr(mrb, "desktop");
    // #else
    platform = mrb_str_new_cstr(mrb, "mobile");
    // #endif

    return platform;
}

static mrb_value
mrb_cc_version(mrb_state *mrb, mrb_value)
{
    mrb_value *argv;
    int argc;
    mrb_get_args(mrb, "*", &argv, &argc);
    if (argc != 0) {
        mrb_raise(mrb, E_ARGUMENT_ERROR, "Invalid number of arguments");
    }

    char version[256];
    // FIXME: how do I get the mruby version?
    snprintf(version, sizeof(version)-1, "%s - %s", cocos2dVersion(), "unknown");
    return mrb_str_new_cstr(mrb, version);
}

static mrb_value
mrb_cc_os(mrb_state *mrb, mrb_value)
{
    mrb_value *argv;
    int argc;
    mrb_get_args(mrb, "*", &argv, &argc);
    if (argc != 0) {
        mrb_raise(mrb, E_ARGUMENT_ERROR, "Invalid number of arguments");
    }

    const char *os;

    // osx, ios, android, windows, linux, etc..
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    os = "ios";
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
    os = "android";
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
    os = "windows";
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_MARMALADE)
    os = "marmalade";
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_LINUX)
    os = "linux";
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_BADA)
    os = "bada";
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_BLACKBERRY)
    os = "blackberry";
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_MAC)
    os = "osx";
#else
    os = "unknown";
#endif

    return mrb_str_new_cstr(mrb, os);
}

static mrb_value
mrb_cc_dump_live_value(mrb_state *mrb, mrb_value)
{
    cc_mrb_dump_live_value(mrb);
    return mrb_nil_value();
}

static mrb_value
mrb_cc_ccobject_find_by_id(mrb_state *mrb, mrb_value)
{
    mrb_int ccobj_id = 0;
    mrb_get_args(mrb, "i", &ccobj_id);
    return cc_mrb_live_value_find_by_id(mrb, ccobj_id);
}

static
void registerDefaultClasses(mrb_state *mrb)
{
    struct RClass *mod_cc = mrb_define_module(mrb, "CC");
    mrb_define_module_function(mrb, mod_cc, "os", mrb_cc_os, MRB_ARGS_NONE());
    mrb_define_module_function(mrb, mod_cc, "version", mrb_cc_version, MRB_ARGS_NONE());
    mrb_define_module_function(mrb, mod_cc, "platform", mrb_cc_platform, MRB_ARGS_NONE());
    mrb_define_module_function(mrb, mod_cc, "dump_live_value", mrb_cc_dump_live_value, MRB_ARGS_NONE());

    mrb_define_module_function(mrb, mod_cc, "ccobject_find_by_id", mrb_cc_ccobject_find_by_id, MRB_ARGS_REQ(1));
    
    mrb_init_cocos2d(mrb);
    CC_MRB_CXX_CLASS_MRB_CLASS_MAP_REGISTER(mrb, AppDelegate,
        cc_mrb_class_get(mrb, "Cocos2d::CCApplication"));

    mrb_init_CocosDenshion(mrb);
#ifndef MRUBY_NO_KAZMATH_BRIDGE
    mrb_init_Kazmath(mrb);
#endif
#ifndef MRUBY_NO_EXTENSION_BRIDGE
    mrb_init_cocos2d_extension(mrb);
    mrb_init_cocos2d_ZipUtils(mrb);

    mrb_init_GL(mrb);
    mrb_init_cocos2d_GLNode(mrb);
#endif
}

CCMRubyEngine::CCMRubyEngine()
: mrb_(NULL)
{
    //this->addRegisterCallback(registerDefaultClasses);
    //this->runLoop = new SimpleRunLoop();
    start();
}

void CCMRubyEngine::start() {
    // for now just this
    //this->createGlobalContext();

    if (!mrb_) {
        mrb_ = mrb_open();
        CCAssert(mrb_, "");

        cc_mrb_helper_init(mrb_);
        mrb_value hash = mrb_gv_get(mrb_, mrb_intern_cstr(mrb_, "G_"));
        if (!mrb_hash_p(hash)) {
            hash = mrb_hash_new(mrb_);
            mrb_gv_set(mrb_, mrb_intern_cstr(mrb_, "G_"), hash);
        }

        mrb_value val;
        mrb_sym sym = mrb_intern2(mrb_, "$LOAD_PATH", 10);
        mrb_value load_path = mrb_gv_get(mrb_, sym);
        if (!mrb_array_p(load_path)) {
            load_path = mrb_ary_new(mrb_);
            val = mrb_str_new_cstr(mrb_, ".");
            mrb_ary_push(mrb_, load_path, val);
        }

        const std::vector<std::string>& searchPaths = CCFileUtils::sharedFileUtils()->getSearchPaths();
        for (std::vector<std::string>::const_iterator s_path = searchPaths.begin();
             s_path != searchPaths.end();
             ++s_path) {
            std::string path = *s_path;
            if (path.length() > 0 && path[path.length() - 1] == '/') {
                // needs this?
                path = path.substr(0, path.size() - 1);
            }
            val = mrb_str_new_cstr(mrb_, path.c_str());
            mrb_ary_push(mrb_, load_path, val);
        }
        mrb_gv_set(mrb_, sym, load_path);

        registerDefaultClasses(mrb_);
        mrb_gc_arena_restore(mrb_, 0);
    }
}

static std::string RemoveFileExt(const std::string& filePath) {
    size_t pos = filePath.rfind('.');
    if (0 < pos) {
        return filePath.substr(0, pos);
    }
    else {
        return filePath;
    }
}

void CCMRubyEngine::reset()
{
    cleanup();
    start();
}

CCMRubyEngine::~CCMRubyEngine()
{
    cleanup();
}

void CCMRubyEngine::cleanup()
{
    if (mrb_) {
        mrb_close(mrb_);
        mrb_ = NULL;
    }
    if (_log_buf) {
        free(_log_buf);
        _log_buf = NULL;
    }
}


static const char *
_mrb_value_to_cstr(mrb_state *mrb, mrb_value obj)
{
    mrb_value str = mrb_funcall(mrb, obj, "inspect", 0);
    if (!mrb_string_p(str)) {
        return NULL;
    }
    struct RString *rs = mrb_str_ptr(str);
    const char *res = const_cast<const char *>(rs->ptr);
    return res;
}

#if 0
#define LOG_MRB_V(mrb, obj) do { \
    const char *cstr = _mrb_value_to_cstr(mrb, obj); \
    _log("%s:%d:%s:", __FUNCTION__, __LINE__, cstr ? cstr : "(NULL)");   \
} while (0)
#else
#define LOG_MRB_V(mrb, obj)
#endif

#if 0
static mrb_value
CCMRubyEngine::log(mrb_state *mrb, mrb_value obj)
{
    mrb_value str;
    str = mrb_f_sprintf(mrb, obj);
    if (mrb_string_p(str)) {
        struct RString *rs = mrb_str_ptr(str);
        const char *msg = const_cast<const char *>(rs->ptr);
        _log(msg);
    }
    return mrb_nil_value();
}
#endif

void CCMRubyEngine::removeScriptObjectByCCObject(CCObject* pObj)
{
    //_log("%s:%p:%u", __FUNCTION__, pObj, pObj->m_uID);
    cc_mrb_value_remove(mrb_, pObj);
}

void CCMRubyEngine::removeScriptHandler(int nHandler)
{
    cc_mrb_proc_remove(mrb_, nHandler);
}


int CCMRubyEngine::reallocateScriptHandler(int nHandler)
{
    mrb_value proc = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_nil_p(proc)) {
        return -1;
    }
    return cc_mrb_proc_keep(mrb_, proc);
}

int CCMRubyEngine::executeScriptFile(const char* fullPath)
{
    if (!fullPath) {
        return -1;
    }

    FILE *fp = fopen(fullPath, "r");
    if (fp == NULL) {
        return -1;
    }

    mrbc_context *c = mrbc_context_new(mrb_);

    mrbc_filename(mrb_, c, fullPath);
    mrb_value v = mrb_load_file_cxt(mrb_, fp, c);

    mrbc_context_free(mrb_, c);
    if (mrb_->exc) {
        if (!mrb_undef_p(v)) {
            //mrb_print_backtrace(mrb_);
            mrb_print_error(mrb_);
        }
        return -1;
    }

    return 0;
}


int CCMRubyEngine::executeNodeEvent(CCNode* pNode, int nAction)
{
    int res = 0;

    mrb_value node = cc_mrb_value_retrieve(mrb_, pNode);
    if (!mrb_nil_p(node)) {
        mrb_sym mid;
        int respond = 0;

        int num_names = 2;
        const char *names[num_names];

        switch (nAction) {
        case kCCNodeOnEnter:
            names[0] = "on_enter";
            names[1] = "onEnter";
            break;
        case kCCNodeOnExit:
            names[0] = "on_exit";
            names[1] = "onExit";
            break;
        case kCCNodeOnEnterTransitionDidFinish:
            names[0] = "on_enter_transition_did_finish";
            names[1] = "onEnterTransitionDidFinish";
            break;
        case kCCNodeOnExitTransitionDidStart:
            names[0] = "on_exit_transition_did_start";
            names[1] = "onExitTransitionDidStart";
            break;
        case kCCNodeOnCleanup:
            names[0] = "on_cleanup";
            names[1] = "onCleanup";
            break;
        default:
            num_names = 0;
            respond = 0;
        }

        struct RClass *c = mrb_class(mrb_, node);
        for (int i = 0; i < num_names; ++i) {
            mid = mrb_intern_cstr(mrb_, names[i]);
            struct RProc *p = mrb_method_search_vm(mrb_, &c, mid);
            if (p && !MRB_PROC_CFUNC_P(p)) {
                respond = 1;
                break;
            }
        }

        if (respond) {
            int err = 0;
            int arena_idx = mrb_gc_arena_save(mrb_);
            mrb_funcall_argv(mrb_, node, mid, 0, NULL);
            mrb_gc_arena_restore(mrb_, arena_idx);

            if (mrb_->exc) {
                mrb_print_error(mrb_);
                mrb_->exc = 0;
                err = 1;
            }

            if (err) {
                return 0;
            }
        }
    }

    int nHandler = pNode->getScriptHandler();
    if (nHandler) {
        int arena_idx = mrb_gc_arena_save(mrb_);
        mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
        if (mrb_type(handle) != MRB_TT_PROC) {
            _log("nHandler:%d is not Proc", nHandler);
            mrb_gc_arena_restore(mrb_, arena_idx);

        } else if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
            _log("nHandler:%d is broken", nHandler);
            mrb_gc_arena_restore(mrb_, arena_idx);
        } else {
            LOG_MRB_V(mrb_, handle);
            mrb_value tag = mrb_fixnum_value(nAction);
            mrb_value ret = mrb_funcall(mrb_, handle, "call", 1, tag);
            res = mrb_bool(ret);
        }

        mrb_gc_arena_restore(mrb_, arena_idx);

        if (mrb_->exc) {
            //mrb_print_backtrace(mrb_);
            mrb_print_error(mrb_);
            mrb_->exc = 0;
            res = 0;
        }
    }

    if (nAction == kCCNodeOnCleanup) {
        int arena_idx = mrb_gc_arena_save(mrb_);

        pNode->unregisterScriptHandler();
        pNode->stopAllActions();
        pNode->unscheduleUpdate();
        
        CCLayer *pLayer = dynamic_cast< CCLayer * >(pNode);
        if (pLayer) {
            pLayer->unregisterScriptTouchHandler();
            pLayer->unregisterScriptKeypadHandler();
            pLayer->unregisterScriptAccelerateHandler();
        }

        CCMenuItem *pMenuItem = dynamic_cast< CCMenuItem * >(pNode);
        if (pMenuItem) {
            pMenuItem->unregisterScriptTapHandler();
            pMenuItem->setTarget(NULL, NULL);
        }

        CCCallFunc *pFunc = dynamic_cast< CCCallFunc * >(pNode);
        if (pFunc) {
            pFunc->removeScriptHandler();
            pFunc->setTargetCallback(NULL);
        }

#ifdef __CCCONTROL_H__
        CCControl *pControl = dynamic_cast< CCControl * >(pNode);
        if (pControl) {
            pControl->removeHandleOfAllControlEvents();
            pControl->removeTargetForAllControlEvents();
        }
#endif

        mrb_gc_arena_restore(mrb_, arena_idx);

        if (pNode->getChildrenCount() > 0) {
            CCArray *children = pNode->getChildren();
            CCObject *child;
            CCARRAY_FOREACH(children, child) {
                CCNode *pChild = static_cast< CCNode * >(child);
                if (pChild) {
                    //CCLog("%s:%d:-->KCCNodeOnCleanup:m_uID=%u", __FUNCTION__, __LINE__, pChild->m_uID);
                    pChild->cleanup();
                    //CCLog("%s:%d:<--KCCNodeOnCleanup:m_uID=%u", __FUNCTION__, __LINE__, pChild->m_uID);
                }
            }
        }

        //pNode->removeAllChildren();

        //CCLog("%s:%d:KCCNodeOnCleanup:m_uID=%u", __FUNCTION__, __LINE__, pNode->m_uID);
        //cc_mrb_release(mrb_, pNode);

        CCScene *pScene = dynamic_cast< CCScene * >(pNode);
        if (pScene) {
            mrb_full_gc(mrb_);
        }
    }

    return res;
}

int CCMRubyEngine::executeMenuItemEvent(CCMenuItem* pMenuItem)
{
    int nHandler = pMenuItem->getScriptTapHandler();
    if (!nHandler) return 0;

    int arena_idx = mrb_gc_arena_save(mrb_);
    mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_type(handle) != MRB_TT_PROC) {
        _log("nHandler:%d is not Proc:%d:%u", nHandler, mrb_type(handle), pMenuItem->m_uID);
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }
    LOG_MRB_V(mrb_, handle);

    if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }

    mrb_value menu_item = cc_mrb_value_retrieve(mrb_, pMenuItem);
    if (mrb_nil_p(menu_item)) {
        menu_item = mrb_obj_value(Data_Wrap_Struct(
                                      mrb_,
                                      cc_mrb_class_get(mrb_, "Cocos2d::CCMenuItem"),
                                      &mrb_type_cocos2d_CCMenuItem,
                                      pMenuItem));
        cc_mrb_value_register(mrb_, pMenuItem, menu_item);
        pMenuItem->retain();
    }

    mrb_value tag = mrb_fixnum_value(pMenuItem->getTag());
    mrb_value ret = mrb_funcall(mrb_, handle, "call", 2, tag, menu_item);
    mrb_gc_arena_restore(mrb_, arena_idx);

    int res = mrb_bool(ret);
    if (mrb_->exc) {
        //mrb_print_backtrace(mrb_);
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0;
    }
    return res;
}

int CCMRubyEngine::executeNotificationEvent(CCNotificationCenter* pNotificationCenter, const char* pszName)
{
    int nHandler = pNotificationCenter->getObserverHandlerByName(pszName);
    if (!nHandler) return 0;

    int arena_idx = mrb_gc_arena_save(mrb_);
    mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_type(handle) != MRB_TT_PROC) {
        _log("nHandler:%d is not Proc:%d:%s", nHandler, mrb_type(handle), pszName);
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }
    LOG_MRB_V(mrb_, handle);

    if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }

    mrb_value name = mrb_str_new_cstr(mrb_, pszName);
    mrb_value ret = mrb_funcall(mrb_, handle, "call", 1, name);
    mrb_gc_arena_restore(mrb_, arena_idx);

    int res = mrb_bool(ret);
    if (mrb_->exc) {
        //mrb_print_backtrace(mrb_);
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0;
    }
    return res;
}

void CCMRubyEngine::willRemoveAction(CCActionManager* pActionManager, CCAction* pAction, CCObject* pTarget)
{
    pAction->cleanup();
}

int CCMRubyEngine::executeCallFuncActionEvent(CCCallFunc* pAction, CCObject* pTarget/* = NULL*/)
{
    int nHandler = pAction->getScriptHandler();
    if (!nHandler) return 0;
    
    int arena_idx = mrb_gc_arena_save(mrb_);
    mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_type(handle) != MRB_TT_PROC) {
        _log("nHandler:%d is not Proc:%d:%u", nHandler, mrb_type(handle), pAction->m_uID);
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }
    LOG_MRB_V(mrb_, handle);

    if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }

    mrb_value ret;
    if (pTarget)
    {
        mrb_value sender = cc_mrb_value_retrieve(mrb_, pTarget);
        if (mrb_nil_p(sender)) {
          sender = mrb_obj_value(Data_Wrap_Struct(
                                     mrb_,
                                     cc_mrb_class_get(mrb_, "Cocos2d::CCNode"),
                                     &mrb_type_cocos2d_CCNode,
                                     pTarget));
          cc_mrb_value_register(mrb_, pTarget, sender);
          pTarget->retain();
        }
        ret = mrb_funcall(mrb_, handle, "call", 1, sender);
    } else {
        ret = mrb_funcall(mrb_, handle, "call", 0);
    }

    mrb_gc_arena_restore(mrb_, arena_idx);

    int res = mrb_bool(ret);
    if (mrb_->exc) {
        //mrb_print_backtrace(mrb_);
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0;
    }
    return res;
}

int CCMRubyEngine::executeSchedule(int nHandler, float dt, CCNode* pNode/* = NULL*/)
{
    if (!nHandler) return 0;

    int arena_idx = mrb_gc_arena_save(mrb_);
    mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_type(handle) != MRB_TT_PROC) {
        _log("nHandler:%d is not Proc", nHandler);
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }
    //LOG_MRB_V(mrb_, handle);

    if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }

    mrb_value ret = mrb_funcall(mrb_, handle, "call", 1, mrb_float_value(mrb_, dt));
    mrb_gc_arena_restore(mrb_, arena_idx);

    int res = mrb_bool(ret);
    if (mrb_->exc) {
        //mrb_print_backtrace(mrb_);
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0;
    }
    return res;
}

int CCMRubyEngine::executeLayerTouchEvent(CCLayer* pLayer, int eventType, CCTouch *pTouch)
{
    CCTouchScriptHandlerEntry* pScriptHandlerEntry = pLayer->getScriptTouchHandlerEntry();
    if (!pScriptHandlerEntry) return 0;
    int nHandler = pScriptHandlerEntry->getHandler();
    if (!nHandler) return 0;

    int arena_idx = mrb_gc_arena_save(mrb_);
    mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_type(handle) != MRB_TT_PROC) {
        _log("nHandler:%d is not Proc:%d:%u:%u", nHandler, mrb_type(handle), pLayer->m_uID, pScriptHandlerEntry->m_uID);
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }
    LOG_MRB_V(mrb_, handle);

    if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }

    const CCPoint pt = CCDirector::sharedDirector()->convertToGL(pTouch->getLocationInView());

    mrb_value ret = mrb_funcall(mrb_, handle, "call", 3,
                                mrb_fixnum_value(eventType),
                                mrb_float_value(mrb_, pt.x),
                                mrb_float_value(mrb_, pt.y));

    mrb_gc_arena_restore(mrb_, arena_idx);

    int res = mrb_bool(ret);
    if (mrb_->exc) {
        //mrb_print_backtrace(mrb_);
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0;
    }
    return res;
}
    
int CCMRubyEngine::executeLayerTouchesEvent(CCLayer* pLayer, int eventType, CCSet *pTouches)
{
    CCTouchScriptHandlerEntry* pScriptHandlerEntry = pLayer->getScriptTouchHandlerEntry();
    if (!pScriptHandlerEntry) return 0;
    int nHandler = pScriptHandlerEntry->getHandler();
    if (!nHandler) return 0;

    int arena_idx = mrb_gc_arena_save(mrb_);

    mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_type(handle) != MRB_TT_PROC) {
        _log("nHandler:%d is not Proc:%d:%u:%u", nHandler, mrb_type(handle), pLayer->m_uID, pScriptHandlerEntry->m_uID);
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }
    LOG_MRB_V(mrb_, handle);

    if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }

    mrb_value touches = mrb_ary_new_capa(mrb_, pTouches->count());
#if 0
    CCDirector* pDirector = CCDirector::sharedDirector();

    for (CCSetIterator it = pTouches->begin(); it != pTouches->end(); ++it)
    {
        CCTouch* pTouch = (CCTouch*)*it;
        const CCPoint pt = pDirector->convertToGL(pTouch->getLocationInView());
        mrb_value touch = mrb_hash_new_capa(mrb_, 3);
        mrb_hash_set(mrb_, touch, mrb_str_new_cstr(mrb_, "x"), mrb_float_value(mrb_, pt.x));
        mrb_hash_set(mrb_, touch, mrb_str_new_cstr(mrb_, "y"), mrb_float_value(mrb_, pt.y));
        mrb_hash_set(mrb_, touch, mrb_str_new_cstr(mrb_, "id"), mrb_fixnum_value(pTouch->getID()));
        mrb_ary_push(mrb_, touches, touch);
    }
#else
    for (CCSetIterator it = pTouches->begin(); it != pTouches->end(); ++it)
    {
        CCTouch* pTouch = (CCTouch*)*it;
        mrb_value touch = cc_mrb_value_retrieve(mrb_, pTouch);
        if (mrb_nil_p(touch)) {
            touch = mrb_obj_value(Data_Wrap_Struct(
                                      mrb_,
                                      cc_mrb_class_get(mrb_, "Cocos2d::CCTouch"),
                                      &mrb_type_cocos2d_CCTouch,
                                      pTouch));
            cc_mrb_value_register(mrb_, pTouch, touch);
            pTouch->retain();
        }
        mrb_ary_push(mrb_, touches, touch);
    }
#endif

    mrb_value ret = mrb_funcall(mrb_, handle, "call", 2,
                                mrb_fixnum_value(eventType),
                                touches);
    mrb_gc_arena_restore(mrb_, arena_idx);

    int res = mrb_bool(ret);
    if (mrb_->exc) {
        //mrb_print_backtrace(mrb_);
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0;
    }
    return res;
}

int CCMRubyEngine::executeAccelerometerEvent(CCLayer *pLayer, CCAcceleration *pAccelerationValue)
{
    int res = 0;

    mrb_value mrb_self = cc_mrb_value_retrieve(mrb_, pLayer);
    if (!mrb_nil_p(mrb_self)) {
        mrb_sym mid;
        int respond = 0;

        int num_names = 2;
        const char *names[num_names];
        names[0] = "did_accelerate";
        names[1] = "didAccelerate";

        struct RClass *c = mrb_class(mrb_, mrb_self);
        for (int i = 0; i < num_names; ++i) {
            mid = mrb_intern_cstr(mrb_, names[i]);
            struct RProc *p = mrb_method_search_vm(mrb_, &c, mid);
            if (p && !MRB_PROC_CFUNC_P(p)) {
                respond = 1;
                break;
            }
        }

        if (respond) {
            int err = 0;
            int arena_idx = mrb_gc_arena_save(mrb_);

            CCAcceleration *av = new CCAcceleration();
            *av = *pAccelerationValue;

            mrb_value argv[1];
            argv[0] = mrb_obj_value(Data_Wrap_Struct(
                                        mrb_,
                                        cc_mrb_class_get(mrb_, "Cocos2d::CCAcceleration"),
                                        &mrb_type_cocos2d_CCAcceleration,
                                        av));
                                     
            mrb_value ret = mrb_funcall_argv(mrb_, mrb_self, mid, 1, argv);
            mrb_gc_arena_restore(mrb_, arena_idx);

            res = mrb_bool(ret);
            if (mrb_->exc) {
                mrb_print_error(mrb_);
                mrb_->exc = 0;
                err = 1;
            }

            if (err) {
                return 0;
            }
        }
    }

    CCScriptHandlerEntry* pScriptHandlerEntry = pLayer->getScriptAccelerateHandlerEntry();
    if (!pScriptHandlerEntry) return 0;
    int nHandler = pScriptHandlerEntry->getHandler();
    if (!nHandler) return 0;

    int arena_idx = mrb_gc_arena_save(mrb_);
    mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_type(handle) != MRB_TT_PROC) {
        _log("nHandler:%d is not Proc:%d:%u:%u", nHandler, mrb_type(handle), pLayer->m_uID, pScriptHandlerEntry->m_uID);
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }
    LOG_MRB_V(mrb_, handle);

    if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }

    CCAcceleration *av = new CCAcceleration();
    *av = *pAccelerationValue;

    mrb_value arg = mrb_obj_value(Data_Wrap_Struct(
                                      mrb_,
                                      cc_mrb_class_get(mrb_, "Cocos2d::CCAcceleration"),
                                      &mrb_type_cocos2d_CCAcceleration,
                                      av));

    mrb_value ret = mrb_funcall(mrb_, handle, "call", 1, arg);
    mrb_gc_arena_restore(mrb_, arena_idx);

    res = mrb_bool(ret);
    if (mrb_->exc) {
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0;
    }
    return res;
}

int CCMRubyEngine::executeLayerKeypadEvent(CCLayer* pLayer, int eventType)
{
    int res = 0;

    mrb_value node = cc_mrb_value_retrieve(mrb_, pLayer);
    if (!mrb_nil_p(node)) {
        mrb_sym mid;
        int respond = 0;

        int num_names = 2;
        const char *names[num_names];

        switch (eventType) {
        case kTypeBackClicked:
            names[0] = "key_back_clicked";
            names[1] = "keyBackClicked";
            break;
        case kTypeMenuClicked:
            names[0] = "key_menu_clicked";
            names[1] = "keyMenuClicked";
            break;
        default:
            num_names = 0;
            respond = 0;
        }

        struct RClass *c = mrb_class(mrb_, node);
        for (int i = 0; i < num_names; ++i) {
            mid = mrb_intern_cstr(mrb_, names[i]);
            struct RProc *p = mrb_method_search_vm(mrb_, &c, mid);
            if (p && !MRB_PROC_CFUNC_P(p)) {
                respond = 1;
                break;
            }
        }

        if (respond) {
            int err = 0;
            int arena_idx = mrb_gc_arena_save(mrb_);
            mrb_value argv[] = {mrb_fixnum_value(eventType)};
            mrb_value ret = mrb_funcall_argv(mrb_, node, mid, 1, argv);
            mrb_gc_arena_restore(mrb_, arena_idx);

            res = mrb_bool(ret);
            if (mrb_->exc) {
                mrb_print_error(mrb_);
                mrb_->exc = 0;
                err = 1;
            }

            if (err) {
                return 0;
            }
        }
    }

    CCScriptHandlerEntry* pScriptHandlerEntry = pLayer->getScriptKeypadHandlerEntry();
    if (!pScriptHandlerEntry) return 0;
    int nHandler = pScriptHandlerEntry->getHandler();
    if (!nHandler) return 0;

    int arena_idx = mrb_gc_arena_save(mrb_);
    mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_type(handle) != MRB_TT_PROC) {
        _log("nHandler:%d is not Proc:%d:%u:%u", nHandler, mrb_type(handle), pLayer->m_uID, pScriptHandlerEntry->m_uID);
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }
    LOG_MRB_V(mrb_, handle);

    if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }

    mrb_value ret = mrb_funcall(mrb_, handle, "call", 1, mrb_fixnum_value(eventType));
    mrb_gc_arena_restore(mrb_, arena_idx);

    res = mrb_bool(ret);
    if (mrb_->exc) {
        //mrb_print_backtrace(mrb_);
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0;
    }
    return res;
}

int CCMRubyEngine::executeEvent(int nHandler, const char* pEventName, CCObject* pEventSource, const char* pEventSourceClassName)
{
    int arena_idx = mrb_gc_arena_save(mrb_);
    mrb_value handle = cc_mrb_proc_retrieve(mrb_, nHandler);
    if (mrb_type(handle) != MRB_TT_PROC) {
        _log("nHandler:%d is not Proc:%d:%s", nHandler, mrb_type(handle), pEventName);
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }
    LOG_MRB_V(mrb_, handle);

    if (!mrb_respond_to(mrb_, handle, mrb_intern_cstr(mrb_, "call"))) {
        mrb_gc_arena_restore(mrb_, arena_idx);
        return 0;
    }

    mrb_value event_name = mrb_str_new_cstr(mrb_, pEventName);
    mrb_value source = mrb_nil_value();
    if (pEventSource) {
        source = cc_mrb_value_retrieve(mrb_, pEventSource);
        if (pEventSourceClassName) {
            struct RClass *klass = cc_mrb_class_get(mrb_, pEventSourceClassName);
            if (klass) {
                mrb_object(source)->c = klass;
            }
        }
    }

    mrb_value ret = mrb_funcall(mrb_, handle, "call", 2, event_name, source);
    mrb_gc_arena_restore(mrb_, arena_idx);

    int res = mrb_bool(ret);
    if (mrb_->exc) {
        //mrb_print_backtrace(mrb_);
        mrb_print_error(mrb_);
        mrb_->exc = 0;
        res = 0;
    }
    return res;
}


NS_CC_END

