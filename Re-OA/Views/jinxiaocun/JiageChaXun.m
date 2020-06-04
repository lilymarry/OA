//
//  JiageChaXun.m
//  Re-OA
//
//  Created by admin on 15/4/15.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JiageChaXun.h"
#import "ScreenHelper.h"
#import "JinXiaoCunWebAPI.h"
#import "AlertHelper.h"
@implementation JiageChaXun
{
   ChooseDateView *dateView;
   ChooseDateView *dateView1;
   SelectPIckView *pickView;
   SelectPIckView *pickView1;

}

-(void)getData
{
    //6500 中心  2
    [JinXiaoCunWebAPI getBaseDataWithtype:@"1"  Success:^(NSArray *arr){
        @try {
            [[NSUserDefaults standardUserDefaults ]setObject:arr forKey:@"alldata"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSMutableArray *hw=[NSMutableArray arrayWithCapacity:10];
            NSMutableArray *hz=[NSMutableArray arrayWithCapacity:10];
            for (int i=0; i<[arr[0][@"hwlv"]count]; i++)
            {
                [hw addObject:arr[0][@"hwlv"][i][@"lvnm"] ];
            }
            pickView.dataArr=hw;
            for (int i=0; i<[arr[0][@"hwzl"]count]; i++)
            {
                [hz addObject:arr[0][@"hwzl"][i][@"zlnm"]];
            }
            pickView1.dataArr=hz;
        }
        @catch (NSException *exception) {
             [AlertHelper singleMBHUDShow:@"无数据！" ForView:self.view AndDelayHid:2];
        }
        @finally {
            
        }
     
        
        
    } fail:^(){
    }];
}
-(JiageChaXun *)instanceJiageChaXun
{
    dateView = [ChooseDateView instanceChooseDateView];
    dateView.chooseDateDelegate=self;
    dateView.dateId=@"1";
    
    dateView1 = [ChooseDateView instanceChooseDateView];
    dateView1.chooseDateDelegate=self;
    dateView1.dateId=@"2";
    
    pickView=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.superview. frame.size.width, 166)];
    pickView.state=0;
    pickView.delegate=self;
 
    pickView1=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    pickView1.state=1;
    pickView1.delegate=self;
   NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JiageChaXun" owner:nil options:nil];
    _view= [nibView lastObject];
    
    [_view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 300)];
   
    _view.tf_fistTime.inputView=dateView;
    _view.tf_lastTime.inputView=dateView1;
    _view.tf_lv.inputView=pickView;
    _view.tf_kind.inputView=pickView1;
    pickView.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
    pickView1.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
   [UIView animateWithDuration:0.2 animations:^(){
        [_view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT]-450, [ScreenHelper SCREEN_WIDTH], 300)];
       
    }completion:^(BOOL finished){
    } ];
    [self getData];
    
     return _view;


}

-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid {
    if ([dateid isEqualToString:@"1"])
    {
        _view.tf_fistTime.text= dateStr;
        [_view.tf_fistTime resignFirstResponder];
        
    }
    else{
        _view.tf_lastTime.text= dateStr;
        [_view.tf_lastTime resignFirstResponder];
    }
}
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    if (state==0)
    {
        _view.tf_lv.text=row;
    
        [_view.tf_lv resignFirstResponder];
    }
    else
    {
        _view.tf_kind.text=row;
        [_view.tf_kind resignFirstResponder];}
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

- (IBAction)surePress:(id)sender
{
   
    NSArray *arr=[[NSUserDefaults standardUserDefaults]objectForKey:@"alldata"];
   
   
       NSArray *lvArr=   arr[0][@"hwlv"];
        NSDictionary *lvdic;
        
        for (int i=0; i<  lvArr.count; i++)
        {
            if (  [ lvArr[i][@"lvnm"]isEqualToString:self.tf_lv.text]) {
                lvdic=[NSDictionary dictionaryWithDictionary:lvArr[i]];
            }
        }
        NSArray *lxArr=arr[0][@"hwzl"];
        NSDictionary *lxdic;
        for (int i=0; i< lxArr.count; i++)
        {
            if ([ lxArr[i][@"zlnm"]isEqualToString:self.tf_kind.text]) {
                lxdic=[NSDictionary dictionaryWithDictionary: lxArr[i]];
            }
        }
        if (self.dataDelegate!=nil &&[self.dataDelegate respondsToSelector:@selector(getJiaGechaXunViewData:andEt:dengji:zhonglei:)])
        {
            if (lvdic.count!=0&&lxdic.count!=0)
            {
                [self. dataDelegate  getJiaGechaXunViewData:self.tf_fistTime.text andEt:self.tf_lastTime.text dengji:lvdic zhonglei:lxdic];
               [self closingTheLittleMenu:nil];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"信息不完整" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }
    
    
}

-(BOOL)canBecomeFirstResponder
{
    return YES;

}
@end
