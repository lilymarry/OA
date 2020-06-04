//
//  MyNewRenWuViewController.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/4.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "MyNewRenWuViewController.h"
#import "HotRewWuWebAPI.h"
//#import <MBProgressHUD.h>
#import "UserPermission.h"
#import "MyRenwuCell.h"
#import "MyRenwuListHotModel.h"
#import "ScreenHelper.h"
#import "MyRenWuNewReceivedDetailViewController.h"
#import "RenWuDetailViewController.h"
#import "MyRenWuFaBuViewController.h"
#import "CharacterHelper.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#import "CommonDelegate.h"
#import "AddRenWuViewController.h"
#import "AllRenWuHotDetailViewController.h"
@interface MyNewRenWuViewController ()<CommonNotification>{
    bool isReceived;
    BOOL isFisrtDispear;
    NSMutableArray *dataArr;
    NSString *typ;
    NSString *maxid;
    
    NSString *method;
}


@end

@implementation MyNewRenWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isReceived= YES;
    isFisrtDispear=YES;
    dataArr=[[NSMutableArray alloc ] init];
  //  typ =[[NSString alloc]init];
  //  typ=@"2";
    method=@"MyTask";
    NSString *menuRoleStr= [UserPermission standartUserInfo].MenuRole;
    NSRange range = [menuRoleStr rangeOfString:@"rw_fb"];
    if ( range.location == NSNotFound)
    {
        self.navigationItem.rightBarButtonItem=nil;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self setupRefresh];
}
//改变列表
- (IBAction)changeMyRenwuList:(id)sender {
    
    switch ([self.segment selectedSegmentIndex]) {
        case 0:
            method=@"MyTask";
               [self.tableView headerBeginRefreshing];
            break;
        case 1:
            method=@"ReleaseTask";
         
             [self.tableView headerBeginRefreshing];
            break;
        case 2:
            method=@"NOFAuditTask";
       
               [self.tableView headerBeginRefreshing];
            break;
        case 3:
            method=@"YESFAuditTask";
       
               [self.tableView headerBeginRefreshing];
            break;
     
        default:
            break;
    }

    
    
//    isReceived = isReceived?NO:YES;
//   
//    [self.tableView headerBeginRefreshing];

    
//    if (isReceived) {
//        [self reloadTheReceivedList];
//    }else{
//        [self reloadThePublishedList];
//    }
}

//-(void)reloadTheReceivedList
//{
//       typ=@"2";
//    
//    
//     [self.tableView headerBeginRefreshing];
//    
//}
//-(void)reloadThePublishedList{
//    typ=@"1";
//    [self.tableView headerBeginRefreshing];
//}
//-(void)reloadTheListByType:(NSString*)type{
//    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText=@"获取中...";
//    
//    [RenWuWebAPI requestHostListByUID:[UserPermission standartUserInfo].ID AndType:type    taid:@"0" page:@"0"
//                          success:^(NSArray *renwulist)
//     {
//         [hud hide:YES];
//         [dataArr removeAllObjects];
//         for (NSDictionary *dict in renwulist) {
//             MyRenwuListHotModel *model=[[MyRenwuListHotModel alloc]initWithJson:dict];
//             [dataArr addObject:model];
//         }
//         
//         [self.tableView reloadData];
//         
//     } fail:^{
//         [MBProgressHUD hideHUDForView:self.view animated:YES];
//         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//         [alert show];
//     }];
//}

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
    [HotRewWuWebAPI requestTaskByUID:[UserPermission standartUserInfo].ID method:method
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
                                     
                                     [self.tableView reloadData];
                                     [self.tableView headerEndRefreshing];
                                     
                                 } fail:^{
                                     [self.tableView headerEndRefreshing];
                                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                     [alert show];
                                 }];

    
    
    
    
//    if (isReceived) {
//    [HotRewWuWebAPI requestHostListByUID:[UserPermission standartUserInfo].ID AndType:@""
//                             taid:@"0" page:@"0" 
//                          success:^(NSArray *renwulist){
//                          
//                              
//                              [dataArr removeAllObjects];
//                              if (renwulist.count>0) {
//                                  for (NSDictionary *dict in renwulist[0][@"task"]) {
//                                      MyRenwuListHotModel *model=[[MyRenwuListHotModel alloc]initWithJson:dict];
//                                      [dataArr addObject:model];
//                                  }
//                                  maxid=  renwulist[0][@"MaxId"];
//                              }
//                              
//                              [self.tableView reloadData];
//                              [self.tableView headerEndRefreshing];
//                              
//                          } fail:^{
//                              [self.tableView headerEndRefreshing];
//                              UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//                              [alert show];
//                          }];
//    }
//    else
//    {
//      
//        [HotRewWuWebAPI requestReleaseTaskByUID:[UserPermission standartUserInfo].ID AndType:@""
//                                     taid:@"0" page:@"0"
//                                  success:^(NSArray *renwulist){
//                                      
//                                      
//                                      [dataArr removeAllObjects];
//                                      if (renwulist.count>0) {
//                                          for (NSDictionary *dict in renwulist[0][@"task"]) {
//                                              MyRenwuListHotModel *model=[[MyRenwuListHotModel alloc]initWithJson:dict];
//                                              [dataArr addObject:model];
//                                          }
//                                          maxid=  renwulist[0][@"MaxId"];
//                                      }
//                                      
//                                      [self.tableView reloadData];
//                                      [self.tableView headerEndRefreshing];
//                                      
//                                  } fail:^{
//                                      [self.tableView headerEndRefreshing];
//                                      UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//                                      [alert show];
//                                  }];
//    
//    
//    }
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
       // MyRenwuListHotModel *model=dataArr[0];
     //   NSString *idStr=model.Ta_Id ;
      //  if (isReceived) {
            
      
       NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long) dataArr.count ];
        // 1.添加数据
            [HotRewWuWebAPI  requestTaskByUID:[UserPermission standartUserInfo].ID method:method
                                         taid:@"0" page:pag
                                      success:^(NSArray *arr){
                                     if (arr.count>0) {
                                         for (NSDictionary *dict in arr[0][@"task"]) {
                                             MyRenwuListHotModel *model=[[MyRenwuListHotModel alloc]initWithJson:dict];
                                             [dataArr addObject:model];
                                         }

                                     }
                                     
                                     
                                     [self.tableView reloadData];
                                     [self.tableView footerEndRefreshing];
                                     
                                 } fail:^{
                                     [self.tableView footerEndRefreshing];
                                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                     [alert show];
                                 }];
            
    }
