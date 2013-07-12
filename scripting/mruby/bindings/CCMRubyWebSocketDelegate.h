#ifndef __CC_MRUBY_WEB_SOCKET_DELEGATE_H__
#define __CC_MRUBY_WEB_SOCKET_DELEGATE_H__

#include "cocoa/CCObject.h"
#include "network/WebSocket.h"
#include "mruby.h"

NS_CC_EXT_BEGIN

class CCMRubyWebSocketDelegate : public CCObject, public WebSocket::Delegate
{
public:
    CCMRubyWebSocketDelegate() {};
    virtual ~CCMRubyWebSocketDelegate() {};
    virtual void onOpen(WebSocket* ws);
    virtual void onMessage(WebSocket* ws, const WebSocket::Data& data);
    virtual void onClose(WebSocket* ws);
    virtual void onError(WebSocket* ws, const WebSocket::ErrorCode& error);
    
protected:
    mrb_value toScriptObject(WebSocket *ws);
    mrb_value toScriptObject(const WebSocket::Data& data);
    mrb_state *getMRBState(void);
    mrb_value funcall(const char *primary, const char *secondary, int argc, mrb_value *argv);
};

NS_CC_EXT_END

#endif /* __CC_MRUBY_WEB_SOCKET_DELEGATE_H__ */
