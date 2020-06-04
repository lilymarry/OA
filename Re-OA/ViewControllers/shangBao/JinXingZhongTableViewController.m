#import "JinXingZhongTableViewController.h"
#import "ShangBaoList.h"
#import "ShangBaoWebAPI.h"
#import "UserPermission.h"
#import "shangBaoListCell.h"
#import <MBProgressHUD.h>
#import "NingHeZhiLiangViewController.h"
#import "AddShangBaoViewController.h"
#import "ScreenHelper.h"
#import "PanJinShangBaoChooseView.h"
#import "JieKuanViewController.h"
#import "FukuanViewController.h"
#import "BaoXiaoViewController.h"
#import "YiShenHeDetailViewController.h"
#import "AlertHelper.h"
#import "MJRefresh.h"
#import "CharacterHelper.h"
#import "CommonDelegate.h"
#import "ZhizhangShangBaoViewController.h"
#import "URL.h"
#import "NingHePaperViewController.h"
#import "NingHeShenGouViewController.h"
#import "NingHeKeHuInfomationController.h"
#import "NingHePaperViewController_1.h"
#import "NewZhizhangShangBaoViewController.h"
@interface JinXingZhongTableViewController ()<PanjinDelegate,CommonNotification>{
    NSMutableArray *_allList;
    NSDictionary *dic;
    UIView *bgView ; //遮罩层
    int selectedTag;
    PanJinShangBaoChooseView *panjinview;
}
@end

@implementation JinXingZhongTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dic=[ShangBaoList standartUserInfo].infoDic;
    _allList =[NSMutableArray array];
    self.navigationItem.title=self.tabBarController.title;
    selectedTag=0;
    
    [self setupRefresh];
    
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
-(void)refreshingDataList{
    [self.tableView headerBeginRefreshing];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [ShangBaoWebAPI getshangBaoListWithUserID:[UserPermission standartUserInfo].ID  ftype:dic[@"typeId"] fstate:@"start,waiting,end" fpId:dic[@"fpId"]
                                         pkey:@""rnum:@""success:^(NSArray *arr) {
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
        return ;
    }
    else
    {
        NSString *idStr=_allList[ 0][@"fpiId"] ;
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long)_allList.count ];
        // 1.添加数据
        [ShangBaoWebAPI getshangBaoListWithUserID:[UserPermission standartUserInfo].ID  ftype:dic[@"typeId"] fstate:@"start,waiting,end" fpId:dic[@"fpId"]
                                             pkey:idStr rnum:pag success:^(NSArray *arr)
         {
             [_allList addObjectsFromArray:arr[0][@"fpi"]];
             [self.tableView reloadData];
             [self.tableView footerEndRefreshing];}
                                             fail:^(){
                                                 [self.tableView footerEndRefreshing];
                                                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                                 [alert show];}];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    //self.tabBarController.navigationController.navigationBar.hidden=YES;
    //      [self setupRefresh];
}
-(void)viewDidDisappear:(BOOL)animated
{
   [AlertHelper hideAllHUDsForView:self.view]; 
}
//跳转上报页面
- (IBAction)redirectToAddShangBaoController:(id)sender {
   // NSLog(@"WWWW___ %@",dic[@"fmtp"] );
    [AlertHelper MBHUDShow:@"匹配表单中..." ForView:self.view AndDelayHid:30];
    
    if( [dic[@"fmtp"] isEqualToString:@"FormFinance"])
    {  [AlertHelper hideAllHUDsForView:self.view];
        [self showThebgview];
        panjinview =[[PanJinShangBaoChooseView alloc] instanceChooseView];
        panjinview.panjinDelegate=self;
        [self.view.window addSubview:panjinview];
    }
    else if([dic[@"fmtp"] isEqualToString:@"FormNHMassErr"])
    {
        NingHeZhiLiangViewController *jou=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NingHe"];
        jou.refreshNotification =self;
        [self.navigationController pushViewController:jou animated:YES];
    }
    
    else if([dic[@"fmtp"] isEqualToString:@"FormNHSpPaper"])
    {
        NingHePaperViewController_1 *jou=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NingHePaper_1"];
        jou.refreshNotification =self;
        [self.navigationController pushViewController:jou animated:YES];
    }
    
    else if([dic[@"fmtp"] isEqualToString:@"FormNewNHSpPaper"])
    {
        NingHePaperViewController *jou=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NingHePaper"];
        jou.refreshNotification =self;
        [self.navigationController pushViewController:jou animated:YES];
    }
    
    
    
    else if ([dic[@"fmtp"] isEqualToString:@"FormPapePrice"])
    {
   
           ZhizhangShangBaoViewController *zhi=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"zhizhang"];
           zhi.refreshNotification =self;
           
           [self.navigationController pushViewController:zhi animated:YES];
       
       
    }
    else if ([dic[@"fmtp"] isEqualToString:@"FormNHCustomerInfo"])
    {
        
        NingHeKeHuInfomationController *zhi=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NingHeKeHu"];
        zhi.refreshNotification =self;
        
        [self.navigationController pushViewController:zhi animated:YES];
        
        
    }
    else if ([dic[@"fmtp"] isEqualToString:@"FormNHPurchase"])
    {
        
        NingHeShenGouViewController *zhi=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NingHeShenGou"];
        zhi.refreshNotification =self;
        
        [self.navigationController pushViewController:zhi animated:YES];
        
        
    }
    else if ([dic[@"fmtp"] isEqualToString:@"FormNHPapePrice"])
    {
        
        NewZhizhangShangBaoViewController *zhi=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"zhizhangnew"];
        zhi.refreshNotification =self;
        
        [self.navigationController pushViewController:zhi animated:YES];
        
        
    }
    else
    {
        AddShangBaoViewController *jou=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddShangBao"];
        jou.refreshNotification =self;
        [self.navigationController pushViewController:jou animated:YES];
    }
}

