//
//  RenWuHotUserCell.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/7.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "RenWuHotUserCell.h"
#import "RenWuDetailHotModel.h"
#import "CharacterHelper.h"
#import "ScreenHelper.h"
#import "TJDisPlayPictureView.h"
#import "LargeImageView.h"
#import "HotRewWuWebAPI.h"
#import "UserPermission.h"
#import "ShangBMapViewController.h"
#define cellheight 100
@interface RenWuHotUserCell()<TJPictureDisPlayViewDelegate>
{int heght;
    TJDisPlayPictureView *DisPlayPicView;
    TJDisPlayPictureView *DisPlayPicView2;
    TJDisPlayPictureView *DisPlayPicView3;
    NSString* uid;
}
@property (weak, nonatomic) IBOutlet UITextView *twDesc;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIView *imaView;
@property (weak, nonatomic) IBOutlet UIImageView *imaFlag;



@end

@implementation RenWuHotUserCell
- (void)buildDisPlayImageUI
{
    DisPlayPicView = [[TJDisPlayPictureView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], 151)];
    DisPlayPicView.delegate = self;
    DisPlayPicView.typeStr=@"RH";
    [_imaView addSubview:DisPlayPicView];
    
    DisPlayPicView2 = [[TJDisPlayPictureView alloc] initWithFrame:CGRectMake(0, 151, [ScreenHelper SCREEN_WIDTH],151)];
    DisPlayPicView2.delegate = self;
    DisPlayPicView2.typeStr=@"XL";
    [_imaView addSubview:DisPlayPicView2];
    
    
    DisPlayPicView3 = [[TJDisPlayPictureView alloc] initWithFrame:CGRectMake(0, 302, [ScreenHelper SCREEN_WIDTH],151)];
    DisPlayPicView3.delegate = self;
    DisPlayPicView3.typeStr=@"QT";
    [_imaView addSubview:DisPlayPicView3];
    
}

- (void)bindModel:(id)model
{
    if (!model) {
        return;
    }
    RenWuDetailHotModel *item = (RenWuDetailHotModel *)model;
    //  NSLog(@"%@",item.nickname);
       _twDesc.text=[CharacterHelper replacingTheBRToEnter:item.Taop_Description] ;
    _username.text=item.Taop_UserName;
    DisPlayPicView.time=item.Taop_ImgDate1;
    DisPlayPicView.la=item.Taop_Latitude1;
    DisPlayPicView.lo=item.Taop_Longitude1;
    
    DisPlayPicView2.time=item.Taop_ImgDate2;
    DisPlayPicView2.la=item.Taop_Latitude2;
    DisPlayPicView2.lo=item.Taop_Longitude2;
    
    DisPlayPicView3.time=item.Taop_ImgDate3;
    DisPlayPicView3.la=item.Taop_Latitude3;
    DisPlayPicView3.lo=item.Taop_Longitude3;
    
    uid=item.Taop_Userid;
    
    NSString *str1=item.Taop_Img1;
    if (str1.length>0) {
        NSArray *  imaArr=[NSMutableArray arrayWithArray:[str1 componentsSeparatedByString:@","]];
        [DisPlayPicView refresPictureView:imaArr withType:@"RH" andUsid:item.Taop_Userid andDecri:item.Taop_Describe1];
      
      //  _picNewView.hidden=YES;
        
    }
    NSString *str2=item.Taop_Img2;
    if (str2.length>0) {
        NSArray *  imaArr=[NSMutableArray arrayWithArray:[str2 componentsSeparatedByString:@","]];
        [DisPlayPicView2 refresPictureView:imaArr withType:@"XL" andUsid:item.Taop_Userid andDecri:item.Taop_Describe2];
          
        
    }
    NSString *str3=item.Taop_Img3;
    if (str3.length>0) {
        NSArray *  imaArr=[NSMutableArray arrayWithArray:[str3 componentsSeparatedByString:@","]];
        [DisPlayPicView3 refresPictureView:imaArr withType:@"QT" andUsid:item.Taop_Userid andDecri:item.Taop_Describe3];
        
    }
 
//      NSString *flagStr=@"unarchived.png";
//       if ([item.Taop_IsSee isEqual:@2]) {
//              //  cell.labDate.hidden=YES;
//                _imaFlag.hidden=YES;
//            }
//    //Taop_IsTimeout 1 超时 /1 没超时
//      else if ([item.Taop_Iscomplete isEqualToString:@"1"] && [item.Taop_IsTimeout isEqualToString:@"2"]  ){
//                flagStr=@"archived.png";
//            }else if ([item.Taop_IsTimeout isEqualToString:@"1"]){
//                flagStr=@"archiving.png";
//            }
//            _imaFlag.image=[UIImage imageNamed:flagStr];
   
    NSString *flagStr=@"unarchived.png";
      _imaFlag.hidden = NO;
    
    if ([item.Taop_Iscomplete isEqualToString:@"3"]) {
        flagStr=@"unarchived.png";
    }else if ([item.Taop_Iscomplete isEqualToString:@"2"]){
        flagStr=@"archiving.png";
    }else if ([item.Taop_Iscomplete isEqualToString:@"1"]){
     //   _imaFlag.hidden = YES;
        flagStr=@"archived.png";
    }
    
     _imaFlag.image=[UIImage imageNamed:flagStr];

}
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(void)showDisPlayImageView:(NSString *)imaName andType:(NSString *)type
{
    NSString *str= [HotRewWuWebAPI HotImgUrlPathWithUid:uid type:type pcName:imaName];
    LargeImageView *view1 = [[LargeImageView alloc] initLargeImage:nil OrImgUrl:str];
  //  [self.view.window addSubview:view];

   [[self viewController].view.window addSubview:view1];
}
-(void)getImag:(NSString *)lo andla:(NSString *)la
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]];
    /*
     ShangBaoMapViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"shangbaomap"];
     controller.x=self.x;
     controller.y=self.y;
     */
    ShangBMapViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"shangbMap"];
    controller.x=lo;
    controller.y=la;
    [[self viewController].navigationController pushViewController:controller animated:YES];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self buildDisPlayImageUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
