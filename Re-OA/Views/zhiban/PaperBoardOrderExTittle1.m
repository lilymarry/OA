//
//  PaperBoardOrderExTittle1.m
//  Re-OA
//
//  Created by imac-1 on 2016/12/16.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaperBoardOrderExTittle1.h"
#import "ChooseDateView.h"
#import "AlertHelper.h"
#import "ScreenHelper.h"
@implementation PaperBoardOrderExTittle1
-( PaperBoardOrderExTittle1 *)instanceChooseView
{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PaperBoardOrderExTittle1" owner:nil options:nil];
    view= [nibView lastObject];
    TimeTittleView *tittleView=[[TimeTittleView alloc]initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH]+100, 44) andMode:@"1" andBtnState:@"2"];
    tittleView.delegate=view;
    [view addSubview:tittleView];
    [view setFrame:CGRectMake(0, 70,1066, 85)];
    
    return view;
}
-(void)selectTime:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta
{
    NSLog(@"fdfjdsfgo");
    [self.delegate getTime:st];
    
}
-(void)refreshlab:(NSString *)str
{
    self.lab_num.text=[NSString stringWithFormat:@"总计：%@",str];
}

@end
