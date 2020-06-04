#import "LoginViewController.h"
//#import <MBProgressHUD.h>
#import "NetRequestTool.h"
#import "UserPermission.h"
#import "ScreenHelper.h"
#import "NullValueHelper.h"
#import "AlertHelper.h"
#import "AppDelegate.h"
#import "JPUSHService.h"
#define  kTextH 50
 
#define kUSERNAME @"username"
#define kPASSWORD @"password"

@interface LoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *_userName;
    UITextField *_password;
    BOOL isEdit;
    UIButton *savaPw;
    UIImageView *remImage;
    MBProgressHUD *hud;
    NSString *versionStr;
    NSString *versionShortStr;
    NSString *appUrl;
    //  BOOL isappstore;
}
@property (strong, nonatomic) NSArray * TextArr;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    // _loginState=@"1";
    
    // isappstore= ((AppDelegate*)[[UIApplication sharedApplication] delegate]).isSubmiteToAppStore;
    [super viewDidLoad];
    CGRect  viewRect = CGRectMake(0, 0,[ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT]);
    self.view.bounds=viewRect;
    
        versionStr =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        versionShortStr =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [self createSubview];
    _userName.text=[[NSUserDefaults standardUserDefaults]objectForKey:kUSERNAME];
    _password.text=[[NSUserDefaults standardUserDefaults]objectForKey:kPASSWORD];
}

//-(void)viewDidAppear:(BOOL)animated{
//
//        [[NetRequestTool sharedRequest]requestVersionFromURLsuccess:^(NSArray *arr){
//
//            NSString *updateVersion= [arr[0] valueForKey:@"version"];
//
//            appUrl = [arr[0] valueForKey:@"url"];
//
//            if ( (![updateVersion isEqualToString:versionStr])) {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"有可用的更新！" message:[[NSString alloc] initWithFormat:@"检测到新版本 v%@",updateVersion] delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"现在升级", nil];
//                [alert show];
//            }
//        } fail:^(){}];
//  //  }
//}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    if (buttonIndex ==1) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
//    }
//}

