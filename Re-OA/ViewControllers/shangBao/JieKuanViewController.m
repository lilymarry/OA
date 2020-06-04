#import "JieKuanViewController.h"
#import "ShangBaoList.h"
#import "ShangBaoWebAPI.h"
#import "UserPermission.h"
#import "AlertHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import <BMapKit.h>
@interface JieKuanViewController ()<UITextFieldDelegate,UITextViewDelegate,UINavigationBarDelegate>
{
    BOOL isEdit;
    NSString *la;
    NSString *lo;
}
@property (weak, nonatomic) IBOutlet UITextField *person;
@property (weak, nonatomic) IBOutlet UITextField *styte;
@property (weak, nonatomic) IBOutlet UITextField *money;
@property (weak, nonatomic) IBOutlet UITextField *jieMoney;
@property (weak, nonatomic) IBOutlet UITextView *spendStyte;
@property (strong,nonatomic)NSDictionary *data;
@property (nonatomic, strong)UINavigationBar * navibar;
@end
@implementation JieKuanViewController
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     isEdit=NO;
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _data =[ShangBaoList standartUserInfo].infoDic;
    self.navigationItem.title=@"借款上报";
    [self getlocation];

    [self.view addSubview:_spendStyte];
   
}
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
-(void)textViewDidBeginEditing:(UITextView *)textView
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
-(void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect frame=self.view.frame;
    if (!isEdit) {
        frame.origin.y=0;
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame=frame;
        }];
    }
}
- (IBAction)sumbit:(id)sender
{
    if (lo.length!=0 &&la.length!=0) {
        
        [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
        [ShangBaoWebAPI ShangBaoCaiwujiekuanWithUid:[UserPermission standartUserInfo].ID
                                                way:_spendStyte.text
                                               extr:_jieMoney.text
                                               pers:_person.text
                                               fpid:_data[@"fpId"]
                                                met:_styte.text
                                                num:_money.text
                                              ftype:_data[@"typeId"]
                                               AndX:lo
                                               AndY:la
                                            success:^(NSArray *arr){
                                                [AlertHelper hideAllHUDsForView:self.view];
                                                if ([[arr[0]objectForKey:@"rzt"]isEqualToString:@"1"])
                                                {
                                                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"上报成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                                                    alert.tag=1000;
                                                    [alert show];
                                                }
                                                
                                                else if ([[arr[0]objectForKey:@"rzt"]isEqualToString:@"3"])
                                                {
                                                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"没有权限，请联系管理员" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                                                    [alert show];
                                                }
                                                else
                                                {
                                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"网络错误，稍后再试" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                                                    [alert show];
                                                }
                                            }
                                               fail:^(){
                                                   [AlertHelper hideAllHUDsForView:self.view];
                                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"网络错误，稍后再试" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                                                   [alert show];}];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
