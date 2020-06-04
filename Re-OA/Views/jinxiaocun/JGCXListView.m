//
//  JGCXListView.m
//  Re-OA
//
//  Created by admin on 15/4/22.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JGCXListView.h"
#import "ScreenHelper.h"
@implementation JGCXListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(JGCXListView *)instanceJiageChaXun
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JGCXListView" owner:nil options:nil];
    _view= [nibView lastObject];
    
    [_view setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH], 20, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    [UIView animateWithDuration:0.2 animations:^(){
         [_view setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH]-220, 20, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    }completion:^(BOOL finished){
    } ];
    return _view;
    
    
}
- (IBAction)selectLIst:(id)sender
{
    UIButton *button=(UIButton *)sender;
    int num=(int)button.tag-1100;
    if (self.delegate!=nil &&[self.delegate respondsToSelector:@selector(getButtonTag:)])
    {
        [self.delegate getButtonTag:num];
        
    }
    [self closingTheLittleMenu:nil];
    
}
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle{
    [self removeTheView:closeMenuHandle];
}


-(void)removeTheView:(void (^)())closeMenuHandle{
    
    [UIView animateWithDuration:0.2 animations:^(){
       [self setFrame:CGRectMake(0,  [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 49)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
        if (closeMenuHandle) {
            closeMenuHandle();
        }
    }];
}
@end
