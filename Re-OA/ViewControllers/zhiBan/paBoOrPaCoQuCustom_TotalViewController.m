//
//  paBoOrPaCoQuCustom_TotalViewController.m
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "paBoOrPaCoQuCustom_TotalViewController.h"
#import "ZhiBanWebAPI.h"
#import "paBoOrPaCoQuCustom_TotalModel.h"
#import "paBoOrPaCoQuCustom_TotalListModel.h"
#import "ChooseDateView.h"
#import "PaBoOrPaCoQuView.h"
#import "ScreenHelper.h"
#import "AlertHelper.h"
@interface paBoOrPaCoQuCustom_TotalViewController ()<RenWuDateChooseDelegate>
{   ChooseDateView *st_view;
    NSMutableArray *dataArr;
    UIView *bgView ; //遮罩层
    PaBoOrPaCoQuView *choseview;
    paBoOrPaCoQuCustom_TotalModel *model;

}

@property (weak, nonatomic) IBOutlet UILabel *lab_ReducedSquare ;//折合平方
@property (weak, nonatomic) IBOutlet UILabel *lab_Cube;//立方
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperSize;//纸度
@property (weak, nonatomic) IBOutlet UILabel *lab_Num;//款数
@property (weak, nonatomic) IBOutlet UILabel *lab_TrimmingLoss ;//修边损耗量
@property (weak, nonatomic) IBOutlet UILabel *lab_Meters ;//米数

@property (weak, nonatomic) IBOutlet UILabel *lab_Square ;//平方

@property (weak, nonatomic) IBOutlet UILabel *lab_Amount  ;//原纸金额

@property (weak, nonatomic) IBOutlet UILabel *lab_SaleAmount ;//折后金额

@property (weak, nonatomic) IBOutlet UILabel *lab_WariningNum;//预警款数
@property (weak, nonatomic) IBOutlet UILabel *lab_TrimmingRatio;//修边率
@property (weak, nonatomic) IBOutlet UILabel *lab_GateNum ;//门幅数量
@property (weak, nonatomic) IBOutlet UILabel *lab_AverageWidth  ;//平均幅宽
@property (weak, nonatomic) IBOutlet UILabel *lab_MetersProportion ;//原纸比例

@property (weak, nonatomic) IBOutlet UILabel *lab_ProcessCost ;  //加工费

@property (weak, nonatomic) IBOutlet UILabel *lab_GrossProfit ; //毛利润
@property (weak, nonatomic) IBOutlet UILabel *lab_WariningProportion; //预警比例

@property (weak, nonatomic) IBOutlet UITextField *tf_time;


@end

