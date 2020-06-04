#import "AllGongGaoViewController.h"
#import "GongGaoWebAPI.h"
#import "UserPermission.h"
#import "GongGaoAllCell.h"
#import "GongDetailViewController.h"
#import "MJRefresh.h"
#import "CharacterHelper.h"
@interface AllGongGaoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_allList;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation AllGongGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _allList =[NSMutableArray array];
    
    [self setupRefresh];
}
-(void)viewWillAppear:(BOOL)animated
{
//    [self setupRefresh];
    
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tabView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //开始刷新
    [_tabView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tabView addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加数据
    [GongGaoWebAPI allGongGaoRequestID:[UserPermission standartUserInfo].ID  sTime:@"" eTime:@"" neid:@"0" page:@"0" success:^(NSArray *arr) {
        [_allList removeAllObjects];
        [_allList addObjectsFromArray:arr];
        [_tabView reloadData];
        //结束刷新状态
        [_tabView headerEndRefreshing];}
     fail:^(){
            [_tabView headerEndRefreshing];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];}];
}
- (void)footerRereshing
{
    if (_allList.count==0)
    {
         _tabView.footerRefreshingText = @"无更新数据";
         [_tabView footerEndRefreshing];
        return ;
    }
   else
   {
    NSString *idStr=_allList[ 0][@"Ne_Id"] ;
    NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long)_allList.count ];
    [GongGaoWebAPI allGongGaoRequestID:[UserPermission standartUserInfo].ID  sTime:@"" eTime:@"" neid:idStr page:pag success:^(NSArray *arr) {
        [_allList addObjectsFromArray:arr];
        [_tabView reloadData];
        [_tabView footerEndRefreshing];}
    fail:^(){
        [_tabView footerEndRefreshing];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];}];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _allList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier=@"GongGaoCell";
    GongGaoAllCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GongGaoAllCell" owner:self options:nil] lastObject];
    }
    cell.tittle.text=_allList[indexPath.row][@"Ne_Title"];
    cell.time.text=_allList[indexPath.row][@"Ne_Date"];
    cell.user.text=_allList[indexPath.row][@"Ne_UseName"];
     cell.desc.text=[CharacterHelper replacingTheBRToEmpty:_allList[indexPath.row][@"Ne_Description"]] ;
     return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongDetailViewController *jou=[[UIStoryboard storyboardWithName:@"gongGao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"detail"];
    jou.neid=_allList[indexPath.row][@"Ne_Id"];
    [self.navigationController pushViewController:jou animated:YES];
}
- (IBAction)lastBtnPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
