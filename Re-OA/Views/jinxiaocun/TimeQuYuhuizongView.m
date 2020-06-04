//
//  TimeQuYuhuizongView.m
//  Re-OA
//
//  Created by admin on 15/4/21.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "TimeQuYuhuizongView.h"
#import "JinXiaoCunWebAPI.h"
#import "ScreenHelper.h"
#import "AlertHelper.h"
@implementation TimeQuYuhuizongView
{
    ChooseDateView *st_view;
   
    SelectPIckView *lv_view;
    SelectPIckView *kind_view;
    SelectPIckView *leixing_view;
}
-(void)getData
{
    [JinXiaoCunWebAPI getBaseDataWithtype:@"1"  Success:^(NSArray *arr){
        @try {
            [[NSUserDefaults standardUserDefaults ]setObject:arr forKey:@"alldata"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSMutableArray *hw=[NSMutableArray arrayWithCapacity:10];
            NSMutableArray *hz=[NSMutableArray arrayWithCapacity:10];
            NSMutableArray *lx=[NSMutableArray arrayWithCapacity:10];
            for (int i=0; i<[arr[0][@"hwlv"]count]; i++)
            {
                [hw addObject:arr[0][@"hwlv"][i][@"lvnm"] ];
            }
            lv_view.dataArr=hw;
            for (int i=0; i<[arr[0][@"hwzl"]count]; i++)
            {
                [hz addObject:arr[0][@"hwzl"][i][@"zlnm"]];
            }
            kind_view.dataArr=hz;//货物种类
            
            
            for (int i=0; i<[arr[0][@"hwlx"]count]; i++)
            {
                [lx addObject:arr[0][@"hwlx"][i][@"lxnm"] ];
            }
            leixing_view.dataArr=lx;//货物类型

        }
        @catch (NSException *exception) {
             [AlertHelper singleMBHUDShow:@"无数据！" ForView:self.view AndDelayHid:2];
        }
        @finally {
            
        }
        
    } fail:^(){
    }];

    
}
-(TimeQuYuhuizongView *)instanceJiageChaXun
{
    st_view = [ChooseDateView instanceChooseDateView];
    st_view.chooseDateDelegate=self;
    st_view.dateId=@"1";

    lv_view =[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.superview. frame.size.width, 166)];
    lv_view.state=0;
    lv_view.delegate=self;
    
    kind_view=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    kind_view.state=1;
    kind_view.delegate=self;
    
    leixing_view=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    leixing_view.state=2;
    leixing_view.delegate=self;
 
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"TimeQuYuhuizongView" owner:nil options:nil];
    _view= [nibView lastObject];
    
    [_view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 300)];
     _view.tf_time.inputView=st_view;
     _view.tf_lv.inputView=lv_view;
     _view.tf_kind.inputView=kind_view;
     _view.tf_leixing.inputView=leixing_view;
    lv_view.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
    kind_view.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
    leixing_view.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
  
    [UIView animateWithDuration:0.2 animations:^(){
        [_view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT]-450, [ScreenHelper SCREEN_WIDTH], 300)];
        
    }completion:^(BOOL finished){
    } ];
    
    [self getData];
    
    return _view;
    
    
}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid {
  
        _view.tf_time.text= dateStr;
        [_view.tf_time resignFirstResponder];
  }
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    switch (state)
    {
        case 0:
        {
            _view.tf_lv.text=row;
            
            [_view.tf_lv resignFirstResponder];
        }
            break;
        case 1:
        {
            _view.tf_kind.text=row;
            
            [_view.tf_kind resignFirstResponder];
        }
            break;
       
        case 2:
        {
            _view.tf_leixing.text=row;
            [_view.tf_leixing resignFirstResponder];
        }
            break;
        default:
            break;
    }
    
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


- (IBAction)chaXunPress:(id)sender {
    
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
    
  
    NSArray *xArr=arr[0][@"hwlx"];
    NSDictionary *xdic;
    for (int i=0; i< xArr.count; i++)
    {
        if ([ xArr[i][@"lxnm"]isEqualToString:self.tf_leixing.text]) {
            xdic=[NSDictionary dictionaryWithDictionary: xArr[i]];
        }
    }
   
    if (self.dataDelegate!=nil &&[self.dataDelegate respondsToSelector:@selector(
                                                                                getTimeQuYuhuizongViewData:dengji:zhonglei:leiXing:
                                                                                 )])
    {    
        if (lvdic.count!=0&&lxdic.count!=0 &xdic.count!=0)
        {
            [self. dataDelegate  getTimeQuYuhuizongViewData:self.tf_time.text  dengji:lvdic zhonglei:lxdic leiXing:xdic ];
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