//盘锦跳转页面
-(void)selectTheTypeID:(int)tid{
    [self hidThebgview];
    [panjinview closingTheLittleMenu:^(){
        switch (tid) {
            case 200:
            {
                JieKuanViewController *controller=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"jiekuansb"];
                controller.refreshNotification=self;
                [self.navigationController pushViewController:controller animated:YES];
            }break;
            case 201:
            {  FukuanViewController *controller=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"fukuansb"];
                controller.refreshNotification=self;
                [self.navigationController pushViewController:controller animated:YES];
            }break;
            case 202:
            {
                BaoXiaoViewController *controller=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"baoxiaosb"];
                controller.refreshNotification=self;
                [self.navigationController pushViewController:controller animated:YES];
            }break;
        } }];
}
//返回
- (IBAction)goBack:(id)sender {
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    
}
//加载背景蒙板
-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheChooseView:)];
    tapGesture.numberOfTapsRequired=1;
    bgView.userInteractionEnabled=YES;
    [bgView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.8;
    }completion:^(BOOL finished){
        
    } ];
}
//撤销背景蒙板
-(void)hidThebgview{
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
        [panjinview closingTheLittleMenu:nil];
    } ];
}
-(void)removeTheChooseView:(void (^)())closeMenuHandle{
    [self hidThebgview];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    cell.time.text=[self substringWithAstring: _allList[indexPath.row][@"ctm"]];
    cell.tittle.text=_allList[indexPath.row][@"tit"];
    cell.content.text=[CharacterHelper replacingTheBRToEmpty:_allList[indexPath.row][@"con"]] ;
    if ([_allList[indexPath.row][@"fstate"]isEqualToString:@"审核中"])
    {
       cell.state.hidden=NO;
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
                                         [AlertHelper singleMBHUDShow:@"删除失败,该上报已被审批" ForView:self.view AndDelayHid:2];
                                     }
                                 } fail:^{
                                     [AlertHelper hideAllHUDsForView:self.view];
                                     [AlertHelper singleMBHUDShow:@"网络操作出现错误" ForView:self.view AndDelayHid:2];
                                 }];
}


@end
