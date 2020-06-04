//
//  AllRenWuHotDetailViewController.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/7.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "AllRenWuHotDetailViewController.h"
#import <MBProgressHUD.h>
#import "HotRewWuWebAPI.h"
#import "UserPermission.h"
#import "MyReceivedReWuDetailModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RenWuChengJieRenCell.h"
#import "RenWuTaopListModel.h"
#import "LargeImageView.h"
#import "CharacterHelper.h"
#import "RenWuDetailHotModel.h"
#import "MyReceivedReWuHotDetailModel.h"
#import "RenWuHotUserCell.h"
#import "RenWuHotDetailViewCell.h"
#import "RenwuHotPersonViewController.h"
#import "AlertHelper.h"
#import "ScreenHelper.h"


@interface AllRenWuHotDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArr;
    MyReceivedReWuHotDetailModel *model;
    NSString*   usersidStr;
    NSString *  usersStr;
    
  //  UIBarButtonItem *item;
    
   UIButton *clorkBt;
   NSString *endTime;
    
}
@property (weak, nonatomic)  NSString *dayLabel;
@property (weak, nonatomic)  NSString *hourLabel;
@property (weak, nonatomic)  NSString *minuteLabel;
@property (weak, nonatomic)  NSString *secondLabel;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) UIButton *itembtn;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AllRenWuHotDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    dataArr =[NSMutableArray array];
    clorkBt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT]) style:UITableViewStylePlain];
   
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;

    [self.view addSubview:_tableView];
    
    
    
    [clorkBt setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH]-80, [ScreenHelper SCREEN_HEIGHT]-180, 60, 60)];
    [clorkBt setBackgroundImage:[UIImage imageNamed:@"unclork"] forState:UIControlStateNormal];
    [clorkBt setBackgroundImage:[UIImage imageNamed:@"clork"] forState:UIControlStateSelected];
    [clorkBt addTarget:self action:@selector(setClork:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clorkBt];
    
  //  clorkBt.selected=YES;
    
   // clorkBt.hidden=YES;
    

    
    NSArray *notificaitons = [[UIApplication sharedApplication] scheduledLocalNotifications];
   //设置已经存在的通知
    if (!notificaitons || notificaitons.count <= 0) {
        //   return;
    }
    for (UILocalNotification *notify in notificaitons) {
        if ([[notify.userInfo objectForKey:@"ta_id"] isEqualToString:self.ta_id]) {
            
            clorkBt.selected=YES;
            
            break;
        }
        
        
    }
    endTime=@"";
    
    if ([_tyteName isEqualToString:@"ReleaseTask"]) {
        UIBarButtonItem  *   item= [[UIBarButtonItem alloc] initWithTitle:@"分配" style:UIBarButtonItemStylePlain target:self action:@selector(dofenpei)];
        self.navigationItem.rightBarButtonItem=item;
        clorkBt.hidden=NO;
    }
    else if([_tyteName isEqualToString:@"NOFAuditTask"])
    {
        UIBarButtonItem  *    item= [[UIBarButtonItem alloc] initWithTitle:@"审核" style:UIBarButtonItemStylePlain target:self action:@selector(doshenhe)];
        self.navigationItem.rightBarButtonItem=item;
        clorkBt.hidden=NO;
    
    }
    else
    {
       clorkBt.hidden=YES;
    }
    
    [self loaddata];
   
    

}
-(void)setClork:(id)sender
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate=[dateFormatter dateFromString:endTime];
    
    NSDate *startDate = [NSDate date];
    
    NSTimeInterval timeInterval =[endDate timeIntervalSinceDate:startDate];
    int timeout = timeInterval;
    if (timeout<30*60) {
        [AlertHelper singleMBHUDShow:@"提醒无效，需提前30分钟设置" ForView:self.view AndDelayHid:1];
        
    }
    else
    {
        clorkBt.selected=!clorkBt.selected;
        
        if (clorkBt.selected) {
            [self  DateOfTiXing:endTime];
        }
        else
        {
            
            [self canellTongZhi];
        }
        
    }
    
    
    
}
- (void)DateOfTiXing:(NSString *)date{
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate=[dateFormatter dateFromString:date];
    
    
    NSString *title = @"您离任务结束时间还有30分钟";
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        // 设置通知的提醒时间
        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
        
        NSDate *date = [NSDate dateWithTimeInterval:-30*60 sinceDate:endDate];
        
        notification.fireDate = date;
        
        // 设置提醒的文字内容
        notification.alertBody   = @"您离任务结束时间还有30分钟";
        notification.alertAction = NSLocalizedString(title, nil);
        
        // 通知提示音 使用默认的
        notification.soundName= UILocalNotificationDefaultSoundName;
        
        // 设置应用程序右上角的提醒个数
        notification.applicationIconBadgeNumber++;
        
        // 设定通知的userInfo，用来标识该通知
        NSMutableDictionary *aUserInfo = [[NSMutableDictionary alloc] init];
        [aUserInfo setObject:self.ta_id forKey:@"ta_id"];
        notification.userInfo = aUserInfo;
        
        // ios8后，需要添加这个注册，才能得到授权
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            // 通知重复提示的单位，可以是天、周、月
            notification.repeatInterval = 0;
        } else {
            // 通知重复提示的单位，可以是天、周、月
            notification.repeatInterval = 0;
        }
        
        // 将通知添加到系统中
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        [AlertHelper singleMBHUDShow:@"任务提醒已设置" ForView:self.view AndDelayHid:1];
        
        //   }
    }
    // }
}

