//
//  QuanBuNewRenWuViewController.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/5.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "QuanBuNewRenWuViewController.h"
#import "HotRewWuWebAPI.h"
#import <MBProgressHUD.h>
#import "UserPermission.h"
#import "QuanBuRenWuCell.h"
#import "MyRenwuListHotModel.h"
//#import "RenWuNewDetailViewController.h"
#import "MJRefresh.h"
#import "CharacterHelper.h"
#import "AllRenWuHotDetailViewController.h"
#import "RenwuHotPersonViewController.h"
@interface QuanBuNewRenWuViewController ()
{
    
    BOOL isFisrtDispear;
    NSMutableArray *dataArr;
    NSString *maxid;

}
@property (weak, nonatomic) IBOutlet UILabel *labshouquan;
@property (weak, nonatomic) IBOutlet UILabel *labkaitong;
@end

@implementation QuanBuNewRenWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isFisrtDispear=YES;
    dataArr=[[NSMutableArray alloc ] init];
    self.navigationItem.title=@"全部任务";
    
    NSString *menuRoleStr= [UserPermission standartUserInfo].MenuRole;
    NSRange range = [menuRoleStr rangeOfString:@"rw_qb"];
    if ( range.location == NSNotFound)
    {
        [self.tableview removeFromSuperview];
        
    }else
    {
        [self.labkaitong removeFromSuperview];
        [self.labshouquan removeFromSuperview];
        [self setupRefresh];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    //    [self setupRefresh];
}

-(void)reloadTheList{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"获取中...";
    
    [HotRewWuWebAPI requestAllTaskByUID:[UserPermission standartUserInfo].ID AndType:@""
                             taid:@"0" page:@"0"
                          success:^(NSArray *renwulist){
                              [hud hide:YES];
                              [dataArr removeAllObjects];
                              for (NSDictionary *dict in renwulist) {
                                  MyRenwuListHotModel *model=[[MyRenwuListHotModel alloc]initWithJson:dict];
                                  [dataArr addObject:model];
                              }
                              [self.tableview reloadData];
                          } fail:^{
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                              [alert show];
                          }];
    
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableview headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableview addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [HotRewWuWebAPI requestAllTaskByUID:[UserPermission standartUserInfo].ID AndType:@""
                             taid:@"0" page:@"0"
                          success:^(NSArray *renwulist){
                             

                              [dataArr removeAllObjects];
                                 if (renwulist.count>0) {
                              for (NSDictionary *dict in renwulist[0][@"task"]) {
                                  MyRenwuListHotModel *model=[[MyRenwuListHotModel alloc]initWithJson:dict];
                                  [dataArr addObject:model];
                              }
                               maxid=  renwulist[0][@"MaxId"];
                                 }
                              [self.tableview reloadData];
                              [self.tableview headerEndRefreshing];
                              
                          } fail:^{
                              [self.tableview headerEndRefreshing];
                              UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                              [alert show];
                          }];
}

- (void)footerRereshing
{
    if (dataArr.count==0)
    {
        self.tableview.footerRefreshingText = @"无更新数据";
        [self.tableview footerEndRefreshing];
        return ;
    }
    else
    {
     //   MyRenwuListHotModel *model=dataArr[0];
    //    NSString *idStr=model.Ta_Id ;
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long) dataArr.count ];
        // 1.添加数据
        [HotRewWuWebAPI requestAllTaskByUID:[UserPermission standartUserInfo].ID AndType:@""
                                 taid:maxid page:pag success:^(NSArray *arr){
                                     if (arr.count>0) {

                                     
                                     for (NSDictionary *dict in arr[0][@"task"]) {
                                         MyRenwuListHotModel *model=[[MyRenwuListHotModel alloc]initWithJson:dict];
                                         [dataArr addObject:model];
                                     }
                                     }
                                     [self.tableview reloadData];
                                     [self.tableview footerEndRefreshing];
                                     
                                 } fail:^{
                                     [self.tableview footerEndRefreshing];
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
    
    MyRenwuListHotModel *model = [dataArr objectAtIndex:indexPath.row];
    QuanBuRenwuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quanburenwucell" forIndexPath:indexPath];
    
    NSString *flagStr=@"unarchived.png";
    cell.imgFlag.hidden = NO;
    
    if ([model.Ta_Iscomplete isEqualToString:@"3"]) {
        flagStr=@"unarchived.png";
    }else if ([model.Ta_Iscomplete isEqualToString:@"2"]){
        flagStr=@"archiving.png";
    }else if ([model.Ta_Iscomplete isEqualToString:@"1"]){
        cell.imgFlag.hidden = YES;
    }
    
    cell.imgFlag.image=[UIImage imageNamed:flagStr];
    
    cell.labDate.text= model.Ta_Lssueddate;
    cell.labTitle.text= model.Ta_Area;
    cell.labDesc.text=[CharacterHelper replacingTheBRToEmpty:model.Ta_Description] ;
    cell.labUser.text=model.Ta_Username;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    MyRenwuListHotModel *model= [dataArr objectAtIndex:indexPath.row];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RenWuHot" bundle:[NSBundle mainBundle]];
//    RenWuNewDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"renwudetail"];
    AllRenWuHotDetailViewController *controller =[[AllRenWuHotDetailViewController alloc]init];
    controller.ta_id= model.Ta_Id;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:controller animated:YES ];
     self.hidesBottomBarWhenPushed=NO;
}
- (IBAction)redirectToManScene:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
