//
//  TimeJiaGeHuidanQuYuView.m
//  Re-OA
//
//  Created by admin on 15/4/21.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "TimeJiaGeHuidanQuYuView.h"
#import "JinXiaoCunWebAPI.h"
#import "ScreenHelper.h"
#import "AlertHelper.h"
@implementation TimeJiaGeHuidanQuYuView
{
    ChooseDateView *st_view;
    SelectPIckView *kind_view;
    SelectPIckView *quyu_view;
    SelectPIckView *leixing_view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)getData
{
    [JinXiaoCunWebAPI getBaseDataWithtype:@"1"  Success:^(NSArray *arr){
        @try {
            [[NSUserDefaults standardUserDefaults ]setObject:arr forKey:@"alldata"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSMutableArray *hz=[NSMutableArray arrayWithCapacity:10];
            
            NSMutableArray *lx=[NSMutableArray arrayWithCapacity:10];
            
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
-(TimeJiaGeHuidanQuYuView *)instanceJiageChaXun
{
    st_view = [ChooseDateView instanceChooseDateView];
    st_view.chooseDateDelegate=self;
    st_view.dateId=@"1";
  
    kind_view=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    kind_view.state=0;
    kind_view.delegate=self;
    
    leixing_view=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    leixing_view.state=1;
    leixing_view.delegate=self;
 
    
    quyu_view=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.superview.frame.size.width, 166) ];
    quyu_view.state=2;
    quyu_view.delegate=self;

    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"TimeJiaGeHuidanQuYuView" owner:nil options:nil];
    _view= [nibView lastObject];
    
    [_view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 300)];
     _view.tf_time.inputView=st_view;
     _view.tf_kind.inputView=kind_view;
      _view.tf_leixing.inputView=leixing_view;
      _view.tf_quyu.inputView=quyu_view;
   
     kind_view.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 166);
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
    
        _view.tf_time.text= dateStr;
        [_view.tf_time resignFirstResponder];
    
}
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    switch (state)
    {
        
        case 0:
        {
            _view.tf_kind.text=row;
            
            [_view.tf_kind resignFirstResponder];
        }
            break;
              case 2:
        {
            _view.tf_quyu.text=row;
            
            [_view.tf_quyu resignFirstResponder];
        }
            break;
        case 1:
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


- (IBAction)chaXunpress:(id)sender {
    NSArray *arr=[[NSUserDefaults standardUserDefaults]objectForKey:@"alldata"];
    NSArray *arr1=[[NSUserDefaults standardUserDefaults]objectForKey:@"dqdata"];
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
    NSArray *dqArr=arr1[0][@"dqxx"];
    NSDictionary *dqdic;
    for (int i=0; i< dqArr.count; i++)
    {
        if ([ dqArr[i][@"dqnm"]isEqualToString:self.tf_quyu.text]) {
            dqdic=[NSDictionary dictionaryWithDictionary: dqArr[i]];
        }
    }
    if (self.dataDelegate!=nil &&[self.dataDelegate respondsToSelector:@selector(
                                                                                getTimeQuYuhuizongViewData:quyu:zhonglei:leiXing:
                                                                                 )])
{
 
        if (lxdic.count!=0  &dqdic.count !=0 &xdic.count!=0)
        {
            [self. dataDelegate  getTimeQuYuhuizongViewData:self.tf_time.text quyu:dqdic zhonglei:lxdic leiXing:xdic ];
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
