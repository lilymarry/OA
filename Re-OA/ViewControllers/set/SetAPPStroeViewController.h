//
//  SetAPPStroeViewController.h
//  Re-OA
//
//  Created by imac-1 on 2016/11/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScreenHelper.h"
#import "PWView.h"
#import <MBProgressHUD.h>
#import "NetRequestTool.h"
#import "UserPermission.h"
#import "LocationTracker.h"
#define kPASSWORD @"password"
#define kUSERNAME @"username"
@interface SetAPPStroeViewController : UIViewController<okButtonDelegate,cancelButtonDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bacScrolzview;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwi;
@property (weak, nonatomic) IBOutlet UISwitch *sharkSwi;
//@property (weak, nonatomic) IBOutlet UISwitch *swi_GPS;
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UIImageView *BackImaView;
@property (strong, nonatomic)  PWView *PWview;//修改密码视图
@property LocationTracker * locationTracker;
@property (nonatomic) NSTimer* locationUpdateTimer;
- (IBAction)chageSoundPress:(id)sender;//声音开关
- (IBAction)changSharkPress:(id)sender;//震动开关
- (IBAction)changPWPress:(id)sender;//显示修改密码视图
- (IBAction)lastBtnPress:(id)sender;


@end
