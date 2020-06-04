//
//  PaBoOrPaCoQuTittleView.m
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaBoOrPaCoQuTittleView.h"
#import "ChooseDateView.h"
#import "AlertHelper.h"
#import "ScreenHelper.h"
@implementation PaBoOrPaCoQuTittleView
{
    
    PaBoOrPaCoQuTittleView *view;
    
}

-(PaBoOrPaCoQuTittleView *)instanceChooseView
{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PaBoOrPaCoQuTittleView" owner:nil options:nil];
    view= [nibView lastObject];
    [view setFrame:CGRectMake(0, 70, 2420, 85)];
    TimeTittleView *tittleView=[[TimeTittleView alloc]initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH]+100, 44) andMode:@"1" andBtnState:@"2"];
    tittleView.delegate=view;
    [view addSubview:tittleView];
    
    
    return view;
}

-(void)selectTime:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta
{
    
    [self.delegate getTime:st];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
