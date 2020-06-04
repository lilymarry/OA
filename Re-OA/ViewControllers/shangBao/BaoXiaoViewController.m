#import "BaoXiaoViewController.h"
#import "SelectPIckView.h"
#import "ShangBaoWebAPI.h"
#import "UserPermission.h"
#import "ShangBaoList.h"
#import "AlertHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import <BMapKit.h>
@interface BaoXiaoViewController ()<okButtonDelegate,UINavigationBarDelegate>
{
    SelectPIckView *  select;
    SelectPIckView *  select1;
    BOOL isEdit;
    NSString *la;
    NSString *lo;
}
@property (weak, nonatomic) IBOutlet UITextField *money;
@property (weak, nonatomic) IBOutlet UITextField *styte;
@property (weak, nonatomic) IBOutlet UITextField *depar;
@property (weak, nonatomic) IBOutlet UITextField *person;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (strong, nonatomic) NSArray *Data1;
@property (strong, nonatomic) NSMutableArray *deparData;
@property ( nonatomic) int rowSe;
@property (nonatomic, strong)UINavigationBar * navibar;
@end

@implementation BaoXiaoViewController
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
        [ShangBaoWebAPI ShangBaoCaiwuBaoXiaoWithUid:[UserPermission standartUserInfo].ID
                                              depId:[NSString stringWithFormat:@"%d",_rowSe+1]
                                                dep:_depar.text fpid:dic[@"fpId"]
                                                met:_styte.text
                                                num:_money.text
                                              ftype:dic[@"typeId"]
                                                det:_content.text
                                               AndX:lo
                                               AndY:la
                                            success: ^(NSArray *arr){
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
    self.navigationItem.title=@"报销上报";
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _Data1=[NSArray arrayWithObjects:@"挂账",@"冲账",@"付款", nil];
    _deparData =[NSMutableArray array];
    select=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    select.dataArr=_Data1;
    select.state=0;
    select.delegate=self;
    self.styte.inputView=select;
    [ShangBaoWebAPI ShangBaoCaiwuDepartListWithsuccess:^(NSArray *arr)
     {
         [_deparData removeAllObjects];
         for (int i=0; i<arr.count; i++)
         {
             [_deparData addObject:arr[i][@"dnm"]];
         }
         select1=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
         select1.dataArr=_deparData;
         select1.state=1;
         select1.delegate=self;
         self.depar.inputView=select1;
     } fail:^(){}];
     [self getlocation];
}
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    if (state==0)
    {
        _styte.text=row;
        [_styte resignFirstResponder];
    }
    else
    {
        _depar.text=row;
        _rowSe=selectrow;
        [self.depar resignFirstResponder];
    }
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isEdit=NO;
    [self.view endEditing:YES];

}
@end
