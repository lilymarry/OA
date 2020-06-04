//
//  PaBoOrPaCoQuView.m
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaBoOrPaCoQuView.h"
#import "ScreenHelper.h"
@implementation PaBoOrPaCoQuView

-(PaBoOrPaCoQuView *)instanceChooseView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PaBoOrPaCoQuView" owner:nil options:nil];
    PaBoOrPaCoQuView*  view= [nibView lastObject];
    [view setFrame:CGRectMake(0,200,  [ScreenHelper SCREEN_WIDTH],150)];
    return view;
}
-(void)refresh
{
    self.lab_c1.text=self.c1;
    self.lab_c2.text= self.c2;
    self.lab_c3.text= self.c3;
    self.lab_c4.text= self.c4;
    self.lab_tittle1.text=self.tittle1;
    self.lab_tittle2.text=self.tittle2;
    self.lab_tittle3.text=self.tittle3;
    self.lab_tittle4.text=self.tittle4;
}
@end
