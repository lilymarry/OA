//
//  JGCXBenDiHuiZongView.m
//  Re-OA
//
//  Created by admin on 15/4/20.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JGCXBenDiHuiZongView.h"
#import "ScreenHelper.h"
#import "JinXiaoCunWebAPI.h"
#import "AlertHelper.h"
@implementation JGCXBenDiHuiZongView
{
    ChooseDateView *dateView;
    ChooseDateView *dateView1;
    SelectPIckView *pickView;
    SelectPIckView *pickView1;
    
}
-(void)getData
{
    [JinXiaoCunWebAPI getBaseDataWithtype:@"1"  Success:^(NSArray *arr){
        @try {
            [[NSUserDefaults standardUserDefaults ]setObject:arr forKey:@"alldata"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSMutableArray *hw=[NSMutableArray arrayWithCapacity:10];
            NSMutableArray *hz=[NSMutableArray arrayWithCapacity:10];
            for (int i=0; i<[arr[0][@"hwlx"]count]; i++)
            {
                [hw addObject:arr[0][@"hwlx"][i][@"lxnm"] ];
            }
            pickView.dataArr=hw;//货物类型
            for (int i=0; i<[arr[0][@"hwzl"]count]; i++)
            {
                [hz addObject:arr[0][@"hwzl"][i][@"zlnm"]];
            }
            pickView1.dataArr=hz;//货物种类
        }
        @catch (NSException *exception) {
              [AlertHelper singleMBHUDShow:@"无数据！" ForView:self.view AndDelayHid:2];
        }
        @finally {
            
        }
       
        
        
    } fail:^(){
    }];
}
-(JGCXBenDiHuiZongView *)instanceJiageChaXun
{
    dateView = [ChooseDateView instanceChooseDateView];
    dateView.chooseDateDelegate=self;
    dateView.dateId=@"1";

    pickView=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.superview. frame.size.width, 166)];
    pickView.state=0;
    pickView.delegate=self;
   
    pickView1=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    pickView1.state=1;
    pickView1.delegate=self;
  
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JGCXBenDiHuiZongView" owner:nil options:nil];
    _view= [nibView lastObject];
    [_view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 250)];
    
    _view.tf_firstTime.inputView=dateView;
    _view.tf_leixing.inputView=pickView;
    _view.tf_kind.inputView=pickView1;
    pickView.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
    pickView1.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
    
    [UIView animateWithDuration:0.2 animations:^(){
        [_view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT]-450, [ScreenHelper SCREEN_WIDTH], 250)];
        
    }completion:^(BOOL finished){
    } ];

    [self getData];
    return _view;
    
    
}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid {
   
        _view.tf_firstTime.text= dateStr;
       [_view.tf_firstTime resignFirstResponder];
   
}
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    if (state==0)
    {
        _view.tf_leixing.text=row;
        
        [_view.tf_leixing resignFirstResponder];
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
        [self setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 250)];
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
    
    
    NSArray *lvArr=   arr[0][@"hwlx"];
    NSDictionary *lvdic;
    
    for (int i=0; i<  lvArr.count; i++)
    {
        if (  [ lvArr[i][@"lxnm"]isEqualToString:self.tf_leixing.text]) {
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
    if (self.dataDelegate!=nil &&[self.dataDelegate respondsToSelector:@selector(getJGCXBenDiHuiZongViewViewData:leixing:zhonglei:)])
    {
        if (lvdic.count!=0&&lxdic.count!=0)
        {
            [self. dataDelegate  getJGCXBenDiHuiZongViewViewData:_tf_firstTime.text leixing:lvdic zhonglei:lxdic];
            [self closingTheLittleMenu:nil];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"信息不完整" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    
}

@end