@implementation paBoOrPaCoQuCustom_TotalViewController
- (IBAction)lastTimePress:(id)sender {
}
- (IBAction)TimePress:(id)sender {
    
    UIButton *but= (UIButton *) sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 00:00",_tf_time.text]];
    NSDate *lastDay;
    if (but.tag==1000) {//时区问题 +8
        lastDay = [NSDate dateWithTimeInterval:-24*60*60+8 sinceDate:date];
        
    }
    else
    {
        lastDay = [NSDate dateWithTimeInterval:+24*60*60+8 sinceDate:date];
    }
    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    [dateform setDateFormat:@"yyyy-MM-dd"];
    
    _tf_time.text=[dateform stringFromDate:lastDay];
    [self getData:_tf_time.text];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArr =[NSMutableArray array];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _tf_time.text = [dateFormatter stringFromDate:date];
    
    //_tf_time.text=destDateString;
    
    st_view = [ChooseDateView instanceChooseDateView];
    st_view.chooseDateDelegate=self;
    st_view.dateId=@"1";
    
    _tf_time.inputView=st_view;
    
    
 
    [self getData:_tf_time.text];
    

    
}
-(void)getData:(NSString *)str
{
      [AlertHelper MBHUDShow:@"获取中--" ForView:self.view AndDelayHid:30];
    [ZhiBanWebAPI paBoOrPaCoQuCustomWithSearchDate:str endCount:@"0" count:@"12" maxid:@"" success:^(NSArray *arr){
        // NSLog(@"zong-------%@",arr);
          [AlertHelper hideAllHUDsForView:self.view];
        NSArray *data=  arr[0][@"ERP_prPaperBoardOrderPaperCostQueryCustom_Total"];
        if (data.count >0) {
            NSDictionary *dic = data[0];
            model=[[paBoOrPaCoQuCustom_TotalModel alloc]initWithDic:dic];
            _lab_ReducedSquare.text=model.ReducedSquare;
            _lab_Cube.text=model.Cube;
            _lab_PaperSize.text=model.PaperSize;
            _lab_Num.text=model.Num;
            _lab_TrimmingLoss.text=model.TrimmingLoss;
            _lab_Meters.text=model.Meters;
            _lab_Square.text=model.Square;
            _lab_Amount.text=model.Amount;
            _lab_SaleAmount.text=model.SaleAmount;
            _lab_WariningNum.text=model.WariningNum;
            _lab_TrimmingRatio.text=[NSString stringWithFormat:@"%@%%",model.TrimmingRatio];
            _lab_GateNum.text=model.GateNum;
            _lab_AverageWidth.text=model.AverageWidth;
            _lab_MetersProportion.text=model.MetersProportion;
            _lab_ProcessCost.text=model.ProcessCost;
            _lab_GrossProfit.text=model.GrossProfit;
            _lab_WariningProportion.text=[NSString stringWithFormat:@"%@%%",model.WariningProportion];
            
        }
        
        
    } fail:^(){
         [AlertHelper hideAllHUDsForView:self.view];
    
    }];


}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid{
    
   
        
        _tf_time.text=dateStr;
        [_tf_time resignFirstResponder];
       [self getData:_tf_time.text];
    
    
}
- (IBAction)detailPress:(id)sender {
    UIButton *but =(UIButton *)sender;
    switch (but.tag) {
        case 2000:
            [self showDetailViewTittle1:@"二层米数"tittle2:@"单坑米数" tittle3:@"双坑米数" tittle4:@"三坑米数" c1:model.TwoLayersMeters c2:model.SinglePitMeters c3:model.DoublePitMeters c4:model.ThreePitMeters];
            break;
        case 2001:
           [self showDetailViewTittle1:@"二层平方"tittle2:@"单坑平方" tittle3:@"双坑平方" tittle4:@"三坑平方" c1:model.TwoLayersSquare c2:model.SinglePitSquare c3:model.DoublePitSquare c4:model.ThreePitSquare];
            break;
        case 2002:
           [self showDetailViewTittle1:@"二层原纸金额"tittle2:@"单坑原纸金额" tittle3:@"双坑原纸金额" tittle4:@"三坑原纸金额" c1:model.TwoLayersAmount c2:model.SinglePitAmount c3:model.DoublePitAmount c4:model.ThreePitAmount];
            break;
        case 2003:
            [self showDetailViewTittle1:@"二层折后金额"tittle2:@"单坑折后金额" tittle3:@"双坑折后金额" tittle4:@"三坑折后金额" c1:model.SaleTwoLayersAmount c2:model.SaleSinglePitAmount c3:model.SaleDoublePitAmount c4:model.SaleThreePitAmount];
            break;
        case 2004:
            [self showDetailViewTittle1:@"二层原纸比例"tittle2:@"单坑原纸比例" tittle3:@"双坑原纸比例" tittle4:@"三坑原纸比例" c1:model.TwoLayersMeterProportion c2:model.SinglePitMeterProportion c3:model.DoublePitMeterProportion c4:model.ThreePitMetersProportion];
            break;
        case 2005:
            [self showDetailViewTittle1:@"二层加工费"tittle2:@"单坑加工费" tittle3:@"双坑加工费" tittle4:@"三坑加工费" c1:model.TwoLayersProcessCost c2:model.SinglePitProcessCost c3:model.DoublePitProcessCost c4:model.ThreePitProcessCost];
            break;
        default:
            break;
    }
   
    
}
-(void)showDetailViewTittle1:(NSString *)tittle1 tittle2:(NSString *)tittle2 tittle3:(NSString *)tittle3 tittle4:(NSString *)tittle4  c1:(NSString *)c1 c2:(NSString *)c2 c3:(NSString *)c3  c4:(NSString *)c4
{
    
    [self showThebgview];
    choseview =[[PaBoOrPaCoQuView alloc]instanceChooseView];
    choseview.c1=c1;
    choseview.c2=c2;
    choseview.c3=c3;
    choseview.c4=c4;
    choseview.tittle1=tittle1;
    choseview.tittle2=tittle2;
    choseview.tittle3=tittle3;
    choseview.tittle4=tittle4;
    [choseview refresh];
    [self.view.window addSubview:choseview];
    
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
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    
    [choseview removeFromSuperview];
}
//撤销背景蒙板
-(void)hidThebgview{
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
