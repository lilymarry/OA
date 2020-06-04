#import "ZuoFeiTableViewController.h"
#import "ShangBaoList.h"
#import "ShangBaoWebAPI.h"
#import "UserPermission.h"
#import "shangBaoListCell.h"
#import "CharacterHelper.h"
#import "AlertHelper.h"
#import "MJRefresh.h"
#import "YiShenHeDetailViewController.h"
@interface ZuoFeiTableViewController (){
    NSMutableArray *_allList;
    NSDictionary *dic;
}

@end

@implementation ZuoFeiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=self.tabBarController.title;
    _allList =[NSMutableArray array];
      dic=[ShangBaoList standartUserInfo].infoDic;
    
     [self setupRefresh];
}
- (void)setupRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加数据
    [ShangBaoWebAPI getshangBaoListWithUserID:[UserPermission standartUserInfo].ID  ftype:dic[@"typeId"] fstate:@"stop" fpId:dic[@"fpId"]
        pkey:@"" rnum:@"0" success:^(NSArray *arr){
          [_allList removeAllObjects];
          [_allList addObjectsFromArray:arr[0][@"fpi"]];
          [self.tableView reloadData];
          //结束刷新状态
          [self.tableView headerEndRefreshing];}
     fail:^(){
           [self.tableView headerEndRefreshing];
           UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
           [alert show];}];
}
- (void)footerRereshing
{
    if (_allList.count==0)
    {
         self.tableView.footerRefreshingText = @"无更新数据";
         [self.tableView footerEndRefreshing];
         return;
    }
    else
    {
        NSString *idStr=_allList[ 0][@"fpiId"] ;
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long)_allList.count ];
        // 1.添加数据
        [ShangBaoWebAPI getshangBaoListWithUserID:[UserPermission standartUserInfo].ID  ftype:dic[@"typeId"] fstate:@"stop" fpId:dic[@"fpId"]
                                             pkey:idStr rnum:pag success:^(NSArray *arr)
         {[_allList addObjectsFromArray:arr[0][@"fpi"]];
          [self.tableView reloadData];
          [self.tableView footerEndRefreshing];}
         fail:^(){
          [self.tableView footerEndRefreshing];
          UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
          [alert show];}];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
//    [self setupRefresh];
}
- (IBAction)goBack:(id)sender {
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier=@"shangBaoListCell";
    shangBaoListCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"shangBaoListCell" owner:self options:nil] lastObject];
    }
    cell.tit.text=_allList[indexPath.row][@"fnm"];
    cell.time.text=[self substringWithAstring:_allList[indexPath.row][@"ctm"]]  ;
    cell.tittle.text=_allList[indexPath.row][@"tit"];
    cell.content.text=[CharacterHelper replacingTheBRToEmpty:_allList[indexPath.row][@"con"]] ;
    if ([_allList[indexPath.row][@"fstate"]isEqualToString:@"审核中"])
    {
        cell.state.image=[UIImage imageNamed:@"unarchived.png"];
    }
    else
    {
        cell.state.hidden=YES;
    }
    return cell;
}
-(NSString *)substringWithAstring:(NSString *)str
{
    NSRange range = NSMakeRange(0, 10) ;
    NSString *time=[str substringWithRange:range];
    return time;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ShenHe" bundle:[NSBundle mainBundle]];
    YiShenHeDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"yishenhedetail"];
    NSDictionary *dict= _allList[indexPath.row];
    controller.fpiId=[dict valueForKey:@"fpiId"];
    controller.cmtp=[dict valueForKey:@"cmTp"];
    controller.fmTp=[dict valueForKey:@"fmTp"];
    controller.x=_allList[indexPath.row][@"x"];
    controller.y=_allList[indexPath.row][@"y"];
    controller.shangbaoState=@"1";
    [self.navigationController pushViewController:controller animated:YES ];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dict= _allList[indexPath.row];
        NSString *fpiId=[dict valueForKey:@"fpiId"];
        [self deleteShangBaoBy:fpiId AndNSIndexPath:indexPath];
    }
}
-(void)deleteShangBaoBy:(NSString*)fpiid AndNSIndexPath:(NSIndexPath *)indexPath{
    [AlertHelper singleMBHUDShow:@"删除中..." ForView:self.view];
    [ShangBaoWebAPI deleteSingleShangBao:fpiid
                                 success:^(NSArray *arr) {
                                     [AlertHelper hideAllHUDsForView:self.view];
                                     NSDictionary *dict =[arr objectAtIndex:0];
                                     NSString *flag=[dict valueForKey:@"rzt"];
                                     if ([@"1" isEqualToString:flag]) {
                                         
                                         [_allList removeObjectAtIndex:indexPath.row];
                                         [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                                     }else{
                                         [AlertHelper singleMBHUDShow:@"删除失败" ForView:self.view AndDelayHid:2];
                                     }
                                 } fail:^{
                                     [AlertHelper hideAllHUDsForView:self.view];
                                     [AlertHelper singleMBHUDShow:@"网络操作出现错误" ForView:self.view AndDelayHid:2];
                                 }];
}

@end
