//
//  NingHeZhiLiangViewController.m
//  Re-OA
//
//  Created by admin on 16/4/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "NingHeZhiLiangViewController.h"
#import "ShangBaoWebAPI.h"
#import "UserPermission.h"
#import "ShangBaoList.h"
#import "AlertHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import <BMapKit.h>
#import "TJPictureView.h"
#import "ScreenHelper.h"
#import "ELCAssetSelectionDelegate.h"
#import "ELCAssetPickerFilterDelegate.h"

#import "ELCImagePickerController.h"
#import "ImageHelper.h"
#import "LargeImageView.h"
@interface NingHeZhiLiangViewController ()<UINavigationBarDelegate,UITextFieldDelegate,TJPictureViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,ELCImagePickerControllerDelegate>
{
    NSString *la;
    NSString *lo;
    BOOL isEdit;
    TJPictureView *pictureView;
    NSArray *dictIma;
}
@property (weak, nonatomic) IBOutlet UITextField *tf_khnm;
@property (weak, nonatomic) IBOutlet UITextField *tf_odcode;
@property (weak, nonatomic) IBOutlet UITextField *tf_size;
@property (weak, nonatomic) IBOutlet UITextField *tf_pm;
@property (weak, nonatomic) IBOutlet UITextField *tf_odnum;
@property (weak, nonatomic) IBOutlet UITextField *tf_err;
@property (weak, nonatomic) IBOutlet UITextView *tf_reason;
@property (weak, nonatomic) IBOutlet UITextView *tf_opinion;

@property (nonatomic, strong)UINavigationBar * navibar;
@property(weak ,nonatomic)IBOutlet UIView *view_imagView;

@property (nonatomic, strong) UIImage         *editedImage;
@property (nonatomic, strong) NSMutableArray  *imagDatas;
@property (strong, nonatomic)  UIImagePickerController  *imagePickerController;

@end

@implementation NingHeZhiLiangViewController
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
                                       andfpid:dic[@"fpId"] x:lo y:la khid:@"" khnm:_tf_khnm.text odcode:_tf_odcode.text size:_tf_size.text pm:_tf_pm.text odnum:_tf_odnum.text err:_tf_err.text reason:_tf_reason.text opinion:_tf_opinion.text pic:self.imagDatas
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
    _imagDatas=[NSMutableArray array];
    [self initImagePicker];
    
    [self buildImageUI];
    [pictureView refresPictureView:self.imagDatas];
   

}
- (void)initImagePicker
{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.allowsEditing = NO;
    _imagePickerController.delegate = self;
}
- (void)buildImageUI
{
    pictureView = [[TJPictureView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH],  76)];
    pictureView.delegate = self;
    pictureView.typeStr=@"1";
    [_view_imagView addSubview:pictureView];
    
    
}
-(void)chooseFromPhotolib
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 9;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
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
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    dictIma=info;
    [self dismissViewControllerAnimated:YES completion:nil];
    [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [self performSelectorInBackground:@selector(getImaWithDic) withObject:nil];
    
    
}
-(void)getImaWithDic
{
    for (NSDictionary *dict in dictIma) {
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *tempImg=[ImageHelper hotLargImagWithImage:image] ;
        if (![self.imagDatas containsObject:tempImg]) {
            
            [self.imagDatas addObject:tempImg];
            
        }
    }
    [self performSelectorOnMainThread:@selector(mainWork) withObject:nil waitUntilDone:NO];
    
    
}
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.editedImage= [ImageHelper zipAndStoreTheChoosedImageWithController:picker AndInfo:info];
    
    
    [self performSelectorInBackground:@selector(getIma) withObject:nil];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)getIma
{
    
    if (![self.imagDatas containsObject:self.editedImage]) {
        
        [self.imagDatas addObject:self.editedImage];
        
    }
    
    
    [self performSelectorOnMainThread:@selector(mainWork) withObject:nil waitUntilDone:NO];
    
    
    
    
}
-(void)mainWork
{
    
    [pictureView refresPictureView:self.imagDatas];
    [AlertHelper hideAllHUDsForView:self.view];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)removeImageView:(int)index andType:(NSString *)type
{
    if (index==8000) {
        UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"选取图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从照片库中选择" otherButtonTitles:@"添加新照片", nil];
        sheet.delegate=self;
        sheet.tag=10000;
        [sheet showInView:self.view];
        
    }
    else
    {
        
        [pictureView refresPictureView:self.imagDatas];
        
    }
}
- (void)showImageView:(int)index andType:(NSString *)type
{
    
    UIImage *image;
    if ([type isEqualToString:@"1"]) {
        image=self.imagDatas[index];
    }
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:image OrImgUrl:nil];
    [self.view.window addSubview:view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0)
    {
        [self  chooseFromPhotolib];
    }
    if (buttonIndex==1)
    {
        [self chooseFromCamera];
        
    }
    if (buttonIndex==2)
    {
        ;
    }
    
    
    
    
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

- (void)textViewDidBeginEditing:(UITextView *)textView
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
- (void)textViewDidEndEditing:(UITextView *)textView
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
