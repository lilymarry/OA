//
//  MyRenWuNewReceivedDetailViewController.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/2.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "MyRenWuNewReceivedDetailViewController.h"
#import "ImageHelper.h"
#import "LargeImageView.h"
#import "TJPictureView.h"
#import "ScreenHelper.h"

#import "AlertHelper.h"
#import "HotRewWuWebAPI.h"
#import "UserPermission.h"
#import "MyReceivedReWuHotDetailModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RenWuTaopModel.h"
#import "MyRenWuQiTaRenViewController.h"
#import "LargeImageView.h"
#import "ImageHelper.h"
#import "CharacterHelper.h"

#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import <BMapKit.h>

#import "TJDisPlayPictureView.h"


#import "ELCAssetSelectionDelegate.h"
#import "ELCAssetPickerFilterDelegate.h"

#import "ELCImagePickerController.h"


#import "ScreenHelper.h"

#import "CircleProgressView.h"
#import "UserSatisfiyView.h"
@interface MyRenWuNewReceivedDetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TJPictureViewDelegate,TJPictureDisPlayViewDelegate,ELCImagePickerControllerDelegate,UIActionSheetDelegate,UserSatisfiyDelegate>
{
    TJPictureView *pictureView;
    TJPictureView *pictureView2;
    TJPictureView *pictureView3;
    BOOL ischooseImg;
    // NSTimer *_timer;
    UIImagePickerController *_imagePickerController;
    
    NSString *typeStr;
    
    MyReceivedReWuHotDetailModel *model;
    NSString *la;
    NSString *lo;
    
    TJDisPlayPictureView *DisPlayPicView;
    TJDisPlayPictureView *DisPlayPicView2;
    TJDisPlayPictureView *DisPlayPicView3;
    
    NSString *renWuId;
    
    UIButton *clorkBt;
    
    UIView *bgView ; //遮罩层
    
    NSString*descri1;
    NSString*descri2;
    NSString*descri3;
    
    NSArray *dictIma;
    
    UserSatisfiyView *choseview;
    
  
    
}
@property (weak, nonatomic) IBOutlet  UITextView *twDesc;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *picNewView;
@property (weak, nonatomic) IBOutlet UIView *picNewView2;
@property (weak, nonatomic) IBOutlet UIView *picNewView3;

@property (nonatomic, strong) UIImage         *editedImage;
@property (nonatomic, strong) NSMutableArray  *imagDatas;

@property (nonatomic, strong) UIImage         *editedImage2;
@property (nonatomic, strong) NSMutableArray  *imagDatas2;

@property (nonatomic, strong) UIImage         *editedImage3;
@property (nonatomic, strong) NSMutableArray  *imagDatas3;

/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */
@property (nonatomic, strong) dispatch_source_t timer;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;


@property (weak, nonatomic) IBOutlet UILabel *Ta_Number;// 编号

@property (weak, nonatomic) IBOutlet UILabel *Ta_Address;

@property (weak, nonatomic) IBOutlet UILabel *Ta_Area;//小区

@property (weak, nonatomic) IBOutlet UILabel *Ta_Phone;//联系电话
@property (weak, nonatomic) IBOutlet UILabel *Ta_Source;// 业务来源
@property (weak, nonatomic) IBOutlet UILabel *Ta_Type;//业务类型

@property (weak, nonatomic) IBOutlet UILabel *Ta_endTime;//到期时间
@property (weak, nonatomic) IBOutlet UILabel *lab_endTime;//到期时间


@property (weak, nonatomic) IBOutlet UILabel *xiaoqueChuli;//消缺处理情况

@property (weak, nonatomic) IBOutlet UILabel *xiaoquesghouliTime;//消缺受理时间
@property (weak, nonatomic) IBOutlet UILabel *xiaoqueChuliTime;//消缺处理时间

@property (weak, nonatomic) IBOutlet UILabel *Ta_TimeLimit;//时限
@property (weak, nonatomic) IBOutlet UILabel *weiHuPersonSign;//维护人员签字

@property (weak, nonatomic) IBOutlet UILabel *PersonSign;//用户签字
@property (weak, nonatomic) IBOutlet UILabel *manyidu;//满意度
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UILabel *remark;//备注

@property (weak, nonatomic) IBOutlet UILabel *Tadescription;//任务描述
@property (weak, nonatomic) IBOutlet UILabel *talssueddate;
@property (weak, nonatomic) IBOutlet UILabel *tastopdate;

