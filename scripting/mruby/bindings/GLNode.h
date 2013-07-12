#include "base_nodes/CCNode.h"
#include "mruby.h"

namespace cocos2d {
class GLNode : public CCNode
{
public:
    GLNode(void);
    void draw();
    
private:
    mrb_state *mrb_;
};

} /* namespace cocos2d */
