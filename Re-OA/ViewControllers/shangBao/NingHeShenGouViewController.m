//
//  NingHeShenGouViewController.m
//  Re-OA
//
//  Created by imac-1 on 2017/5/12.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "NingHeShenGouViewController.h"
#import "ShangBaoWebAPI.h"
#import "UserPermission.h"
#import "ShangBaoList.h"
#import "AlertHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import <BMapKit.h>
#import "NingHeShenGouModel.h"
#import "NingHeShenGouCell.h"
#import "AddNingHeShenGouView.h"
#import "ScreenHelper.h"
#import "TJPictureView.h"
#import "ScreenHelper.h"
#import "ELCAssetSelectionDelegate.h"
#import "ELCAssetPickerFilterDelegate.h"

#import "ELCImagePickerController.h"
#import "ImageHelper.h"
#import "LargeImageView.h"
@interface NingHeShenGouViewController ()<UINavigationBarDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,NingHeShenGouModelDelegate,UITextFieldDelegate,TJPictureViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,ELCImagePickerControllerDelegate>
{
    
    BOOL isEdit;
    NSString *la;
    NSString *lo;
    NSMutableArray *dataArray;
    
    UIView *bgView ; //遮罩层
    BOOL isChooseMode;
    AddNingHeShenGouView *view;
    
    TJPictureView *pictureView;
    NSArray *dictIma;

}
@property (weak, nonatomic) IBOutlet UITextField *tf_txtMingChengXingHao;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtDanWei;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtShuLiang;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *tf_txtBeiZhu;
@property (nonatomic, strong)UINavigationBar * navibar;
@property(weak ,nonatomic)IBOutlet UIView *view_imagView;

@property (nonatomic, strong) UIImage         *editedImage;
@property (nonatomic, strong) NSMutableArray  *imagDatas;
@property (strong, nonatomic)  UIImagePickerController  *imagePickerController;
@end

@implementation NingHeShenGouViewController

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

- (void)submit:(id)sender
{
    if (lo.length!=0 &&la.length!=0) {
        [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
        NSMutableString *s=[NSMutableString string];
        NSMutableString *s2=[NSMutableString string];
          NSMutableString *s3=[NSMutableString string];
          NSMutableString *s4=[NSMutableString string];
        for (int i=0; i<dataArray.count; i++) {
             NingHeShenGouModel *model=dataArray[i];
             [s appendString:  model.name];
             [s2 appendString:  model.shuliang];
            [s3 appendString:  model.dawei];
            [s4 appendString:  model.beizhu];
            if (i!=dataArray.count-1) {
                [s appendString:@"[&]"];
                [s2 appendString:@"[&]"];
                [s3 appendString:@"[&]"];
                [s4 appendString:@"[&]"];

                
            }
          
        }
      //  NSLog(@"WW %@ %@ %@ %@",s,s2,s3,s4);
        
        NSDictionary *dic=[ShangBaoList standartUserInfo].infoDic;
        [ShangBaoWebAPI ningHeShenGouShangbao:[UserPermission standartUserInfo].ID andfpid:dic[@"fpId"] x:lo y:la txtMingChengXingHao:s txtDanWei:s3 txtShuLiang:s2 txtBeiZhu:s4  pic:self.imagDatas
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
    dataArray = [[NSMutableArray alloc]init];
   
    _imagDatas=[NSMutableArray array];
    [self initImagePicker];
    
    
    
    UIView *   otisView = [[UIView alloc]initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 176)];
    //otisView.backgroundColor = [UIColor redColor];
    otisView.userInteractionEnabled = YES;
    otisView.hidden = NO;
    [_tableView setTableFooterView:otisView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0, 0, 195,44);
    //btn.center = CGPointMake(SCREEN_WIDTH*0.5, 60);
    [btn addTarget:self action:@selector(AddItem) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"添加一条记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    [otisView addSubview:btn];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17, 10, 25, 25)];
    image.image = [UIImage imageNamed:@"addDetail.png"];
    // image.center = CGPointMake(SCREEN_WIDTH*0.25, 42.5);
    [btn addSubview:image];
    
    
    
    UIView *   otisView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)+1, self.view.frame.size.width, 80)];
    //otisView1.backgroundColor = [UIColor yellowColor];
    otisView1.userInteractionEnabled = YES;
   
    [otisView addSubview:otisView1];
    
    UIView *   otis = [[UIView alloc]initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, 1)];
    otis.backgroundColor = [UIColor groupTableViewBackgroundColor];
    otis.userInteractionEnabled = YES;
    
    [otisView1 addSubview:otis];
    
    
    pictureView = [[TJPictureView alloc] initWithFrame:CGRectMake(0, 1, [ScreenHelper SCREEN_WIDTH],  76)];
    pictureView.delegate = self;
    pictureView.typeStr=@"1";
    [otisView1 addSubview:pictureView];
    [pictureView refresPictureView:self.imagDatas];

    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor clearColor];
    btn1.frame = CGRectMake(self.view.frame.size.width/2-61, CGRectGetMaxY(otisView1.frame)+2, 132,38);
    //btn.center = CGPointMake(SCREEN_WIDTH*0.5, 60);
    [btn1 addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"renwuButton.png"] forState:UIControlStateNormal];
    [btn1 setTitle:@"上报" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    [otisView addSubview:btn1];
    

    

    
    
    [self GetData];
    
    
    
    
    
    
}
- (void)initImagePicker
{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.allowsEditing = NO;
    _imagePickerController.delegate = self;
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
    LargeImageView *view1 = [[LargeImageView alloc] initLargeImage:image OrImgUrl:nil];
    [self.view.window addSubview:view1];
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

- (void)GetData{
//    dataArray = CarManager.carInfoArray;
//    if (dataArray.count == 0) {
//        otisView.hidden = NO;
//    }else{
//        otisView.hidden = NO;
//    }
    [_tableView  reloadData];
}

- (void)AddItem{
    if (!isChooseMode) {
        [self showThebgview];
        view =[[AddNingHeShenGouView alloc]  instanceChooseView];
        view.delegate=self;
        [self.view.window addSubview:view];
    }
}
-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
    tapGesture.numberOfTapsRequired=1;
    [bgView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.8;
    }completion:^(BOOL finished){
        
    } ];
}
//撤销背景蒙板
-(void)hidThebgview{
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}
//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    [view closingTheLittleMenu:nil];
    
}
-(void)getNingHeShenGouModel:(NingHeShenGouModel *)model
{
    [dataArray addObject:model];
    [_tableView reloadData];
     [self hidThebgview];
    [view closingTheLittleMenu:nil];

}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    
//    CGRect frame=self.view.frame;
//    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//    if (!isEdit)
//    {
//        if (textField.tag>=107) {
//            frame.origin.y-= window.frame.size.height==480?200:158;
//            [UIView animateWithDuration:0.5f animations:^{
//                self.view.frame=frame;
//            }];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
    NingHeShenGouCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NingHeShenGouCell" owner:nil options:nil];
        cell= [nibView lastObject];

    }
    NingHeShenGouModel *model=dataArray[indexPath.row];
    cell.name.text=model.name;
    cell.shuliang.text=model.shuliang;
    cell.beizhu.text=model.beizhu;
    cell.dawei.text=model.dawei;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    TJFoundCarSettingViewController *ctrl = [[TJFoundCarSettingViewController alloc]init];
//    ctrl.indexPath = indexPath.row;
//    ctrl.mBlock = ^{
//        [self GetData];
//    };
//    [self.naviController pushViewController:ctrl animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];

    }
}

@end
