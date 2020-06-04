#import "BangDanListViewController.h"
#import "JinXiaoCunWebAPI.h"
#import "BdListModel.h"
#import "AlertHelper.h"

#import "ZhiJianViewController.h"
#import "MJRefresh.h"
#import "JXCCommonCell.h"
#import "ScreenHelper.h"
#import "CommonDelegate.h"
@interface BangDanListViewController ()<CommonNotification>
{
    NSMutableArray *dataArr;
}
@end

@implementation BangDanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     dataArr=[NSMutableArray new];
     [self setupRefresh];


}
-(IBAction)navBackBt{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView  headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView  addFooterWithTarget:self action:@selector(footerRereshing)];
}
- (void)headerRereshing
{
    [JinXiaoCunWebAPI getBangDanListWithRnum:@"" bdtyp:@"1" success:^(NSArray *arr){
       
        [dataArr removeAllObjects];
        
        if ( arr.count>0) {
            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
            NSArray *dictArr= [dict objectForKey:@"bd"];
            for (NSDictionary *dict1 in dictArr) {
                BdListModel *model=[[BdListModel alloc]initWithJson:dict1];
                [dataArr addObject:model];
            }
        }
        
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        
    } fail:^(){
        [self.tableView headerEndRefreshing];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];}];

}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.tabBarController.tabBar setHidden:NO];
}
- (void)footerRereshing{
    if (dataArr.count==0)
    {
        self.tableView.footerRefreshingText = @"无更新数据";
        [self.tableView footerEndRefreshing];
        return ;
    }
    else
    {
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count ];

        [JinXiaoCunWebAPI getBangDanListWithRnum:pag bdtyp:@"1" success:^(NSArray *arr){
                NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
                NSArray *dictArr= [dict objectForKey:@"bd"];
                for (NSDictionary *dict1 in dictArr) {
                    BdListModel *model=[[BdListModel alloc]initWithJson:dict1];
                    [dataArr addObject:model];
                }
          
            
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
            
        } fail:^(){
            [self.tableView footerEndRefreshing];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];}];


    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identfier=@"bangdan";
    JXCCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JXCCommonCell" owner:self options:nil] lastObject];
    }
    BdListModel *model=dataArr[indexPath.row];
    cell.lab_BangDanHao.text=model.bdno;
    cell.lab_BangDanRiQi.text=model.time;
    cell.lab_ChePaiHao.text=model.carno;
    cell.lab_WuZiMing.text=model.wuzi;
    cell.lab_Dengji.hidden=YES;
    cell.lab_zuofei.hidden=YES;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     ZhiJianViewController *tab=[[UIStoryboard storyboardWithName:@"ZhiJian" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"zj"];
     BdListModel *model=dataArr[indexPath.row];
     tab.model=model;
     tab.bdnum=model.bdno;
     tab.carNum=model.carno;
    [tab setRefreshNotification:self];
    [self.navigationController pushViewController:tab animated:YES];

}
-(void)refreshingDataList{
    [self.tableView headerBeginRefreshing];
}


@end
