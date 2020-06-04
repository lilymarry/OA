#import "AddShangBaoViewController.h"
#import "ImageHelper.h"
#import "LargeImageView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ShangBaoList.h"
#import  "ShangBaoWebAPI.h"
#import "UserPermission.h"
#import <MBProgressHUD.h>
#import "AlertHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import <BMapKit.h>
#import "TJPictureView.h"
#import "ScreenHelper.h"
#import "ELCAssetSelectionDelegate.h"
#import "ELCAssetPickerFilterDelegate.h"

#import "ELCImagePickerController.h"
@interface AddShangBaoViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UINavigationBarDelegate,TJPictureViewDelegate,ELCImagePickerControllerDelegate,UIActionSheetDelegate>
{
    NSURL *urlPlay;
    BOOL ischooseImg;
    AVAudioRecorder *recorder;
    NSString *soundDir;//声音跟目录
    NSString *sound;//声音完整目录
    int num;//声音编号
    BOOL displaySoundView;
    NSString *la;
    NSString *lo;
    TJPictureView *pictureView;
    NSArray *dictIma;
  }
@property (weak, nonatomic) IBOutlet UIButton *souDelBtn;
@property (weak, nonatomic) IBOutlet UIButton *picDelBtn;
@property (weak, nonatomic) IBOutlet UIView *priView;
@property (weak, nonatomic) IBOutlet UIButton *sumbitBtn;
@property (weak, nonatomic) IBOutlet UIView *backVIew;
@property (weak, nonatomic) IBOutlet UITextField *tittext;
@property (weak, nonatomic) IBOutlet UITextView *conttext;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labPriceSep;
@property (weak, nonatomic) IBOutlet UITextField *priceText;
@property (weak, nonatomic) IBOutlet UIImageView *scanImg;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UILabel *scanLab;
@property (weak, nonatomic) IBOutlet UILabel *scanLabSep;
@property (weak, nonatomic) IBOutlet UIButton *playSounBtn;
@property (weak, nonatomic) IBOutlet UILabel *soundLable;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *playLab;
@property (weak, nonatomic) IBOutlet UIView *soundView;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UIView *view_imagView;

@property (nonatomic, strong) NSMutableArray  *imagDatas;

@property (strong, nonatomic) AVAudioPlayer *avPlay;
@property (nonatomic, strong)UINavigationBar * navibar;
@property (strong, nonatomic)  UIImagePickerController  *imagePickerController;
@property (nonatomic, strong) UIImage         *editedImage;
@property (nonatomic)NSTimer * time;
@end

