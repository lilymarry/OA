//
//  paBoOrPaCoQuCustom_detailTittleView.m
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "paBoOrPaCoQuCustom_detailTittleView.h"
#import "ChooseDateView.h"
#import "AlertHelper.h"
#import "ScreenHelper.h"
@implementation paBoOrPaCoQuCustom_detailTittleView

-( paBoOrPaCoQuCustom_detailTittleView *)instanceChooseView
{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"paBoOrPaCoQuCustom_detailTittleView1" owner:nil options:nil];
    view= [nibView lastObject];
    [view setFrame:CGRectMake(0, 70, 2670, 85)];
    TimeTittleView *tittleView=[[TimeTittleView alloc]initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH]+100, 44) andMode:@"1" andBtnState:@"2"];
    tittleView.delegate=view;
    [view addSubview:tittleView];
    
    
    return view;
}

-(void)selectTime:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta
{
    
    [self.delegate getTime:st];
    
}



@end
