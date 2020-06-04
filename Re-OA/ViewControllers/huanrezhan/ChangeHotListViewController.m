//
//  ChangeHotListViewController.m
//  Re-OA
//
//  Created by imac-1 on 2016/12/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "ChangeHotListViewController.h"
#import "MJRefresh.h"
#import "AlertHelper.h"
#import "CommonDelegate.h"
#import "ChangeHostWebAPI.h"
#import "ChangHotModel.h"
#import "ChangHotListCell.h"
#import "AddHotListViewController.h"
@interface ChangeHotListViewController ()<CommonNotification>{

    NSMutableArray *dataArr;
 
    NSString *maxid;
    int page;
}


@end

@implementation ChangeHotListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     dataArr=[[NSMutableArray alloc ] init];
      maxid=@"";
      page=0;
       [self setupRefresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    page=0;
    [ChangeHostWebAPI requestChangHotPageCount:@"5" page:[NSString stringWithFormat:@"%d",page] MaxId:maxid success:^(NSArray *renwulist) {
        

                                         
                                         
                                         [dataArr removeAllObjects];
                                         if (renwulist.count>0) {
                                             for (NSDictionary *dict in renwulist[0][@"rows"]) {
                                                 ChangHotModel *model=[[ChangHotModel alloc]init];
                                                 [model setValuesForKeysWithDictionary:dict];

                                                 [dataArr addObject:model];
                                             }
                                             maxid=  renwulist[0][@"MaxId"];
                                         }
        page ++;
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
        
        
        [ChangeHostWebAPI requestChangHotPageCount:@"5" page:[NSString stringWithFormat:@"%d",page] MaxId:maxid success:^(NSArray *renwulist) {
            
            if (renwulist.count>0) {
                for (NSDictionary *dict in renwulist[0][@"rows"]) {
                    ChangHotModel *model=[[ChangHotModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    
                    [dataArr addObject:model];
                }
                maxid=  renwulist[0][@"MaxId"];
                    page ++;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismisViewCon:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
   
        return dataArr.count;
   
}
//quanbudetailcell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
        static NSString *CustomCellIdentifier = @"Cell1";
        ChangHotModel *model=[dataArr objectAtIndex:indexPath.row];
        ChangHotListCell  *cell = (ChangHotListCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
        if (!cell) {
            NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ChangHotListCell" owner:nil options:nil];
            cell= [nibView lastObject];
        }
        cell.HTR_Consumption1.text=[NSString stringWithFormat:@"%@kg/㎡", model.HTR_Consumption1];;
        cell.HTR_Consumption2.text=[NSString stringWithFormat:@"%@kw*h/㎡", model.HTR_Consumption2];;
        cell.HTR_Consumption3.text=[NSString stringWithFormat:@"%@GL/㎡", model.HTR_Consumption3];
        cell.HTR_Date.text=model.HTR_Date;
        cell.HTR_M.text= [NSString stringWithFormat:@"%@㎡", model.HTR_M];
    
        cell.HTR_Mark1.text=[NSString stringWithFormat:@"%@kg/㎡",model.HTR_Mark1];
        cell.HTR_Mark2.text=[NSString stringWithFormat:@"%@kw*h/㎡",model.HTR_Mark2];
        cell.HTR_Mark3.text=[NSString stringWithFormat:@"%@GL/㎡",model.HTR_Mark3];
        cell.HTR_SiteName.text=model.HTR_SiteName;
    return cell;
        
 
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        return 158;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"HotChang" bundle:[NSBundle mainBundle]];
    ChangHotModel *model=[dataArr objectAtIndex:indexPath.row];
    AddHotListViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"AddHotList"];
    controller._mode= model;
    controller.state=@"0";
    [self.navigationController pushViewController:controller animated:YES ];


}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     AddHotListViewController *viewController = segue.destinationViewController;
    [viewController setRefreshNotification:self];

}
-(void)refreshingDataList
{
    [self.tableView headerBeginRefreshing];

}


@end