@implementation AddShangBaoViewController
- (IBAction)picDelBtnPress:(id)sender
{
    if (ischooseImg==NO)
    {}
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"是否取消图片" delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"是的", nil];
        alert.tag=1002;
        [alert show];
    }
}
- (IBAction)SouDelBtnPress:(id)sender
{
    if ([self.soundLable.text isEqualToString:@"请选择"])
    {}
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"是否取消音频" delegate:self cancelButtonTitle:@"不" otherButtonTitles:@"是的", nil];
        alert.tag=1001;
        [alert show];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"上报";
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
  
    
    ischooseImg=NO;
    _soundView.hidden =YES;
    _backVIew.alpha=0;
    displaySoundView=NO;
    soundDir =[[NSString alloc]init];
    [self selectBiaoDan];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLargeImage:)];
    [_scanImg addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGestureBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
    tapGesture.numberOfTapsRequired=1;
    [_backVIew addGestureRecognizer:tapGestureBack];
    
    num=0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getsoundName:) name:@"soundName" object:nil];
    [self.view addSubview:self.soundView];
    
     self.picDelBtn.hidden=YES;
     self.souDelBtn.hidden=YES;
     [self getlocation];
    _imagDatas=[NSMutableArray array];
    [self initImagePicker];
    
    [self buildImageUI];
    [pictureView refresPictureView:self.imagDatas];
    
  
}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==0)
//    {
//        
//        [self openPicLibrary];
//        
//    }
//    if (buttonIndex==1)
//    {
//        
//        [self chooseFromCamera];
//    }
//    if (buttonIndex==2)
//    {
//        ;
//    }
//}
-(void)openPicLibrary{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 9;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (void)initImagePicker
{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.allowsEditing = NO;
    _imagePickerController.delegate = self;
}
- (void)buildImageUI
{
    pictureView = [[TJPictureView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH],  60)];
    pictureView.delegate = self;
    pictureView.typeStr=@"1";
    [_view_imagView addSubview:pictureView];
    
    
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

- (IBAction)addPicBtnPress:(id)sender
{
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
    if (actionSheet.tag==10001)
    {
        if (buttonIndex==0)
        {
            [self performSegueWithIdentifier:@"sound" sender:nil];
        }
        if (buttonIndex==1)
        {
            [UIView beginAnimations:@"soundViewDisplay" context:nil];
            [UIView setAnimationDuration:0.5];
            _soundView.hidden=NO;
            _TimeLable.text =@"0";
            displaySoundView =YES;
            [UIView commitAnimations];
            
            [UIView beginAnimations:@"back" context:nil];
            [UIView setAnimationDuration:0.5];
            _backVIew.alpha=0.5;
            [UIView commitAnimations];
            [self audio];
        }
        if (buttonIndex==2)
        {
            ;
        }
    }
}
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    
    [UIView animateWithDuration:0.3 animations:^(){
        _backVIew.alpha=0.0;
        
    } completion:^(BOOL finished){
        _soundView.hidden =YES;
    }];
}
#pragma mark - 创建目录
-(NSString *)documentsPath
{
    soundDir = [NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(), @"record"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:soundDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:soundDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *str= [self generateTradeNO];
    sound=[NSString stringWithFormat:@"%@.wmv",str];
    NSString *s=[NSString stringWithFormat:@"%@/%@",soundDir,sound];
    return s;
}
//读取目录
-(NSString *)documentsSoundPath:(NSString *)str
{
    return [soundDir stringByAppendingPathComponent:str];
}
//随机生成nameID
- (NSString *)generateTradeNO
{
    NSDate *dates = [NSDate date];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddHH:mm-"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *loctime = [formatter stringFromDate:dates];
    num++;
    return [ NSString stringWithFormat:@"%@%d",loctime,num];
    
}
#pragma mark - 初始化录音
- (void)audio
{
    urlPlay = [NSURL fileURLWithPath:[self documentsPath]];
    NSError *error;
    //初始化
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        //7.0第一次运行会提示，是否允许使用麦克风
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        //AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if(session == nil)
           // NSLog(@"Error creating session: %@", [sessionError description]);
        {}
        else
            [session setActive:YES error:nil];
    }
    NSMutableDictionary * recordSettings = [NSMutableDictionary dictionaryWithCapacity:10];
    [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatMPEG4AAC] forKey: AVFormatIDKey];
    [recordSettings setObject:[NSNumber numberWithFloat:8000.0] forKey: AVSampleRateKey];
    [recordSettings setObject:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSettings setObject:[NSNumber numberWithBool:YES] forKey:AVLinearPCMIsBigEndianKey];
    [recordSettings setObject:[NSNumber numberWithBool:YES] forKey:AVLinearPCMIsFloatKey];
    //录音的质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    recorder = [[AVAudioRecorder alloc]initWithURL:urlPlay settings:recordSettings error:&error];
    if (error)
    {
        //NSLog(@"recorderError:%@", error);
    }
    //开启音量检测
    recorder.meteringEnabled = YES;
    
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


- (IBAction)addSoundBtnPress:(id)sender
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"选取声音" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从录音库中选择" otherButtonTitles:@"添加新录音", nil];
    sheet.delegate=self;
    sheet.tag=10001;
    [sheet showInView:self.view];
}
- (IBAction)changSonBtnStatePress:(id)sender
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayback error:&err];
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    NSString *str= [self  documentsSoundPath:self.soundLable.text];
    NSURL *  PlaySound=[NSURL URLWithString:str];
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:PlaySound error:nil];
    self.avPlay = player;
    [self.avPlay play];
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