//初始化登录界面
-(void)createSubview
{
    //视图背景
    UIImageView *b=[[UIImageView alloc]init];
    b.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    b.image=[UIImage imageNamed:@"denglubeijing-1242w2208h@3x.png"];
    [self.view addSubview:b];
    
    CGFloat iconX=25;
    CGFloat iconWH=25;
    CGFloat y;
    if ( self.view.bounds.size.height==480)
    {
        y=170;
    }
    else
    {
        y=240;
    }
    CGFloat w=self.view.frame.size.width;
    
    //登陆框背景
    UIImageView *back=[[UIImageView alloc]init];
    back.frame=CGRectMake(8, y, w-16, 255);
    back.image=[UIImage imageNamed:@"denglukuan.png"];
    [self.view addSubview:back];
    //用户框
    UIView *view1=[[UIView alloc]init];
    view1.backgroundColor=[UIColor whiteColor];;
    view1.frame=CGRectMake(25, y+20, w-50, kTextH);
    [self.view addSubview:view1];
    
    //用户名前面的icon
    UIImageView *userIcon=[[UIImageView alloc]init];
    userIcon.backgroundColor=[UIColor whiteColor];
    userIcon.frame=CGRectMake(5, 15, iconWH, iconWH);
    userIcon.image=[UIImage imageNamed:@"user.png"];
    [view1 addSubview:userIcon];
    
    _userName=[[UITextField alloc]init];
    _userName.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _userName.placeholder=@"工号";
    _userName.frame=CGRectMake(CGRectGetMaxX(userIcon.frame)+10, 3, CGRectGetWidth(view1.frame)-iconWH, kTextH);
    _userName.delegate=self;
    [view1 addSubview:_userName];
    
    //密码框
    UIView *view2=[[UIView alloc]init];
    view2.backgroundColor=[UIColor whiteColor];;
    view2.frame=CGRectMake(25, CGRectGetMaxY(view1.frame)+8, w-50, kTextH);
    [self.view addSubview:view2];
    
    //密码前面的icon
    UIImageView *pwIcon=[[UIImageView alloc]init];
    pwIcon.frame=CGRectMake(5, 15, iconWH, iconWH);
    pwIcon.image=[UIImage imageNamed:@"lock.png"];
    [view2 addSubview:pwIcon];
    
    _password=[[UITextField alloc]init];
    _password.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _password.placeholder=@"密码";
    _password.secureTextEntry=YES;
    _password.frame=CGRectMake(CGRectGetMaxX(pwIcon.frame)+10, 4,  CGRectGetWidth(view2.frame)-iconWH, kTextH);
    _password.delegate=self;
    [view2 addSubview:_password];
    
    //记住密码button
    savaPw=[UIButton buttonWithType:UIButtonTypeCustom];
    savaPw.frame=CGRectMake(0, CGRectGetMaxY(view2.frame), self.view.frame.size.width/2, kTextH);
    savaPw.showsTouchWhenHighlighted = NO;
    savaPw.selected=[[NSUserDefaults standardUserDefaults]boolForKey:@"savepw"];
    [savaPw addTarget:self action:@selector(savePassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savaPw];
    
    remImage=[[UIImageView alloc]initWithFrame:CGRectMake(iconX,12, iconWH, iconWH)];
    if (savaPw.selected)
    {
        remImage.image=[UIImage imageNamed:@"remBtn.png"];
    }
    else
    {
        remImage.image=[UIImage imageNamed:@"unRemBtn.png"];
    }
    [savaPw addSubview:remImage];
    
    
    UILabel *savetext=[[UILabel alloc]init];
    savetext.text=@"记住密码";
    savetext.frame=CGRectMake(CGRectGetMaxX(remImage.frame)+15,3, w/3, kTextH);
    [savaPw addSubview:savetext];
    
    //登陆按钮
    UIButton *login=[UIButton buttonWithType:UIButtonTypeCustom];
    login.frame=CGRectMake(25, CGRectGetMaxY(savaPw.frame)+10, self.view.frame.size.width-50, kTextH-8);
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [login setBackgroundImage:[UIImage imageNamed:@"loginBtn1111.png"] forState:UIControlStateNormal];
    [self.view addSubview:login];
    
        //版本分割线
        CGRect labvFrame=CGRectMake(0, [ScreenHelper SCREEN_HEIGHT]-50, [ScreenHelper SCREEN_WIDTH], 1);
        UILabel *labV=[[UILabel alloc ] initWithFrame:labvFrame];
        labV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:labV];
    
        //版本文本
        CGRect labvtFrame=CGRectMake(0, [ScreenHelper SCREEN_HEIGHT]-49, [ScreenHelper SCREEN_WIDTH], 49);
        UILabel *labVT=[[UILabel alloc ] initWithFrame:labvtFrame];
        labVT.backgroundColor = [UIColor whiteColor];
        labVT.textAlignment=NSTextAlignmentCenter;
        labVT.textColor=[UIColor lightGrayColor];
        labVT.font =  [UIFont fontWithName:@"Arial" size:12.0f];
        labVT.text= [[NSString alloc] initWithFormat:@"v%@  build:%@",versionShortStr,versionStr];
        [self.view addSubview:labVT];
    //
    _TextArr=[NSArray arrayWithObjects:_userName,_password, nil];
}

