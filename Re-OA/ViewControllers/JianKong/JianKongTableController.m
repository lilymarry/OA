//
//  JianKongTableController.m
//  Re-OA
//
//  Created by imac-1 on 15/5/27.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JianKongTableController.h"
#import "JianKongModel.h"
#import "PlayerDemoViewController.h"
#import "AlertHelper.h"
#import "JianKongWebAPI.h"
@interface JianKongTableController (){
    NSMutableArray *dataArry;
}

@end

@implementation JianKongTableController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   // NSLog(@"1111 %@ %@",_gcid, _lxid);
    dataArry= [NSMutableArray new];
    [AlertHelper singleMBHUDShow:@"获取中..." ForView:self.view];
    [JianKongWebAPI requestJianKongListWithgcid:_gcid lxid:_lxid success:^(NSArray *dataArr){
        
       // NSLog(@"WWWW %@",dataArr);
        [AlertHelper hidMBHUDFromView:self.view];
        [dataArry removeAllObjects];
        
        if (dataArr && dataArr.count>0) {
            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: dataArr[0]];
            NSArray *dictArr= [dict objectForKey:@"sxt"];
          //  NSLog(@"+++++AAAAAAAAA%@",dictArr);
            for (NSDictionary *dict1 in dictArr) {
                
                JianKongModel *model=[[JianKongModel alloc]initWithJson:dict1];
                [dataArry addObject:model];
            }
        }
        [self.tableView reloadData];

    
    
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
    
    }];
        /*
    JianKongModel *model = [[JianKongModel alloc] init];
    model.dkzx=@"5700";
    model.td=@"1";
    model.tdnm=@"摄像头1-1";
    model.ip=@"60.10.187.159";
    model.dvrnm=@"admin";
    model.dvrpwd=@"12345";
    
    [dataArry addObject:model];
    
    
    model = [[JianKongModel alloc] init];
    model.dkzx=@"6700";
    model.td=@"0";
    model.tdnm=@"摄像头2-0";
    model.ip=@"60.10.187.159";
    model.dvrnm=@"admin";
    model.dvrpwd=@"12345";
    
    [dataArry addObject:model];
    
    model = [[JianKongModel alloc] init];
    model.dkzx=@"6700";
    model.td=@"1";
    model.tdnm=@"摄像头2-1";
    model.ip=@"60.10.187.159";
    model.dvrnm=@"admin";
    model.dvrpwd=@"12345";
    
    [dataArry addObject:model];
    
    
    model = [[JianKongModel alloc] init];
    model.dkzx=@"7700";
    model.td=@"1";
    model.tdnm=@"摄像头3-1";
    model.ip=@"60.10.187.159";
    model.dvrnm=@"admin";
    model.dvrpwd=@"12345";
    
    [dataArry addObject:model];
    */
    
}

//- (IBAction)redirectToManScene:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

-(void)viewWillAppear:(BOOL)animated
{
//     [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
//     [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JianKongModel *model = [dataArry objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jiankongcell"];
    if (!cell)
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"jiankongcell"];
    
 
    cell.textLabel.text= [NSString stringWithFormat:@"%@-%ld",model.tdnm,indexPath.row+1];
    cell.detailTextLabel.text=model.td;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JianKongModel *model= (JianKongModel*)[dataArry objectAtIndex:indexPath.row];
   
    PlayerDemoViewController *plyerController = [[PlayerDemoViewController alloc] init];
     plyerController.m_deviceIpFieldstr=model.ip;
     plyerController.m_devicePortFieldstr=model.dkzx;
     plyerController.m_tongdao=model.td;
     plyerController.m_uerNameFieldstr=model.dvrnm;
     plyerController.m_passwordFieldstr=model.dvrpwd;
    [self.navigationController pushViewController:plyerController animated:YES];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationFaceDown animated:YES];
//    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
//    //设置旋转动画
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:duration];
//    //设置导航栏旋转
//    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 32);
//    self.navigationController.navigationBar.transform = CGAffineTransformMakeRotation(M_PI*(-0.5));
//    //设置视图旋转
//    self.view.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    self.view.transform = CGAffineTransformMakeRotation(M_PI*(-0.5));
//    [UIView commitAnimations];
//
//}
@end
