
#import "AddRenWuViewController.h"
#import "RenWuUserGroupModel.h"
#import "RenWuUsersModel.h"
#import <MBProgressHUD.h>
#import "ChooseDateView.h"
#import "RenWuWebAPI.h"
#import "UserPermission.h"
#import "NullValueHelper.h"
#import "ImageHelper.h"
#import "LargeImageView.h"
#import "RenwuPersonViewController.h"
@interface AddRenWuViewController(){
    UIImagePickerController *_imagePickerController;
    
    NSString *usersidStr;
    NSString *usersStr;
    ChooseDateView *dateView;
    BOOL istixing;
    BOOL ishukan;
    
    BOOL ischooseImg;
}
@end

@implementation AddRenWuViewController

-(void)viewDidLoad{
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    ischooseImg=NO;
    _txtDesc.delegate=self;
    dateView = [ChooseDateView instanceChooseDateView];
    dateView.chooseDateDelegate=self;
    dateView.dateId=@"1";
    self.txtDate.inputView=dateView;
    _TextArr=[NSArray arrayWithObjects:_txtName,_txtDate,_txtUsers,nil];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLargeImage:)];
    [self.imgUpload addGestureRecognizer:tapGesture];
     self.picDelBtn.hidden=YES;
}

//发布任务
- (IBAction)submitRenWu:(id)sender {
    
    if ([NullValueHelper textViewAndtextFeildNotNullOrNull:_TextArr])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整信息" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSString *name = [self.txtName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *description = [self.txtDesc.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *stopdate = self.txtDate.text;
        NSString *isremind = (self.swiAlter.on)?@"1":@"2";
        NSString *iswatch = (self.swiWatch.on)?@"1":@"2";
        NSString *username = [[UserPermission standartUserInfo].name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *uid = [UserPermission standartUserInfo].ID ;
        NSString *arraycjuserid = usersidStr;
        NSString *arraycjusername = [usersStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"提交中...";
        NSData  *_imgData=(ischooseImg)?UIImageJPEGRepresentation(self.imgUpload.image, 0.5):nil;
        
        [RenWuWebAPI sendARenWuByname:name
                       Anddescription:(![@"点此输入" isEqualToString:self.txtDesc.text])?description:@""
                          Andstopdate:stopdate
                          Andisremind:isremind
                           Andiswatch:iswatch
                          Andusername:username
                            Anduserid:uid
                     Andarraycjuserid:(arraycjuserid)?arraycjuserid:@""
                   Andarraycjusername:(arraycjusername)?arraycjusername:@""
                         AndUploadImg:_imgData
                              success:^(NSArray *renwuArr) {
                                  UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已派送" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                  [alert show];
                                  
                                  NSObject<CommonNotification> *tmpDele=self.refreshNotification;
                                  [tmpDele refreshingDataList];
                                  
                                  [self.navigationController popViewControllerAnimated:YES];
                                  
                                  
                              } fail:^{
                                  hud.labelText=@"提交失败";
                                  [hud hide:YES];
                              }];
    }
}

//日期选取
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid{
    self.txtDate.text= dateStr;
    [self.txtDate resignFirstResponder];
}

////承接人选取
//-(void)setTheChooseUser:(NSMutableArray *)userArr{
//    usersStr=[NSMutableString new];
//    usersidStr=[NSMutableString new];
//    for (RenWuUserGroupModel *group in userArr) {
//        NSMutableArray *users=group.users;
//        for (RenWuUsersModel *user in users) {
//            if (user.isChoosed) {
//                [usersStr appendString:user.name];
//                [usersStr appendString:@","];
//                
//                [usersidStr appendString:user.uid];
//                [usersidStr appendString:@","];
//            }
//        }
//    }
//    if (usersStr.length>0 && usersidStr.length>0) {
//        [usersStr deleteCharactersInRange:NSMakeRange(usersStr.length-1, 1)];
//        [usersidStr deleteCharactersInRange:NSMakeRange(usersidStr.length-1, 1)];
//        self.txtUsers.text= usersStr;
//        
//    }
//}
- (IBAction)AddBtnPress:(id)sender
{
    RenwuPersonViewController  *to=[[RenwuPersonViewController alloc]initWithBlock:^(NSArray *names,NSArray *uids)
                                    {   to.isinGongGao=@"2";
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
                                            _txtUsers.text=usersStr;
                                        }
                                    }];
    [self.navigationController pushViewController:to animated:YES];
    
    
}
//成为承接人代理
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier compare:@"chooseusersegue"]==NO)
    {
        [[segue destinationViewController] setValue:self forKey:@"chooseUserDelegate"];
    }
}

//选取图片
- (IBAction)chooseThePicture:(id)sender {
    
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"选取图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从照片库中选择" otherButtonTitles:@"添加新照片", nil];
    sheet.delegate=self;
    sheet.tag=10000;
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==10000)
    {
        if (buttonIndex==0)
        {
           // NSLog(@"从照片库中选择");
            [self chooseFromPhotolib];
        }
        if (buttonIndex==1)
        {
           // NSLog(@"新拍照");
            [self chooseFromCamera];
        }
        if (buttonIndex==2)
        {
           // NSLog(@"取消");
        }
    }
    
}
-(void)chooseFromPhotolib
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)chooseFromCamera
{
    //检查是否有相机（图片选取器的isSourceTypeAvailable类方法）
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        _imagePickerController=[UIImagePickerController new];
        _imagePickerController.delegate=self;
        //_imagePickerController.allowsEditing = YES;  //是否可编辑
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img= [ImageHelper zipAndStoreTheChoosedImageWithController:picker AndInfo:info];
    self.imgUpload.image=img;
    ischooseImg=YES;
    self.picDelBtn.hidden=NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//查看图片
-(void)showLargeImage:(UITapGestureRecognizer*)gesture{
    if (ischooseImg) {
        LargeImageView *view = [[LargeImageView alloc] initLargeImage:self.imgUpload.image OrImgUrl:nil];
        [self.view.window addSubview:view];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选取图片" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}
//隐藏编辑
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:0.5f animations:^{
        self.view.frame=frame;
    }];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([@"点此输入" isEqualToString:self.txtDesc.text]) {
        self.txtDesc.text=@"";
    }
    CGRect frame=self.view.frame;
    frame.origin.y=frame.origin.y- 158;
    [UIView animateWithDuration:0.5f animations:^{
        self.view.frame=frame;
    }];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([@"" isEqualToString:self.txtDesc.text]) {
        self.txtDesc.text=@"点此输入";
    }
}
- (IBAction)deleSelectPicPress:(id)sender {
    if (ischooseImg==NO)
    {
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"取消选择" delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"是的", nil];
        alert.tag=1000;
        [alert show];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (buttonIndex==1)
        {
            ischooseImg=NO;
            self.imgUpload.image=[UIImage imageNamed:@"nopicture.png"];
            self.picDelBtn.hidden=YES;
        }
    
}
@end
