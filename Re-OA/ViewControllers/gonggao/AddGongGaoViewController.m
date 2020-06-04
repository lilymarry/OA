#import "AddGongGaoViewController.h"
#import "ToPerViewController.h"
#import "GongGaoWebAPI.h"
#import "UserPermission.h"
#import "NullValueHelper.h"
#import "AlertHelper.h"
@interface AddGongGaoViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    NSString *uid;
}
@property (weak, nonatomic) IBOutlet UITextField *tittle;
@property (weak, nonatomic) IBOutlet UILabel *personLable;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property(strong ,nonatomic)NSArray *arr;

@end

@implementation AddGongGaoViewController
- (IBAction)submit:(id)sender
{
   
    if ([NullValueHelper textViewAndtextFeildNotNullOrNull:_arr])
    {
        UIAlertView *  alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"信息不完整！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
        [GongGaoWebAPI addGongGaoRequestID:[UserPermission standartUserInfo].ID tittle:_tittle.text description:_content.text acceptName:_personLable.text acceptID:uid  userName:[UserPermission standartUserInfo].name   success:^(NSArray *arr)
         {
            [AlertHelper hideAllHUDsForView:self.view];
             @try {
                 int code = [[arr[0]objectForKey:@"bool"] intValue];
                 if (code==1)
                 {
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     alert.tag=1000;
                     [alert show];
                 }else
                 {
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器错误,请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                 }
             }
             @catch (NSException *exception) {
                 }
         }
         fail:^(){
             [AlertHelper hideAllHUDsForView:self.view];
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误,请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
    [self.navigationController popViewControllerAnimated: YES];
}
-(void)viewDidLoad {
    [super viewDidLoad];
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    uid=[[NSString alloc]init];
    _personLable.text=@"选择参与人";
    _arr =[NSArray arrayWithObjects:_tittle,_content, nil];
}
- (IBAction)AddBtnPress:(id)sender
{
    ToPerViewController *to=[[ToPerViewController alloc]initWithBlock:^(NSArray *names,NSArray *uids)
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
            uid= [uidstr substringToIndex:uidstr.length-1];
            _personLable.text= [namestr substringToIndex:namestr.length-1];
        }
    }];
    [self.navigationController pushViewController:to animated:YES];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
