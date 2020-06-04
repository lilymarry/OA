//
//  NingHeKeHuInfomationController.m
//  Re-OA
//
//  Created by imac-1 on 2017/5/16.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "NingHeKeHuInfomationController.h"
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
@interface NingHeKeHuInfomationController ()<UINavigationBarDelegate,UITextFieldDelegate,TJPictureViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,ELCImagePickerControllerDelegate,UIActionSheetDelegate>
{
    
    BOOL isEdit;
    NSString *la;
    NSString *lo;
    TJPictureView *pictureView;
    NSArray *dictIma;
    
}
@property (weak, nonatomic) IBOutlet UITextField *tf_txtMingCheng;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtDiZhi;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtLianXiRen;

@property (weak, nonatomic) IBOutlet UITextField *tf_txtDianHua;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtSanZheng;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtHuanPing;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtYueDingLiang;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtShengChanZhi;

@property (weak, nonatomic) IBOutlet UITextField *tf_txtZiChan;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtZhangQi;

@property (weak, nonatomic) IBOutlet UITextView *tf_txtShuoMing;


@property(weak ,nonatomic)IBOutlet UIView *view_imagView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (nonatomic, strong)UINavigationBar * navibar;
@property (nonatomic, strong) UIImage         *editedImage;
@property (nonatomic, strong) NSMutableArray  *imagDatas;
@property (strong, nonatomic)  UIImagePickerController  *imagePickerController;


@end

@implementation NingHeKeHuInfomationController

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
        [ShangBaoWebAPI ningHeKeHuInformationShangbao:[UserPermission standartUserInfo].ID andfpid:dic[@"fpId"] x:lo y:la txtMingCheng:_tf_txtMingCheng.text txtDiZhi:_tf_txtDiZhi.text txtLianXiRen:_tf_txtLianXiRen.text txtDianHua:_tf_txtDianHua.text txtSanZheng:_tf_txtSanZheng.text txtHuanPing:_tf_txtHuanPing.text txtYueDingLiang:_tf_txtYueDingLiang.text txtShengChanZhi:_tf_txtShengChanZhi.text  txtZiChan:_tf_txtZiChan.text txtZhangQi:_tf_txtZhangQi.text txtShuoMing :_tf_txtShuoMing.text  pic:self.imagDatas
                                    success: ^(NSArray *arr){
                                        
                                        NSLog(@"AAAAA %@",arr);
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
    _scrollView.contentSize = CGSizeMake([ScreenHelper SCREEN_WIDTH],823);
    // [_scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScroll)];
    [self.scrollView addGestureRecognizer:tap];
    
    
}
-(void)tapScroll
{
    
    [_tf_txtMingCheng resignFirstResponder];
    [_tf_txtDiZhi resignFirstResponder];
    [_tf_txtLianXiRen resignFirstResponder];
    [_tf_txtDianHua resignFirstResponder];
    [_tf_txtSanZheng resignFirstResponder];
    [_tf_txtHuanPing resignFirstResponder];
    [_tf_txtYueDingLiang resignFirstResponder];
    [_tf_txtShengChanZhi resignFirstResponder];
    [_tf_txtZiChan resignFirstResponder];
    [_tf_txtZhangQi resignFirstResponder];
    [_tf_txtShuoMing resignFirstResponder];
    
}

- (void)initImagePicker
{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.allowsEditing = NO;
    _imagePickerController.delegate = self;
}
- (void)buildImageUI
{
    pictureView = [[TJPictureView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH],  79)];
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


//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//
//    CGRect frame=self.view.frame;
//    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//    if (!isEdit)
//    {
//        if (textField.tag>=107) {
//         frame.origin.y-= window.frame.size.height==480?200:158;
//        [UIView animateWithDuration:0.5f animations:^{
//            self.view.frame=frame;
//        }];
//        }
//
//    }
//    isEdit=YES;
//
//
//}
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//
//    CGRect frame=self.view.frame;
//    if (!isEdit) {
//        frame.origin.y=0;
//        [UIView animateWithDuration:0.5f animations:^{
//            self.view.frame=frame;
//        }];
//    }
//
//
//}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    //  NSLog(@"点击了搜索");
//    [textField resignFirstResponder];
//    return YES;
//}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    CGRect frame=self.view.frame;
//    if (!isEdit) {
//        frame.origin.y=0;
//        [UIView animateWithDuration:0.5f animations:^{
//            self.view.frame=frame;
//        }];
//    }
//    return NO;
//}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    isEdit=NO;
//    [self.view endEditing:YES];
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
