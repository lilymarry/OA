#import "ZhiJianViewController.h"
#import "ScreenHelper.h"
#import "JinXiaoCunWebAPI.h"
#import  "SelectPIckView.h"
#import "UserPermission.h"
#import "AlertHelper.h"
#import "TJPictureView.h"
#import "ScreenHelper.h"
#import "ELCAssetSelectionDelegate.h"
#import "ELCAssetPickerFilterDelegate.h"
#import "ELCImagePickerController.h"
#import "LargeImageView.h"
#import "ImageHelper.h"
@interface ZhiJianViewController ()<okButtonDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TJPictureViewDelegate,ELCImagePickerControllerDelegate>
{
   
    BOOL isEdit;
    NSMutableArray *hwlvArr;//等级
    //NSMutableArray *bdArr;//详情
    SelectPIckView *select;
    
    CGRect beiZhuFrame;
    
    TJPictureView *pictureView;
    NSArray *dictIma;
    NSString * hwlvStr;
}
@property (weak, nonatomic) IBOutlet UILabel *lab_bdnum;
@property (weak, nonatomic) IBOutlet UILabel *lab_carNum;
@property (weak, nonatomic) IBOutlet UITextField *tf_zaWuWeight;
@property (weak, nonatomic) IBOutlet UITextField *tf_zazhiWeight;
@property (weak, nonatomic) IBOutlet UITextField *tf_zaPapperweiht;
@property (weak, nonatomic) IBOutlet UITextField *tf_jinZhongWeight;
@property (weak, nonatomic) IBOutlet UITextField *tf_maoWeight;
@property (weak, nonatomic) IBOutlet UITextField *tf_zaWuWeightBi;
@property (weak, nonatomic) IBOutlet UITextField *tf_zazhiWeightBi;
@property (weak, nonatomic) IBOutlet UITextField *tf_zaPapperweihtBi;
@property (weak, nonatomic) IBOutlet UITextField *tf_dengji;
@property (weak, nonatomic) IBOutlet UITextField *tf_kg;
@property (weak, nonatomic) IBOutlet UITextField *tf_baifenbi;
@property (weak, nonatomic) IBOutlet UITextField *tf_shuifen;
@property (weak, nonatomic) IBOutlet UITextField *tf_num;
@property (weak, nonatomic) IBOutlet UITextField *tf_Person;
@property (weak, nonatomic) IBOutlet UITextView *tv_beizhu;
@property (weak, nonatomic) IBOutlet UIView *view_beizhu;
@property (nonatomic, strong) NSMutableArray  *imagDatas;
@property (strong, nonatomic)  UIImagePickerController  *imagePickerController;
@property (nonatomic, strong) UIImage         *editedImage;
@property (weak, nonatomic) IBOutlet UIView *view_imagView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ZhiJianViewController
- (NSString *)jiSuanPress:(NSString *)num1 andNum:(NSString *)num2
{
    double rel=(double )[num1 doubleValue]/[num2 doubleValue];
    rel=rel*100;
    NSString *relt=[NSString stringWithFormat:@"%0.3f",rel];
    return relt;
    
}
- (IBAction)SHCaozuoBtnPress:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"选取操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"发布" otherButtonTitles:@"废弃", nil];
    sheet.delegate=self;
    sheet.tag=10001;
 
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
          
            [self faBuPress];
        }
        if (buttonIndex==1)
        {
       
            [self feiqiBtnPress];
        }
        if (buttonIndex==2)
        {
            ;
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


- (void)feiqiBtnPress
{
//    NSString *dengji=self.tf_dengji.text;
//    if ([dengji isEqualToString:@"自动"])
//    {
//        dengji=@"";
//    }
//
//     NSString *str=[self selectDengji:self.tf_dengji.text] ;
     [AlertHelper singleMBHUDShow:@"提交中..." ForView:self.view];
    [JinXiaoCunWebAPI sendResultFeiqiWithUserID:[UserPermission standartUserInfo].ID bdid:_model.bdid hwlvnm:self.tf_dengji.text hwlv:hwlvStr zawu:_tf_zaWuWeightBi.text zazhi3:_tf_zaPapperweihtBi.text zazhe4:_tf_zazhiWeightBi.text shuifen:_tf_shuifen.text koukg:_tf_kg.text koupct:_tf_baifenbi.text jianshu:_tf_num.text beizhu:_tv_beizhu.text success:^(NSArray *arr){
         [AlertHelper hidMBHUDFromView:self.view];
        int result=[[arr[0]objectForKey:@"bool"] intValue];
        if (result==1)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"提交错误，稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
    
    }];


}
-(NSString *)selectDengji:(NSString *)dengji
{
    if ([dengji isEqualToString:@"A级"])
    {
        return @"1";
    }
   else if ([dengji isEqualToString:@"B级"])
    {
        return @"2";
    }
   else if ([dengji isEqualToString:@"C级"])
   {
       return @"3";
   }
   else if ([dengji isEqualToString:@"D级"])
   {
       return @"4";
   }
    else
    {
      return @"0";
    }
}
- (void)faBuPress
{
//    NSString *dengji=self.tf_dengji.text;
//    if ([dengji isEqualToString:@"自动"])
//    {
//        dengji=@"";
//    }
//
//
//     NSString *str=[self selectDengji:self.tf_dengji.text] ;
    
     [AlertHelper singleMBHUDShow:@"提交中..." ForView:self.view];
    
    [JinXiaoCunWebAPI sendResultjyzjWithUserID:[UserPermission standartUserInfo].ID bdtyp:@"2" bdid:_model.bdid hwlvnm:self.tf_dengji.text hwlv: hwlvStr zawu:_tf_zaWuWeightBi.text zazhi3:_tf_zaPapperweihtBi.text zazhe4:_tf_zazhiWeightBi.text shuifen:_tf_shuifen.text maokg:_tf_maoWeight.text jingkg:_tf_jinZhongWeight.text zawukg:_tf_zaWuWeight.text zhazhi3kg:_tf_zaPapperweiht.text zhazhi4kg:_tf_zazhiWeight.text koukg:_tf_kg.text koupct:_tf_baifenbi.text jianshu:_tf_num.text  images:self.imagDatas success:^(NSArray *arr){
         [AlertHelper hidMBHUDFromView:self.view];
         int result=[[arr[0]objectForKey:@"bool"] intValue];
        if (result==1)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag=111;
            [alert show];
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"提交错误，稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
        }
    
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
    }];
    

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==111) {
        NSObject<CommonNotification> *tmpDele=self.refreshNotification;
        [tmpDele refreshingDataList];
    }
   
    [self.navigationController popViewControllerAnimated: YES];

}
-(void)viewWillAppear:(BOOL)animated
{
   
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScroll)];
    [self.scrollView addGestureRecognizer:tap];
    
    _scrollView.contentSize = CGSizeMake([ScreenHelper SCREEN_WIDTH],[ScreenHelper SCREEN_WIDTH]+300);
    beiZhuFrame=_view_beizhu.frame;
    _lab_bdnum.text=_bdnum;
    _lab_carNum.text=_carNum;
  
    hwlvStr=@"";
    _imagDatas=[NSMutableArray array];
    
    [self initImagePicker];
    
    [self buildImageUI];
    [pictureView refresPictureView:self.imagDatas];
    
    [ JinXiaoCunWebAPI getBangDanDataWithbdId:_model.bdid bdtyp:@"2" success:^(NSArray *arr){

        
     //   [bdArr removeAllObjects];
    //    [hwlvArr removeAllObjects];
      //  bdArr =[NSMutableArray arrayWithArray:[arr[0]objectForKey:@"bd"]];
        hwlvArr =[NSMutableArray arrayWithArray:[arr[0]objectForKey:@"hwlv"]];
      //  NSString *str=@"自动";
        NSMutableArray *data=[NSMutableArray array];
      //  [data addObject:str];

        for (int i=0; i<hwlvArr.count; i++)
        {   [data addObject:hwlvArr[i][@"djnm"]];
           
        }
        select=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
        select.dataArr=data;
        select.state=1;
        select.delegate=self;
        self.tf_dengji.inputView=select;
        
    } fail:^(){}];

    
 }
