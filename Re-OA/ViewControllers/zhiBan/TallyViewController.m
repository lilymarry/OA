//
//  TallyViewController.m
//  Re-OA
//
//  Created by 123 on 16/3/13.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "TallyViewController.h"
#import "ZhiBanWebAPI.h"
#import "TallyViewCell.h"
#import "TallyModel.h"
#import "TallyTittleView.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#define tittleWidth 3760
@interface TallyViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,getTimeDelegate>
{
    NSMutableArray *dataArr;
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
    TallyTittleView *view2;
    NSString *  maxid;
    NSString *destDateString;
    NSString *stim;
    NSString *etim;
    
}


@end

@implementation TallyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    destDateString = [dateFormatter stringFromDate:date];
    stim=[NSString stringWithFormat:@"%@ 00:00",destDateString];
    etim=[NSString stringWithFormat:@"%@ 23:59",destDateString];
    
   //  self. automaticallyAdjustsScrollViewInsets=NO;
    
    dataArr =[NSMutableArray array];
    maxid=@"";
    
    
    view2 = [[TallyTittleView alloc]instanceChooseView];
    view2.delegate=self;
    [self.view addSubview:view2];
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,100, self.view.frame.size.width,self.view.frame.size.height-200)];
    rightScrollView.bounces = NO;
    rightScrollView.delegate = self;
    [self.view addSubview:rightScrollView];
    rightScrollView.contentSize = CGSizeMake(tittleWidth,self.view.frame.size.height-200);
    
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
    [ZhiBanWebAPI tallyWithStartDate:stim  endDate:etim endCount:@"0" count:@"12" maxid:@"" success:^(NSArray *arr){
        [dataArr removeAllObjects];
       [AlertHelper hideAllHUDsForView:self.view];
        
        NSArray *sarr=arr[0][@"ERP_V_Tally_Total"];
        
        NSDictionary *dic=sarr[0];
        if (dic.count>0) {
            TallyModel *model= [[ TallyModel alloc]initWithDic:dic];
            [dataArr addObject:model];
        }

        maxid=arr[0][@"MaxId"];
        NSArray *daArr=arr[0][@"ERP_V_Tally"];
        for (NSDictionary *dic in daArr) {
            
            TallyModel *model=[[TallyModel alloc]initWithDic:dic];
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
        [ZhiBanWebAPI tallyWithStartDate:stim endDate:etim endCount:[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count-1] count:@"12" maxid:maxid success:^(NSArray *arr){
                 [AlertHelper hideAllHUDsForView:self.view];
            NSArray *daArr=arr[0][@"ERP_V_Tally"];
            for (NSDictionary *dic in daArr) {
                
                TallyModel *model=[[TallyModel alloc]initWithDic:dic];
                [dataArr addObject:model];
                
                
            }
        
            [rightTableView reloadData];
            //结束刷新状态
            [rightTableView footerEndRefreshing];
        } fail:^(){}];
        
    }
    
}
-(void)getTime:(NSString *)st et:(NSString *)et
{
   // NSLog(@"WWWWW %@",st);
    stim=st ;
    etim=et;
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
    TallyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TallyViewCell" owner:self options:nil] lastObject];
        
    }
    TallyModel *model=[dataArr objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        cell.lab_num.text =[NSString stringWithFormat:@"总计:%@", model.ItemTotal];
    }
    
    else
    {
        cell.lab_num.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }


    cell.lab_State.text=model.State;
    cell.lab_StateApprove.text=model.StateApprove;
    cell.lab_SetMan.text=model.SetMan;
    cell.lab_TallyMan.text=model.TallyMan;
    cell.lab_DeliveryMan.text=model.DeliveryMan;
    cell.lab_PrintMan.text=model.PrintMan;
    cell.lab_Stevedore.text=model.Stevedore;
    cell.lab_Code.text=model.Code;
    cell.lab_SetDate.text=model.SetDate;
    cell.lab_PrintTime.text=model.PrintTime;
    cell.lab_VehicleCode.text=model.VehicleCode;
    cell.lab_Driver.text=model.Driver;
    cell.lab_DeliveryDate.text=model.DeliveryDate;
    cell.lab_RateFreight.text=model.RateFreight;
    cell.lab_Freight.text=model.Freight;
    cell.lab_TheoryFreight.text=model.TheoryFreight;
    cell.lab_PlateNumber.text=model.PlateNumber;
    cell.lab_CustomAmount.text=model.CustomAmount;
    cell.lab_Mileage.text=model.Mileage;
    cell.lab_MoneyDelivery.text=model.MoneyDelivery;
    cell.lab_Volume.text=model.Volume;
    cell.lab_VolumePrice.text=model.VolumePrice;
    cell.lab_Weight.text=model.Weight;
    cell.lab_fnGetTallyCustomName.text=model.fnGetTallyCustomName;
    cell.lab_Mobile.text=model.Mobile;
    cell.lab_OrderAmount.text=model.OrderAmount;
    cell.lab_ReturnAmount.text=model.ReturnAmount;
    cell.lab_ReturnTime.text=model.ReturnTime;
    
    cell.lab_HasDelivery.text=model.HasDelivery;
    cell.lab_DeliveryHasPrinted.text=model.DeliveryHasPrinted;
    cell.lab_HasFreight.text=model.HasFreight;
    
    cell.lab_SquareAmount.text=model.SquareAmount;
    cell.lab_SquareFiveLayers.text=model.SquareFiveLayers;
    cell.lab_SquareFiveLayersPrice.text=model.SquareFiveLayersPrice;
    cell.lab_FreightSquare.text=model.FreightSquare;
    cell.lab_TheoryFreightSquare.text=model.TheoryFreightSquare;
    cell.lab_CustomSubsidy.text=model.CustomSubsidy;
    cell.lab_OrderSubsidy.text=model.OrderSubsidy;
    cell.lab_Remark.text=model.Remark;
    cell.lab_Sequence.text=model.Sequence;
    cell.lab_BillAmount.text=model.BillAmount;
    cell.lab_FreightByCustomOnly.text=model.FreightByCustomOnly;
    cell.lab_RateByCustomOnly.text=model.RateByCustomOnly;
    cell.lab_SID.text=model.SID;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
