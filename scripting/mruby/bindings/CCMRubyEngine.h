//
//  CCMRubyEngine.h
//  
//
//  Created by 
//  Copyright (c) 2013
//

#ifndef __CC_MRUBY_ENGINE_H__
#define __CC_MRUBY_ENGINE_H__

#include <assert.h>
#include "cocos2d.h"

extern "C" {
#include "mruby.h"
#include "mruby/data.h"
}

NS_CC_BEGIN

class SimpleRunLoop : public CCObject
{
public:
	void update(float d);
};

class CCMRubyEngine : public CCObject, public CCScriptEngineProtocol
{
    mrb_state *mrb_;
	CCMRubyEngine();
public:
	~CCMRubyEngine();

	static CCMRubyEngine *getInstance() {
		static CCMRubyEngine* pInstance = NULL;
        if (pInstance == NULL) {
            pInstance = new CCMRubyEngine();
        }
		return pInstance;
	};

    virtual ccScriptType getScriptType() { return kScriptTypeMRuby; };

    /** Remove script object. */
    virtual void removeScriptObjectByCCObject(CCObject* pObj);
    
    /** Remove script function handler, only LuaEngine class need to implement this function. */
    virtual void removeScriptHandler(int nHandler);

    /** **/
    virtual void willRemoveAction(CCActionManager* pActionManager, CCAction* pAction, CCObject* pTarget);
    
    /** Reallocate script function handler, only LuaEngine class need to implement this function. */
    virtual int reallocateScriptHandler(int nHandler);
    
    /**
     @brief Execute script code contained in the given string.
     @param codes holding the valid script code that should be executed.
     @return 0 if the string is executed correctly.
     @return other if the string is executed wrongly.
     */
    virtual int executeString(const char* codes) { return -1;}
    
    /**
     @brief Execute a script file.
     @param filename String object holding the filename of the script file that is to be executed
     */
    virtual int executeScriptFile(const char* filename);
    
    /**
     @brief Execute a scripted global function.
     @brief The function should not take any parameters and should return an integer.
     @param functionName String object holding the name of the function, in the global script environment, that is to be executed.
     @return The integer value returned from the script function.
     */
    virtual int executeGlobalFunction(const char* functionName) { return -1; };
    
    /**
     @brief Execute a node event function
     @param pNode which node produce this event
     @param nAction kNodeOnEnter,kNodeOnExit,kMenuItemActivated,kNodeOnEnterTransitionDidFinish,kNodeOnExitTransitionDidStart
     @return The integer value returned from the script function.
     */
    virtual int executeNodeEvent(CCNode* pNode, int nAction);
    
    virtual int executeMenuItemEvent(CCMenuItem* pMenuItem);
    /** Execute a notification event function */
    virtual int executeNotificationEvent(CCNotificationCenter* pNotificationCenter, const char* pszName);
    
    /** execute a callfun event */
    virtual int executeCallFuncActionEvent(CCCallFunc* pAction, CCObject* pTarget = NULL);
    /** execute a schedule function */
    virtual int executeSchedule(int nHandler, float dt, CCNode* pNode = NULL);
    
    /** functions for executing touch event */
    virtual int executeLayerTouchesEvent(CCLayer* pLayer, int eventType, CCSet *pTouches);
    virtual int executeLayerTouchEvent(CCLayer* pLayer, int eventType, CCTouch *pTouch);

    /** functions for keypad event */
    virtual int executeLayerKeypadEvent(CCLayer* pLayer, int eventType);

    /** execute a accelerometer event */
    virtual int executeAccelerometerEvent(CCLayer* pLayer, CCAcceleration* pAccelerationValue);

    /** function for common event */
    virtual int executeEvent(int nHandler, const char* pEventName, CCObject* pEventSource = NULL, const char* pEventSourceClassName = NULL);

    /** called by CCAssert to allow scripting engine to handle failed assertions
     * @return true if the assert was handled by the script engine, false otherwise.
     */
    virtual bool handleAssert(const char *msg) { return false; };

    void start();
    void reset();
    void cleanup();

public:
    inline mrb_state *getMRBState(void) { return mrb_; }
};

NS_CC_END

#endif /* __CC_MRUBY_ENGINE_H__ */
