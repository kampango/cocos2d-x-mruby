/****************************************************************************
Copyright (c) 2013 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/

#ifndef __CC_EXTENTIONS_CCCOMCONTROLLER_H__
#define __CC_EXTENTIONS_CCCOMCONTROLLER_H__

#include "cocos2d.h"
#include "CCInputDelegate.h"

NS_CC_EXT_BEGIN

class CCComController : public cocos2d::CCComponent, public CCInputDelegate
{
protected:
    CCComController(void);
    
public:
   virtual ~CCComController(void);
   virtual bool init();
   virtual void onEnter();
   virtual void onExit();
   virtual void update(float delta);
   virtual bool isEnabled() const;
   virtual void setEnabled(bool b);
    
   static CCComController* create(void);

public:
    void registerScriptHandler(int nHandler);
    void unregisterScriptHandler(void);
    void registerScriptTouchHandler(int nHandler, bool bIsMultiTouches, int nPriority, bool bSwallowsTouches);
    void unregisterScriptTouchHandler(void);

public:
    virtual bool ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent);
    virtual void ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent);

    virtual void ccTouchesBegan(CCSet *pTouches, CCEvent *pEvent);
    virtual void ccTouchesMoved(CCSet *pTouches, CCEvent *pEvent);
    virtual void ccTouchesEnded(CCSet *pTouches, CCEvent *pEvent);
    virtual void ccTouchesCancelled(CCSet *pTouches, CCEvent *pEvent);

public:
    virtual bool isTouchEnabled();
    virtual void setTouchEnabled(bool value);

private:
    CCLayer *m_pInputDelegate;
};

NS_CC_EXT_END

#endif  // __FUNDATION__CCCOMPONENT_H__
