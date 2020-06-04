//
//  PaperBoardOrderExViewController.m
//  Re-OA
//
//  Created by admin on 16/3/29.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaperBoardOrderExViewController.h"
#import "PaperBoardOrderExCell1.h"
#import "PaperBoardOrderExModel.h"
#import "PaperBoardOrderExTittle1.h"
#import "ZhiBanWebAPI.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#define tittleWidth 1066
@interface PaperBoardOrderExViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,getDelegate>
{

    NSMutableArray *dataArr;
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
    PaperBoardOrderExTittle1 *view2;
    NSString *  maxid;
    NSString *destDateString;
    NSString *  time;
    NSString *etim;
    
}


@end

@implementation PaperBoardOrderExViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    time = [dateFormatter stringFromDate:date];
    dataArr =[NSMutableArray array];
    maxid=@"";
    
    
    view2 = [[PaperBoardOrderExTittle1 alloc]instanceChooseView];
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
    [view2 refreshlab:@""];
    [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
    [ZhiBanWebAPI paperBoardOrderExWithSearchDate:time OrderExNum:@"83.5" endCount:@"0" count:@"12" maxid:@"" success:^(NSArray *arr){
        [dataArr removeAllObjects];
        [AlertHelper hideAllHUDsForView:self.view];
        
                NSArray *sarr=arr[0][@"ERP_V_PaperBoardOrderEx_Total"];
        
                NSDictionary *dic=sarr[0];
                if (dic.count>0) {
                   PaperBoardOrderExModel *model= [[ PaperBoardOrderExModel alloc]initWithDic:dic];
                 //   [dataArr addObject:model];
                    
                    [view2 refreshlab:model.ItemTotal];
                }
        maxid=arr[0][@"MaxId"];
        NSArray *daArr=arr[0][@"ERP_V_PaperBoardOrderEx"];
        for (NSDictionary *dic in daArr) {
            
            PaperBoardOrderExModel *model=[[ PaperBoardOrderExModel alloc]initWithDic:dic];
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
        [ZhiBanWebAPI  paperBoardOrderExWithSearchDate:time OrderExNum:@"83.5" endCount:[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count] count:@"12" maxid:maxid success:^(NSArray *arr){
            [AlertHelper hideAllHUDsForView:self.view];
            NSArray *daArr=arr[0][@"ERP_V_PaperBoardOrderEx"];
            for (NSDictionary *dic in daArr) {
                
                PaperBoardOrderExModel *model=[[ PaperBoardOrderExModel alloc]initWithDic:dic];
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
        PaperBoardOrderExCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PaperBoardOrderExCell1" owner:self options:nil] lastObject];
            
        }
        PaperBoardOrderExModel *model=[dataArr objectAtIndex:indexPath.row];
//    if (indexPath.row==0) {
//       // cell.num.text =[NSString stringWithFormat:@"总计:%@", model.ItemTotal];
//    }
////
//    else
//{
      cell.num.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
//   }
       // cell.SID.text=model.SID;
        cell.OrderCode.text=model.OrderCode;
       // cell.Anxious.text=model.Anxious;
     //   cell.CustomCode.text=model.CustomCode;
        cell.CustomName.text=model.CustomName;
       // cell.Abbreviation.text=model.Abbreviation;
        
      //  cell.Area.text=model.Area;
        cell.BusinessMan.text=model.BusinessMan;
    cell.yuanzhiBi.text=[NSString stringWithFormat: @"%.2f%%",[self jisuanzhiBi:model]];
//        cell.DistcountCash.text=model.DistcountCash;
//        cell.Address.text=model.Address;
//        cell.RateFreight.text=model.RateFreight;
//        cell.Mileage.text=model.Mileage;
//        cell.PinYin.text=model.PinYin;
//        cell.StorageArea.text=model.StorageArea;
//        cell.RateOfDistinct.text=model.RateOfDistinct;
        cell.PaperBoardCode.text=model.PaperBoardCode;
//        cell.CodePaperEquip.text=model.CodePaperEquip;
//        cell.PaperBoardCodeProduce.text=model.PaperBoardCodeProduce;
//        cell.CodePaperEquipProduce.text=model.CodePaperEquipProduce;
//        cell.PitCode.text=model.PitCode;
//        cell.Layer.text=model.Layer;
//        cell.SchedulingClass.text=model.SchedulingClass;
//        cell.Height.text=model.Height;
//        cell.BaseWeight.text=model.BaseWeight;
//        cell.Spec.text=model.Spec;
//        cell.SpecEx.text=model.SpecEx;
//        cell.PricSpec.text=model.PricSpec;
//        cell.ProduceSpec.text=model.ProduceSpec;
//        
//        cell.PaperKai.text=model.PaperKai;
//        cell.Degree.text=model.Degree;
//        
//        
//        cell.SetMan.text=model.SetMan;
//        cell.SetDate.text=model.SetDate;
//        cell.UpdateDate.text=model.UpdateDate;
//        
//        cell.UpdateMan.text=model.UpdateMan;
//        
//        cell.DeliveryDate.text=model.DeliveryDate;
        cell.PaperBoardWidth.text=model.PaperBoardWidth;
        
        
        cell.PaperBoardLength.text=model.PaperBoardLength;
//        cell.PaperBoardWidthPrice.text=model.PaperBoardWidthPrice;
//        cell.PaperWidth.text=model.PaperWidth;
//        
//        cell.TheEdge.text=model.TheEdge;
//        cell.PlusMm.text=model.PlusMm;
        cell.Amount.text=model.Amount;
//        cell.MaterialAmount.text=model.MaterialAmount;
//        
//        cell.LargeAmount.text=model.LargeAmount;
//        cell.SendNum.text=model.SendNum;
//        
//        
//        cell.AmountToProduce.text=model.AmountToProduce;
//        cell.PricePaperBoard.text=model.PricePaperBoard;
        cell.PriceSquare.text=model.PriceSquare;
        
        cell.CostOfPaper.text=model.CostOfPaper;
//        cell.NetEdgeSize.text=model.NetEdgeSize;
//        cell.PriceNetEdge.text=model.PriceNetEdge;
//        cell.CantDiscount.text=model.CantDiscount;
//        
//        cell.ChangePrice.text=model.ChangePrice;
//        cell.StockCode.text=model.StockCode;
//        cell.OrderType.text=model.OrderType;
//        cell.ProduceRemark.text=model.ProduceRemark;
//        cell.ShippingRemark.text=model.ShippingRemark;
//        cell.PressLine.text=model.PressLine;
//          cell.PressLine1.text=model.PressLine1;
//          cell.PressLine2.text=model.PressLine2;
//          cell.PressLine3.text=model.PressLine3;
//          cell.PressLine4.text=model.PressLine4;
//          cell.PressLine5.text=model.PressLine5;
//          cell.PressLine6.text=model.PressLine6;
//          cell.PressLine7.text=model.PressLine7;
//          cell.PressLine8.text=model.PressLine8;
//        
//        cell.PressureType.text=model.PressureType;
//        cell.Attention.text=model.Attention;
//        cell.ApproveMan.text=model.ApproveMan;
//        cell.PerSquareMeterPrice.text=model.PerSquareMeterPrice;
//        cell.PerVolume.text=model.PerVolume;
//        cell.PerSquareMeter.text=model.PerSquareMeter;
//        cell.perWeight.text=model.perWeight;
//        cell.PerSquareMeterFiveLayers.text=model.PerSquareMeterFiveLayers;
//        cell.PaperSquare.text=model.PaperSquare;
//        cell.BillSquare.text=model.BillSquare;
//        cell.BillVolume.text=model.BillVolume;
//        cell.BillWeight.text=model.BillWeight;
//        cell.BillPaperLength.text=model.BillPaperLength;
//        
//        cell.PlanSquare.text=model.PlanSquare;
//        cell.PlanVolume.text=model.PlanVolume;
//        cell.PlanWeight.text=model.PlanWeight;
//        cell.PlanPaperLength.text=model.PlanPaperLength;
//        
//        cell.ReturnAmount.text=model.ReturnAmount;
//        cell.HasChecked.text=model.HasChecked;
//        cell.PriceProcess.text=model.PriceProcess;
//        cell.InAmount.text=model.InAmount;
//        cell.TallyAmount.text=model.TallyAmount;
//        cell.TallyFlag.text=model.TallyFlag;
//        cell.PriceGroupCode.text=model.PriceGroupCode;
//        cell.PriceOffer.text=model.PriceOffer;
//        cell.DeductionAmount.text=model.DeductionAmount;
//        cell.InsertOrder.text=model.InsertOrder;
//        cell.ProduceSequence.text=model.ProduceSequence;
//        cell.ProducePlanCode.text=model.ProducePlanCode;
//        cell.DeviceCode.text=model.DeviceCode;
//        cell.TeamName.text=model.TeamName;
//        cell.TimeBeginProduce.text=model.TimeBeginProduce;
//        cell.ProduceState.text=model.ProduceState;
//        cell.ProducePlanDate.text=model.ProducePlanDate;
        cell.PitCodeGroup.text=model.PitCodeGroup;
 
        
        return cell;

}
-(double)jisuanzhiBi:(PaperBoardOrderExModel *)model
{
    double num=   [model.CostOfPaper doubleValue]/[model.PriceSquare doubleValue];
    double num1=[self exchangStr:num];
    if (num1>0) {
         return num1;
    }
    else return 0;
   
    
    

}
-(double )exchangStr:(double)doub
{
    double Bum=  round(doub*10000)/10000;
  
    return Bum*100;
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