//保存密码130
-(void)savePassword:(UIButton *)sender
{
    sender.selected=!sender.selected;
    remImage.image=(!sender.selected)?[UIImage imageNamed:@"unRemBtn.png"]:[UIImage imageNamed:@"remBtn.png"];
    [[NSUserDefaults standardUserDefaults]setBool:sender.selected forKey:@"savepw"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)endHUD{
    hud.hidden = YES;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}
//登陆
-(void)login
{
    isEdit=NO;
    [self.view endEditing:YES];
    
    if ([NullValueHelper textViewAndtextFeildNotNullOrNull:_TextArr])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [AlertHelper MBHUDShow:@"登录中..." ForView:self.view AndDelayHid:30];
        
//        [[NetRequestTool sharedRequest]getWeatherSuccess:^(NSDictionary *userInfo) {
//            NSLog(@"%@",userInfo);
//        } fail:^{
//            
//        }];
        
        
   
        [[NetRequestTool sharedRequest] requestLogin:_userName.text andPassword:_password.text success:^(NSArray *userInfo)
         {   NSLog(@"__________%@",userInfo);
             [AlertHelper hideAllHUDsForView:self.view];
             NSDictionary *userDic=nil;
             if (userInfo) {
                 userDic=(NSDictionary*)userInfo[0];
             }
             
             if ([[userDic objectForKey:@"rzt"]isEqualToString:@"0"])
             {
                 UIAlertView *   alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:@"用户名不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
             }
             else if ([[userDic objectForKey:@"rzt"]isEqualToString:@"2"])
             {
                 UIAlertView *   alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
             }
             else
             {
                 UserPermission *user = [UserPermission standartUserInfo];
                 
                 NSMutableArray *userData=[[NSMutableArray alloc] init ];
                 [userData addObject:userDic];
                 [user setInfoArr:userData];
                 @try {
                     __autoreleasing NSMutableSet *tags = [NSMutableSet set];
                     [self setTags:&tags addTag:@""];
                     
                     NSLog(@"QQQ %@",user.ID);
                     NSString *str=  [ NSString stringWithFormat:@"%d",[user.ID intValue]];
                     //  NSString *str=  [ NSString stringWithFormat:@"%@",user.ID ];
                     __autoreleasing NSString *alias =str;
                     [self analyseInput:&alias tags:&tags];
                     
                     if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
                         [JPUSHService setAlias:alias
                               callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                                         object:self];
                         
#endif
                     }  else {
                         [JPUSHService setTags:tags
                                         alias:alias
                              callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                                        target:self];
                     }
                     
                 }
                 @catch (NSException *exception) {
                     
                 }
                 @finally {
                     
                 }
                 
                 [[NSUserDefaults standardUserDefaults] setObject:_userName.text forKey:kUSERNAME];
                 if (savaPw.selected)
                 {
                     [[NSUserDefaults standardUserDefaults ]setObject:_password.text forKey:kPASSWORD];
                     [[NSUserDefaults standardUserDefaults]synchronize];
                 }else
                 {
                     [[NSUserDefaults standardUserDefaults]removeObjectForKey:kPASSWORD];
                     [[NSUserDefaults standardUserDefaults]synchronize];
                 }
                 //  _loginState=@"2";
                 UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                 UIViewController *changyongController = [s instantiateViewControllerWithIdentifier:@"Main"];
                 
                 [self presentViewController:changyongController animated:YES completion:nil];
                 
                 
             }
         } fail:^{
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
             [alert show];
         }];
       
    }
}
- (void)setTags:(NSMutableSet **)tags addTag:(NSString *)tag {
    //  if ([tag isEqualToString:@""]) {
    // }
    [*tags addObject:tag];
}
- (void)analyseInput:(NSString **)alias tags:(NSSet **)tags {
    // alias analyse
    if (![*alias length]) {
        // ignore alias
        *alias = nil;
    }
    // tags analyse
    if (![*tags count]) {
        *tags = nil;
    } else {
        __block int emptyStringCount = 0;
        [*tags enumerateObjectsUsingBlock:^(NSString *tag, BOOL *stop) {
            if ([tag isEqualToString:@""]) {
                emptyStringCount++;
            } else {
                emptyStringCount = 0;
                *stop = YES;
            }
        }];
        if (emptyStringCount == [*tags count]) {
            *tags = nil;
        }
    }
}
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =[NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,[self logSet:tags], alias];
    NSLog(@"TagsAlias回调:%@", callbackString);
}
- (NSString *)logSet:(NSSet *)dic {
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame=self.view.frame;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    if (!isEdit)
    {
        frame.origin.y-= window.frame.size.height==568?130:158;
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame=frame;
        }];
    }
    isEdit=YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect frame=self.view.frame;
    if (!isEdit) {
        frame.origin.y=0;
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame=frame;
        }];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isEdit=NO;
    [self.view endEditing:YES];
}
@end