-(void)canellTongZhi
{
    NSArray *notificaitons = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //获取当前所有的本地通知
    if (!notificaitons || notificaitons.count <= 0) {
        return;
    }
    for (UILocalNotification *notify in notificaitons) {
        if ([[notify.userInfo objectForKey:@"ta_id"] isEqualToString:self.ta_id]) {
            //取消一个特定的通知
            [[UIApplication sharedApplication] cancelLocalNotification:notify];
            [AlertHelper singleMBHUDShow:@"任务提醒已取消" ForView:self.view AndDelayHid:1];
            break;
        }
        
    }
}
-(void)loaddata
{
//    if ([_Taop_ISRelease isEqualToString:@"0"]) {
//        UIBarButtonItem  *   item= [[UIBarButtonItem alloc] initWithTitle:@"分配" style:UIBarButtonItemStylePlain target:self action:@selector(dofenpei)];
//        self.navigationItem.rightBarButtonItem=item;
//        clorkBt.hidden=NO;
//    }
//    else  if ([_Taop_ISRelease isEqualToString:@"1"]&&[_Taop_ISFAudit isEqualToString:@"0"]) {
//        UIBarButtonItem  *    item= [[UIBarButtonItem alloc] initWithTitle:@"审核" style:UIBarButtonItemStylePlain target:self action:@selector(doshenhe)];
//        self.navigationItem.rightBarButtonItem=item;
//        clorkBt.hidden=NO;
//    }
//    
//    
//    else
//    {
//        clorkBt.hidden=YES;
//    }
    
    
    [AlertHelper MBHUDShow:@"获取中..." ForView:self.view AndDelayHid:30];
    
    [HotRewWuWebAPI requestHotReceivedDetailByUID:[UserPermission standartUserInfo].ID
                                       AndType:@"1"
                                       AndTAID:self.ta_id success:^(NSArray *renwulist){
                                           [AlertHelper hideAllHUDsForView:self.view];
                                           if (renwulist && renwulist.count>0) {
                                               
                                               [dataArr removeAllObjects];
                                               NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: renwulist[0]];
                                               
                                               model=[[MyReceivedReWuHotDetailModel alloc]initWithJson:[dict objectForKey:@"task"][0]];
                                               
                                               endTime=model.tastopdate;
                                               //当前时间
                                               NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                                               [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                               NSDate *endDate = [dateFormatter dateFromString:endTime];
                                               NSDate *startDate = [NSDate date];
                                               [self setJiShi:startDate date2:endDate];
                                               
                                               NSArray *arr=[dict objectForKey:@"list"];
                                               for (NSDictionary *dic in arr) {
                                                   RenWuDetailHotModel *mode=[[RenWuDetailHotModel alloc]initWithJson:dic];
                                                   [dataArr addObject:mode];
                                               }
                                               [self.tableView reloadData];
                                               
                                           }
                                           //  [hud hide:YES];
                                       }  fail:^{
                                           [AlertHelper hideAllHUDsForView:self.view];
                                           [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];                                       }];
    
}

