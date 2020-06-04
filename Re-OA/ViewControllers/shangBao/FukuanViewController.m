#import "FukuanViewController.h"
#import "SelectPIckView.h"
#import "ShangBaoWebAPI.h"
#import "ShangBaoList.h"
#import "UserPermission.h"
#import "AlertHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import <BMapKit.h>
@interface FukuanViewController ()<UITextFieldDelegate,okButtonDelegate ,UINavigationBarDelegate>
{
    SelectPIckView *select;
    SelectPIckView *select1;
    BOOL isEdit;
    NSString *la;
    NSString *lo;
}
@property (weak, nonatomic) IBOutlet UITextField *kind;
@property (weak, nonatomic) IBOutlet UITextField *style;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *num;
@property (weak, nonatomic) IBOutlet UITextField *money;
@property (weak, nonatomic) IBOutlet UITextField *yingMoney;
@property (nonatomic, strong)UINavigationBar * navibar;
@property (strong, nonatomic) NSArray *Data1;
@property (strong, nonatomic) NSArray *Data2;
@property (strong, nonatomic) NSDictionary *data;
@end
@implementation FukuanViewController
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

- (IBAction)sumbit:(id)sender
{
    if (lo.length!=0 &&la.length!=0) {
        [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
        [ShangBaoWebAPI ShangBaoCaiwuFuKuanWithUid:[UserPermission standartUserInfo].ID
                                              cont:_num.text
                                              extr:_yingMoney.text
                                              proj:_name.text
                                              prop:_kind.text
                                              fpid:_data[@"fpId"]
                                               met:_style.text
                                               num:_money.text
                                             ftype:_data[@"typeId"]
                                              AndX:lo
                                              AndY:la
                                           success:^(NSArray * arr){
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
                                               }}
                                              fail:^(){
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
    self.navigationItem.title=@"付款上报";
    _data=[ShangBaoList standartUserInfo].infoDic;
    _Data1=[NSArray arrayWithObjects:@"应付款",@"预付款",@"带款提货",@"货到验收",@"进度款", nil];
    _Data2=[NSArray arrayWithObjects:@"电汇",@"支票",@"承兑汇票",@"现金", nil];
    select=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    select.dataArr=_Data1;
    select.state=0;
    select.delegate=self;
    self.kind.inputView=select;
    select1=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,  self.view.frame.size.width, 166) ];
    select1.dataArr=_Data2;
    select.state=1;
    select1.delegate=self;
    self.style.inputView=select1;
     [self getlocation];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    isEdit=NO;
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag>103)
    {
        CGRect frame=self.view.frame;
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        if (!isEdit)
        {
            frame.origin.y-= window.frame.size.height==480?110:0;
            [UIView animateWithDuration:0.5f animations:^{
                self.view.frame=frame;
            }];
        }
        isEdit=YES;
    }
  
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag>103)
    {
    CGRect frame=self.view.frame;
    if (!isEdit) {
        frame.origin.y=0;
        [UIView animateWithDuration:0.5f animations:^{
            self.view.frame=frame;
        }];
    }
    }
}

-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    if (state==0)
    {
        self.style.text=row;
        [self.style resignFirstResponder];
    }
    else
    {
        self.kind.text=row;
        [self.kind resignFirstResponder];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
