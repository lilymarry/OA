//
//  JGCXQuYuHuiZongView.m
//  Re-OA
//
//  Created by admin on 15/4/20.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JGCXQuYuHuiZongView.h"
#import "JinXiaoCunWebAPI.h"
#import "ScreenHelper.h"
#import "AlertHelper.h"
@implementation JGCXQuYuHuiZongView

{
    ChooseDateView *st_view;
    ChooseDateView *et_view;
    SelectPIckView *lv_view;
    SelectPIckView *kind_view;
    SelectPIckView *yewu_view;
    SelectPIckView *quyu_view;
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
            NSMutableArray *yw=[NSMutableArray arrayWithCapacity:10];
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
            
            for (int i=0; i<[arr[0][@"ywlb"]count]; i++)
            {
                [yw addObject:arr[0][@"ywlb"][i][@"lbnm"] ];
            }
            yewu_view.dataArr=yw;//货物类型
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
    
    [JinXiaoCunWebAPI getZoneSuccess:^(NSArray *arr){
        @try {
            [[NSUserDefaults standardUserDefaults ]setObject:arr forKey:@"dqdata"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSMutableArray *dq=[NSMutableArray arrayWithCapacity:10];
            
            for (int i=0; i<[arr[0][@"dqxx"]count]; i++)
            {
                [dq addObject:arr[0][@"dqxx"][i][@"dqnm"] ];
            }
            quyu_view.dataArr=dq;
        }
        @catch (NSException *exception) {
            [AlertHelper singleMBHUDShow:@"无数据！" ForView:self.view AndDelayHid:2];
        }
        @finally {
            
        }
      
    } fail:^(){}];
    
}
-(JGCXQuYuHuiZongView *)instanceJiageChaXun
{
    st_view = [ChooseDateView instanceChooseDateView];
    st_view.chooseDateDelegate=self;
    st_view.dateId=@"1";
  
    et_view = [ChooseDateView instanceChooseDateView];
    et_view.chooseDateDelegate=self;
    et_view.dateId=@"2";

    lv_view =[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.superview. frame.size.width, 166)];
    lv_view.state=0;
    lv_view.delegate=self;
  
    kind_view=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    kind_view.state=1;
    kind_view.delegate=self;
   
    yewu_view=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    yewu_view.state=2;
    yewu_view.delegate=self;
   
    leixing_view=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    leixing_view.state=4;
    leixing_view.delegate=self;
 
    
    quyu_view=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    quyu_view.state=3;
    quyu_view.delegate=self;
    _view.tf_quyu.inputView=quyu_view;
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JGCXQuYuHuiZongView" owner:nil options:nil];
    _view= [nibView lastObject];
    
    [_view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 300)];
    _view.tf_firstTime.inputView=st_view;
     _view.tf_lastTime.inputView=et_view;
     _view.tf_lv.inputView=lv_view;
     _view.tf_kind.inputView=kind_view;
     _view.tf_yewu.inputView=yewu_view;
     _view.tf_leiXing.inputView=leixing_view;
    _view.tf_quyu.inputView=quyu_view;
    lv_view.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
    kind_view.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
    yewu_view.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
    leixing_view.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
    quyu_view.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);

    [UIView animateWithDuration:0.2 animations:^(){
        [_view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT]-450, [ScreenHelper SCREEN_WIDTH], 300)];
        
    }completion:^(BOOL finished){
    } ];
   [self getData];
    
    return _view;


}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid {
    if ([dateid isEqualToString:@"1"]) {
        _view.tf_firstTime.text= dateStr;
         [_view.tf_firstTime resignFirstResponder];
    }
    else
    {    _view.tf_lastTime.text= dateStr;
        [_view.tf_lastTime resignFirstResponder];
    
    }
 
    
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
            _view.tf_yewu.text=row;
            
            [_view.tf_yewu resignFirstResponder];
        }
            break;
        case 3:
        {
            _view.tf_quyu.text=row;
            
            [_view.tf_quyu resignFirstResponder];
        }
            break;
        case 4:
        {
            _view.tf_leiXing.text=row;
            
            [_view.tf_leiXing resignFirstResponder];
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


- (IBAction)surePress:(id)sender {
    
    NSArray *arr=[[NSUserDefaults standardUserDefaults]objectForKey:@"alldata"];
    NSArray *arr1=[[NSUserDefaults standardUserDefaults]objectForKey:@"dqdata"];

    
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
    
    NSArray *ywArr=arr[0][@"ywlb"];
    NSDictionary *ywdic;
    for (int i=0; i< ywArr.count; i++)
    {
        if ([ ywArr[i][@"lbnm"]isEqualToString:self.tf_yewu.text]) {
            ywdic=[NSDictionary dictionaryWithDictionary: ywArr[i]];
        }
    }
    NSArray *xArr=arr[0][@"hwlx"];
    NSDictionary *xdic;
    for (int i=0; i< xArr.count; i++)
    {
        if ([ xArr[i][@"lxnm"]isEqualToString:self.tf_leiXing.text]) {
            xdic=[NSDictionary dictionaryWithDictionary: xArr[i]];
        }
    }
    NSArray *dqArr=arr1[0][@"dqxx"];
    NSDictionary *dqdic;
    for (int i=0; i< dqArr.count; i++)
    {
        if ([ dqArr[i][@"dqnm"]isEqualToString:self.tf_quyu.text]) {
            dqdic=[NSDictionary dictionaryWithDictionary: dqArr[i]];
        }
    }
    if (self.dataDelegate!=nil &&[self.dataDelegate respondsToSelector:@selector(
          getJGCXQuYuHuiZongViewViewData:et:dengji:zhonglei:yewu:quyu: leiXing:
                                  )])
    {    //  NSLog(@"%@ %@ %@ %@ %@ %@",self.tf_firstTime.text ,self.tf_lastTime.text ,lvdic,lxdic,ywdic,dqdic);
        if (lvdic.count!=0&&lxdic.count!=0 &ywdic.count!=0 &dqdic.count !=0 &xdic.count!=0)
        {
            [self. dataDelegate  getJGCXQuYuHuiZongViewViewData:self.tf_firstTime.text et:self.tf_lastTime.text dengji:lvdic zhonglei:lxdic yewu:ywdic quyu:dqdic leiXing:xdic ];
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
