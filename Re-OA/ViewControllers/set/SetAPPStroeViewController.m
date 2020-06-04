 //
//  SetAPPStroeViewController.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "SetAPPStroeViewController.h"
#import "AlertHelper.h"
#import "AppDelegate.h"
#import "ChangYongMenuViewController.h"
@interface SetAPPStroeViewController ()<UIAlertViewDelegate>{
    NSString *versionStr;
    NSString *versionShortStr;
    NSString *appUrl;
    BOOL isappstore;
    /// SetViewController * single;
}


@end

@implementation SetAPPStroeViewController

{
    CGRect  viewRect;
}
- (void)viewDidLoad {
    //  isappstore= ((AppDelegate*)[[UIApplication sharedApplication] delegate]).isSubmiteToAppStore;
    
    [super viewDidLoad];
    
    versionStr =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    versionShortStr =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    // Do any additional setup after loading the view.
    viewRect = CGRectMake(0, 0,[ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT]);
    self.view.bounds=viewRect;
    self.bacScrolzview.contentSize=CGSizeMake(viewRect.size.width, viewRect.size.height+20);
    
    //判定switch状态
    [self SetswitchON];
    
    
    //加载修改密码视图
    _PWview =[[PWView alloc]initWithFrame:CGRectMake(0, viewRect.size.height, viewRect.size.width,240)];
    _PWview.cancelDelegate=self;
    _PWview.okDelegate=self;
    [self.view addSubview:_PWview];
    _BackView.alpha=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
//版本检测
- (IBAction)checkVersion:(id)sender {
    [AlertHelper singleMBHUDShow:@"检测版本中..." ForView:self.view];
    
    if (isappstore) {
        //appstore检测
    }else{
        /*
         [[NetRequestTool sharedRequest] requestVersionFromFIRsuccess:^(NSDictionary* dic){
         [AlertHelper hideAllHUDsForView:self.view];
         NSString *updateVersion= [dic valueForKey:@"version"];
         NSString *updateShortVersion= [dic valueForKey:@"versionShort"];
         appUrl = [dic valueForKey:@"update_url"];
         
         if ((![updateShortVersion isEqualToString:versionShortStr]) || (![updateVersion isEqualToString:versionStr])) {
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:[[NSString alloc] initWithFormat:@"检测到新版本 v%@(build:%@)",updateShortVersion,updateVersion] delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"现在升级", nil];
         alert.tag=1000;
         [alert show];
         }else{
         [AlertHelper singleMBHUDShow:@"已经是最新版本" ForView:self.view AndDelayHid:2];
         }
         } fail:^(){
         [AlertHelper hideAllHUDsForView:self.view];
         }];
         */
        [[NetRequestTool sharedRequest]requestVersionFromURLsuccess:^(NSArray *arr){
            // NSLog(@"WWW!! %@",arr);
            [AlertHelper hideAllHUDsForView:self.view];
            
            NSString *updateVersion= [arr[0] valueForKey:@"version"];
            //            NSString *updateShortVersion= [dic valueForKey:@"versionShort"];
            appUrl = [arr[0] valueForKey:@"url"];
            //
            if ( (![updateVersion isEqualToString:versionStr])) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"有可用的更新！" message:[[NSString alloc] initWithFormat:@"检测到新版本 v%@",updateVersion] delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"现在升级", nil];
                alert.tag=1000;
                [alert show];
            }
            else{
                [AlertHelper singleMBHUDShow:@"已经是最新版本" ForView:self.view AndDelayHid:2];
            }
            
            
        } fail:^(){
            [AlertHelper hideAllHUDsForView:self.view];
        }];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect frame=self.view.bounds;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    frame.origin.y-= window.frame.size.height==568?150:178;
    [UIView animateWithDuration:0.5f animations:^{
        self.view.frame=frame;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect frame=self.view.frame;
    frame.origin.y=0;
    [UIView animateWithDuration:0.5f animations:^{
        self.view.frame=frame;
    }];
}
/*
 -(void)CheakGPS
 {
 if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GPS"]) {
 
 [self startUploadLocation];
 }
 else{
 
 
 [self endlocation];
 }
 
 }
 
 #pragma mark
 -(void)startUploadLocation{
 
 self.locationTracker = [[LocationTracker alloc]init];
 [self.locationTracker startLocationTracking];
 NSTimeInterval time =  [[UserPermission standartUserInfo].time intValue];
 self.locationUpdateTimer =
 [NSTimer scheduledTimerWithTimeInterval:5
 target:self
 selector:@selector(updateLocation)
 userInfo:nil
 repeats:YES];
 }
 
 -(void)updateLocation{
 [self.locationTracker updateLocationToServer];
 }
 -(void)endlocation
 {
 NSLog(@"stop location");
 [self.locationUpdateTimer invalidate];
 //  self.locationUpdateTimer =nil;
 [self.locationTracker stopLocationTracking];
 
 }
 */
-(void)SetswitchON
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"sound"])
    {
        [_soundSwi setOn:YES];
    }
    else
    {
        [_soundSwi setOn:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"shark"])
    {
        [_sharkSwi setOn:YES];
    }
    else
    {
        [_sharkSwi setOn:NO];
    }
    //    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"GPS"])
    //    {
    //        [_swi_GPS setOn:YES];
    //       //  [self startUploadLocation];
    //    }
    //    else
    //    {
    //        [_swi_GPS setOn:NO];
    //     //   [self endlocation];
    //    }
    
}
- (IBAction)chageSoundPress:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setBool:_soundSwi.on forKey:@"sound"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)changSharkPress:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setBool:_sharkSwi.on forKey:@"shark"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//- (IBAction)changGPSPress:(id)sender
//{
//    [[NSUserDefaults standardUserDefaults]setBool:_swi_GPS.on forKey:@"GPS"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//
//  //  [self SetswitchON];
//
//
//}
- (IBAction)changPWPress:(id)sender
{
    _BackImaView.hidden=YES;
    [_sharkSwi setEnabled:NO];
    [_soundSwi setEnabled:NO];
    //  [_swi_GPS setEnabled:NO];
    NSTimeInterval animationDuration = 0.5f;
    
    [UIView beginAnimations:@"back" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    _BackView.alpha=0.8;
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"display" context:nil];
    [UIView setAnimationDuration:animationDuration];
    _PWview.center=self.view.center;
    [UIView commitAnimations];
}
-(void)doButton:(id)sender
{
    NSString *message;
    if ([_PWview.yuanPW.text isEqualToString:@""]) {
        message=@"原密码不能为空！";
    }else if ([_PWview.xinPW.text isEqualToString:@""])
    {
        message=@"新密码不能为空!";
    }else if (![_PWview.quePW.text isEqualToString:_PWview.xinPW.text])
    {
        message=@"两次输入密码不相同!";
    }
    
    if (message)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [AlertHelper singleMBHUDShow:@"提交中" ForView:self.view];
        
        [[NetRequestTool sharedRequest] requestUpdataPw:[UserPermission standartUserInfo].ID newPw:_PWview.xinPW.text   success:^(NSArray *success)
         {
             [AlertHelper hideAllHUDsForView:self.view];
             @try {
                 //  NSLog(@"修改密码 %@",success);
                 int code = [[success[0]objectForKey:@"rzt"] intValue];
                 if (code==1)
                 {
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                 }else
                 {
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"修改失败,请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                 }
             }
             @catch (NSException *exception) {
                 
             }
             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             [self cancelButton:nil];
         } fail:^{
             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alert show];
             [self cancelButton:nil];
         }];
    }
}

