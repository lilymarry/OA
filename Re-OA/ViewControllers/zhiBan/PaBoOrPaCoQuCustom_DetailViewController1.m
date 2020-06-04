//
//  PaBoOrPaCoQuCustom_DetailViewController.m
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaBoOrPaCoQuCustom_DetailViewController1.h"
#import "paBoOrPaCoQuCustom_detailTittleView1.h"
#import "paBoOrPaCoQuCustom_detailModel.h"
#import "paBoOrPaCoQuCustom_detailCell1.h"
#import "ZhiBanWebAPI.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#define tittleWidth 2670
@interface PaBoOrPaCoQuCustom_DetailViewController1 ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,getTimeDelegate>
{
    NSMutableArray *dataArr;
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
    paBoOrPaCoQuCustom_detailTittleView1 *view2;
    NSString *  maxid;
    NSString *destDateString;
    NSString *  time;
}


@end

@implementation PaBoOrPaCoQuCustom_DetailViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    NSDate *date=[NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    time = [dateFormatter stringFromDate:date];
//    
//    dataArr =[NSMutableArray array];
//    maxid=@"";
//    
//    
//    view2 = [[paBoOrPaCoQuCustom_detailTittleView1 alloc]instanceChooseView];
//    [view2 refreshLab:_dateStr];
//    view2.delegate=self;
//    [self.view addSubview:view2];
//    
//    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,100, self.view.frame.size.width,self.view.frame.size.height-100)];
//    rightScrollView.bounces = NO;
//    rightScrollView.delegate = self;
//    [self.view addSubview:rightScrollView];
//    rightScrollView.contentSize = CGSizeMake(tittleWidth,self.view.frame.size.height-100);
//    
//    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, tittleWidth, CGRectGetHeight(rightScrollView.frame)-50)];
//    rightTableView.delegate = self;
//    rightTableView.dataSource = self;
//    rightTableView.rowHeight = 50;
//    [rightScrollView addSubview:rightTableView];
//    
//    [self setupRefresh];
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@订单详情",_CustomNam]];

}
-(void)viewWillAppear:(BOOL)animated
{
    dataArr =[NSMutableArray array];
    //  maxid=@"";
    
    
    view2 = [[paBoOrPaCoQuCustom_detailTittleView1 alloc]instanceChooseView];
    [view2 refreshLab:_dateStr];
    view2.delegate=self;
    [self.view addSubview:view2];

    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,100, self.view.frame.size.width,self.view.frame.size.height-100)];
    rightScrollView.bounces = NO;
    rightScrollView.delegate = self;
    [self.view addSubview:rightScrollView];
    rightScrollView.contentSize = CGSizeMake(tittleWidth,self.view.frame.size.height-100);
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, tittleWidth, CGRectGetHeight(rightScrollView.frame)-50)];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.rowHeight = 50;
    [rightScrollView addSubview:rightTableView];
    
    [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
    
    [ZhiBanWebAPI ReportDayDetailWithSearchDate:_dateStr   CustomNum:_CustomNum success:^(NSArray *arr){
        [dataArr removeAllObjects];
        [AlertHelper hideAllHUDsForView:self.view];
        NSArray *sarr=arr[0][@"ERP_prPaperBoardOrderPaperCostQueryPaperBoardOrder_Total"];
        NSDictionary *dic=sarr[0];
        if (dic.count>0) {
                           paBoOrPaCoQuCustom_detailModel *model= [[ paBoOrPaCoQuCustom_detailModel alloc]initWithDic:dic];
                            [dataArr addObject:model];
                        }
        
        NSArray *daArr=arr[0][@"ERP_prPaperBoardOrderPaperCostQueryPaperBoardOrder"];
        for (NSDictionary *dic in daArr) {
            
            paBoOrPaCoQuCustom_detailModel *model=[[ paBoOrPaCoQuCustom_detailModel alloc]initWithDic:dic];
            [dataArr addObject:model];
            
            
        }
      
        [rightTableView reloadData];
        
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络错误，稍后再试" ForView:self.view AndDelayHid:2];
        
    }];
    
    
    
    //    view2 = [[PaBoOrPaCoQuTittleView1 alloc]instanceChooseView];
    //    view2.delegate=self;
    //    [view2 refreshLab:_dateStr];
    //    [self.view addSubview:view2];
    //    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,100, self.view.frame.size.width,self.view.frame.size.height-100)];
    //    rightScrollView.bounces = NO;
    //    rightScrollView.delegate = self;
    //    [self.view addSubview:rightScrollView];
    //    rightScrollView.contentSize = CGSizeMake(tittleWidth,self.view.frame.size.height-100);
    //    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, tittleWidth, CGRectGetHeight(rightScrollView.frame)-50)];
    //    rightTableView.delegate = self;
    //    rightTableView.dataSource = self;
    //    rightTableView.rowHeight = 50;
    //    [rightScrollView addSubview:rightTableView];
    //  [self setupRefresh];
}


