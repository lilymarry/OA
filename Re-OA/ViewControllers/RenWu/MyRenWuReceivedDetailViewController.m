
#import "MyRenWuReceivedDetailViewController.h"
#import <MBProgressHUD.h>
#import "RenWuWebAPI.h"
#import "UserPermission.h"
#import "MyReceivedReWuDetailModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RenWuTaopModel.h"
#import "MyRenWuQiTaRenViewController.h"
#import "LargeImageView.h"
#import "ImageHelper.h"
#import "CharacterHelper.h"

@interface MyRenWuReceivedDetailViewController (){
    id data;
    UIImagePickerController *_imagePickerController;
    MyReceivedReWuDetailModel *model;
    RenWuTaopModel *taoModel;
    
    BOOL ischooseImg;
}

@end

@implementation MyRenWuReceivedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    ischooseImg=NO;
    self.twDesc.delegate=self;
    self.navigationItem.title=@"接收任务详情";
     self.picDelBtn.hidden=YES;
    UIBarButtonItem *item= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"renwuUsers"] style:UIBarButtonItemStyleBordered target:self action:@selector(redirectController:)];
    self.navigationItem.rightBarButtonItem=item;
    
    UITapGestureRecognizer *uploadtapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUploadLargeImage:)];
    [self.imgUpload addGestureRecognizer:uploadtapGesture];
    UITapGestureRecognizer *imgtapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLargeImage:)];
    [self.imgrenwu addGestureRecognizer:imgtapGesture];
    
}
//查看上传图片
-(void)showUploadLargeImage:(UITapGestureRecognizer*)gesture{
    if (ischooseImg) {
        LargeImageView *view = [[LargeImageView alloc] initLargeImage:self.imgUpload.image OrImgUrl:nil];
        [self.view.window addSubview:view];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选取图片" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//查看任务图片
-(void)showLargeImage:(UITapGestureRecognizer*)gesture{
    NSString *imgurlstr=[[RenWuWebAPI largeImgUrlPathWithUid:model.tauserid] stringByAppendingString:model.taimg];
    
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:nil OrImgUrl:imgurlstr];
    [self.view.window addSubview:view];
}

-(void)viewWillAppear:(BOOL)animated{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"获取中...";
    
    [RenWuWebAPI requestReceivedDetailByUID:[UserPermission standartUserInfo].ID
                                    AndType:@"3"
                                    AndTAID:self.ta_id success:^(NSArray *renwulist){
                                        if (renwulist && renwulist.count>0) {
                                            
                                            
                                            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: renwulist[0]];
                                            data=dict;
                                            
                                            model=[[MyReceivedReWuDetailModel alloc]initWithJson:[dict objectForKey:@"task"][0]];
                                            
                                            self.labUserName.text=model.username;
                                            self.labsdate.text=model.talssueddate;
                                            self.labedate.text=model.tastopdate;
                                            self.twTitle.text=model.taname;
                                            self.twContent.text=[CharacterHelper replacingTheBRToEnter:model.tadescription] ;
                                            
                                            NSString *imgurlstr=[[RenWuWebAPI smallImgUrlPathWithUid:model.tauserid] stringByAppendingString:model.taimg];
                                            NSURL *url=[NSURL URLWithString:imgurlstr];
                                            [self.imgrenwu sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"nopicture"]];
                                            if ([[dict objectForKey:@"taop"] count]!=0) {
                                                taoModel=[[RenWuTaopModel alloc]initWithJson:[dict objectForKey:@"taop"][0]];
                                            }
                                            
                                            
                                            
                                        }
                                        [hud hide:YES];
                                    }  fail:^{
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                        [alert show];
                                    }];
}

- (IBAction)submitReceiveRenWu:(id)sender {
    
    NSString *userid =[UserPermission standartUserInfo].ID;
    NSString *taid = self.ta_id;
    NSString *tkonid =taoModel.taopid;
    NSString *todescription = ([@"点此输入" isEqualToString:self.twDesc.text])?@"":[self.twDesc.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"提交中...";
    if (ischooseImg) {
        
        NSData  *_imgData=UIImageJPEGRepresentation(self.imgUpload.image, 0.5);
        
        [RenWuWebAPI doRenWuByuserid:userid
                             Andtaid:taid
                           Andtkonid:tkonid
                    Andtodescription:todescription
                        AndUploadImg:_imgData
                             success:^(NSArray *resArr) {
                                 NSString *str=@"已提交";
                                 
                                 if (resArr && resArr.count>0) {
                                     NSDictionary *dict = resArr[0];
                                     NSString *flag=  [dict objectForKey:@"bool"];
                                     if (![@"1" isEqualToString:flag]) {
                                         str=@"提交失败，请稍候重试";
                                     }
                                 }
                                 
                                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                 [alert show];
                                 [self.navigationController popViewControllerAnimated:YES];
                             } fail:^{
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                 [alert show];
                             }];
    }else{
        [RenWuWebAPI doRenWuByuserid:userid
                             Andtaid:taid
                           Andtkonid:tkonid
                    Andtodescription:todescription
                             success:^(NSArray *resArr) {
                                 NSString *str=@"已提交";
                                 
                                 if (resArr && resArr.count>0) {
                                     NSDictionary *dict = resArr[0];
                                     NSString *flag=  [dict objectForKey:@"bool"];
                                     if (![@"1" isEqualToString:flag]) {
                                         str=@"提交失败，请稍候重试";
                                     }
                                 }
                                 
                                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                 [alert show];
                                 [self.navigationController popViewControllerAnimated:YES];
                             } fail:^{
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                 [alert show];
                             }];
    }
}

-(void)redirectController:(id)sender{
    //qitarenrenwu
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RenWu" bundle:[NSBundle mainBundle]];
    MyRenWuQiTaRenViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"qitarenrenwu"];
    controller.dataArr=[data objectForKey:@"list"];
    [self.navigationController pushViewController:controller animated:YES ];
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
          //  NSLog(@"取消");
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
    if ([@"点此输入" isEqualToString:self.twDesc.text]) {
        self.twDesc.text=@"";
    }
    CGRect frame=self.view.frame;
    frame.origin.y=frame.origin.y- 158;
    [UIView animateWithDuration:0.5f animations:^{
        self.view.frame=frame;
    }];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([@"" isEqualToString:self.twDesc.text]) {
        self.twDesc.text=@"点此输入";
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
