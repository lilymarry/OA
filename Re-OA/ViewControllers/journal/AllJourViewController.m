#import "AllJourViewController.h"
#import "RizhiWebAPI.h"
#import "UserPermission.h"
#import "JourDetailViewController.h"
#import "RizhiAllTableViewCell.h"
#import "CharacterHelper.h"
#import "MJRefresh.h"
@interface AllJourViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_allList;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation AllJourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _allList =[NSMutableArray array];
    _table.dataSource=self;
    _table.delegate=self;

    [self setupRefresh];
}
-(void)viewWillAppear:(BOOL)animated
{
//    [self setupRefresh];

}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_table addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_table headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_table addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加数据
    [RizhiWebAPI allRizhiRequestlistID:[UserPermission standartUserInfo].ID startTime:@"" edTime:@"" joid:@"0" page :@"0" success:^(NSArray *arr) {
        [_allList removeAllObjects];
        [_allList addObjectsFromArray:arr];
        [_table reloadData];
        //结束刷新状态
        [_table headerEndRefreshing];}
   fail:^(){
       [_table headerEndRefreshing];
       UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
       [alert show];}];
}
- (void)footerRereshing
{
    if (_allList.count==0)
    {
        _table.footerRefreshingText = @"无更新数据";
        [_table footerEndRefreshing];
        return ;
    }
    else
    {
        NSString *idStr=_allList [0][@"Jo_Id"] ;
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long)_allList.count ];
        // 1.添加数据
        [RizhiWebAPI allRizhiRequestlistID:[UserPermission standartUserInfo].ID startTime:@"" edTime:@"" joid:idStr  page :pag success:^(NSArray *arr) {
            [_allList addObjectsFromArray:arr];
            [_table reloadData];
            [_table footerEndRefreshing];}
         fail:^(){
             [_table footerEndRefreshing];
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
             [alert show];}];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _allList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier=@"rizhicell";
    RizhiAllTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RizhiAllTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tittleLable.text=_allList[indexPath.row][@"Jo_Title"];
    cell.contentLable.text=[CharacterHelper replacingTheBRToEmpty:_allList[indexPath.row][@"Jo_Description"]] ;
    cell.timeLable.text=_allList[indexPath.row][@"Jo_Date"];
   cell.userLable.text= _allList[indexPath.row][@"Jo_UserName"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JourDetailViewController *jou=[[UIStoryboard storyboardWithName:@"rizhi" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"detail"];
    jou.detail=_allList[indexPath.row];
    jou.flag=@"2";
    [self.navigationController pushViewController:jou animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)lastBtnPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
