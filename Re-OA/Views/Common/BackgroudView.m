
#import "BackgroudView.h"
#import "ScreenHelper.h"

@implementation BackgroudView

+(void)showTheBackgroudViewToView:(UIView*)parentView showedHandle:(void (^)())showedHandle  hiddenHandle:(void (^)())hiddenHandle{
    BackgroudView *bgView = [[BackgroudView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0;
    [parentView addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:bgView action:@selector(hidTheBackgroudview:)];
    tapGesture.numberOfTapsRequired=1;
    [bgView addGestureRecognizer:tapGesture];
    
    bgView.hiddenHandle= hiddenHandle;
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.6;
    }completion:^(BOOL finished){
        if (showedHandle!=nil) {
            showedHandle();
        }
        
    } ];
}

-(void)hidTheBackgroudview:(UITapGestureRecognizer*)gesture{
 
    if ([gesture.view isKindOfClass:[BackgroudView class]]) {
        [UIView animateWithDuration:0.3 animations:^(){
            self.alpha=0.0;
        } completion:^(BOOL finished){
            [self removeFromSuperview];
            if (self.hiddenHandle!=nil) {
                self.hiddenHandle();
            }
        }];
    }
}

+(void)hidTheBackgroudviewFromParentView:(UIView*)parentView hiddenHandle:(void (^)())hiddenHandle{
    
    for (UIView *view in parentView.subviews) {
        if ([view isKindOfClass:[BackgroudView class]]) {
            [UIView animateWithDuration:0.3 animations:^(){
                view.alpha=0.0;
            } completion:^(BOOL finished){
                [view removeFromSuperview];
                if (hiddenHandle!=nil) {
                    hiddenHandle();
                }
            }];
              break;
        }
      
    }
    
  
}



@end