@property (weak, nonatomic) IBOutlet UILabel *username;


@property (weak, nonatomic) IBOutlet UITextView *taskDescrition;

@property (weak, nonatomic) IBOutlet UIView *view_usePic;

@property (nonatomic, strong) CircleProgressView *circleProgress;



@end

@implementation MyRenWuNewReceivedDetailViewController
- (CircleProgressView *)circleProgress
{
    if(!_circleProgress)
    {
        _circleProgress = [[CircleProgressView alloc] initWithFrame:CGRectMake([ScreenHelper SCREEN_WIDTH]/2-40, [ScreenHelper SCREEN_HEIGHT]/2-40, 80, 80)];
        _circleProgress.backgroundColor = [UIColor whiteColor];
    }
    return _circleProgress;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    clorkBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [clorkBt setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH]-80, [ScreenHelper SCREEN_HEIGHT]-180, 60, 60)];
    [clorkBt setBackgroundImage:[UIImage imageNamed:@"unclork"] forState:UIControlStateNormal];
    [clorkBt setBackgroundImage:[UIImage imageNamed:@"clork"] forState:UIControlStateSelected];
    [clorkBt addTarget:self action:@selector(setClork:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clorkBt];
    
    
    _scrollView.contentSize = CGSizeMake(0, 2000);
    _scrollView.scrollEnabled = YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScroll)];
    [self.scrollView addGestureRecognizer:tap];
    
    lo=@"";
    la=@"";
    // [self getlocation];
    
    
    
    
    _imagDatas=[NSMutableArray array];
    _imagDatas2=[NSMutableArray array];
    _imagDatas3=[NSMutableArray array];
    [self initImagePicker];
    [self buildDisPlayImageUI];
    [self buildImageUI];
    
    
    
    [pictureView refresPictureView:self.imagDatas];
    [pictureView2 refresPictureView:self.imagDatas2];
    [pictureView3 refresPictureView:self.imagDatas3];
    
    ischooseImg=NO;
    
    clorkBt.selected=NO;
    
    NSArray *notificaitons = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //获取当前所有的本地通知
    if (!notificaitons || notificaitons.count <= 0) {
        //   return;
    }
    for (UILocalNotification *notify in notificaitons) {
        if ([[notify.userInfo objectForKey:@"ta_id"] isEqualToString:self.ta_id]) {
            //取消一个特定的通知
            clorkBt.selected=YES;
            break;
        }
        
        
    }
    [self loadData];
    
     [self.view addSubview:self.circleProgress];
     self.circleProgress.hidden=YES;
    
}
-(void)setJiShi:(NSDate *)startDate date2:(NSDate *)endDate
{
    
    NSTimeInterval timeInterval =[endDate timeIntervalSinceDate:startDate];
    
    if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.dayLabel.text = @"已过期";
                        self.hourLabel.text = @"";
                        self.minuteLabel.text = @"";
                        self.secondLabel.text = @"";
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    if (days==0) {
                        self.dayLabel.text = @"";
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {
                            self.dayLabel.text = @"0天";
                        }else{
                            self.dayLabel.text = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours<10) {
                            self.hourLabel.text = [NSString stringWithFormat:@"0%d:",hours];
                        }else{
                            self.hourLabel.text = [NSString stringWithFormat:@"%d:",hours];
                        }
                        if (minute<10) {
                            self.minuteLabel.text = [NSString stringWithFormat:@"0%d:",minute];
                        }else{
                            self.minuteLabel.text = [NSString stringWithFormat:@"%d:",minute];
                        }
                        if (second<10) {
                            self.secondLabel.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondLabel.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
    
}
-(void)addUpdateIma
{
    
    
}
-(void)setClork:(id)sender
{
    
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate=[dateFormatter dateFromString:_lab_endTime.text];
    
    NSDate *startDate = [NSDate date];
    
    NSTimeInterval timeInterval =[endDate timeIntervalSinceDate:startDate];
    int timeout = timeInterval;
    if (timeout<30*60) {
        [AlertHelper singleMBHUDShow:@"提醒无效，需提前30分钟设置" ForView:self.view AndDelayHid:1];
        
    }
    else
    {
        clorkBt.selected=!clorkBt.selected;
        
        if (clorkBt.selected) {
            [self  DateOfTiXing:_lab_endTime.text];
        }
        else
        {
            
            [self canellTongZhi];
        }
        
    }
    
    
    
}
-(void)canellTongZhi
{
    NSArray *notificaitons = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //获取当前所有的本地通知
    if (!notificaitons || notificaitons.count <= 0) {
        return;
    }
    for (UILocalNotification *notify in notificaitons) {
        if ([[notify.userInfo objectForKey:@"ta_id"] isEqualToString:self.ta_id]) {
            //取消一个特定的通知
            [[UIApplication sharedApplication] cancelLocalNotification:notify];
            [AlertHelper singleMBHUDShow:@"任务提醒已取消" ForView:self.view AndDelayHid:1];
            break;
        }
        
    }
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
-(void)loadData
{
    //    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.labelText=@"获取中...";
    [AlertHelper MBHUDShow:@"获取中..." ForView:self.view AndDelayHid:30];
    [HotRewWuWebAPI requestHotReceivedDetailByUID:[UserPermission standartUserInfo].ID
                                       AndType:@"3"
                                       AndTAID:self.ta_id success:^(NSArray *renwulist){
                                           [AlertHelper hideAllHUDsForView:self.view];
                                           if (renwulist && renwulist.count>0) {
                                               //      @try {
                                               NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: renwulist[0]];
                                               model=[[MyReceivedReWuHotDetailModel alloc]initWithJson:[dict objectForKey:@"task"][0]];
                                               _Ta_Number.text=model.Ta_Number;
//                                               _Ta_Address.text=model.Ta_Address;
//                                               _Ta_Area.text=model.Ta_Area;
                                                _Ta_Area.text=[NSString stringWithFormat:@"%@(%@)",model.Ta_Area,model.Ta_Address];

                                               _Ta_Phone.text=model.Ta_Phone;
                                               _Ta_Source.text=model.Ta_Source;
                                               _Ta_Type.text=model.Ta_Type;
                                               _Ta_endTime.text=model.Ta_endTime;
                                               _lab_endTime.text=model.Ta_endTime;
                                               _xiaoqueChuli.text=model.xiaoqueChuli;
                                               _xiaoquesghouliTime.text=model.xiaoquesghouliTime;
                                               _xiaoqueChuliTime.text=model.xiaoqueChuliTime;
                                               _Ta_TimeLimit.text=model.Ta_TimeLimit;
                                               _weiHuPersonSign.text=model.weiHuPersonSign;
                                               _PersonSign.text=model.PersonSign;
                                               _manyidu.text=model.manyidu;
                                               _remark.text=model.remark;
                                               _username.text=model.username;
                                               if([model.Ta_Satisfied isEqualToString:@"满意"])
                                               {
                                                   _view1.backgroundColor=[UIColor blueColor];
                                               }
                                               else if([model.Ta_Satisfied isEqualToString:@"一般"])
                                               {
                                                   _view2.backgroundColor=[UIColor blueColor];
                                               }
                                               else  if([model.Ta_Satisfied isEqualToString:@"不满意"])
                                               {
                                                  _view3.backgroundColor=[UIColor blueColor];
                                               }
                                               //当前时间
                                               NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                                               [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                               NSDate *endDate = [dateFormatter dateFromString:_lab_endTime.text];
                                               NSDate *startDate = [NSDate date];
                                               [self setJiShi:startDate date2:endDate];
                                               
                                               NSArray *delayArr=[dict objectForKey:@"delay"];
                                               NSMutableString *str=[NSMutableString string];
                                               for (NSDictionary *dic in delayArr){
                                                   NSString *str1=[NSString stringWithFormat: @"延时时间:%@",dic[@"HTY_Stopdate"]];
                                                   [str appendString:str1];
                                                   [str appendString:@"\n"];
                                                   NSString *str2=[NSString stringWithFormat: @"延时原因:%@",dic[@"HTY_Description"]];
                                                   [str appendString:str2];
                                                   [str appendString:@"\n"];
                                               }
                                               _twDesc.text=str;
                                               
                                               NSArray *arr=[dict objectForKey:@"taop"];
                                               if (arr.count>0) {
                                                   
                                                   
                                                   NSDictionary *picDic=[dict objectForKey:@"taop"][0];
                                                   renWuId=picDic[@"taopid"];
                                                   descri1=picDic[@"Taop_Describe1"];
                                                   descri2=picDic[@"Taop_Describe2"];
                                                   descri3=picDic[@"Taop_Describe3"];
                                                   
                                                   NSString *str1=picDic[@"Taop_Img1"];
                                                   if (str1.length>0) {
                                                       NSArray *  imaArr=[NSMutableArray arrayWithArray:[picDic[@"Taop_Img1"] componentsSeparatedByString:@","]];
                                                       [DisPlayPicView refresPictureView:imaArr withType:@"RH"andUsid:[UserPermission standartUserInfo].ID andDecri:picDic[@"Taop_Describe1"]];
                                                       // _picNewView.hidden=YES;
                                                       
                                                   }
                                                   else
                                                   {
                                                       //  _picNewView.hidden=NO;
                                                       
                                                   }
                                                   NSString *str2=picDic[@"Taop_Img2"];
                                                   if (str2.length>0) {
                                                       NSArray *  imaArr2=[NSMutableArray arrayWithArray:[picDic[@"Taop_Img2"] componentsSeparatedByString:@","]];
                                                       [DisPlayPicView2 refresPictureView:imaArr2 withType:@"XL"andUsid:[UserPermission standartUserInfo].ID andDecri:picDic[@"Taop_Describe2"]];
                                                       //  _picNewView2.hidden=YES;
                                                   }
                                                   else
                                                   {
                                                       // _picNewView2.hidden=NO;
                                                       
                                                   }
                                                   NSString *str3=picDic[@"Taop_Img3"];
                                                   if (str3.length>0) {
                                                       NSArray *  imaArr3=[NSMutableArray arrayWithArray:[picDic[@"Taop_Img3"] componentsSeparatedByString:@","]];
                                                       [DisPlayPicView3 refresPictureView:imaArr3 withType:@"QT"andUsid:[UserPermission standartUserInfo].ID andDecri:picDic[@"Taop_Describe3"]];
                                                       //  _picNewView3.hidden=YES;
                                                   }
                                                   //                                               else
                                                   //                                               {
                                                   //                                                   _picNewView3.hidden=NO;
                                                   //
                                                   //                                               }
                                                   
                                                   //                                               } @catch (NSException *exception) {
                                                   //
                                                   //                                               } @finally {
                                                   //
                                                   //                                               }
                                                   //   NSLog(@"AAAA_ %@",renwulist);
                                                   
                                               }
                                           }
                                           //   [self setUpImaViewframe:_picNewView.hidden picView2:_picNewView2.hidden picView3:_picNewView3.hidden];
                                           
                                           
                                       }  fail:^{
                                           [AlertHelper hideAllHUDsForView:self.view];
                                           [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
                                       }];
    
}
-(void)setUpImaViewframe:(BOOL)picView  picView2:(BOOL)picView2 picView3:(BOOL)picView3
{
    if(picView==NO &&picView2==NO&picView3==NO)
    {
        
    }
    else if(picView==NO &&picView2==NO&picView3==YES)
    {
    }
    else if(picView==NO &&picView2==YES&picView3==NO)
    {
        [_picNewView3 setFrame:CGRectMake(0, 1032, [ScreenHelper SCREEN_WIDTH], 152)];
    }
    else if(picView==NO &&picView2==YES&picView3==YES)
    {
    }
    else if(picView==YES &&picView2==NO&picView3==NO)
    {
        [_picNewView2 setFrame:CGRectMake(0, 878, [ScreenHelper SCREEN_WIDTH], 152)];
        [_picNewView3 setFrame:CGRectMake(0, 1032, [ScreenHelper SCREEN_WIDTH], 152)];
    }
    else if(picView==YES &&picView2==NO&picView3==YES)
    {
        [_picNewView2 setFrame:CGRectMake(0, 878, [ScreenHelper SCREEN_WIDTH], 152)];
        
    }
    else if(picView==YES &&picView2==YES&picView3==NO)
    {
        [_picNewView3 setFrame:CGRectMake(0, 878, [ScreenHelper SCREEN_WIDTH], 152)];
        
    }
    else if(picView==YES &&picView2==YES&picView3==YES)
    {
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //  [self loadData];
}


-(void)tapScroll
{
    [self.twDesc resignFirstResponder];
    
    [self.view endEditing:YES];
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:0.5f animations:^{
        self.view.frame=frame;
    }];
    
    
    
    
}

- (void)initImagePicker
{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.allowsEditing = NO;
    _imagePickerController.delegate = self;
}
- (void)buildDisPlayImageUI
{
    DisPlayPicView = [[TJDisPlayPictureView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], 151)];
    DisPlayPicView.delegate = self;
    DisPlayPicView.typeStr=@"RH";
    [_view_usePic addSubview:DisPlayPicView];
    
    DisPlayPicView2 = [[TJDisPlayPictureView alloc] initWithFrame:CGRectMake(0, 151, [ScreenHelper SCREEN_WIDTH], 151)];
    DisPlayPicView2.delegate = self;
    DisPlayPicView2.typeStr=@"XL";
    [_view_usePic addSubview:DisPlayPicView2];
    
    
    DisPlayPicView3 = [[TJDisPlayPictureView alloc] initWithFrame:CGRectMake(0, 302, [ScreenHelper SCREEN_WIDTH],151)];
    DisPlayPicView3.delegate = self;
    DisPlayPicView3.typeStr=@"QT";
    [_view_usePic addSubview:DisPlayPicView3];
    
}
- (void)buildImageUI
{
    pictureView = [[TJPictureView alloc] initWithFrame:CGRectMake(0, 40, [ScreenHelper SCREEN_WIDTH],  120)];
    pictureView.delegate = self;
    pictureView.typeStr=@"1";
    [_picNewView addSubview:pictureView];
    
    pictureView2 = [[TJPictureView alloc] initWithFrame:CGRectMake(0, 40, [ScreenHelper SCREEN_WIDTH], 120)];
    pictureView2.delegate = self;
    pictureView2.typeStr=@"2";
    [_picNewView2 addSubview:pictureView2];
    
    
    pictureView3 = [[TJPictureView alloc] initWithFrame:CGRectMake(0, 40, [ScreenHelper SCREEN_WIDTH], 120)];
    pictureView3.delegate = self;
    pictureView3.typeStr=@"3";
    [_picNewView3 addSubview:pictureView3];
    
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
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    
      [choseview removeFromSuperview];
}
//撤销背景蒙板
-(void)hidThebgview{
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}

//- (void)clearImageUI
//{
//    pictureView.hidden = YES;
//    [pictureView removeFromSuperview];
//    pictureView = nil;
//}
-(void)openPicLibrary{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 9;
    //    if ([typeStr isEqualToString:@"1"]) {
    //
    //        elcPicker.maximumImagesCount = 9-self.imagDatas.count;
    //
    //
    //    }
    //    else if ([typeStr isEqualToString:@"2"])
    //    {
    //
    //        elcPicker.maximumImagesCount = 9-self.imagDatas2.count;
    //
    //
    //    }
    //    else
    //    {
    //
    //        elcPicker.maximumImagesCount = 9-self.imagDatas3.count;
    //    }
    //
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods
-(void)getImaWithDic
{
    for (NSDictionary *dict in dictIma) {
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *tempImg=[ImageHelper hotLargImagWithImage:image] ;
        if ([typeStr isEqualToString:@"1"]) {
            
            if (![self.imagDatas containsObject:tempImg]) {
                
                [self.imagDatas addObject:tempImg];
                
            }
        }
        else if ([typeStr isEqualToString:@"2"])
        {
            
            if (![self.imagDatas2 containsObject:tempImg]) {
                
                [self.imagDatas2 addObject:tempImg];
                
            }
            
        }
        else
        {
            
            if (![self.imagDatas3 containsObject:tempImg]) {
                
                [self.imagDatas3 addObject:tempImg];
                
            }
        }
        
    }
    [self performSelectorOnMainThread:@selector(mainWork) withObject:nil waitUntilDone:NO];
    
    
}
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    dictIma=info;
    [self dismissViewControllerAnimated:YES completion:nil];
    [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [self performSelectorInBackground:@selector(getImaWithDic) withObject:nil];
    
    
}
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if ([typeStr isEqualToString:@"1"]) {
        self.editedImage= [ImageHelper hotZipAndStoreTheChoosedImageWithController:picker AndInfo:info];
        
    }
    else if ([typeStr isEqualToString:@"2"])
    {
        self.editedImage2= [ImageHelper hotZipAndStoreTheChoosedImageWithController:picker AndInfo:info];
        
    }
    else
    {
        self.editedImage3= [ImageHelper hotZipAndStoreTheChoosedImageWithController:picker AndInfo:info];
        
        
    }
    
    [self performSelectorInBackground:@selector(getIma) withObject:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)getIma
{
    
    if ([typeStr isEqualToString:@"1"]) {
        
        if (![self.imagDatas containsObject:self.editedImage]) {
            
            [self.imagDatas addObject:self.editedImage];
            
        }
    }
    else if ([typeStr isEqualToString:@"2"])
    {
        if (![self.imagDatas2 containsObject:self.editedImage2]) {
            
            [self.imagDatas2 addObject:self.editedImage2];
            
        }
        
    }
    else
    {
        if (![self.imagDatas3 containsObject:self.editedImage3]) {
            
            [self.imagDatas3 addObject:self.editedImage3];
            
        }
    }
    
    
    [self performSelectorOnMainThread:@selector(mainWork) withObject:nil waitUntilDone:NO];
    
    
    
    
}
-(void)mainWork
{
    if ([typeStr isEqualToString:@"1"]) {
        [pictureView refresPictureView:self.imagDatas];
        
    }
    else if ([typeStr isEqualToString:@"2"])
    {
        [pictureView2 refresPictureView:self.imagDatas2];
    }
    else
    {
        [pictureView3 refresPictureView:self.imagDatas3];
    }
    
    [AlertHelper hideAllHUDsForView:self.view];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)removeImageView:(int)index andType:(NSString *)type
{
    typeStr=type;
    if (index==8000) {
        if ([type isEqualToString:@"1"]&&(self.imagDatas2.count>0||self.imagDatas3.count>0)) {
            [AlertHelper singleMBHUDShow:@"请将图片上传后，再选择添加" ForView:self.view AndDelayHid:2];
            
        }
        else if ([type isEqualToString:@"2"]&&(self.imagDatas.count>0||self.imagDatas3.count>0))
        {
            [AlertHelper singleMBHUDShow:@"请将图片上传后，再选择添加" ForView:self.view AndDelayHid:2];
            
        }
        else if ([type isEqualToString:@"3"]&&(self.imagDatas2.count>0||self.imagDatas.count>0))
        {
            [AlertHelper singleMBHUDShow:@"请将图片上传后，再选择添加" ForView:self.view AndDelayHid:2];
            
            
        }
        else
        {
            UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"选取图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从照片库中选择" otherButtonTitles:@"添加新照片", nil];
            sheet.delegate=self;
            sheet.tag=10000;
            [sheet showInView:self.view];
            
        }
        
    }
    else
    {
        if ([typeStr isEqualToString:@"1"]) {
            [pictureView refresPictureView:self.imagDatas];
        }
        else if ([typeStr isEqualToString:@"2"])
        {
            [pictureView2 refresPictureView:self.imagDatas2];
        }
        else
        {
            [pictureView3 refresPictureView:self.imagDatas3];
            
        }
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        
        [self openPicLibrary];
        
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

- (void)showImageView:(int)index andType:(NSString *)type
{
    
    UIImage *image;
    if ([type isEqualToString:@"1"]) {
        image=self.imagDatas[index];
    }
    else if ([type isEqualToString:@"2"])
    {
        image=self.imagDatas2[index];
    }
    else
    {
        image=self.imagDatas3[index];
    }
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:image OrImgUrl:nil];
    [self.view.window addSubview:view];
}
- (void)showDisPlayImageView:(NSString *)imaName andType:(NSString *) type
{
    NSString *imgurlstr=[HotRewWuWebAPI HotImgUrlPathWithUid:[UserPermission standartUserInfo].ID type:type pcName:imaName];
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:nil OrImgUrl:imgurlstr];
    [self.view.window addSubview:view];
    
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
    [self.view endEditing:YES];
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:0.5f animations:^{
        self.view.frame=frame;
    }];
    
}



- (void)DateOfTiXing:(NSString *)date{
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate=[dateFormatter dateFromString:date];
    
    
    NSString *title = @"您离任务结束时间还有30分钟";
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        // 设置通知的提醒时间
        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
        
        NSDate *date = [NSDate dateWithTimeInterval:-30*60 sinceDate:endDate];
        
        notification.fireDate = date;
        
        // 设置提醒的文字内容
        notification.alertBody   = @"您离任务结束时间还有30分钟";
        notification.alertAction = NSLocalizedString(title, nil);
        
        // 通知提示音 使用默认的
        notification.soundName= UILocalNotificationDefaultSoundName;
        
        // 设置应用程序右上角的提醒个数
        notification.applicationIconBadgeNumber++;
        
        // 设定通知的userInfo，用来标识该通知
        NSMutableDictionary *aUserInfo = [[NSMutableDictionary alloc] init];
        [aUserInfo setObject:self.ta_id forKey:@"ta_id"];
        notification.userInfo = aUserInfo;
        
        // ios8后，需要添加这个注册，才能得到授权
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            // 通知重复提示的单位，可以是天、周、月
            notification.repeatInterval = 0;
        } else {
            // 通知重复提示的单位，可以是天、周、月
            notification.repeatInterval = 0;
        }
        
        // 将通知添加到系统中
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        [AlertHelper singleMBHUDShow:@"任务提醒已设置" ForView:self.view AndDelayHid:1];
        
        //   }
    }
    // }
}
-(void)getPicRenWuDescribe1WithTag:(int)tagg andMeg:(NSString *)meg
{
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle: @"任务描述"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定",nil];
    theAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
    UITextField * text1 = [theAlert textFieldAtIndex:0];
    text1.text=meg;
    theAlert.tag=tagg;
    [theAlert show];
}
- (IBAction)picPress1:(id)sender {
    if(self.imagDatas.count>0)
    {
        [self  getPicRenWuDescribe1WithTag:10001 andMeg:descri1];
        
    }
    else
    {
        [AlertHelper singleMBHUDShow:@"请选择图片" ForView:self.view AndDelayHid:1];
    }
    
}
- (IBAction)picPress2:(id)sender {
    if(self.imagDatas2.count>0)
    {
        
        [self  getPicRenWuDescribe1WithTag:10002 andMeg:descri2];
    }
    else
    {
        [AlertHelper singleMBHUDShow:@"请选择图片" ForView:self.view AndDelayHid:1];
    }
    
    
}
- (IBAction)picPress3:(id)sender {
    if(self.imagDatas3.count>0)
    {
        [self  getPicRenWuDescribe1WithTag:10003 andMeg:descri3];
    }
    else
    {
        [AlertHelper singleMBHUDShow:@"请选择图片" ForView:self.view AndDelayHid:1];
    }
    
    
}


