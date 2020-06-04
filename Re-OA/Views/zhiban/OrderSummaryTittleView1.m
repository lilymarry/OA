//
//  OrderSummaryTittleView.m
//  Re-OA
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "OrderSummaryTittleView1.h"
#import "ChooseDateView.h"
#import "AlertHelper.h"
#import "TimeTittleView.h"
#import "ScreenHelper.h"
@implementation OrderSummaryTittleView1

{
    
    OrderSummaryTittleView1 *view;
    
}

-(OrderSummaryTittleView1 *)instanceChooseView
{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"OrderSummaryTittleView1" owner:nil options:nil];
    view= [nibView lastObject];
    //  [view setFrame:CGRectMake(0, 70, 1250, 83)];
    [view setFrame:CGRectMake(0, 70, 915, 85)];
    TimeTittleView *tittleView=[[TimeTittleView alloc]initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH]+90, 44) andMode:@"1" andBtnState:@"2"];
    tittleView.delegate=view;
    
    [view addSubview:tittleView];
    //NSLog(@"WWW %f",view.frame.size.height);
    //view.backgroundColor=[UIColor greenColor];
    
    
    return view;
}
-(void)selectTime:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta
{
    [self.delegate getTime:st et:et];
    
}

@end
