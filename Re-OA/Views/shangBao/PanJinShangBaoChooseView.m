
#import "PanJinShangBaoChooseView.h"
#import "ScreenHelper.h"

@implementation PanJinShangBaoChooseView

-(PanJinShangBaoChooseView *)instanceChooseView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"panjincaiwuView" owner:nil options:nil];
    PanJinShangBaoChooseView *view= [nibView lastObject];
    [view setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH], 20, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    [UIView animateWithDuration:0.2 animations:^(){
        [view setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH]-220, 20, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    }completion:^(BOOL finished){
    } ];
    
    
    [view addTapOneGestureForParentView:view AndChildView:view.jiekuanView];
    [view addTapOneGestureForParentView:view AndChildView:view.fukuanView];
    [view addTapOneGestureForParentView:view AndChildView:view.baoxiaoView];

    return view;
}


-(void)addTapOneGestureForParentView:(UIView*)pview AndChildView:(UIView*)cView{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:pview action:@selector(selectTheShangBaoType:)];
    tapGesture.numberOfTapsRequired=1;
    [cView addGestureRecognizer:tapGesture];
}


-(void)selectTheShangBaoType:(UITapGestureRecognizer*)gesture{
    int tid= (int)gesture.view.tag;
    NSObject<PanjinDelegate> *tmpDele=self.panjinDelegate;
    [tmpDele selectTheTypeID:tid];
}


-(void)closingTheLittleMenu:(void (^)())closeMenuHandle{
    [self removeTheView:closeMenuHandle];
}

-(void)removeTheView:(void (^)())closeMenuHandle{
    
    [UIView animateWithDuration:0.2 animations:^(){
       [self setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH], 20, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
        if (closeMenuHandle) {
            closeMenuHandle();
        }
    }];
}


@end
