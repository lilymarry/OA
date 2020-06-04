#import "TimeChoose.h"

@implementation TimeChoose

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.borderWidth=1;
       // self.layer.borderColor=kSetColor(215, 215, 215, 1).CGColor;
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(5, 0, contentRect.size.width, contentRect.size.height);
}
@end
