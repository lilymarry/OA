//
//  OrderSummaryViewController.m
//  Re-OA
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "OrderSummaryViewController.h"
#import "ZhiBanWebAPI.h"
#import "OrderSummaryCell.h"
#import "OrderSummaryModel.h"
#import "OrderSummaryTittleView.h"
#import "AlertHelper.h"
#define tittleWidth 960
@interface OrderSummaryViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,getTimeDelegate>
{
    NSMutableArray *data;
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
    OrderSummaryTittleView *view2;
}
@end
@implementation OrderSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data=[NSMutableArray array];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *   destDateString = [dateFormatter stringFromDate:date];
    
    view2 = [[OrderSummaryTittleView alloc]instanceChooseView];
    view2.delegate=self;
    [self.view addSubview:view2];
    
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height-100)];
    rightScrollView.bounces = NO;
    rightScrollView.delegate = self;
    [self.view addSubview:rightScrollView];
    rightScrollView.contentSize = CGSizeMake(tittleWidth,self.view.frame.size.height-100);
    
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, tittleWidth, CGRectGetHeight(rightScrollView.frame)-50)];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.rowHeight = 50;
    [rightScrollView addSubview:rightTableView];
    
    
    NSString *stim=[NSString stringWithFormat: @"%@ 00:00",destDateString];
    NSString *etim=[NSString stringWithFormat:@"%@ 23:59",destDateString];
    
    [self selectTime:stim andEndTime:etim];
    
    
    
}
-(void)getTime:(NSString *)st et:(NSString *)et
{
    
    [self selectTime:st andEndTime:et];
    
}
-(void)selectTime:(NSString *)st andEndTime:(NSString *)et
{
    [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
    [ZhiBanWebAPI businessManOrderSummaryWithStartDate:st  endDate:et success:^(NSArray *arr){
        [data removeAllObjects];
        [AlertHelper hideAllHUDsForView:self.view];
        NSArray *sarr=arr[0][@"ERP_prBusinessManOrderSummary_Total"];
        if (sarr.count>0) {
            NSDictionary *dic=sarr[0];
            OrderSummaryModel *model= [[OrderSummaryModel alloc]initWithDic:dic];
            [data addObject:model];
        }
        NSArray *dataArr=arr[0][@"ERP_prBusinessManOrderSummary"];
        for (NSDictionary *dic in dataArr ) {
            OrderSummaryModel *model= [[OrderSummaryModel alloc]initWithDic:dic];
            [data addObject:model];
            
        }
        [rightTableView reloadData];
     
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络错误，稍后再试" ForView:self.view AndDelayHid:2];
        
    }];
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //重新布下局
    view2.frame = CGRectMake(0, 70, tittleWidth, 85);
    view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, tittleWidth, 85);
    view2.clipsToBounds = YES;
    [self.view addSubview:view2];
    [rightTableView reloadData];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.0];
    view2.frame = CGRectMake(0, 70, tittleWidth,85);
    view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, tittleWidth, 85);
    view2.clipsToBounds = YES;
    [self.view addSubview:view2];
    [UIView commitAnimations];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return data.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   OrderSummaryModel *model = [data objectAtIndex:indexPath.row];
    
    OrderSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    if (!cell) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"OrderSummaryCell" owner:self options:nil];
        cell= [nibView lastObject];
    }
    if (indexPath.row==0) {
        cell.lab_num.text =@"总计";
    }
    
    else
    {
        cell.lab_num.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    
    cell.lab_SalesMan.text=model.SalesMan;
    cell.lab_ModelsNum.text=model.ModelsNum;
    cell.lab_CustomerNum.text=model.CustomerNum;
    cell.lab_BeforeDiscountAmount.text=model.BeforeDiscountAmount;
    cell.lab_AfterDiscountAmount.text=model.AfterDiscountAmount;
    cell.lab_MeterNum.text=model.MeterNum;
    cell.lab_Square.text=model.Square;
    cell.lab_Cube.text=model.Cube;
    cell.lab_BasePaperAmount.text=model.BasePaperAmount;
    cell.lab_GrossProfit.text=model.GrossProfit;
    cell.lab_BasePaperProportion.text=model.BasePaperProportion;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
