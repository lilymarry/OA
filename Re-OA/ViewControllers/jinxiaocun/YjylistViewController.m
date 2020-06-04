#import "YjylistViewController.h"
#import "JinXiaoCunWebAPI.h"
#import "BdListModel.h"
#import "AlertHelper.h"
#import "UserPermission.h"
#import "MJRefresh.h"
#import  "JXCCommonCell.h"
#import "YzjDetailViewController.h"
@interface YjylistViewController ()
{
    NSMutableArray *dataArr;
}
@end

@implementation YjylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=[NSMutableArray new];
    [self setupRefresh];
}
-(IBAction)navBackBt{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
     [self.tabBarController.tabBar setHidden:NO];
    
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
    [JinXiaoCunWebAPI getYiBangDanListWithRnum:@"" bdtyp:@"0" bm:@"" userId:[UserPermission standartUserInfo].ID success:^(NSArray *arr){
        
      
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
- (void)footerRereshing{
    if (dataArr.count==0)
    {
        self.tableView.footerRefreshingText = @"无更新数据";
        [self.tableView footerEndRefreshing];
        return ;
    }
    else
    { 
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count];
        
       [JinXiaoCunWebAPI getYiBangDanListWithRnum:pag bdtyp:@"0" bm:@"" userId:[UserPermission standartUserInfo].ID success:^(NSArray *arr){
            
            
            if ( arr.count>0) {
                NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
                NSArray *dictArr= [dict objectForKey:@"bd"];
                for (NSDictionary *dict1 in dictArr) {
                    BdListModel *model=[[BdListModel alloc]initWithJson:dict1];
                    [dataArr addObject:model];
                }
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identfier=@"jxccommoncell";
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
    if ([model.BangDanState isEqualToString:@"0"])
    {
        cell.lab_zuofei.hidden=YES;
    }
    else
    {
        cell.lab_zuofei.hidden=NO;;
        
    }

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YzjDetailViewController *tab=[[UIStoryboard storyboardWithName:@"ZhiJian" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"YzjDetail"];
    BdListModel *model=dataArr[indexPath.row];
    tab.model=model;
    [self.navigationController pushViewController:tab animated:YES];
    
}

@end
