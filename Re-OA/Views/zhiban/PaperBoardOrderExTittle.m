//
//  PaperBoardOrderExTittle.m
//  Re-OA
//
//  Created by admin on 16/3/29.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaperBoardOrderExTittle.h"
#import "ChooseDateView.h"
#import "AlertHelper.h"
#import "ScreenHelper.h"
@implementation PaperBoardOrderExTittle
{
    
  //  PaperBoardOrderExTittle *view;
    
}

-( PaperBoardOrderExTittle *)instanceChooseView
{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PaperBoardOrderExTittle" owner:nil options:nil];
    view= [nibView lastObject];
    TimeTittleView *tittleView=[[TimeTittleView alloc]initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH]+100, 44) andMode:@"1" andBtnState:@"2"];
    tittleView.delegate=view;
    [view addSubview:tittleView];
    [view setFrame:CGRectMake(0, 70,9030, 85)];
   
    return view;
}
-(void)selectTime:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta
{
    NSLog(@"fdfjdsfgo");
    [self.delegate getTime:st];
    
}
@end