//- (void)setupRefresh
//{
//    
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [rightTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [rightTableView headerBeginRefreshing];
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [rightTableView addFooterWithTarget:self action:@selector(footerRereshing)];
//}
//
//#pragma mark 开始进入刷新状态
//- (void)headerRereshing
//{
//    [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
//    [ZhiBanWebAPI paBoOrPaCoQuPaBoOrderDetailWithSearchDate:time CustomNum:_CustomNum endCount:@"0" count:@"12" maxid:@"" success:^(NSArray *arr){
//        [dataArr removeAllObjects];
//              [AlertHelper hideAllHUDsForView:self.view];
//        
//                NSArray *sarr=arr[0][@"ERP_prPaperBoardOrderPaperCostQueryPaperBoardOrder_Total"];
//        
//                NSDictionary *dic=sarr[0];
//                if (dic.count>0) {
//                   paBoOrPaCoQuCustom_detailModel *model= [[ paBoOrPaCoQuCustom_detailModel alloc]initWithDic:dic];
//                    [dataArr addObject:model];
//                }
//        maxid=arr[0][@"MaxId"];
//        NSArray *daArr=arr[0][@"ERP_prPaperBoardOrderPaperCostQueryPaperBoardOrder"];
//        for (NSDictionary *dic in daArr) {
//            
//            paBoOrPaCoQuCustom_detailModel *model=[[ paBoOrPaCoQuCustom_detailModel alloc]initWithDic:dic];
//            [dataArr addObject:model];
//            
//            
//        }
//        [rightTableView reloadData];
//        //结束刷新状态
//        [rightTableView  headerEndRefreshing];
//    } fail:^(){}];
//    
//}
//
//- (void)footerRereshing
//{
//    if (dataArr.count==0)
//    {
//        //  self.tableView.footerRefreshingText = @"无更新数据";
//        //  [self.tableView footerEndRefreshing];
//        return ;
//    }
//    else
//    {
//        [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
//        [ZhiBanWebAPI paBoOrPaCoQuPaBoOrderDetailWithSearchDate:time CustomNum:_CustomNum endCount:[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count-1] count:@"12" maxid:maxid success:^(NSArray *arr){
//            [AlertHelper hideAllHUDsForView:self.view];
//            NSArray *daArr=arr[0][@"ERP_prPaperBoardOrderPaperCostQueryPaperBoardOrder"];
//            for (NSDictionary *dic in daArr) {
//                
//                paBoOrPaCoQuCustom_detailModel *model=[[ paBoOrPaCoQuCustom_detailModel alloc]initWithDic:dic];
//                [dataArr addObject:model];
//                
//                
//            }
// 
//            [rightTableView reloadData];
//            //结束刷新状态
//            [rightTableView footerEndRefreshing];
//        } fail:^(){}];
//        
//    }
//    
//}
-(NSString *)seachtime:(NSString *)str
{
    
    NSString *st=@" ";
    NSRange range = [str rangeOfString:st];//匹配得到的下标
    if (range.location !=NSNotFound)
    {
        str = [str substringToIndex:range.location];//截取范围类的字符串
        
    }
    return str;
}

-(void)getTime:(NSString *)st
{
    
    time=[self seachtime:st] ;
    [rightTableView headerBeginRefreshing];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ScrollViewDelegate
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

//防止滑动过程中锁定方向不让滑动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate)
        [self scrollViewDidEndDecelerating:scrollView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArr count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identfier=@"cell";
    paBoOrPaCoQuCustom_detailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"paBoOrPaCoQuCustom_detailCell1" owner:self options:nil] lastObject];
        
    }
    paBoOrPaCoQuCustom_detailModel *model=[dataArr objectAtIndex:indexPath.row];
    
    if (indexPath.row==0) {
        cell.lab_num.text =[NSString stringWithFormat:@"总计:%@", model.ItemTotal];
    }
    
    else
    {
        cell.lab_num.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    
    
    cell.lab_OrderCode.text=model.OrderCode;
    cell.lab_PaperBoardName.text=model.PaperBoardName;
    cell.lab_PaperBoardCodeProduce.text=model.PaperBoardCodeProduce;
    cell.lab_PaperKai.text=model.PaperKai;
    cell.lab_PaperWidth.text=model.PaperWidth;
    cell.lab_PaperBoardLength.text=model.PaperBoardLength;
    
    cell.lab_OrderNum.text=model.OrderNum;
    cell.lab_SaleAmount.text=model.SaleAmount;
    cell.lab_PaperBoardSpecifications.text=model.PaperBoardSpecifications;
    cell.lab_ValuationSpecifications.text=model.ValuationSpecifications;
    cell.lab_PproducteExplain.text=model.PproducteExplain;
    cell.lab_DeliveryExplain.text=model.DeliveryExplain;

    cell.lab_SquarePrice.text=model.SquarePrice;


    cell.lab_Cube.text=model.Cube;
    cell.lab_Square.text=model.Square;
    cell.lab_OrderDateTime.text=model.OrderDateTime;
    cell.lab_ScheduleNum.text=model.ScheduleNum;
    cell.lab_DeliveryDateTime.text=model.DeliveryDateTime;
    cell.lab_CustomPurchaseNum.text=model.CustomPurchaseNum;
    cell.lab_CustomCode.text=model.CustomCode;
    cell.lab_SaleAmount.text=model.SaleAmount;
    cell.lab_Abbreviation.text=model.Abbreviation;
    cell.lab_PaperPrice.text=model.PaperPrice;
    cell.lab_Trimming.text=model.Trimming;
    
    cell.lab_TrimmingRatio.text=model.TrimmingRatio;
    cell.lab_Salesman.text=model.Salesman;
    
    
    cell.lab_DeliveryNum.text=model.DeliveryNum;
    cell.lab_TallyNum.text=model.TallyNum;
    cell.lab_CarNum.text=model.CarNum;
    
    cell.lab_PrintDateTime.text=model.PrintDateTime;
    
    if ([_quanXianId1 isEqualToString:@"ywymrdd"]) {
        cell.lab_BasePaperSquarePrice.text=@"无权限";
        cell.lab_BasePaperAmount.text=@"无权限";
        cell.lab_ProcessingCost.text=@"无权限";
        cell.lab_BasePaperPercent.text=@"无权限";
        
    }
    else
    {
        cell.lab_BasePaperSquarePrice.text=model.BasePaperSquarePrice;
        cell.lab_BasePaperAmount.text=model.BasePaperAmount;
        cell.lab_ProcessingCost.text=model.ProcessingCost;
        cell.lab_BasePaperPercent.text=model.BasePaperPercent;
        
    }


    return cell;
    
    
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
