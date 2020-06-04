//
//  OrderSummaryViewController.m
//  Re-OA
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "OrderSummaryViewController1.h"
#import "ZhiBanWebAPI.h"
#import "OrderSummaryCell1.h"
#import "OrderSummaryModel.h"
#import "OrderSummaryTittleView1.h"
#import "AlertHelper.h"
#import "UserPermission.h"
#import "PaBoOrPaCoQuCustom_TotalListViewController1.h"
#define tittleWidth 960
@interface OrderSummaryViewController1 ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,getTimeDelegate>
{
    NSMutableArray *data;
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
    OrderSummaryTittleView1 *view2;
    NSString *time;
}
@end
@implementation OrderSummaryViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
     self. automaticallyAdjustsScrollViewInsets=NO;
    data=[NSMutableArray array];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *   destDateString = [dateFormatter stringFromDate:date];
    
    view2 = [[OrderSummaryTittleView1 alloc]instanceChooseView];
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
    
    
    // NSString *stim=[NSString stringWithFormat: @"%@ 00:00",destDateString];
    // NSString *etim=[NSString stringWithFormat:@"%@ 23:59",destDateString];
    time=destDateString;
    [self selectTime:time andEndTime:destDateString];
}
-(NSString *)subString:(NSString *)str
{
    if (str.length==0)
    {
        return nil;
    }
    else
    {
        NSString *string=@" ";
        NSRange range = [str  rangeOfString:string];//匹配得到的下标
      //  NSString *   temp = [str substringFromIndex:range.length+range.location];//截取范围类的字符串
        
        NSString *tem=[str substringToIndex:range.location];
        
        return [NSString stringWithFormat: @"%@",tem];
    }
}
-(void)getTime:(NSString *)st et:(NSString *)et
{
    
    time=[self subString:st];
    [self selectTime:time andEndTime:et];
    
}
-(void)selectTime:(NSString *)st andEndTime:(NSString *)et
{
    [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
    [ZhiBanWebAPI ReportBusinessManOrderWithSearchDate:st   uid:[UserPermission standartUserInfo].ID success:^(NSArray *arr){
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
    
    OrderSummaryCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
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
    if ([_quanXianId1 isEqualToString:@"ywymrdd"]) {
        cell.lab_BasePaperAmount.text=@"无权限";
        cell.lab_GrossProfit.text=@"无权限";
        cell.lab_BasePaperProportion.text=@"无权限";
    }
    else
    {
    cell.lab_BasePaperAmount.text=model.BasePaperAmount;
    cell.lab_GrossProfit.text=model.GrossProfit;
    cell.lab_BasePaperProportion.text=model.BasePaperProportion;
    }
 
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row!=0) {
        
 
    OrderSummaryModel *model=[data objectAtIndex:indexPath.row];
   UIStoryboard *s = [UIStoryboard storyboardWithName:@"ZhiBan" bundle:[NSBundle mainBundle]];
    PaBoOrPaCoQuCustom_TotalListViewController1 *changyongController = [s instantiateViewControllerWithIdentifier:@"PaBoOrPaCoQu"];
   changyongController.yw=model.SalesMan;
    changyongController.dateStr=time;
    changyongController.quanXianId1=_quanXianId1;
    
    [self.navigationController pushViewController:changyongController animated:YES];
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
