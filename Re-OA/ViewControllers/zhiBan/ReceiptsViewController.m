#pragma  退货明细

#import "ReceiptsViewController.h"
#import "ZhiBanWebAPI.h"
#import "ReceiptsViewCell.h"
#import "receiptsModel.h"
#import "ReceiptsTittleView.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#define tittleWidth 1260
@interface ReceiptsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,getTimeDelegate>
{
    NSMutableArray *dataArr;
    UIScrollView *rightScrollView;
    UITableView *rightTableView;
    ReceiptsTittleView *view2;
    NSString *  maxid;
    NSString *destDateString;
    NSString *  stim;
    NSString *etim;
}
@end  
@implementation ReceiptsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    destDateString = [dateFormatter stringFromDate:date];
    stim=[NSString stringWithFormat:@"%@ 00:00",destDateString];
    etim=[NSString stringWithFormat:@"%@ 23:59",destDateString];
    
    dataArr =[NSMutableArray array];
    maxid=@"";
    view2 = [[ReceiptsTittleView alloc]instanceChooseView];
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
    
    [ZhiBanWebAPI receiptsWithStartDate:stim endDate:etim endCount:@"0" count:@"12" maxid:@"" success:^(NSArray *arr){
        [AlertHelper hideAllHUDsForView:self.view];
        [dataArr removeAllObjects];
        NSArray *sarr=arr[0][@"ERP_V_Receipts_Total"];
        if (sarr.count>0) {
            NSDictionary *dic=sarr[0];
            
            receiptsModel *model= [[ receiptsModel alloc]initWithDic:dic];
            [dataArr addObject:model];
        }
        
        
        
        maxid=arr[0][@"MaxId"];
        NSArray *daArr=arr[0][@"ERP_V_Receipts"];
        
        for (NSDictionary *dic in daArr) {
            
            receiptsModel *model=[[receiptsModel alloc]initWithDic:dic];
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
        [ZhiBanWebAPI receiptsWithStartDate:stim endDate:etim endCount:[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count-1] count:@"12" maxid:maxid success:^(NSArray *arr){
          //  NSLog(@"WWWWW %@",arr);
            [AlertHelper hideAllHUDsForView:self.view];
            if ([arr[0][@"bool"]isEqualToString:@"1"]) {
                NSArray *daArr=arr[0][@"ERP_V_Receipts"];
                for (NSDictionary *dic in daArr) {
                    
                    receiptsModel *model=[[receiptsModel alloc]initWithDic:dic];
                    [dataArr addObject:model];
                    
                    
                }
                [rightTableView reloadData];
                [rightTableView footerEndRefreshing];
            }
            else
            {
                [AlertHelper singleMBHUDShow:@"无新数据！" ForView:rightTableView  AndDelayHid:2];
            }
            
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
    ReceiptsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReceiptsViewCell" owner:self options:nil] lastObject];
        
    }
    receiptsModel *model=[dataArr objectAtIndex:indexPath.row];

    if (indexPath.row==0) {
           cell.lab_num.text =[NSString stringWithFormat:@"总计:%@", model.ItemTotal];
    }
    
    else
    {
        cell.lab_num.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
  
     cell.lab_Abbreviation.text=model.Abbreviation;
    cell.lab_BusinessMan.text=model.BusinessMan;
    cell.lab_IsStop.text=model.IsStop;
    cell.lab_Code.text=model.Code;
    cell.lab_CustomCode.text=model.CustomCode;
    cell.lab_ReceiptsDate.text=model.ReceiptsDate;
    cell.lab_Money.text=model.Money;
    cell.lab_SetDate.text=model.SetDate;
    cell.lab_SetMan.text=model.SetMan;
    cell.lab_Remark.text=model.Remark;
    cell.lab_Type.text=model.Type;
    cell.lab_State.text=model.State;
    cell.lab_ConfirmDate.text=model.ConfirmDate;
    cell.lab_ConfirmMan.text=model.ConfirmMan;
    cell.lab_BillCode.text=model.BillCode;
    cell.lab_SID.text=model.SID;
    
    return cell;

    
}


@end