-(void)cancelButton:(id)sender
{
    _BackImaView.hidden=YES;
    [_sharkSwi setEnabled:YES];
    [_soundSwi setEnabled:YES];
    //  [_swi_GPS setEnabled:YES];
    [_PWview.yuanPW resignFirstResponder];
    [_PWview.xinPW resignFirstResponder];
    [_PWview.quePW resignFirstResponder];
    
    NSTimeInterval animationDuration = 0.5f;
    [UIView beginAnimations:@"display" context:nil];
    [UIView setAnimationDuration:animationDuration];
    _PWview.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, viewRect.size.width,240 );
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"back" context:nil];
    [UIView setAnimationDuration:animationDuration];
    _BackView.alpha=0;
    [UIView commitAnimations];
}

- (IBAction)lastBtnPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancelButton:nil];
}

//退出
- (IBAction)signout:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"确定退出该app吗？" delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"是的", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (theAlert.tag==1000) {
        if (buttonIndex ==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
        }
    }else{
        if (1==buttonIndex) {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText=@"退出app中...";
            self.view.hidden=YES;
            [[NetRequestTool sharedRequest] requestsignout:[UserPermission standartUserInfo].ID
                                                   success:^(NSArray *success){
                                                   } fail:^{
                                                   }];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self exitApplication];
        }}
}
- (void)exitApplication {
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view.window cache:NO];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
}


@end
