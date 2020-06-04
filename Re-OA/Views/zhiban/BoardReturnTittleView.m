//
//  BoardReturnTittleView.m
//  Re-OA
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "BoardReturnTittleView.h"
#import "ChooseDateView.h"
#import "AlertHelper.h"

#import "ScreenHelper.h"
@implementation BoardReturnTittleView

{
  
   BoardReturnTittleView *view;
    
}
-(BoardReturnTittleView *)instanceChooseView
{

    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"BoardReturnView" owner:nil options:nil];
    view= [nibView lastObject];
    [view setFrame:CGRectMake(0, 70, 3260,85)];
    TimeTittleView *tittleView=[[TimeTittleView alloc]initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH]+80, 44) andMode:@"1" andBtnState:@"1" ];
    tittleView.delegate=view;
    [view addSubview:tittleView];

    return view;
}
-(void)selectTime:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta
{

    [self.delegate getTime:st et:et];
    
}
@end