- (IBAction)approve:(id)sender
{
    
  if (lo.length!=0 &&la.length!=0) {
        
        NSData *soundData=[NSData dataWithContentsOfFile:[self documentsSoundPath:_soundLable.text]];
        NSDictionary *dic=[ShangBaoList standartUserInfo].infoDic;
//        NSData  *_imgData;
//        if (ischooseImg) {
//            _imgData=[NSData data];;
//            
//            _imgData =UIImageJPEGRepresentation(self.scanImg.image, 0.5);
//        }
        [AlertHelper MBHUDShow:@"提交中" ForView:self.view AndDelayHid:30];
    //  NSLog(@"WWWW %@",self.imagDatas);
        [ShangBaoWebAPI approveMorePicShangBaoWithUSerID:[UserPermission standartUserInfo].ID
                                           flowId: dic[@"fpId"]
                                             ftyp:dic[@"typeId"]
                                           tittle:_tittext.text
                                             cont:_conttext.text
                                             pric:_priceText.text
                                              pic:self.imagDatas
                                              voi:soundData
                                             AndX:lo
                                             AndY:la
                                          success:^(NSArray *arr){
                                              
                                              [AlertHelper hideAllHUDsForView:self.view];
                                              if ([[arr[0]objectForKey:@"rzt"]isEqualToString:@"1"])
                                              {
                                                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"上报成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                  alert.tag=1000;
                                                  [alert show];
                                              }
                                              else if ([[arr[0]objectForKey:@"rzt"]isEqualToString:@"3"])
                                              {
                                                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"没有权限，请联系管理员" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                  [alert show];
                                              }
                                              else if ([[arr[0]objectForKey:@"rzt"]isEqualToString:@"0"])
                                              {
                                                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"上报失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                  [alert show];
                                              }
                                              else if ([[arr[0]objectForKey:@"rzt"]isEqualToString:@"2"])
                                              {
                                                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"数据不全，操作失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                  [alert show];
                                              }
                                              else
                                              {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"网络错误，稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                                  [alert show];
                                              }
                                          } fail:^(){
                                              [AlertHelper hideAllHUDsForView:self.view];
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"网络错误，稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                              
                                              [alert show];
                                              
                                          }];
  }
  else
  {
      
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"定位失败，请打开定位" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
      [alert show];
      
  }


}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag)
    {
        case 1000:
        {
            NSObject<CommonNotification> *tmpDele=self.refreshNotification;
            [tmpDele refreshingDataList];
            [self.navigationController popViewControllerAnimated: YES];
        }break;
        case 1001:
        {  if (buttonIndex==1)
            {
                self.soundLable.text=@"请选择";
                self.souDelBtn.hidden=YES;
            }
        }break;
        case 1002:
        { if (buttonIndex==1)
            {
                ischooseImg=NO;
                self.scanImg.image=[UIImage imageNamed:@"nopicture.png"];
                self.picDelBtn.hidden=YES;
            }
        }break;
    default:
        break;
    }
}
-(void)selectBiaoDan
{
    //音频版
    if ([[[ShangBaoList standartUserInfo].infoDic objectForKey:@"fmtp"]isEqualToString:@"fmpv"])
    {
        self.priView.hidden=YES;
        self.labPrice.hidden=YES;
        self.labPriceSep.hidden=YES;
        self.priceText.hidden=YES;
    }
    //基本
    if ([[[ShangBaoList standartUserInfo].infoDic objectForKey:@"fmtp"]isEqualToString:@"fmbas"])
    {
        self.priView.hidden=YES;
        self.labPrice.hidden=YES;
        self.labPriceSep.hidden=YES;
        self.priceText.hidden=YES;
        self.scanImg.hidden=YES;
        self.scanBtn.hidden=YES;
        self.scanLab.hidden=YES;
        self.scanLabSep.hidden=YES;
        self.playSounBtn.hidden=YES;
        self.soundLable.hidden=YES;
        self.playBtn.hidden=YES;
        self.playLab.hidden=YES;
        self.picDelBtn.hidden=YES;
        self.souDelBtn.hidden=YES;
        self.view_imagView.hidden=YES; 
        
    }
    //完全
    if (  [[[ShangBaoList standartUserInfo].infoDic objectForKey:@"fmtp"]isEqualToString:@"fmall"])
    {
        
    }
    
}
-(void)getsoundName:(NSNotification *)obj
{   self.soundLable.text=obj.object;
    self.souDelBtn.hidden=NO;
}
-(void)showLargeImage:(UITapGestureRecognizer*)gesture{
    if (ischooseImg) {
        LargeImageView *view = [[LargeImageView alloc] initLargeImage:self.scanImg.image OrImgUrl:nil];
        [self.view.window addSubview:view];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选取图片" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];}
}
#pragma 文本编辑的代码
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
#pragma 录音方面的代码
-(BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                }
                else {
                    bCanRecord = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:nil
                                                    message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
                                                   delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil] show];
                    });
                }
            }];
        }
    }
    
    return bCanRecord;
}
- (void)startChangeView
{
    _TimeLable.text = @"0";
    if ([self canRecord])
    {
        //创建录音文件，准备录音
        if ([recorder prepareToRecord])
        {
            //开始
            [recorder record];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
            [[AVAudioSession sharedInstance] setActive: YES error: nil];
            NSError *error;
            BOOL success = [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
            if(!success)
            {
               // NSLog(@"error doing outputaudioportoverride - %@", [error localizedDescription]);
            }
            if (_time) {
                [_time invalidate];
            }
            _time = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(handTimer:) userInfo:nil repeats:YES];
        }
    }
}
- (void)handTimer:(NSTimer *)timer
{
    float time = [_TimeLable.text floatValue];
    time += .2;
    _TimeLable.text =[NSString stringWithFormat:@"%g",time];
    
}
- (void)endChangeView
{
    double cTime = recorder.currentTime;
    if (cTime > 2) {//如果录制时间<2 不发送
        _soundLable.text=sound;
         self.souDelBtn.hidden=NO;
    }else {
        //删除记录的文件
        [recorder deleteRecording];
        
        [[[UIAlertView alloc] initWithTitle:@"录音无效"
                                    message:@"录音时间太短(大于2秒)"
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
    }
    [recorder stop];
    [_time invalidate];
    _soundView.hidden=YES;
    _backVIew.alpha=0.0;
   
}

@end
