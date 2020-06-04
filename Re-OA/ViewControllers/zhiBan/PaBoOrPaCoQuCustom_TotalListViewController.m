//
//  PaBoOrPaCoQuCustom_TotalListViewController.m
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaBoOrPaCoQuCustom_TotalListViewController.h"
#import "PaBoOrPaCoQuTittleView.h"
#import "paBoOrPaCoQuCustom_TotalListModel.h"
#import "paBoOrPaCoQuCustom_TotalListCell.h"
#import "PaBoOrPaCoQuCustom_DetailViewController.h"
#import "ZhiBanWebAPI.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#define tittleWidth 2420
@interface PaBoOrPaCoQuCustom_TotalListViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,getTimeDelegate>
{
    NSMutableArray *dataArr;
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
     PaBoOrPaCoQuTittleView *view2;
    NSString *  maxid;
     NSString *  time;
}
@end

@implementation PaBoOrPaCoQuCustom_TotalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    time = [dateFormatter stringFromDate:date];
    
    dataArr =[NSMutableArray array];
    maxid=@"";
}
-(void)viewWillAppear:(BOOL)animated
{

    
    view2 = [[PaBoOrPaCoQuTittleView alloc]instanceChooseView];
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
    [self setupRefresh];
}

- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [rightTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [rightTableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [rightTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
    [ZhiBanWebAPI paBoOrPaCoQuCustomWithSearchDate:time endCount:@"0" count:@"12" maxid:@"" success:^(NSArray *arr){
        [dataArr removeAllObjects];
        [AlertHelper hideAllHUDsForView:self.view];
        
        maxid=arr[0][@"MaxId"];
        NSArray *daArr=arr[0][@"ERP_prPaperBoardOrderPaperCostQueryCustom"];
        for (NSDictionary *dic in daArr) {
            
             paBoOrPaCoQuCustom_TotalListModel *model=[[ paBoOrPaCoQuCustom_TotalListModel alloc]initWithDic:dic];
            [dataArr addObject:model];
            
            
        }
   
        [rightTableView reloadData];
        //结束刷新状态
        [rightTableView  headerEndRefreshing];
    } fail:^(){}];
    
}

- (void)footerRereshing
{
    if (dataArr.count==0)
    {
        //  self.tableView.footerRefreshingText = @"无更新数据";
        //  [self.tableView footerEndRefreshing];
        return ;
    }
    else
    {
        [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
        [ZhiBanWebAPI paBoOrPaCoQuCustomWithSearchDate:time endCount:[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count] count:@"12" maxid:maxid success:^(NSArray *arr){
            [AlertHelper hideAllHUDsForView:self.view];
            NSArray *daArr=arr[0][@"ERP_prPaperBoardOrderPaperCostQueryCustom"];
            for (NSDictionary *dic in daArr) {
                
                paBoOrPaCoQuCustom_TotalListModel *model=[[ paBoOrPaCoQuCustom_TotalListModel alloc]initWithDic:dic];
                [dataArr addObject:model];
                
                
            }
            [rightTableView reloadData];
            //结束刷新状态
            [rightTableView footerEndRefreshing];
        } fail:^(){}];
        
    }
    
}
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
        paBoOrPaCoQuCustom_TotalListCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"paBoOrPaCoQuCustom_TotalListCell" owner:self options:nil] lastObject];
            
        }
        paBoOrPaCoQuCustom_TotalListModel *model=[dataArr objectAtIndex:indexPath.row];
  
        cell.lab_num.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    
    
        cell.lab_CustomCode.text=model.CustomCode;
        cell.lab_Abbreviation.text=model.Abbreviation;
        cell.lab_Region.text=model.Region;
        cell.lab_BusinessMan.text=model.BusinessMan;
        cell.lab_ReducedSquare.text=model.ReducedSquare;
        cell.lab_Cube.text=model.Cube;
        cell.lab_PaperSize.text=model.PaperSize;
        cell.lab_Num.text=model.Num;
        cell.lab_TrimmingLoss.text=model.TrimmingLoss;
        cell.lab_Meters.text=model.Meters;
        cell.lab_TwoLayersMeters.text=model.TwoLayersMeters;
        cell.lab_SinglePitMeters.text=model.SinglePitMeters;
        cell.lab_DoublePitMeters.text=model.DoublePitMeters;
        cell.lab_ThreePitMeters.text=model.ThreePitMeters;
        cell.lab_Square.text=model.Square;
        cell.lab_TwoLayersSquare.text=model.TwoLayersSquare;
        cell.lab_SinglePitSquare.text=model.SinglePitSquare;
        cell.lab_DoublePitSquare.text=model.DoublePitSquare;
        cell.lab_ThreePitSquare.text=model.ThreePitSquare;
        cell.lab_Amount.text=model.Amount;
        cell.lab_TwoLayersAmount.text=model.TwoLayersAmount;
        cell.lab_SinglePitAmount.text=model.SinglePitAmount;
        cell.lab_DoublePitAmount.text=model.DoublePitAmount;
        cell.lab_ThreePitAmount.text=model.ThreePitAmount;
        cell.lab_SaleAmount.text=model.SaleAmount;
        cell.lab_SaleTwoLayersAmount.text=model.SaleTwoLayersAmount;
        cell.lab_SaleSinglePitAmount.text=model.SaleSinglePitAmount;
        cell.lab_SaleDoublePitAmount.text=model.SaleDoublePitAmount;
        cell.lab_SaleThreePitAmount.text=model.SaleThreePitAmount;
        cell.lab_WariningNum.text=model.WariningNum;
        return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    paBoOrPaCoQuCustom_TotalListModel *model=[dataArr objectAtIndex:indexPath.row];
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"ZhiBan" bundle:[NSBundle mainBundle]];
    PaBoOrPaCoQuCustom_DetailViewController *changyongController = [s instantiateViewControllerWithIdentifier:@"PaBoOrPaCoQuCustom"];
    changyongController.CustomNum=model.CustomCode;

    [self.navigationController pushViewController:changyongController animated:YES];



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
