#import "MyJournalViewController.h"
#import "RizhiWebAPI.h"
#import "UserPermission.h"
#import "JourDetailViewController.h"
#import "RizhiTableViewCell.h"
#import "CharacterHelper.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#import "CommonDelegate.h"
#import "AddJourViewController.h"
@interface MyJournalViewController ()<UITableViewDataSource,UITableViewDelegate,CommonNotification>
{
    NSMutableArray *_ownList;
    NSDictionary *dic;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation MyJournalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ownList =[NSMutableArray array];
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
    [RizhiWebAPI myRizhiRequestlistID:[UserPermission standartUserInfo].ID startTime:@"" edTime:@"" joid:@"0" page :@"0" success:^(NSArray *arr) {
        [_ownList removeAllObjects];
        [_ownList addObjectsFromArray:arr];
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
    if (_ownList.count==0)
    {
        _table.footerRefreshingText = @"无更新数据";
        [_table footerEndRefreshing];
        return ;
    }
    else
    {
        NSString *idStr=_ownList[ 0][@"Jo_Id"] ;
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long)_ownList.count ];
        // 1.添加数据
        [RizhiWebAPI myRizhiRequestlistID:[UserPermission standartUserInfo].ID startTime:@"" edTime:@"" joid:idStr  page :pag success:^(NSArray *arr) {
            [_ownList addObjectsFromArray:arr];
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
    return _ownList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier=@"rizhicell";
    RizhiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"RizhiTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tittleLable.text=_ownList[indexPath.row][@"Jo_Title"];
    cell.contentLable.text=[CharacterHelper replacingTheBRToEmpty:_ownList[indexPath.row][@"Jo_Description"]] ;
    cell.contentLable.textColor=[UIColor lightGrayColor];
    cell.timeLable.text=_ownList[indexPath.row][@"Jo_Date"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JourDetailViewController *jou=[[UIStoryboard storyboardWithName:@"rizhi" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"detail"];
    jou.detail=_ownList[indexPath.row];
    jou.flag=@"1";
    [self.navigationController pushViewController:jou animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *joid=_ownList[indexPath.row][@"Jo_Id"];
        [self deleteRiZhiBy:joid AndNSIndexPath:indexPath];
    }
}
-(void)deleteRiZhiBy:(NSString*)joid AndNSIndexPath:(NSIndexPath *)indexPath{
    [AlertHelper singleMBHUDShow:@"删除中..." ForView:self.view];
    [RizhiWebAPI deleteSingleRiZhi:joid
                           success:^(NSArray *arr) {
                               [AlertHelper hideAllHUDsForView:self.view];
                               NSDictionary *dict =[arr objectAtIndex:0];
                               NSString *flag=[dict valueForKey:@"bool"];
                               if ([@"1" isEqualToString:flag]) {
                                   
                                   [_ownList removeObjectAtIndex:indexPath.row];
                                   [self.table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                               }else{
                                   [AlertHelper singleMBHUDShow:@"操作失败" ForView:self.view AndDelayHid:2];
                               }
                           } fail:^{
                               [AlertHelper hideAllHUDsForView:self.view];
                               [AlertHelper singleMBHUDShow:@"网络出现错误" ForView:self.view AndDelayHid:2];
                           }];
}

-(void)refreshingDataList{
    [self.table headerBeginRefreshing];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddJourViewController *controller = segue.destinationViewController;
    [controller setRefreshNotification:self];
}


- (IBAction)lastBtnPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
