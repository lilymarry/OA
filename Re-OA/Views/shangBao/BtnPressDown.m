#import "BtnPressDown.h"

@implementation BtnPressDown

-(void)awakeFromNib
{
    [super awakeFromNib ];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.Downdelegate startChangeView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.Downdelegate endChangeView];
}
@end
