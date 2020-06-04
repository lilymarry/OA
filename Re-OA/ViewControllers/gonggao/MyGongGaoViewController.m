#import "MyGongGaoViewController.h"
#import "GongGaoWebAPI.h"
#import "GongGaoCell.h"
#import "UserPermission.h"
#import "GongDetailViewController.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#import "CommonDelegate.h"
#import "AddGongGaoViewController.h"
#import "CharacterHelper.h"
@interface MyGongGaoViewController ()<UITableViewDelegate,UITableViewDataSource,CommonNotification>
{
    NSMutableArray *_ownList;
}
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation MyGongGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ownList =[NSMutableArray array];
    
    NSString *menuRoleStr= [UserPermission standartUserInfo].MenuRole;
    NSRange range = [menuRoleStr rangeOfString:@"gg_fb"];
    if ( range.location == NSNotFound)
    {
        self.navigationItem.rightBarButtonItem=nil;
    }
       
    [self setupRefresh];
}
-(void)viewWillAppear:(BOOL)animated
{
    // [self setupRefresh];
    
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tabView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_tabView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tabView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加数据
    [GongGaoWebAPI myGongGaoRequestID:[UserPermission standartUserInfo].ID  sTime:@"" eTime:@"" neid:@"0" page:@"0" success:^(NSArray *arr) {
        [_ownList removeAllObjects];
        [_ownList addObjectsFromArray:arr];
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
    if (_ownList.count==0)
    {
        _tabView.footerRefreshingText = @"无更新数据";
        [_tabView footerEndRefreshing];
        return ;
    }
    else
    {
        NSString *idStr=_ownList[ 0][@"Ne_Id"] ;
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long)_ownList.count ];
        // 1.添加数据
        [GongGaoWebAPI myGongGaoRequestID:[UserPermission standartUserInfo].ID  sTime:@"" eTime:@"" neid:idStr page:pag success:^(NSArray *arr) {
            [_ownList addObjectsFromArray:arr];
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
- (IBAction)lastBtnPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ownList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier=@"GongGaoCell";
    GongGaoCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GongGaoCell" owner:self options:nil] lastObject];
    }
    cell.tittle.text=_ownList[indexPath.row][@"Ne_Title"];
    cell.time.text=_ownList[indexPath.row][@"Ne_Date"];
    cell.desc.text=[CharacterHelper replacingTheBRToEmpty:_ownList[indexPath.row][@"Ne_Description"]] ;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GongDetailViewController *jou=[[UIStoryboard storyboardWithName:@"gongGao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"detail"];
    jou.neid=_ownList[indexPath.row][@"Ne_Id"];
    [self.navigationController pushViewController:jou animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *neid=_ownList[indexPath.row][@"Ne_Id"];
        [self deleteGongGaoBy:neid AndNSIndexPath:indexPath];
    }
}
-(void)deleteGongGaoBy:(NSString*)neid AndNSIndexPath:(NSIndexPath *)indexPath{
    [AlertHelper singleMBHUDShow:@"删除中..." ForView:self.view];
    [GongGaoWebAPI deleteSingleGongGao:neid
                               success:^(NSArray *arr) {
                                   [AlertHelper hideAllHUDsForView:self.view];
                                   NSDictionary *dict =[arr objectAtIndex:0];
                                   NSString *flag=[dict valueForKey:@"bool"];
                                   if ([@"1" isEqualToString:flag]) {
                                       
                                       [_ownList removeObjectAtIndex:indexPath.row];
                                       [self.tabView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                                   }else{
                                       [AlertHelper singleMBHUDShow:@"操作失败" ForView:self.view AndDelayHid:2];
                                   }
                               } fail:^{
                                   [AlertHelper hideAllHUDsForView:self.view];
                                   [AlertHelper singleMBHUDShow:@"网络出现错误" ForView:self.view AndDelayHid:2];
                               }];
}
-(void)refreshingDataList{
    [self.tabView headerBeginRefreshing];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddGongGaoViewController *viewController = segue.destinationViewController;
    [viewController setRefreshNotification:self];
}

@end
