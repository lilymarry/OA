
#import "DaKaViewController.h"
#import "Location.h"
#import "DaKaWebAPI.h"
//#import <MBProgressHUD.h>
#import "UserPermission.h"
#import <CoreLocation/CoreLocation.h>
#import "AlertHelper.h"
@interface DaKaViewController (){
    
    BOOL gpsOpened ;
    NSTimeInterval time;
    BOOL hasQiandao;
    
 //   MBProgressHUD *hud;
}

@end

@implementation DaKaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheStaticTime];
    
    Location *location=[Location sharedLocation];
    gpsOpened = [location checkGPSOpened];
}
//-(void)endHUD{
//    hud.hidden = YES;
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//    [alert show];
//}

-(void)viewDidAppear:(BOOL)animated{
    [AlertHelper MBHUDShow:@"获取中..." ForView:self.view AndDelayHid:30];
    [DaKaWebAPI requestDakaInfoByUID:[UserPermission standartUserInfo].ID success:^(NSArray *dataArr){
       NSLog(@"AAAA %@",dataArr);
        [AlertHelper hideAllHUDsForView:self.view];
        NSDictionary *dict =dataArr[0];
        NSString *typeStr= [dict valueForKey:@"type"];
        NSString *serverTimeStr= [dict valueForKey:@"tm"];
        NSString *lastStr= [dict valueForKey:@"last"];
        
        self.btnQianDao.enabled=([@"1" isEqualToString:typeStr] && gpsOpened)?YES:NO;
        self.btnQianTui.enabled=((![@"1" isEqualToString:typeStr]) && gpsOpened)?YES:NO;
        
        self.labQiandaoShijian.text=( gpsOpened && ([@"1" isEqualToString:typeStr]))?@"":lastStr;
        hasQiandao=( ![@"1" isEqualToString:typeStr]);
        if ((![@"" isEqualToString:lastStr]) && (![@"" isEqualToString:serverTimeStr])) {
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *endDate = [dateFormatter dateFromString:serverTimeStr];
            NSDate *senderDate = [dateFormatter dateFromString:lastStr];
            time=[endDate timeIntervalSinceDate:senderDate];
            int hours = ((int)time)/3600;
            int minute = ((int)time)%3600/60;
            int second = ((int)time)%3600%60;
            
            self.labShichang.text=(hasQiandao)?[[NSString alloc] initWithFormat:@"%i:%i:%i",hours,minute,second]:@"";
            
            NSTimer *timer=   [NSTimer timerWithTimeInterval:1 target:self selector:@selector(setTheTimes:) userInfo:nil repeats:YES];
            [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
            
        }else{
            self.labQiandaoShijian.text=@"";
            self.labShichang.text=@"";
        }
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

//签到
- (IBAction)singIn:(id)sender {
    Location *location=[Location sharedLocation];
    
  //  [location getCurrentLocation];
    [location getCurrentLocationWithBlock:^(CLLocationCoordinate2D coordinate) {
        [AlertHelper MBHUDShow:@"获取中..." ForView:self.view AndDelayHid:30];
        [DaKaWebAPI requestDakaActionByUID:[UserPermission standartUserInfo].ID AndType:@"1" AndCoornidate:coordinate success:^(NSArray *dataArr){
          NSLog(@"AAAAAQQDEDDW %@",dataArr);
            [AlertHelper hideAllHUDsForView:self.view];
            NSDictionary *dict =dataArr[0];
            NSString *resStr= [dict valueForKey:@"rzt"];
            NSString *serverTimeStr= [dict valueForKey:@"tm"];
            
            if ([@"0" isEqualToString:resStr]) {
               // hud.labelText=@"签到失败";
                [AlertHelper singleMBHUDShow:@"签到失败" ForView:self.view AndDelayHid:3];
            }else if ([@"1" isEqualToString:resStr]){
               // hud.labelText=@"签到成功";
                [AlertHelper singleMBHUDShow:@"签到成功" ForView:self.view AndDelayHid:3];

                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *sDate = [dateFormatter dateFromString:serverTimeStr];
                time=[sDate timeIntervalSinceDate:sDate];
                self.labQiandaoShijian.text=([@"1" isEqualToString:resStr])?serverTimeStr:@"";
                hasQiandao=YES;
                self.btnQianDao.enabled=NO;
                self.btnQianTui.enabled=YES;
                
            }else if ([@"2" isEqualToString:resStr]){
               // hud.labelText=@"不在范围内";
                 [AlertHelper singleMBHUDShow:@"不在范围内" ForView:self.view AndDelayHid:3];
            }else if ([@"3" isEqualToString:resStr]){
               // hud.labelText=@"已签到过，请不要重复签到";
                 [AlertHelper singleMBHUDShow:@"已签到过，请不要重复签到" ForView:self.view AndDelayHid:3];
            }
         //   [hud hide:YES afterDelay:1];
            
        }fail:^{
            //  hud.labelText=@"签到失败，请检查网络";
           // [MBProgressHUD hideHUDForView:self.view animated:YES];
           //   [AlertHelper singleMBHUDShow:@"签到失败，请检查网络" ForView:self.view AndDelayHid:3];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"签退失败，请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];

        }];
    }];
}
//签退
- (IBAction)signOut:(id)sender {
    
    Location *location=[Location sharedLocation];
    
  //  [location getCurrentLocation];
    [location getCurrentLocationWithBlock:^(CLLocationCoordinate2D coordinate) {
        [AlertHelper MBHUDShow:@"获取中..." ForView:self.view AndDelayHid:30];
        [DaKaWebAPI requestDakaActionByUID:[UserPermission standartUserInfo].ID AndType:@"2" AndCoornidate:coordinate success:^(NSArray *dataArr){
            [AlertHelper hideAllHUDsForView:self.view];
            NSLog(@"BBBBB  %@",dataArr);
            NSDictionary *dict =dataArr[0];
            NSString *resStr= [dict valueForKey:@"rzt"];
            NSString *serverTimeStr= [dict valueForKey:@"tm"];
            
            if ([@"0" isEqualToString:resStr]) {
              //  hud.labelText=@"签退失败";
                [AlertHelper singleMBHUDShow:@"签退失败" ForView:self.view AndDelayHid:3];

            }else if ([@"1" isEqualToString:resStr]){
               // hud.labelText=@"签退成功";
                [AlertHelper singleMBHUDShow:@"签退成功" ForView:self.view AndDelayHid:3];

                hasQiandao=NO;
                self.labQiandaoShijian.text=([@"1" isEqualToString:resStr])?serverTimeStr:@"";
                
                self.btnQianDao.enabled=YES;
                self.btnQianTui.enabled=NO;
                
                self.labShichang.text=@"";
                self.labQiandaoShijian.text=@"";
            }else if ([@"2" isEqualToString:resStr]){
              //  hud.labelText=@"不在范围内";
                 [AlertHelper singleMBHUDShow:@"不在范围内" ForView:self.view AndDelayHid:3];
            }else if ([@"3" isEqualToString:resStr]){
             //   hud.labelText=@"已签退过，请不要重复签到";
                [AlertHelper singleMBHUDShow:@"已签退过，请不要重复签到" ForView:self.view AndDelayHid:3];

            }
          //  [hud hide:YES afterDelay:1];
            
        }fail:^{
         //   hud.labelText=@"签退失败，请检查网络";
          //  [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"签退失败，请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }];
    }];
}

-(void)setTheTimes:(NSTimer *)timer{
    [self setTheStaticTime];
    
    if (hasQiandao) {
        time++;
        int hours = ((int)time)/3600;
        int minute = ((int)time)%3600/60;
        int second = ((int)time)%3600%60;
        
        self.labShichang.text=[[NSString alloc] initWithFormat:@"%i:%i:%i",hours,minute,second];
    }else{
        self.labShichang.text=@"";
    }
}
-(void)setTheStaticTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd  EEEE";
    NSDate *date=[NSDate date];//[formatter dateFromString:time[0]];
    self.labDate.text=[formatter stringFromDate:date];
    
    formatter.dateFormat=@"HH:mm:ss";
    self.labTime.text=[formatter stringFromDate:date];
}

- (IBAction)redirectToManScene:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