//        else
//        {
//            NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long) dataArr.count ];
//            // 1.添加数据
//            [HotRewWuWebAPI requestReleaseTaskByUID:[UserPermission standartUserInfo].ID AndType:@""
//                                         taid:maxid page:pag success:^(NSArray *arr){
//                                             if (arr.count>0) {
//                                                 for (NSDictionary *dict in arr[0][@"task"]) {
//                                                     MyRenwuListHotModel *model=[[MyRenwuListHotModel alloc]initWithJson:dict];
//                                                     [dataArr addObject:model];
//                                                 }
//                                                 
//                                             }
//                                             
//                                             
//                                             [self.tableView reloadData];
//                                             [self.tableView footerEndRefreshing];
//                                             
//                                         } fail:^{
//                                             [self.tableView footerEndRefreshing];
//                                             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//                                             [alert show];
//                                         }];
//
//        }
//    }

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
    MyRenwuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myrenwucell" forIndexPath:indexPath];
    cell.imgFlag.hidden = NO;
    NSString *flagStr=@"unarchived.png";
    if ([method isEqualToString:@"MyTask"]) {
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
    cell.labTitle.text= model.Ta_Area;
    cell.labDesc.text=[CharacterHelper replacingTheBRToEmpty:model.Ta_Description ];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyRenwuListHotModel *model= [dataArr objectAtIndex:indexPath.row];
    NSLog(@"WW %@",model.Ta_Iscomplete);
    
    //已完成任务
//    if ([model.Ta_Iscomplete isEqualToString:@"1"] ) {
//    //    AllRenWuHotDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"renwudetail"];
//         AllRenWuHotDetailViewController *controller = [[AllRenWuHotDetailViewController alloc]init];
//        controller.ta_id= model.Ta_Id;
//        [self.navigationController pushViewController:controller animated:YES ];
//    }else{
        if ([method isEqualToString:@"MyTask"])
        {  if (![model.Ta_Iscomplete isEqualToString:@"1"] ) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyRenWuHot" bundle:[NSBundle mainBundle]];
        MyRenWuNewReceivedDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"RenWuNewReceived"];
        controller.ta_id= model.Ta_Id;
        [self.navigationController pushViewController:controller animated:YES ];
          }
        else
        {
            AllRenWuHotDetailViewController *controller = [[AllRenWuHotDetailViewController alloc]init];
            controller.ta_id= model.Ta_Id;
            controller.tyteName=method;
            controller.Taop_ISFAudit=model.Taop_ISFAudit;
            controller.Taop_ISRelease=model.Taop_ISRelease;
            [self.navigationController pushViewController:controller animated:YES ];
            
            
        }

        }
        else
        {
            AllRenWuHotDetailViewController *controller = [[AllRenWuHotDetailViewController alloc]init];
            controller.ta_id= model.Ta_Id;
            controller.tyteName=method;
            controller.Taop_ISFAudit=model.Taop_ISFAudit;
            controller.Taop_ISRelease=model.Taop_ISRelease;
            [self.navigationController pushViewController:controller animated:YES ];
        
        
        }
   //   }
//    else{
//            MyRenWuFaBuViewController *controller = [storyboard instantiateViewControllerWithIdentifier:storyID];
//            controller.ta_id= model.Ta_Id;
//            [self.navigationController pushViewController:controller animated:YES ];
//        }
//    }
}

//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return (isReceived)?NO:YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        MyRenwuListHotModel *model= [dataArr objectAtIndex:indexPath.row];
//        [self deleteRenWuBy:model.Ta_Id AndNSIndexPath:indexPath];
//    }
//}
//-(void)deleteRenWuBy:(NSString*)taid AndNSIndexPath:(NSIndexPath *)indexPath{
//    [AlertHelper singleMBHUDShow:@"删除中..." ForView:self.view];
//    [RenWuWebAPI deleteSingleRenWu:taid
//                           success:^(NSArray *arr) {
//                               [AlertHelper hideAllHUDsForView:self.view];
//                               NSDictionary *dict =[arr objectAtIndex:0];
//                               NSString *flag=[dict valueForKey:@"bool"];
//                               if ([@"1" isEqualToString:flag]) {
//                                   
//                                   [dataArr removeObjectAtIndex:indexPath.row];
//                                   [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//                               }else{
//                                   [AlertHelper singleMBHUDShow:@"操作失败" ForView:self.view AndDelayHid:2];
//                               }
//                           } fail:^{
//                               [AlertHelper hideAllHUDsForView:self.view];
//                               [AlertHelper singleMBHUDShow:@"网络出现错误" ForView:self.view AndDelayHid:2];
//                           }];
//}
//
-(void)refreshingDataList{
    [self.tableView headerBeginRefreshing];
}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    AddRenWuViewController *controller = segue.destinationViewController;
//    [controller setRefreshNotification:self];
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (IBAction)redirectToManScene:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