-(void)loadImageHotPicByUID:(NSString *)userid AndType:(NSString *)type imaArr:(NSArray *)imaArr AndTkonid:(NSString *)tkonid Taop_Describe:(NSString *)Taop_Describe
{
  //  [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
    [self .view endEditing:YES];
    self.circleProgress.hidden=NO;
    [HotRewWuWebAPI requestHotPicByUID:userid AndType:type AndTkonid:tkonid Taop_Longitude:lo
     
                      Taop_Latitude:la Taop_Describe:Taop_Describe imaArr:imaArr success:^(NSArray * arr) {
                          [AlertHelper hideAllHUDsForView:self.view];
                          [self loadData];
                          if ([type isEqualToString:@"1"]) {
                              [self.imagDatas removeAllObjects];
                              [pictureView refresPictureView:self.imagDatas];
                              
                          }
                          else if ([type isEqualToString:@"2"])
                          {
                              [self.imagDatas2 removeAllObjects];
                              [pictureView2 refresPictureView:self.imagDatas2];
                              
                          }
                          else
                          {
                              [self.imagDatas3 removeAllObjects];
                              [pictureView3 refresPictureView:self.imagDatas3];
                              
                          }
                          
                          
                      } fail:^{
                          [AlertHelper hideAllHUDsForView:self.view];
                          [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
                          
                      } progress:^(float progress) {
                         NSLog(@"sss__ %f",progress);
                       

                          dispatch_async(dispatch_get_main_queue(), ^{
//                              view2 = [[RenWuHotImaUpdateView alloc]initWithFrame:CGRectMake(40, 200, [ScreenHelper SCREEN_WIDTH]-80,104)];
//                              [self.view addSubview:view2];
//                              while (progress < 1.0f) {
//                                  view2.progress=progress;
//                                  [view2 refresh];
//                                  
//                                  
//                                  
//                              }
//                              if (progress==1.0f) {
//                                  [view2 removeFromSuperview];
//                              }
                          self.circleProgress.percent = progress;
                          self.circleProgress.centerLabel.text = [NSString stringWithFormat:@"%.02f%%", self.circleProgress.percent*100];
                          
                          if(self.circleProgress.percent == 1.0f)
                          {
                                 self.circleProgress.hidden=YES;
                            //  [self.timer invalidate];
                          }

                          
//                          
//                              SDPieLoopProgressView *loop = [SDPieLoopProgressView progressView];
//                              
//                              loop.frame =  CGRectMake(([ScreenHelper SCREEN_WIDTH]-80)/2,([ScreenHelper SCREEN_HEIGHT]-80)/2 , 80, 80);
//                              
//                              loop.progress =progress;
                          
                     });
                          
                      } ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    [SDWebImageManager.sharedManager.imageCache clearMemory];
    [SDWebImageManager.sharedManager.imageCache clearDisk];
    
    
}
- (IBAction)subPress:(id)sender {
    
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle: @"任务描述"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定",nil];
    theAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
    theAlert.tag=1000;
    [theAlert show];
    
}
- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *pingyuStr=@"";
    if (theAlert.alertViewStyle == UIAlertViewStylePlainTextInput) {
        pingyuStr = [theAlert textFieldAtIndex:0].text;
    }
    if ([@"确定" isEqualToString:[theAlert buttonTitleAtIndex:buttonIndex]]) {
        
        if (theAlert.tag==1000) {
            
            [self.imagDatas removeAllObjects];
            [self.imagDatas2 removeAllObjects];
            [self.imagDatas3 removeAllObjects];
            
            
            [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
            [HotRewWuWebAPI requestHotDiscriptionByUID:[UserPermission standartUserInfo].ID AndTodescription:pingyuStr AndTAID:renWuId success:^(NSArray * arr) {
                
                if ([[arr[0]objectForKey:@"bool"]intValue]==1) {
                    [HotRewWuWebAPI  requestFinishHotTaop_Id:renWuId AndTaop_Taid:self.ta_id success:^(NSArray *  arr) {
                        [AlertHelper hideAllHUDsForView:self.view];
                        
                        if ([[arr[0]objectForKey:@"bool"]intValue]==1) {
                            
                            if (![model.Ta_IsEvaluate isEqualToString:@"1"]) {
                   
                            [self showThebgview];
         
                            choseview =[[UserSatisfiyView alloc] initWithFrame:CGRectMake(0,100, self.view.frame.size.width, 230) ];
                            choseview.delegate=self;
                 
                            [self.view.window addSubview:choseview];

                            }
                            else
                            {
                            [AlertHelper singleMBHUDShow:@"任务已完成" ForView:self.view AndDelayHid:1];
                            [self.navigationController popViewControllerAnimated:YES];
                            }
                            
                        }
                        else
                        {
                            [AlertHelper singleMBHUDShow:@"提交错误 ，稍后再试" ForView:self.view AndDelayHid:1];
                            
                        }
                        
                    } fail:^{
                        [AlertHelper hideAllHUDsForView:self.view];
                        
                        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
                        
                    }  ];
                }
                
            } fail:^{
                [AlertHelper hideAllHUDsForView:self.view];
                
                [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
                
            } ];
        }
        
        else  if  (theAlert.tag==10001) {
            
            [self loadImageHotPicByUID:[UserPermission standartUserInfo].ID AndType:@"1" imaArr:self.imagDatas AndTkonid:renWuId Taop_Describe:pingyuStr];
            
        }
        
        else  if  (theAlert.tag==10002) {
            
            [self loadImageHotPicByUID:[UserPermission standartUserInfo].ID AndType:@"2" imaArr:self.imagDatas2 AndTkonid:renWuId Taop_Describe:pingyuStr];
            
        }
        else
        {
            [self loadImageHotPicByUID:[UserPermission standartUserInfo].ID AndType:@"3" imaArr:self.imagDatas3 AndTkonid:renWuId Taop_Describe:pingyuStr];
            
        }
    }
    
}
-(void)selectUserSatisfiyWithtype:(NSString *)type andText:(NSString *)text
{
    [self hidThebgview];
    
    [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
    [HotRewWuWebAPI  requestTaskFinishHotTaop_Id:self.ta_id Ta_Satisfied:type Ta_SatisfiedDes:text success:^(NSArray *  arr) {
        [AlertHelper hideAllHUDsForView:self.view];
        
        if ([[arr[0]objectForKey:@"bool"]intValue]==1) {
  
            
            
            [AlertHelper singleMBHUDShow:@"任务已评价" ForView:self.view AndDelayHid:1];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            [AlertHelper singleMBHUDShow:@"提交错误 ，稍后再试" ForView:self.view AndDelayHid:1];
            
        }
        
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
        
    }  ];


}
- (IBAction)savePress:(id)sender {
    
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
