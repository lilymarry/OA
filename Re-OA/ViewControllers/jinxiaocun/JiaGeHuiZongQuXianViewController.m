//
//  JiaGeHuiZongQuXianViewController.m
//  Re-OA
//
//  Created by admin on 15/5/5.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JiaGeHuiZongQuXianViewController.h"
#import "CSChartsColorRegion.h"
#import "ScreenHelper.h"
#import "AlertHelper.h"
#import "JinXiaoCunWebAPI.h"
@interface JiaGeHuiZongQuXianViewController ()<getViewDataDelegate ,CSChartsViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lab_st;
@property (weak, nonatomic) IBOutlet UILabel *lab_et;
@property (weak, nonatomic) IBOutlet UILabel *lab_zhonglei;
@property (weak, nonatomic) IBOutlet UILabel *lab_lv;

@end


@implementation JiaGeHuiZongQuXianViewController
{
    UIView *bgView ; //遮罩层
    BOOL isChooseMode;
    JiageChaXun *view;
    NSArray *rcArr;
    NSArray *ccArr;
    double maxwide;
    NSDictionary *dic;
    NSMutableArray *allData;
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chartsView = [[CSChartsView alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 233)];
    [self.view addSubview:self.chartsView];
    [self addChartsview];

}
-(void)viewDidAppear:(BOOL)animated
{
    if (self.segmentControl.selectedSegmentIndex==0)
    {
        [self reloadTheRuChangList];
    }
    else
    {
       [self reloadTheRuChangList];
    }

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
        view =[[JiageChaXun alloc]  instanceJiageChaXun];
        view.dataDelegate=self;
        [self.view.window addSubview:view];
    }
}
//改变列表
- (IBAction)changeList:(id)sender {
    
    if (self.segmentControl.selectedSegmentIndex==0)
    {
        
        [self reloadTheRuChangList];
        
    }
    else
    {
        [self reloadTheChuChangList];
    }
}
-(void)getJiaGechaXunViewData:(NSString *)st andEt:(NSString *)et dengji:(NSDictionary *)dengjiDic zhonglei:(NSDictionary *)zhongleiDic
{
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    
    [JinXiaoCunWebAPI getZhudetaillistDataWithHwlv:dengjiDic[@"lvid"] hwzl:zhongleiDic[@"zlid"] kstm:st jstm:et success:^(NSArray *arr){
        
        [AlertHelper hideAllHUDsForView:self.view];
        _lab_st.text=st;
        _lab_et.text=et;
        _lab_zhonglei.text=zhongleiDic[@"zlnm"];
        _lab_lv.text=dengjiDic[@"lvnm"];
        [allData removeAllObjects];
        allData=[NSMutableArray arrayWithArray:arr];
        if (self.segmentControl.selectedSegmentIndex==0)
        {
            [self reloadTheRuChangList];
        }
        else
        {
            [self reloadTheChuChangList];
        }
    } fail:^(){
        [AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];
    }];
    
    [self hidThebgview];
    [view closingTheLittleMenu:nil];
    
}

-(void)reloadTheRuChangList
{
    NSMutableArray *arr=[NSMutableArray array];
    NSMutableArray *data=[NSMutableArray array];
    if (allData.count!=0)
    {   if([allData[0][@"rc"] count]!=0)
    {
        rcArr= allData[0][@"rc"];
        for (int  i=0; i<rcArr.count; i++)
        {
            CSChartsPoint *point0 = CSChartsPointMake(i, [rcArr[i][@"pjjg"]doubleValue]);
            point0.pointStyle = CSChartsPointStyleSolidWhite;
            point0.color = [UIColor colorWithRed:228 / 255.0 green:81 / 255.0 blue:26 / 255.0 alpha:1];
            [arr addObject:point0];
            [ data addObject:rcArr[i][@"tm"] ];
        }
        self.chartsView.xAxisSignArray=[NSArray arrayWithArray:data];
        self.chartsView.mainLinePointArray=[NSArray arrayWithArray:arr];
        
    }
    else
    {
        rcArr=nil;
        self.chartsView.xAxisSignArray=nil;
        self.chartsView.mainLinePointArray=nil;
      
    }
      
        
         [self.chartsView refreshCSChartsView];
    }
    
    
    
    
}
-(void)reloadTheChuChangList{
    NSMutableArray *arr=[NSMutableArray array];
    NSMutableArray *data=[NSMutableArray array];
    if (allData.count!=0)
    { if([allData[0][@"cc"] count ]!=0)
    {
        ccArr=allData[0][@"cc"];
        for (int  i=0; i<ccArr.count; i++)
        {
            CSChartsPoint *point0 = CSChartsPointMake(i, [ccArr[i][@"pjjg"]doubleValue]);
            point0.pointStyle = CSChartsPointStyleSolidWhite;
            point0.color = [UIColor colorWithRed:228 / 255.0 green:81 / 255.0 blue:26 / 255.0 alpha:1];
            [arr addObject:point0];
            [ data addObject:ccArr[i][@"tm"] ];
        }
        self.chartsView.xAxisSignArray=[NSArray arrayWithArray:data];
        self.chartsView.mainLinePointArray=arr;
        
    }
    else
    {
        ccArr=nil;
        self.chartsView.xAxisSignArray=nil;
        self.chartsView.mainLinePointArray=nil;

    }
       
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
