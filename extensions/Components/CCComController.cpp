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

#include "CCComController.h"

NS_CC_EXT_BEGIN

CCComController::CCComController(void)
:m_pInputDelegate(NULL)
{
    CCScriptEngineProtocol* pEngine = CCScriptEngineManager::sharedManager()->getScriptEngine();
    if (pEngine != NULL && pEngine->getScriptType() == kScriptTypeMRuby) {
        m_pInputDelegate = new CCLayer();
        m_pInputDelegate->retain();
    }
    m_strName = "Constoller";
}

CCComController::~CCComController(void)
{
    if (m_pInputDelegate) {
        m_pInputDelegate->release();
    }
}

bool CCComController::init()
{
    if (!CCComponent::init()) {
        return false;
    }
    if (m_pInputDelegate && !m_pInputDelegate->init()) {
        return false;
    }
    return true;
}

void CCComController::onEnter()
{
    if (m_pInputDelegate) {
        m_pInputDelegate->onEnter();
        return;
    }
    CCComponent::onEnter();
}

void CCComController::onExit()
{
    if (m_pInputDelegate) {
        m_pInputDelegate->onExit();
        return;
    }
    CCComponent::onExit();
}

void CCComController::update(float delta)
{
    if (m_pInputDelegate) {
        m_pInputDelegate->update(delta);
        return;
    }
    CCComponent::update(delta);
}

bool CCComController::isEnabled() const
{
    return m_bEnabled;
}

void CCComController::setEnabled(bool b)
{
    m_bEnabled = b;
}

void CCComController::registerScriptHandler(int nHandler)
{
    if (m_pInputDelegate) {
        m_pInputDelegate->registerScriptHandler(nHandler);
    }
}

void CCComController::unregisterScriptHandler()
{
    if (m_pInputDelegate) {
        m_pInputDelegate->unregisterScriptHandler();
    }
}

bool CCComController::isTouchEnabled()
{
    if (m_pInputDelegate) {
        return m_pInputDelegate->isTouchEnabled();
    }
    return CCInputDelegate::isTouchEnabled();
}

void CCComController::setTouchEnabled(bool value)
{
    if (m_pInputDelegate) {
        m_pInputDelegate->setTouchEnabled(value);
        return;
    }
    CCInputDelegate::setTouchEnabled(value);
}


void CCComController::registerScriptTouchHandler(int nHandler, bool bIsMultiTouches, int nPriority, bool bSwallowsTouches)
{
    if (m_pInputDelegate)
    {
        return m_pInputDelegate->registerScriptTouchHandler(nHandler, bIsMultiTouches, nPriority, bSwallowsTouches);
    }
}

void CCComController::unregisterScriptTouchHandler(void)
{
    if (m_pInputDelegate)
    {
        m_pInputDelegate->unregisterScriptTouchHandler();
        return;
    }
}

//CCTouchDelegate Methods
bool CCComController::ccTouchBegan(CCTouch *pTouch, CCEvent *pEvent)
{
    if (m_pInputDelegate)
    {
        return m_pInputDelegate->ccTouchBegan(pTouch, pEvent);
    }

    CC_UNUSED_PARAM(pTouch);
    CC_UNUSED_PARAM(pEvent);
    return false;
}

void CCComController::ccTouchMoved(CCTouch *pTouch, CCEvent *pEvent)
{
    if (m_pInputDelegate)
    {
        return m_pInputDelegate->ccTouchMoved(pTouch, pEvent);
    }

    CC_UNUSED_PARAM(pTouch);
    CC_UNUSED_PARAM(pEvent);
}

void CCComController::ccTouchEnded(CCTouch *pTouch, CCEvent *pEvent)
{
    if (m_pInputDelegate)
    {
        return m_pInputDelegate->ccTouchEnded(pTouch, pEvent);
    }

    CC_UNUSED_PARAM(pTouch);
    CC_UNUSED_PARAM(pEvent);
}

void CCComController::ccTouchCancelled(CCTouch *pTouch, CCEvent *pEvent)
{
    if (m_pInputDelegate)
    {
        return m_pInputDelegate->ccTouchCancelled(pTouch, pEvent);
    }

    CC_UNUSED_PARAM(pTouch);
    CC_UNUSED_PARAM(pEvent);
}

void CCComController::ccTouchesBegan(CCSet *pTouches, CCEvent *pEvent)
{
    if (m_pInputDelegate)
    {
        return m_pInputDelegate->ccTouchesBegan(pTouches, pEvent);
    }

    CC_UNUSED_PARAM(pTouches);
    CC_UNUSED_PARAM(pEvent);
}

void CCComController::ccTouchesMoved(CCSet *pTouches, CCEvent *pEvent)
{
    if (m_pInputDelegate)
    {
        return m_pInputDelegate->ccTouchesMoved(pTouches, pEvent);
    }

    CC_UNUSED_PARAM(pTouches);
    CC_UNUSED_PARAM(pEvent);
}

void CCComController::ccTouchesEnded(CCSet *pTouches, CCEvent *pEvent)
{
    if (m_pInputDelegate)
    {
        return m_pInputDelegate->ccTouchesEnded(pTouches, pEvent);
    }

    CC_UNUSED_PARAM(pTouches);
    CC_UNUSED_PARAM(pEvent);
}

void CCComController::ccTouchesCancelled(CCSet *pTouches, CCEvent *pEvent)
{
    if (m_pInputDelegate)
    {
        return m_pInputDelegate->ccTouchesCancelled(pTouches, pEvent);
    }

    CC_UNUSED_PARAM(pTouches);
    CC_UNUSED_PARAM(pEvent);
}


CCComController* CCComController::create(void)
{
    CCComController * pRet = new CCComController();
    if (pRet && pRet->init())
    {
        pRet->autorelease();
    }
    else
    {
        CC_SAFE_DELETE(pRet);
    }
	return pRet;
}

NS_CC_EXT_END