-(void)dofenpei
{
    RenwuHotPersonViewController  *to=[[RenwuHotPersonViewController alloc]initWithBlock:^(NSArray *names,NSArray *uids)
                                       {
                                           NSMutableString *namestr=[NSMutableString string];
                                           NSMutableString *uidstr=[NSMutableString string];
                                           [names enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                                            {
                                                [namestr appendString:[NSString stringWithFormat:@"%@,",obj]];
                                            }];
                                           [uids enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                               [uidstr appendString:[NSString stringWithFormat:@"%@,",obj]];
                                           }];
                                           if (uidstr.length!=0&&namestr.length!=0)
                                           {
                                               usersidStr= [uidstr substringToIndex:uidstr.length-1];
                                               
                                               usersStr   = [namestr substringToIndex:namestr.length-1];
                                               // _txtUsers.text=usersStr;
                                               UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"任务分配给以下人员" message:usersStr delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
                                               alert.tag=1000;

                                               [alert show];

                                               
                                           }
                                       }];
    [self.navigationController pushViewController:to animated:YES];
    
    
}
-(void)sendFenPeiUser
{
    [AlertHelper MBHUDShow:@"分配中..." ForView:self.tableView AndDelayHid:30];
   [HotRewWuWebAPI sendPersonListTaid:self.ta_id arraycjuserid:usersidStr arraycjusername:usersStr success:^(NSArray *arr) {
      // NSLog(@"AAAA___   %@",arr);
        [AlertHelper hideAllHUDsForView:self.tableView];
       if ([arr[0][@"bool"] integerValue]==1) {
            [AlertHelper singleMBHUDShow:@"任务分配成功" ForView:self.tableView AndDelayHid:1];
            [self.navigationController popViewControllerAnimated:YES];
       }
       else
       {
        [AlertHelper singleMBHUDShow:@"任务分配失败" ForView:self.tableView AndDelayHid:1];
       }
   } fail:^{
       [AlertHelper hideAllHUDsForView:self.tableView];
       [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.tableView AndDelayHid:1];
   }];
}
-(void)doshenhe
{
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"审核描述"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定",nil];
    theAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
    theAlert.tag=1001;
    [theAlert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000) {
        switch (buttonIndex) {
            case 0:
                //  NSLog(@"分配任务");
                [self sendFenPeiUser];
                break;
            case 1:
                //  NSLog(@"取消");
                break;
            default:
                break;
        }
        
    }
    else
    {
        NSString *pingyuStr=@"";
        if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
            pingyuStr = [alertView textFieldAtIndex:0].text;
        }
        if ([@"确定" isEqualToString:[alertView buttonTitleAtIndex:buttonIndex]]) {
            [AlertHelper MBHUDShow:@"审核中..." ForView:self.tableView AndDelayHid:30];
            [HotRewWuWebAPI AddAuditWithTaid:self.ta_id Taop_Describe:pingyuStr success:^(NSArray *arr) {
                [AlertHelper hideAllHUDsForView:self.tableView];
                if ([arr[0][@"bool"] integerValue]==1) {
                    [AlertHelper singleMBHUDShow:@"任务审核成功" ForView:self.tableView AndDelayHid:1];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
               else  if ([arr[0][@"bool"] integerValue]==-1) {
                    [AlertHelper singleMBHUDShow:@"有用户未完成任务" ForView:self.tableView AndDelayHid:1];
                    
                   
                }
                else
                {
                    [AlertHelper singleMBHUDShow:@"任务审核失败" ForView:self.tableView AndDelayHid:1];
                }
                
            } fail:^{
                [AlertHelper hideAllHUDsForView:self.tableView];
                [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.tableView AndDelayHid:1];
            }];
        }
    }
    
}
-(void)setJiShi:(NSDate *)startDate date2:(NSDate *)endDate
{
    
    NSTimeInterval timeInterval =[endDate timeIntervalSinceDate:startDate];
    
    if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.dayLabel = @"已过期";
                        self.hourLabel = @"";
                        self.minuteLabel = @"";
                        self.secondLabel = @"";
                        
                        NSIndexSet *set=[NSIndexSet indexSetWithIndex:0];
                        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    if (days==0) {
                        self.dayLabel = @"";
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {
                            self.dayLabel = @"0天";
                        }else{
                            self.dayLabel = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours<10) {
                            self.hourLabel = [NSString stringWithFormat:@"0%d:",hours];
                        }else{
                            self.hourLabel = [NSString stringWithFormat:@"%d:",hours];
                        }
                        if (minute<10) {
                            self.minuteLabel = [NSString stringWithFormat:@"0%d:",minute];
                        }else{
                            self.minuteLabel = [NSString stringWithFormat:@"%d:",minute];
                        }
                        if (second<10) {
                            self.secondLabel = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondLabel = [NSString stringWithFormat:@"%d",second];
                        }
                        NSIndexSet *set=[NSIndexSet indexSetWithIndex:0];
                        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
    
}


-(void)viewWillAppear:(BOOL)animated{
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else
    {
        return dataArr.count;
    }
}
//quanbudetailcell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *CustomCellIdentifier = @"Cell1";
        RenWuHotDetailViewCell *cell = (RenWuHotDetailViewCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
        if (!cell) {
            NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"RenWuHotDetailViewCell" owner:nil options:nil];
            cell= [nibView lastObject];
        }
       // cell.ddelegate=self;
        
        if ([model.Ta_IsEvaluate isEqualToString:@"1"]) {
            [cell.btn_satis setTitle:@"已经评价" forState:UIControlStateNormal];
            [cell.btn_satis setEnabled:NO];
        }
        else
        {
            [cell.btn_satis setTitle:@"立即评价" forState:UIControlStateNormal];
            [cell.btn_satis setEnabled:YES];
        }
        
        cell.Ta_Number.text=model.Ta_Number;
       cell.Ta_Address.text=model.Ta_Address;
        cell.Ta_Area.text=[NSString stringWithFormat:@"%@(%@)",model.Ta_Area,model.Ta_Address];
        cell.Ta_Phone.text=model.Ta_Phone;
        cell.Ta_Source.text=model.Ta_Source;
        cell.Ta_Type.text=model.Ta_Type;
        cell.Ta_endTime.text=model.Ta_endTime;
       cell.lab_endTime.text=model.Ta_endTime;
        cell.xiaoqueChuli.text=model.xiaoqueChuli;
        cell.xiaoquesghouliTime.text=model.xiaoquesghouliTime;
        cell.xiaoqueChuliTime.text=model.xiaoqueChuliTime;
       cell.Ta_TimeLimit.text=model.Ta_TimeLimit;
        cell.weiHuPersonSign.text=model.weiHuPersonSign;
        cell.PersonSign.text=model.PersonSign;
        cell.manyidu.text=model.manyidu;
        cell.remark.text=model.remark;
        cell.username.text=model.username;
        cell.talssueddate.text=model.talssueddate;
        cell.tastopdate.text=model.tastopdate;
        cell.username.text=model.username;
        cell.fabutime.text=model.tastopdate;
        cell.biaoti.text=model.Ta_Area;
        cell.Tadescription.text=model.tadescription;
        cell.dayLabel.text=_dayLabel;
        cell.hourLabel.text=_hourLabel;
        cell.minuteLabel.text=_minuteLabel;
        cell.secondLabel.text=_secondLabel;
         NSString *flagStr=@"unarchived.png";
        cell.imaFlag.hidden = NO;
        
        if ([model.iscomplete isEqualToString:@"3"]) {
            flagStr=@"unarchived.png";
        }else if ([model.iscomplete isEqualToString:@"2"]){
            flagStr=@"archiving.png";
        }else if ([model.iscomplete isEqualToString:@"1"]){
            cell.imaFlag.hidden = YES;
          // flagStr=@"archived.png";
        }
        if([model.Ta_Satisfied isEqualToString:@"满意"])
        {
            cell.view1.backgroundColor=[UIColor blueColor];
        }
        else if([model.Ta_Satisfied isEqualToString:@"一般"])
        {
            cell.view2.backgroundColor=[UIColor blueColor];
        }
        else  if([model.Ta_Satisfied isEqualToString:@"不满意"])
        {
            cell.view3.backgroundColor=[UIColor blueColor];
        }

        cell.imaFlag.image=[UIImage imageNamed:flagStr];
        return cell;

    }
    else
    {
            RenWuDetailHotModel *taopmodel = [dataArr objectAtIndex:indexPath.row];
        
        //  NSString *flagStr=@"unarchived.png";
              static NSString *CustomCellIdentifier = @"Cell2";
              RenWuHotUserCell *cell = (RenWuHotUserCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
          if (!cell) {
            NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"RenWuHotUserCell" owner:nil options:nil];
            cell= [nibView lastObject];
          }
        [cell bindModel:taopmodel];

        return cell;

    
    
    }
//    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // return 250;
    if ((indexPath.section)==0) {
        return 680;
    }
    else
    {
        return 620;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    [SDWebImageManager.sharedManager.imageCache clearMemory];
    [SDWebImageManager.sharedManager.imageCache clearDisk];
    
    
}
-(void)getRenWuHotDetail
{
//    NSLog(@"gdsagfsdfgds");
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RenWuHot" bundle:[NSBundle mainBundle]];
//    UserSatisfiedViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"UserSatisfied"];
//    controller.ta_id= self.ta_id;
//    [self.navigationController pushViewController:controller animated:YES ];

}

@end
