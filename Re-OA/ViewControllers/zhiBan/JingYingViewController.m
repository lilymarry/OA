//
//  JingYingViewController.m
//  Re-OA
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "JingYingViewController.h"
#import "SCNavTabBarController.h"
#import "DingViewController.h"
#import "PaiPingViewController.h"
#import "PaiViewController.h"
#import "SongViewController.h"
#import "YuanViewController.h"
#import "QiViewController.h"
#import "ZhiBanWebAPI.h"
#import "PaiModel.h"
#import "PaiPingModel.h"
#import "SongModel.h"
#import "YuanModel.h"
#import "QiModel.h"
#import "DingModel.h"
#import "AlertHelper.h"
#import "ZongViewController.h"
#import "ZongModel.h"
@interface JingYingViewController ()<SelectTimeDelegate>
{
    SCNavTabBarController *navTabBarController ;
    PaiModel *paiModel;
    PaiPingModel *paiPingModel;
    SongModel *songModel;
    YuanModel *yuanModel;
    DingModel *dingModel;
    QiModel *qiModel;
    ZongModel *zongModel;
    
}
@end

@implementation JingYingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    NSString *st=[NSString stringWithFormat:@"%@ 00:00",destDateString];
    NSString *et=[NSString stringWithFormat:@"%@ 23:59",destDateString];
   [self addViewControllerWithNowTime:destDateString st:st et:et state:@"1"];
   [self getData:st et:et NowTime:destDateString state:@"1"];
}
-(void)getData:(NSString *)st et:(NSString *)et NowTime:(NSString *)time state:(NSString *)sta
{
    [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
    [ZhiBanWebAPI managementSummaryWithStartDate:st endDate:et Suecss:^(NSArray *arr){
        [AlertHelper hideAllHUDsForView:self.view];

        NSDictionary *dic= arr[0][@"ERP_prManagementSummary"][0];
        //NSLog(@"2EEEE %@",arr);
        paiModel=[[PaiModel alloc]initWithDic:dic ];
        paiPingModel =[[PaiPingModel alloc]initWithDic:dic ];
        dingModel=[[DingModel alloc]initWithDic:dic ];
        
        songModel=[[SongModel alloc]initWithDic:dic];
        yuanModel=[[YuanModel alloc]initWithDic:dic];
        qiModel=[[QiModel alloc]initWithDic:dic];
        
        zongModel=[[ZongModel alloc ]initWithDic:dic];
        navTabBarController.subViewControllers=nil;
        
        
       [self addViewControllerWithNowTime:time st:st et:et state:sta];
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络错误，稍后再试" ForView:self.view AndDelayHid:2];
    }];

}
-(void)addViewControllerWithNowTime:(NSString *)NowTime st:(NSString*)time2 et:(NSString *)time3 state:(NSString *)state
{
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"ZhiBan" bundle:[NSBundle mainBundle]];
    
    ZongViewController *oneView = [s instantiateViewControllerWithIdentifier:@"zong"];
    oneView.model=zongModel;
    oneView.title = @"常用信息";
    
    DingViewController *oneViewController = [s instantiateViewControllerWithIdentifier:@"Ding"];
    oneViewController.model=dingModel;
    oneViewController.title = @"订单";

    
    
    PaiPingViewController *twoViewController = [s instantiateViewControllerWithIdentifier:@"PaiPing"];
    twoViewController.pmodel=paiPingModel;
    twoViewController.title = @"排产平方";
  
    
    PaiViewController *threeViewController = [s instantiateViewControllerWithIdentifier:@"Pai"];
    threeViewController.model=paiModel;
    threeViewController.title = @"排产";

    
   SongViewController *fourViewController = [s instantiateViewControllerWithIdentifier:@"Song"];
    fourViewController.model=songModel;
    fourViewController.title = @"送货";
    
    
    YuanViewController *fiveViewController = [s instantiateViewControllerWithIdentifier:@"Yuan"];
    fiveViewController.model=yuanModel;
    fiveViewController.title = @"原纸";
 
    
   QiViewController *sixViewController =  [s instantiateViewControllerWithIdentifier:@"Qi"];
    sixViewController .model=qiModel;
    sixViewController.title = @"其他";

    navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneView,oneViewController, twoViewController, threeViewController, fourViewController, fiveViewController, sixViewController];
    navTabBarController.delegate=self;
    navTabBarController.nowTime= NowTime;
    navTabBarController.stTime=time2;
    
    navTabBarController.etTime=time3;
    navTabBarController.state=state;
    
    //NSLog(@"---%@ %@ %@ %@ ",NowTime ,time2 ,time3 ,state);
    
    [navTabBarController addParentController:self];


}
-(void)selectTime1:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta
{
   //NSLog(@"111111WWWWW %@ %@ %@",st,et, sta);
    
    [self getData:st et:et NowTime:nowTime state:sta ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