-(void)tapScroll
{
    
    
    [_tf_zaWuWeight resignFirstResponder];
    [_tf_zazhiWeight resignFirstResponder];
    [_tf_zaPapperweiht resignFirstResponder];
    [_tf_jinZhongWeight resignFirstResponder];
    [_tf_maoWeight resignFirstResponder];
    [_tf_zaWuWeightBi resignFirstResponder];
    [_tf_zazhiWeightBi resignFirstResponder];
    [_tf_zaPapperweihtBi resignFirstResponder];
    [_tf_dengji resignFirstResponder];
    [_tf_kg resignFirstResponder];
    [_tf_baifenbi resignFirstResponder];
    [_tf_shuifen resignFirstResponder];
    [_tf_num resignFirstResponder];
    [_tf_Person resignFirstResponder];
    [_tv_beizhu resignFirstResponder];

    
}
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    char X = [string UTF8String][0];
    
    if (X == '.') {
        //判断之前是否输入过'.'如果输入过，不让输入这个
        if ([textField.text rangeOfString:@"."].length == 1) {
            return NO;
        }
    }
  
    if (textField == _tf_zaWuWeight || textField == _tf_maoWeight||textField == _tf_zazhiWeight||textField == _tf_zaPapperweiht)
    {
        
        //第一步、去除空格、
        NSString * str1 = _tf_zaWuWeight.text;
        str1 = [str1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString * str2 = _tf_maoWeight.text;
        str2 = [str2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString * str3 = _tf_zazhiWeight.text;
        str3 = [str3 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString * str4 = _tf_zaPapperweiht.text;
        str4 = [str4 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //第二步、更新新输入的数值.
        if (textField == _tf_zaWuWeight) {
            NSMutableString * strs = [NSMutableString stringWithString:str1];
            [strs replaceCharactersInRange:range withString:string];
            str1 = strs;
        }
       else  if (textField == _tf_maoWeight) {
            NSMutableString * strs = [NSMutableString stringWithString:str2];
            [strs replaceCharactersInRange:range withString:string];
            str2 = strs;
        }
       else if (textField == _tf_zazhiWeight) {
            NSMutableString * strs = [NSMutableString stringWithString:str3];
            [strs replaceCharactersInRange:range withString:string];
            str3 = strs;
        }
       else if (textField == _tf_zaPapperweiht) {
            NSMutableString * strs = [NSMutableString stringWithString:str4];
            [strs replaceCharactersInRange:range withString:string];
            str4 = strs;
        }
       else{}
        if (str2.length==0||[str2 isEqualToString:@"0"])
        {
            _tf_zaWuWeightBi.text=@"0" ;
            _tf_zazhiWeightBi.text=@"0";
            _tf_zaPapperweihtBi.text=@"0";
        }
        else
        {
        
        _tf_zaWuWeightBi.text=[self jiSuanPress:str1 andNum:str2] ;
        _tf_zazhiWeightBi.text=[self jiSuanPress:str3 andNum:str2];
        _tf_zaPapperweihtBi.text=[self jiSuanPress:str4 andNum:str2];
        }
    }
    return YES;
}
-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
   
        _tf_dengji.text=row;
        [_tf_dengji resignFirstResponder];
    hwlvStr= hwlvArr[selectrow][@"djid"];

}

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField.tag>101)
//    {
//        [self displayKeyBoard];
//        isEdit=YES;
//    }
//
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [self hiddenKeyBoard];
//
//}
//-(void)displayKeyBoard
//{
//    CGRect frame=self.view.frame;
//    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//   if (!isEdit)
//    {
//        frame.origin.y-= window.frame.size.height==480?180:178;
//        [UIView animateWithDuration:0.5f animations:^{
//            self.view.frame=frame;
//        }];
//    }
//}
//-(void)hiddenKeyBoard
//{
//    CGRect frame=self.view.frame;
//    if (!isEdit) {
//        frame.origin.y=0;
//        [UIView animateWithDuration:0.5f animations:^{
//            self.view.frame=frame;
//        }];
//    }}
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//
//    CGRect frame=self.view.frame;
//
//    if (!isEdit)
//    {
//        frame.origin.y=-250;
//
//        [UIView animateWithDuration:0.5f animations:^{
//            self.view.frame=frame;
//        }];
//    }
//
//
//}
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    [self hiddenKeyBoard];
//
//}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    isEdit=NO;
//    [self.view endEditing:YES];
//    [self hiddenKeyBoard];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    // foucsTextField = textField;
    _scrollView.contentSize = CGSizeMake([ScreenHelper SCREEN_WIDTH],[ScreenHelper SCREEN_HEIGHT]+300 +216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:_scrollView];//把当前的textField的坐标映射到scrollview上
    if(_scrollView.contentOffset.y-pt.y+64<=0)//判断最上面不要去滚动
        [_scrollView setContentOffset:CGPointMake(0, pt.y-64) animated:YES];//华东
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _scrollView.contentSize = CGSizeMake([ScreenHelper SCREEN_WIDTH],[ScreenHelper SCREEN_HEIGHT]+300 +216);//原始滑动距离增加键盘高度
    CGPoint pt = [textView convertPoint:CGPointMake(0, 0) toView:_scrollView];//把当前的textField的坐标映射到scrollview上
    if(_scrollView.contentOffset.y-pt.y+64<=0)//判断最上面不要去滚动
        [_scrollView setContentOffset:CGPointMake(0, pt.y-64) animated:YES];//华东
    
    
}

@end
