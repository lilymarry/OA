

#import "MyRenWuViewController.h"
#import "RenWuWebAPI.h"
#import <MBProgressHUD.h>
#import "UserPermission.h"
#import "MyRenwuCell.h"
#import "MyRenwuListModel.h"
#import "ScreenHelper.h"
#import "MyRenWuReceivedDetailViewController.h"
#import "RenWuDetailViewController.h"
#import "MyRenWuFaBuViewController.h"
#import "CharacterHelper.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#import "CommonDelegate.h"
#import "AddRenWuViewController.h"

@interface MyRenWuViewController ()<CommonNotification>{
    bool isReceived;
    BOOL isFisrtDispear;
    NSMutableArray *dataArr;
    NSString *typ;
    
    NSString*method;
}

@end

@implementation MyRenWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isReceived= YES;
    isFisrtDispear=YES;
    dataArr=[[NSMutableArray alloc ] init];
    typ =[[NSString alloc]init];
    typ=@"2";
    
    NSString *menuRoleStr= [UserPermission standartUserInfo].MenuRole;
    NSRange range = [menuRoleStr rangeOfString:@"rw_fb"];
    if ( range.location == NSNotFound)
    {
        self.navigationItem.rightBarButtonItem=nil;
    }
    method=@"";
   // [self setupRefresh];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setupRefresh];
}
//改变列表
- (IBAction)changeMyRenwuList:(id)sender {
    
    
    
    isReceived = isReceived?NO:YES;
    
    if (isReceived) {
        [self reloadTheReceivedList];
    }else{
        [self reloadThePublishedList];
    }
}

-(void)reloadTheReceivedList
{
    typ=@"2";
    [self setupRefresh];
    
    
}
-(void)reloadThePublishedList{
    typ=@"1";
    [self setupRefresh];
    
    
}
-(void)reloadTheListByType:(NSString*)type{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"获取中...";
    
    [RenWuWebAPI requestListByUID:[UserPermission standartUserInfo].ID AndType:type    taid:@"0" page:@"0"
                          success:^(NSArray *renwulist)
     {
         [hud hide:YES];
         [dataArr removeAllObjects];
         for (NSDictionary *dict in renwulist) {
             MyRenwuListModel *model=[[MyRenwuListModel alloc]initWithJson:dict];
             [dataArr addObject:model];
         }
         
         [self.tableView reloadData];
         
     } fail:^{
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
         [alert show];
     }];
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [RenWuWebAPI requestListByUID:[UserPermission standartUserInfo].ID AndType:typ
                             taid:@"0" page:@"0"
                          success:^(NSArray *renwulist){
                              
                              [dataArr removeAllObjects];
                              for (NSDictionary *dict in renwulist) {
                                  MyRenwuListModel *model=[[MyRenwuListModel alloc]initWithJson:dict];
                                  [dataArr addObject:model];
                              }
                              
                              [self.tableView reloadData];
                              [self.tableView headerEndRefreshing];
                              
                          } fail:^{
                              [self.tableView headerEndRefreshing];
                              UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                              [alert show];
                          }];
}

- (void)footerRereshing
{
    if (dataArr.count==0)
    {
        self.tableView.footerRefreshingText = @"无更新数据";
        [self.tableView footerEndRefreshing];
        return ;
    }
    else
    {
        MyRenwuListModel *model=dataArr[0];
        NSString *idStr=model.Ta_Id ;
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long) dataArr.count ];
        // 1.添加数据
        [RenWuWebAPI requestListByUID:[UserPermission standartUserInfo].ID AndType:typ
                                 taid:idStr page:pag success:^(NSArray *arr){
                                     
                                     
                                     for (NSDictionary *dict in arr) {
                                         MyRenwuListModel *model=[[MyRenwuListModel alloc]initWithJson:dict];
                                         [dataArr addObject:model];
                                     }
                                     
                                     [self.tableView reloadData];
                                     [self.tableView footerEndRefreshing];
                                     
                                 } fail:^{
                                     [self.tableView footerEndRefreshing];
                                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                     [alert show];
                                 }];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
}
//myrenwucell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyRenwuListModel *model = [dataArr objectAtIndex:indexPath.row];
    MyRenwuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myrenwucell" forIndexPath:indexPath];
    cell.imgFlag.hidden = NO;
    NSString *flagStr=@"unarchived.png";
    if (isReceived) {
        if ([model.Ta_Iscomplete isEqualToString:@"1"]){
            cell.imgFlag.hidden = YES;
        }
    }else{
        
        if ([model.Ta_Iscomplete isEqualToString:@"3"]) {
            flagStr=@"unarchived.png";
        }else if ([model.Ta_Iscomplete isEqualToString:@"2"]){
            flagStr=@"archiving.png";
        }else if ([model.Ta_Iscomplete isEqualToString:@"1"]){
            cell.imgFlag.hidden = YES;
        }
    }
    cell.imgFlag.image=[UIImage imageNamed:flagStr];
    
    cell.labDate.text= model.Ta_Lssueddate;
    cell.labTitle.text= model.Ta_Name;
    cell.labDesc.text=[CharacterHelper replacingTheBRToEmpty:model.Ta_Description ];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyRenwuListModel *model= [dataArr objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RenWu" bundle:[NSBundle mainBundle]];
    
    
    //已完成任务
    if ([model.Ta_Iscomplete isEqualToString:@"1"] && (isReceived)) {
        RenWuDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"renwudetail"];
        controller.ta_id= model.Ta_Id;
        [self.navigationController pushViewController:controller animated:YES ];
    }else{
        NSString *storyID=(isReceived)?@"myreceivedrenwu":@"mypublishedrenwu";
        //未完成 ＋ 已接收
        if (isReceived) {
            MyRenWuReceivedDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:storyID];
            controller.ta_id= model.Ta_Id;
            [self.navigationController pushViewController:controller animated:YES ];
            
        }else{
            MyRenWuFaBuViewController *controller = [storyboard instantiateViewControllerWithIdentifier:storyID];
            controller.ta_id= model.Ta_Id;
            [self.navigationController pushViewController:controller animated:YES ];
        }
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return (isReceived)?NO:YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MyRenwuListModel *model= [dataArr objectAtIndex:indexPath.row];
        [self deleteRenWuBy:model.Ta_Id AndNSIndexPath:indexPath];
    }
}
-(void)deleteRenWuBy:(NSString*)taid AndNSIndexPath:(NSIndexPath *)indexPath{
    [AlertHelper singleMBHUDShow:@"删除中..." ForView:self.view];
    [RenWuWebAPI deleteSingleRenWu:taid
                           success:^(NSArray *arr) {
                               [AlertHelper hideAllHUDsForView:self.view];
                               NSDictionary *dict =[arr objectAtIndex:0];
                               NSString *flag=[dict valueForKey:@"bool"];
                               if ([@"1" isEqualToString:flag]) {
                                   
                                   [dataArr removeObjectAtIndex:indexPath.row];
                                   [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                               }else{
                                   [AlertHelper singleMBHUDShow:@"操作失败" ForView:self.view AndDelayHid:2];
                               }
                           } fail:^{
                               [AlertHelper hideAllHUDsForView:self.view];
                               [AlertHelper singleMBHUDShow:@"网络出现错误" ForView:self.view AndDelayHid:2];
                           }];
}

-(void)refreshingDataList{
    [self.tableView headerBeginRefreshing];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddRenWuViewController *controller = segue.destinationViewController;
    [controller setRefreshNotification:self];
}


- (IBAction)redirectToManScene:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
