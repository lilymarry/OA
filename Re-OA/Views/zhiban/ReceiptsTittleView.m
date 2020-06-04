//
//  ReceiptsTittleView.m
//  Re-OA
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "ReceiptsTittleView.h"
#import "ChooseDateView.h"
#import "AlertHelper.h"
#import "TimeTittleView.h"
#import "ScreenHelper.h"
@implementation ReceiptsTittleView
{

    ReceiptsTittleView *view;

}

-(ReceiptsTittleView *)instanceChooseView
{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ReceiptsTittleView" owner:nil options:nil];
    view= [nibView lastObject];
   //  [view setFrame:CGRectMake(0, 70, 1250, 83)];
     [view setFrame:CGRectMake(0, 70, 1260, 85)];
    TimeTittleView *tittleView=[[TimeTittleView alloc]initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH]+90, 44) andMode:@"1" andBtnState:@"1"];
    tittleView.delegate=view;
    
    [view addSubview:tittleView];
  //  NSLog(@"WWW %f",view.frame.size.height);
    //view.backgroundColor=[UIColor greenColor];


    return view;
}
-(void)selectTime:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta
{
       [self.delegate getTime:st et:et];

}
@end
