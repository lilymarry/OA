//
//  JGCXquxian2ViewController.m
//  Re-OA
//
//  Created by admin on 15/6/18.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JGCXquxian2ViewController.h"
#import "JGCXQuYuHuiZongView.h"
#import "ScreenHelper.h"
#import "JinXiaoCunWebAPI.h"
#import "CSChartsColorRegion.h"
#import "AlertHelper.h"
@interface JGCXquxian2ViewController ()<getJGCXQuYuHuiZongViewDataDelegate,CSChartsViewDelegate>
{
    UIView *bgView ; //遮罩层
    BOOL isChooseMode;
    JGCXQuYuHuiZongView *view;
    NSArray *rcArr;
    NSArray *ccArr;
    double maxwide;
    NSDictionary *dic;
    NSMutableArray *allData;
    
    
}
@property (weak, nonatomic) IBOutlet UILabel *lab_et;
@property (weak, nonatomic) IBOutlet UILabel *lab_lv;
@property (weak, nonatomic) IBOutlet UILabel *lab_zhonglei;
@property (weak, nonatomic) IBOutlet UILabel *lab_diqu;
@property (weak, nonatomic) IBOutlet UILabel *lab_leixing;
@property (weak, nonatomic) IBOutlet UILabel *lab_yewu;
@property (weak, nonatomic) IBOutlet UILabel *lab_st;
@end

@implementation JGCXquxian2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chartsView = [[CSChartsView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 233)];
    [self.view addSubview:self.chartsView];
    [self addChartsview];
}
-(void)addChartsview
{
    self.chartsView.yAxisMax = 100;
    self.chartsView.yAxisMin = 0;
    self.chartsView.yAxisSignAmount = 10;
    self.chartsView.yAxisSignFormat = @"%0.0f";
    //self.chartsView.detailRectUnitString = @"times/h";
    self.chartsView.detailRectSize = CGSizeMake(80, 25);
    self.chartsView.xAxisSignArray = nil;
    
    self.chartsView.delegate = self;
    self.chartsView.mainLinePointArray=nil;
    self.chartsView.detailRectTextFormat = @"%0.f ";
    self.chartsView.isRegionSeparated = NO;
    self.chartsView.colorRegionArray = [NSArray arrayWithObjects:CSChartsColorRegionMake([UIColor colorWithRed:211 / 255.0 green:234 / 255.0 blue:210 / 255.0 alpha:1], 40),CSChartsColorRegionMake([UIColor colorWithRed:244 / 255.0 green:250 / 255.0 blue:246 / 255.0 alpha:1], 40),nil];
    
}
- (IBAction)chaxunPress:(id)sender
{
    if (!isChooseMode) {
        [self showThebgview];
        view =[[JGCXQuYuHuiZongView alloc]  instanceJiageChaXun];
        view.dataDelegate=self;
        [self.view.window addSubview:view];
    }
}

-(void)getJGCXQuYuHuiZongViewViewData:(NSString *)st et:(NSString *)et dengji:(NSDictionary *)dengjiDic zhonglei:(NSDictionary *)zhongleiDic yewu:(NSDictionary *)yeWudic quyu:(NSDictionary *)quyu leiXing:(NSDictionary *)leixing
{
    
    [AlertHelper singleMBHUDShow:@"获取中..." ForView:self.view];

    [JinXiaoCunWebAPI getQuYuhuizongDataWithHwzl:zhongleiDic[@"zlid"] hwlv:dengjiDic[@"lvid"] dq:quyu[@"dqid"] ywlb:yeWudic[@"lbid"] hwlx:leixing[@"lxid"] kstm:st jstm:et success:^(NSArray *arr){
        [AlertHelper hidMBHUDFromView:self.view];

        _lab_st.text=st;
        _lab_et.text=et;
        _lab_zhonglei.text=zhongleiDic[@"zlnm"];
        _lab_lv.text=dengjiDic[@"lvnm"];
        _lab_diqu.text=quyu[@"dqnm"];
        _lab_yewu.text=yeWudic[@"lbnm"];
        _lab_leixing.text=leixing[@"lxnm"];
        [allData removeAllObjects];
        
        for (int i=0; i<[arr[0][@"tjdata"] count]; i++)
        {
            if ([arr[0][@"tjdata"][i][@"qunm"]isEqualToString:quyu[@"dqnm"]])
            {
                
                allData=[NSMutableArray arrayWithArray:arr[0][@"tjdata"][i][@"data"]];
            }
            
        }
        //NSLog(@"1");
        [self reloadTheRuChangList];
        
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];

    
    }];
    [self hidThebgview];
    
}
-(void)reloadTheRuChangList
{
   // NSLog(@"WWWW %@",allData);
    NSMutableArray *arr=[NSMutableArray array];
    NSMutableArray *data=[NSMutableArray array];
    if (allData.count!=0)
    {
        
        
        for (int  i=0; i<allData.count; i++)
        {
            CSChartsPoint *point0 = CSChartsPointMake(i, [allData[i][@"pjjg"]doubleValue]);
            point0.pointStyle = CSChartsPointStyleSolidWhite;
            point0.color = [UIColor colorWithRed:228 / 255.0 green:81 / 255.0 blue:26 / 255.0 alpha:1];
            [arr addObject:point0];
            [ data addObject:allData[i][@"tm"] ];
        }
        self.chartsView.xAxisSignArray=[NSArray arrayWithArray:data];
        self.chartsView.mainLinePointArray=[NSArray arrayWithArray:arr];
        [self.chartsView refreshCSChartsView];
        
    }
    else
    {
        self.chartsView.xAxisSignArray=nil;
        self.chartsView.mainLinePointArray=nil;
        [self.chartsView refreshCSChartsView];
    }
    
}





-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
    tapGesture.numberOfTapsRequired=1;
    [bgView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.8;
    }completion:^(BOOL finished){
        
    } ];
}
//撤销背景蒙板
-(void)hidThebgview{
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}
//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    [view closingTheLittleMenu:nil];
    
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
