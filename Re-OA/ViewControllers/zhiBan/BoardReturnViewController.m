
#import "BoardReturnViewController.h"
#import "ZhiBanWebAPI.h"
#import "BoardReturnCell.h"
#import "BoardReturnModel.h"
#import "BoardReturnTittleView.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#define tittleWidth 3260
@interface BoardReturnViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,getTimeDelegate>
{
    NSMutableArray *dataArr;
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
    BoardReturnTittleView *view2;
    NSString *maxid;
    NSString *destDateString;
    NSString *stim;
    NSString *etim;
    
}

@end

@implementation BoardReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    destDateString = [dateFormatter stringFromDate:date];
    stim=[NSString stringWithFormat:@"%@ 00:00",destDateString];
    etim=[NSString stringWithFormat:@"%@ 23:59",destDateString];
    
    dataArr =[NSMutableArray array];
    maxid=@"";
    
    view2 = [[BoardReturnTittleView alloc]instanceChooseView];
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
    [ZhiBanWebAPI paperBoardReturnWithStartDate:stim endDate:etim endCount:@"0" count:@"12" maxid:@"" success:^(NSArray *arr){
        [AlertHelper hideAllHUDsForView:self.view];
        [dataArr removeAllObjects];
        NSArray *sarr=arr[0][@"ERP_V_PaperBoardReturn_Total"];
        
        NSDictionary *dic=sarr[0];
        if (dic.count>0) {
            BoardReturnModel *model= [[ BoardReturnModel alloc]initWithDic:dic];
            [dataArr addObject:model];
        }
        
        
        maxid=arr[0][@"MaxId"];
        NSArray *daArr=arr[0][@"ERP_V_PaperBoardReturn"];
        for (NSDictionary *dic in daArr) {
            
            BoardReturnModel *model=[[BoardReturnModel alloc]initWithDic:dic];
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
        [ZhiBanWebAPI paperBoardReturnWithStartDate:stim endDate:etim endCount:[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count-1] count:@"12" maxid:maxid success:^(NSArray *arr){
            [AlertHelper hideAllHUDsForView:self.view];
            NSArray *daArr=arr[0][@"ERP_V_PaperBoardReturn"];
            for (NSDictionary *dic in daArr) {
                
                BoardReturnModel *model=[[BoardReturnModel alloc]initWithDic:dic];
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
    
    return dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identfier=@"cell";
    BoardReturnCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BoardReturnCell" owner:self options:nil] lastObject];
        
    }
    BoardReturnModel *model=[dataArr objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        cell.lab_num.text=[NSString stringWithFormat:@"总计:%@", model.ItemTotal];
        
        
    }
    else
    {
        cell.lab_num.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
    }
    cell.lab_Code.text=model.Code;
    cell.lab_Date.text=model.Date;
    cell.lab_DeliveryCode.text=model.DeliveryCode;
    cell.lab_OrderCode.text=model.OrderCode;
    cell.lab_PbrAmount.text=model.PbrAmount;
    cell.lab_Money.text=model.Money;
    cell.lab_Freight.text=model.Freight;
    cell.lab_FreightSquare.text=model.FreightSquare;
    cell.lab_MoneyRateOfDiscount.text=model.MoneyRateOfDiscount;
    cell.lab_Reason.text=model.Reason;
    cell.lab_PricePaperBoard.text=model.PricePaperBoard;
    cell.lab_CustomCode.text=model.CustomCode;
    cell.lab_Abbreviation.text=model.Abbreviation;
    cell.lab_CustomName.text=model.CustomName;
    cell.lab_PaperBoardCode.text=model.PaperBoardCode;
    cell.lab_RateOfDiscount.text=model.RateOfDiscount;
    cell.lab_PaperBoardWidth.text=model.PaperBoardWidth;
    cell.lab_PaperBoardLength.text=model.PaperBoardLength;
    cell.lab_PerVolumeAmount.text=model.PerVolumeAmount;
    cell.lab_PerSquareMeterAmount.text=model.PerSquareMeterAmount;
    cell.lab_PerSquareMeterFiveLayersAmount.text=model.PerSquareMeterFiveLayersAmount;
    cell.lab_PricSpec.text=model.PricSpec;
    cell.lab_SpecEx.text=model.SpecEx;
    cell.lab_MastPerson.text=model.MastPerson;
    cell.lab_SecondPerson.text=model.SecondPerson;
    cell.lab_PlateNumber.text=model.PlateNumber;
    cell.lab_PlateNumberEx.text=model.PlateNumberEx;
    cell.lab_Driver.text=model.Driver;
    cell.lab_State.text=model.State;
    cell.lab_SetDate.text=model.SetDate;
    cell.lab_SetMan.text=model.SetMan;
    cell.lab_ProcessMode.text=model.ProcessMode;
    cell.lab_PboAmount.text=model.PboAmount;
    cell.lab_TimeBeginProduce.text=model.TimeBeginProduce;
    cell.lab_TeamName.text=model.TeamName;
    cell.lab_ReturnAmount.text=model.ReturnAmount;
    cell.lab_PitCode.text=model.PitCode;
    cell.lab_DeliveryMan.text=model.DeliveryMan;
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

@end
