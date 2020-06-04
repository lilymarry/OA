#import "AddJourViewController.h"
#import "RizhiWebAPI.h"
#import "UserPermission.h"
#import  "NullValueHelper.h"
#import "AlertHelper.h"
@interface AddJourViewController ()<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tittle;
@property (weak, nonatomic) IBOutlet UITextView *context;
@property (strong, nonatomic) NSArray * TextArr;
- (IBAction)fabuBtnPress:(id)sender;

@end

@implementation AddJourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _TextArr=[NSArray arrayWithObjects:_tittle,_context,nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
- (IBAction)fabuBtnPress:(id)sender
{
    if ([NullValueHelper textViewAndtextFeildNotNullOrNull:_TextArr])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示！" message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
     }else{
        [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
        [RizhiWebAPI addRizhiRequestlistID :[UserPermission standartUserInfo].ID tittleName:_tittle.text userName:[UserPermission standartUserInfo].name andContent:_context.text success:^(NSArray *arr)
         {
            [AlertHelper hideAllHUDsForView:self.view];
             int result=   [[arr[0]objectForKey:@"bool"] intValue];
             if (result==1)
             {
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"已提交" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                  alert.tag=1000;
                 [alert show];
             }
             else{
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误，稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
             }}
        fail:^(){
          [AlertHelper hideAllHUDsForView:self.view];
          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误，稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
          [alert show];
         }];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000) {
        NSObject<CommonNotification> *tmpDele=self.refreshNotification;
        [tmpDele refreshingDataList];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
