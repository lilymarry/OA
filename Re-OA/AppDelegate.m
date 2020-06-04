#import "AppDelegate.h"

#import "LoginViewController.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate

// 程序开启时，执行该方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {    UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    if (isProduction ) {
        NSLog(@"YYYYY");
    }
    else
    {
        NSLog(@"NNNNN");
    }
    
    //    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
    //                                                   UIRemoteNotificationTypeSound |
    //                                                   UIRemoteNotificationTypeAlert)
    //                                       categories:nil];
    //
    //    [APService setupWithOption:launchOptions];
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    [JPUSHService setBadge:0];
    //  UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:dituKey generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    LoginViewController *login=[[LoginViewController alloc]init];
    //  ZhiBanLoginViewController *login=[[ZhiBanLoginViewController alloc]init];
     self.window.rootViewController=login;
    
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    timer = [[NSTimer alloc] initWithFireDate:fireDate
                                     interval:1
                                       target:self
                                     selector:@selector(countedtargetMethod:)
                                     userInfo:nil
                                      repeats:YES];
    
    timerCount = 1;
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
    
    return YES;
}
-(void)countedtargetMethod:(NSTimer*)theTimer
{
    
    timerCount++;
    @try
    {
        if (timerCount ==60*30)
        {
            [[NetRequestTool sharedRequest]requestLineState:[UserPermission standartUserInfo].ID success:^(NSArray *arr ){
                //  NSLog(@"%@",arr);
            } fail:^{}];
            timerCount=0;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

// 当应用程序掉到后台时，执行该方法
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    UIApplication*   app = [UIApplication sharedApplication];
    
    
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
                NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
                timer = [[NSTimer alloc] initWithFireDate:fireDate
                                                 interval:1
                                                   target:self
                                                 selector:@selector(countedtargetMethod:)
                                                 userInfo:nil
                                                  repeats:YES];
                
                timerCount = 1;
                NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
                [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
                
                
                
                
                
                
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
    
    
    
}

// 当应用程序回到前台时，执行该方法
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    //   [APService setBadge:0];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    // 程序进入前台，转化为高精确定位
    // self.executingInBackground = NO;
    //  [self.myLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // [APService registerDeviceToken:deviceToken];
    [JPUSHService registerDeviceToken:deviceToken];
    
    
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    
    [JPUSHService handleRemoteNotification:userInfo];
    NSString *key= userInfo[@"lx"];
    
    if (application.applicationState == UIApplicationStateInactive)
    {
        [self gettongzhiData:key dic:userInfo];
    }
    
    else
    {
        //  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:tishi delegate:self cancelButtonTitle:@"处理" otherButtonTitles:@"否", nil];
        
        //  [alert show];
        
    }
    
    
    [JPUSHService setBadge:0];
    
    
}
-(void)gettongzhiData:(NSString *)str dic:(NSDictionary *)dic
{
    if ([str isEqualToString:@"gg"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"gongao" object:dic];
        
    }
    if ([str isEqualToString:@"rz"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"rizhi" object:dic];
    }
    
    if ([str isEqualToString:@"rw"]||[str isEqualToString:@"rwwc"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"renwu" object:dic];
        
    }
    
    if ([str isEqualToString:@"sp"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shenhe" object:dic];
        
    }
    if ([str isEqualToString:@"spwc"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shangbao" object:dic];
        
    }
    
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    NSString *key= userInfo[@"lx"];
    if (application.applicationState == UIApplicationStateInactive)
    {
        [self gettongzhiData:key dic:userInfo];
    }
    
    else
    {
        //  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:tishi delegate:self cancelButtonTitle:@"处理" otherButtonTitles:@"否", nil];
        
        //  [alert show];
        
    }
    [JPUSHService setBadge:0];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
    }
    else
    {
        
        
    }
    
}
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    //    UNNotificationRequest *request = notification.request; // 收到推送的请求
    //    UNNotificationContent *content = request.content; // 收到推送的消息内容
    //
    //    NSNumber *badge = content.badge;  // 推送消息的角标
    //    NSString *body = content.body;    // 推送消息体
    //    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    //    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    //    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
//        NSString *key= userInfo[@"lx"];
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:tishi delegate:self cancelButtonTitle:@"处理" otherButtonTitles:@"否", nil];
//        
//     [alert show];
  //  [self gettongzhiData:key dic:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
    }
    else {
        // 判断为本地通知
        //   NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    [JPUSHService setBadge:0];
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    //    UNNotificationContent *content = request.content; // 收到推送的消息内容
    //
    //    NSNumber *badge = content.badge;  // 推送消息的角标
    //    NSString *body = content.body;    // 推送消息体
    //    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    //    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    //    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSString *key= userInfo[@"lx"];
        [self gettongzhiData:key dic:userInfo];
        //  NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
    }
    else {
        // 判断为本地通知
        //  NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    [JPUSHService setBadge:0];
    completionHandler();  // 系统要求执行这个方法
}
#endif
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    application.applicationIconBadgeNumber =0;
    [[UIApplication sharedApplication] cancelLocalNotification:notification];

    
    
//    if (application.applicationState == UIApplicationStateInactive)
//    {
//        NSArray *keyArr=[notification.userInfo allKeys];
//        for (NSString *key in keyArr)
//        {
//            if([key isEqualToString:@"Jo_Title"])
//            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"rizhi" object:notification.userInfo];
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            }
//            if ([key isEqualToString:@"Ta_Name"])
//            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"renwu" object:notification.userInfo];
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            }
//            if ([key isEqualToString:@"Ne_Title"])
//            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"gongao" object:notification.userInfo];
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            }
//            if ([key isEqualToString:@"FPI_Id"])
//            {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"shenhe" object:notification.userInfo];
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//                
//            }}}
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

//- (NSString *)logDic:(NSDictionary *)dic {
//    if (![dic count]) {
//        return nil;
//    }
//    NSString *tempStr1 =
//    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
//                                                 withString:@"\\U"];
//    NSString *tempStr2 =
//    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 =
//    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *str =
//    [NSPropertyListSerialization propertyListFromData:tempData
//                                     mutabilityOption:NSPropertyListImmutable
//                                               format:NULL
//                                     errorDescription:NULL];
//    return str;
//}
//

@end
