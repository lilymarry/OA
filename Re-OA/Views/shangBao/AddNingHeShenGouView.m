//
//  AddNingHeShenGouView.m
//  Re-OA
//
//  Created by imac-1 on 2017/5/16.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "AddNingHeShenGouView.h"
#import "ScreenHelper.h"

@implementation AddNingHeShenGouView

-(AddNingHeShenGouView *)instanceChooseView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"AddNingHeShenGouView" owner:nil options:nil];
    AddNingHeShenGouView *view= [nibView lastObject];
    [view setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH], 20, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    [UIView animateWithDuration:0.2 animations:^(){
   
        if ( [ScreenHelper SCREEN_HEIGHT]==480 ) {
             [view setFrame:CGRectMake(0,0, [ScreenHelper SCREEN_WIDTH], 241)];
        }
        else
        {
        [view setFrame:CGRectMake(0, 50, [ScreenHelper SCREEN_WIDTH], 241)];
        }
        
    }completion:^(BOOL finished){
    } ];
    
    
 
    
    return view;
}
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle{
    [self removeTheView:closeMenuHandle];
}


-(void)removeTheView:(void (^)())closeMenuHandle{
    
    [UIView animateWithDuration:0.2 animations:^(){
        [self setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 300)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
        if (closeMenuHandle) {
            closeMenuHandle();
        }
    }];
}

- (IBAction)truePress:(id)sender {
    NingHeShenGouModel *mode=[[NingHeShenGouModel alloc]init];
    mode.name=_tf_name.text;
    mode.dawei=_tf_danwei.text;
    mode.shuliang=_tf_shuliang.text;
    mode.beizhu=_tf_beiZhu.text;
    
    
    
    
    
    [self.delegate getNingHeShenGouModel:mode];
 
    
}

- (IBAction)closeViewPress:(id)sender {
}
@end
