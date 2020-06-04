//
//  MaintabViewController.m
//  Re-OA
//
//  Created by admin on 15/9/17.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "MaintabViewController.h"
#import "UserPermission.h"
@interface MaintabViewController ()

@end
@implementation MaintabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTongZhiMsgShow:) name:@"rizhi" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRenwuMsgShow:) name:@"renwu" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getGongGaoMsgShow:) name:@"gongao" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getshenheMsgShow:) name:@"shenhe" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getshangbaoMsgShow:) name:@"shangbao" object:nil];
    
       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTongZhiMsgShow:) name:@"rizhi" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRenwuMsgShow:) name:@"renwu" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getGongGaoMsgShow:) name:@"gongao" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getshenheMsgShow:) name:@"shenhe" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getshangbaoMsgShow:) name:@"shangbao" object:nil];
      [self startUploadLocation];

}
-(void)startUploadLocation{
    
    self.locationTracker = [[LocationTracker alloc]init];
    [self.locationTracker startLocationTracking];
    NSTimeInterval time =  [[UserPermission standartUserInfo].time intValue];
    self.locationUpdateTimer =
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(updateLocation)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)updateLocation{
    [self.locationTracker updateLocationToServer];
}

-(void)getGongGaoMsgShow:(NSNotification *)objec
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"gongGao" bundle:[NSBundle mainBundle]];
    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"gongGao"];

    [self presentViewController:changyongController animated:YES completion:nil];
}
-(void)getshenheMsgShow:(NSNotification *)objec
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"ShenHe" bundle:[NSBundle mainBundle]];
    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"ShenHe"];

    [self presentViewController:changyongController animated:YES completion:nil];
}
-(void)getRenwuMsgShow:(NSNotification *)objec
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"RenWu" bundle:[NSBundle mainBundle]];
    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"RenWu"];

    [self presentViewController:changyongController animated:YES completion:nil];

}
-(void)getTongZhiMsgShow:(NSNotification *)objec
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"rizhi" bundle:[NSBundle mainBundle]];
    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"rizhi"];

    [self presentViewController:changyongController animated:YES completion:nil];

}
-(void)getshangbaoMsgShow:(NSNotification *)objec
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]];
    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"ShangBao"];

    [self presentViewController:changyongController animated:YES completion:nil];
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
