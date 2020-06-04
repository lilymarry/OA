//
//  NingHeZhiLiangViewController.m
//  Re-OA
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "NingHeZhiLiangViewController_1.h"
#import "ShangBaoWebAPI.h"
#import "UserPermission.h"
#import "ShangBaoList.h"
#import "AlertHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import <BMapKit.h>

@interface NingHeZhiLiangViewController_1 ()<UINavigationBarDelegate,UITextFieldDelegate>
{
    NSString *la;
    NSString *lo;
    BOOL isEdit;
}
@property (weak, nonatomic) IBOutlet UITextField *tf_khnm;
@property (weak, nonatomic) IBOutlet UITextField *tf_odcode;
@property (weak, nonatomic) IBOutlet UITextField *tf_size;
@property (weak, nonatomic) IBOutlet UITextField *tf_pm;
@property (weak, nonatomic) IBOutlet UITextField *tf_odnum;
@property (weak, nonatomic) IBOutlet UITextField *tf_err;
@property (weak, nonatomic) IBOutlet UITextField *tf_reason;
@property (weak, nonatomic) IBOutlet UITextField *tf_opinion;

@property (nonatomic, strong)UINavigationBar * navibar;
@end

@implementation NingHeZhiLiangViewController_1
-(void)getlocation
{
    Location *location=[Location sharedLocation];
    
    [location getCurrentLocationWithBlock:^(CLLocationCoordinate2D coordinate) {
        CLLocationCoordinate2D loca2D = CLLocationCoordinate2DMake(coordinate .latitude , coordinate.longitude );
        NSDictionary *baidu = BMKConvertBaiduCoorFrom(loca2D,BMK_COORDTYPE_GPS);
        CLLocationCoordinate2D trans = BMKCoorDictionaryDecode(baidu);
        la=[NSString stringWithFormat:@"%.14f", trans.latitude];
        lo=[NSString stringWithFormat:@"%.14f", trans.longitude];
    }];
    
    
}
- (IBAction)submit:(id)sender
{
    if (lo.length!=0 &&la.length!=0) {
        [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
        NSDictionary *dic=[ShangBaoList standartUserInfo].infoDic;
        [ShangBaoWebAPI ningHeZhiLiangShangbao:[UserPermission standartUserInfo].ID
                                       andfpid:dic[@"fpId"] x:lo y:la khid:@"" khnm:_tf_khnm.text odcode:_tf_odcode.text size:_tf_size.text pm:_tf_pm.text odnum:_tf_odnum.text err:_tf_err.text reason:_tf_reason.text opinion:_tf_opinion.text
                                       success: ^(NSArray *arr){
                                           
                                         //  NSLog(@"AAAAA %@",arr);
                                           [AlertHelper hideAllHUDsForView:self.view];
                                           if ([[arr[0]objectForKey:@"bool"]isEqualToString:@"1"])
                                           {
                                               UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"上报成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                                               alert.tag=1000;
                                               [alert show];
                                           }
                                           else if ([[arr[0]objectForKey:@"bool"]isEqualToString:@"3"])
                                           {
                                               UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"没有权限，请联系管理员" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                                               [alert show];
                                           }
                                           else
                                           {
                                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"网络错误，稍后再试" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                                               [alert show];
                                           }
                                           
                                       } fail:^(){
                                           [AlertHelper hideAllHUDsForView:self.view];
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"网络错误，稍后再试" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                                           [alert show];
                                           
                                       }];
    }
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"定位失败，请打开定位" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonInde
{
    if (alertView.tag==1000) {
        NSObject<CommonNotification> *tmpDele=self.refreshNotification;
        [tmpDele refreshingDataList];
    }
    [self.navigationController popViewControllerAnimated: YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    [self getlocation];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame=self.view.frame;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    if (!isEdit)
    {
        frame.origin.y-= window.frame.size.height==480?130:158;
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

//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return NO;
//}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isEdit=NO;
    [self.view endEditing:YES];
    
}


@end
