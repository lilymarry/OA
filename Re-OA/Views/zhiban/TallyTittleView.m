//
//  TallyTittleView.m
//  Re-OA
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "TallyTittleView.h"
#import "ChooseDateView.h"
#import "AlertHelper.h"
#import "ScreenHelper.h"
@implementation TallyTittleView
{

    TallyTittleView *view;
    
}

-(TallyTittleView *)instanceChooseView
{

    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"TallyTittleView" owner:nil options:nil];
    view= [nibView lastObject];
    [view setFrame:CGRectMake(0, 70, 3760, 85)];
    TimeTittleView *tittleView=[[TimeTittleView alloc]initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH]+100, 44) andMode:@"1" andBtnState:@"1"];
    tittleView.delegate=view;
    [view addSubview:tittleView];
    

    return view;
}

-(void)selectTime:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta
{

    [self.delegate getTime:st et:et];
    
}

@end
