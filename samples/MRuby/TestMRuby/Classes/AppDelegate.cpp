#include "cocos2d.h"
#include "CCEGLView.h"
#include "AppDelegate.h"
#include "CCMRubyEngine.h"
#include "SimpleAudioEngine.h"
//#include "Lua_extensions_CCB.h"
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
//#include "Lua_web_socket.h"
#endif

using namespace CocosDenshion;

USING_NS_CC;

AppDelegate::AppDelegate()
{
}

AppDelegate::~AppDelegate()
{
    SimpleAudioEngine::end();
}

bool AppDelegate::applicationDidFinishLaunching()
{
    // initialize director
    CCDirector *pDirector = CCDirector::sharedDirector();
    pDirector->setOpenGLView(CCEGLView::sharedOpenGLView());

    // turn on display FPS
    pDirector->setDisplayStats(true);

    // set FPS. the default value is 1.0/60 if you don't call this
    pDirector->setAnimationInterval(1.0 / 60);
    
    // register mruby engine
    CCMRubyEngine* pEngine = CCMRubyEngine::getInstance();
    CCScriptEngineManager::sharedManager()->setScriptEngine(pEngine);
    
    CCFileUtils* pFileUtils = CCFileUtils::sharedFileUtils();
    std::vector<std::string> searchPaths = pFileUtils->getSearchPaths();

    CCSize screenSize = CCEGLView::sharedOpenGLView()->getFrameSize();
    CCSize designSize = CCSizeMake(480, 320);

    ResolutionPolicy policy = kResolutionNoBorder;
    if (screenSize.height > 320)
    {
        CCSize resourceSize = CCSizeMake(960, 640);
        pDirector->setContentScaleFactor(resourceSize.height / designSize.height);
        searchPaths.insert(searchPaths.begin(), "hd");
        if (floor(screenSize.width/screenSize.height * 100) != floor(resourceSize.width / resourceSize.height * 100)) {
            policy = kResolutionShowAll;
        }
    }

    CCEGLView::sharedOpenGLView()->setDesignResolutionSize(designSize.width, designSize.height, policy);

    searchPaths.push_back("cocosbuilderRes");

#if CC_TARGET_PLATFORM == CC_PLATFORM_BLACKBERRY
    searchPaths.push_back("TestCppResources");
    searchPaths.push_back("script");
#endif

    pFileUtils->setSearchPaths(searchPaths);

#if 1
    searchPaths = pFileUtils->getSearchPaths();
    CCLog("searchPaths:");
    for (std::vector<std::string>::const_iterator itr = searchPaths.begin();
         itr != searchPaths.end();
         ++itr) {
        CCLog("  %s", (*itr).c_str());
    }
#endif

    std::string path = pFileUtils->fullPathForFilename("start.rb");
    pEngine->executeScriptFile(path.c_str());

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
    CCDirector::sharedDirector()->stopAnimation();
    SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
    SimpleAudioEngine::sharedEngine()->pauseAllEffects();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
    CCDirector::sharedDirector()->startAnimation();
    SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
    SimpleAudioEngine::sharedEngine()->resumeAllEffects();
}
