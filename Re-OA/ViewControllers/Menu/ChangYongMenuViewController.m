
#import "ChangYongMenuViewController.h"
#import "MenuFrameView.h"
#import "MenuModel.h"
#import "ScreenHelper.h"
#import "FirstMenuChooseViewController.h"
#import "UserPermission.h"

#import "ShangBaoLiuTableViewController.h"
#import "RenWuWebAPI.h"
#import "UIView+Badge.h"
#import "ShenHeWebAPI.h"
#import "AlertHelper.h"
#import "SetViewController.h"
@interface ChangYongMenuViewController ()<FavoriteMenuDataSource,setViewDelegate>
{
    NSMutableArray *menuData;
    MenuFrameView *frameView;
    UIButton *renWuBtn;
    UIButton *shenHeBtn;
    //SetViewController  *_set;
    
    
    
}
@end

@implementation ChangYongMenuViewController

int wanggeCount=1;
int wanggeDivNum=0;
int wanggeDiffNum=0;
int renwuBadgeValue=0;
int shenheBadgeValue=0;


-(void)viewWillAppear:(BOOL)animated
{
    [RenWuWebAPI requestNumNotCompleteTaskWithUid:[UserPermission standartUserInfo].ID success:^(NSArray *num){
        renWuBtn.badge.badgeValue=[[num[0]objectForKey:@"count"] intValue];
        renwuBadgeValue=[[num[0]objectForKey:@"count"] intValue];
    } fail:^(){ [AlertHelper hideAllHUDsForView:self.view];
    }];
    
    [ShenHeWebAPI requestNumNotCompleteShenHeWithUid:[UserPermission standartUserInfo].ID  ftyp:@"" adstate:@"0" success:^(NSArray *num){
        shenHeBtn.badge.badgeValue=[[num[0]objectForKey:@"rzt"] intValue];
        shenheBadgeValue=[[num[0]objectForKey:@"rzt"] intValue];
    } fail:^(){
    }];
    


}
//首次加载
- (void)viewDidLoad {
    [super viewDidLoad];
   // _set=[SetViewController shareSingleController];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.title=[NSString stringWithFormat:@"欢迎 %@",[UserPermission standartUserInfo].name];
    
    menuData=[MenuModel menusOfChangYong];
    frameView=[[MenuFrameView alloc] initForIphoneScreen];
    frameView.MenuFrameViewDelegate=self;
    frameView.setViewDelegate=self;
    self.view=frameView;
    
    [self createWangGe];
    
  
        
   // [self startUploadLocation];

//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getTongZhiMsgShow:) name:@"rizhi" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRenwuMsgShow:) name:@"renwu" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getGongGaoMsgShow:) name:@"gongao" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getshenheMsgShow:) name:@"shenhe" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getshangbaoMsgShow:) name:@"shangbao" object:nil];
    
}
-(void)puchSetView:(id)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Set" bundle:[NSBundle mainBundle]];
     // UIStoryboard *story = [UIStoryboard storyboardWithName:@"SetView" bundle:[NSBundle mainBundle]];
    UIViewController *setController = [story instantiateViewControllerWithIdentifier:@"Set"];
    [self presentViewController:setController animated:YES completion:nil];
}
//-(void)getGongGaoMsgShow:(NSNotification *)objec
//{
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"gongGao" bundle:[NSBundle mainBundle]];
//    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"gongGao"];
//    
//    [self presentViewController:changyongController animated:YES completion:nil];
//}
//-(void)getshenheMsgShow:(NSNotification *)objec
//{
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"ShenHe" bundle:[NSBundle mainBundle]];
//    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"ShenHe"];
//    
//    [self presentViewController:changyongController animated:YES completion:nil];
//}
//-(void)getRenwuMsgShow:(NSNotification *)objec
//{
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"RenWu" bundle:[NSBundle mainBundle]];
//    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"RenWu"];
//    
//    [self presentViewController:changyongController animated:YES completion:nil];
//    
//}
//-(void)getTongZhiMsgShow:(NSNotification *)objec
//{
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"rizhi" bundle:[NSBundle mainBundle]];
//    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"rizhi"];
//    
//    [self presentViewController:changyongController animated:YES completion:nil];
//    
//}
//-(void)getshangbaoMsgShow:(NSNotification *)objec
//{
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]];
//    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"ShangBao"];
//    
//    [self presentViewController:changyongController animated:YES completion:nil];
//}
//
//#pragma mark
//-(void)startUploadLocation{
//    
//    self.locationTracker = [[LocationTracker alloc]init];
//    [self.locationTracker startLocationTracking];
//    NSTimeInterval time =  [[UserPermission standartUserInfo].time intValue];
//    self.locationUpdateTimer =
//    [NSTimer scheduledTimerWithTimeInterval:time
//                                     target:self
//                                   selector:@selector(updateLocation)
//                                   userInfo:nil
//                                    repeats:YES];
//}
//
//-(void)updateLocation{
//    [self.locationTracker updateLocationToServer];
//}
//-(void)endlocation
//{
//     NSLog(@"stop location");
//   // [self.locationUpdateTimer invalidate];
//    // self.locationUpdateTimer =nil;
//   // [self.locationTracker stopLocationTracking];
//    
//}
//设置完常用后，刷新主界面
-(void)refreshingTheFavoriteMenus
{
    menuData=[MenuModel menusOfChangYong];
    NSArray *menuArr=frameView.menuSV.subviews;
    for (UIControl *crt in menuArr) {
        [crt removeFromSuperview];
    }
    [self createWangGe];
}
//网格背景图
-(void)createWangGe
{
    //计算背景图数量
    wanggeDivNum= (int)menuData.count/9;
    wanggeDiffNum= menuData.count%9;
    
    if (wanggeDivNum==0)
    {
        wanggeCount=1;
    }else if (wanggeDiffNum==0)
    {
        wanggeCount= wanggeDivNum;
    }else if(wanggeDiffNum!=0)
    {
        wanggeCount=wanggeDivNum+1;
    }
    [frameView buildingBackgroundOfWangGe:wanggeCount];
}

//生成菜单项委托
-(void)menusFromFavoriteSetting
{
    float side=frameView.menuSV.frame.size.width/3.0;
    int y=0;
    
    if ( self.view.frame.size.height==812)
    {
        y=25;
    }

    for (int j =0; j<wanggeCount; j++) {    //每一页
        for (int i=j*9; i<menuData.count&&i<(j+1)*9; i++) {
            MenuModel *m= [menuData objectAtIndex:i];
            CGRect rect;
            
            if (i-(j*9)<3)   //第一行
            {
                rect = CGRectMake((i%3+3*j)*side, y, side, side);
            }else if (i-(j*9)<6) //第二行
            {
                rect = CGRectMake((i%3+3*j)*side, side+y, side, side);
            }//else if (i-(j*9)<9) //第三行
            else
            {
                rect = CGRectMake((i%3+3*j)*side, side*2+y, side, side);
            }
            
            UIButton *btn =[[UIButton alloc] initWithFrame:rect];
            [btn setBackgroundImage:[UIImage imageNamed:m.imageName] forState:UIControlStateNormal];
            [btn setTag:i+100];
            if (i==menuData.count-1)    //如果是最后一个加号按钮
            {
                [btn addTarget:self action:@selector(redirectSettingFavoriteController:) forControlEvents:UIControlEventTouchUpInside];
            }else
            {
                // [btn addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
                [btn addTarget:self action:@selector(redirectViewController:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            if ([m .num isEqualToString:@"rw"])
            {
                renWuBtn =btn;
                btn.badge.displayWhenZero=NO;
                btn.badge.placement=kBadgePlacementUpperRight;
                btn.badge.badgeValue= renwuBadgeValue;
            }
            if([m .num isEqualToString:@"sh"]){
                shenHeBtn= btn;
                btn.badge.displayWhenZero=NO;
                btn.badge.placement=kBadgePlacementUpperRight;
                btn.badge.badgeValue= shenheBadgeValue;
            }
            
            [frameView.menuSV addSubview:btn];
        }
    }
}

//去常用设置场景
-(void)redirectSettingFavoriteController:(id)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:@"FavoriteChooseViewController"];
    FirstMenuChooseViewController *firstController= (FirstMenuChooseViewController*)changyongController.childViewControllers[0];
    firstController.refreshMenudelegate=self;
    [self presentViewController:changyongController animated:YES completion:nil];
}



//不同菜单跳转不同的场景中
-(void)redirectViewController:(id)sender
{
    
    UIButton *btn=sender;
    MenuModel *m= [menuData objectAtIndex:btn.tag-100];
    
    [self checkMenuAccessForRedirectWithMenuModel:m];
}
-(void)checkMenuAccessForRedirectWithMenuModel:(MenuModel*)m
{
    
//    UIStoryboard *story = [UIStoryboard storyboardWithName:m.storyboardName bundle:[NSBundle mainBundle]];
//    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:m.storyboardID];
//    [self presentViewController:changyongController animated:YES completion:nil];
//    


    
    //@"cldw,cwsb,dk,gg,rssb,rw,rz,sb,scsb,sh,sjdw,xzsb,ywsb"
    NSString *menuKey= [UserPermission standartUserInfo].MenuRole;

    NSString *shangbaoKey= @"rssb,scsb,xzsb,ywsb,cwsb";
    NSDictionary *dict=@{@"rssb":@"2",@"scsb":@"5",@"xzsb":@"3",@"ywsb":@"4",@"cwsb":@"1"};
  //  NSString *formKey= @"jyhz,ywydd,skmx,thtj,lhtj,mrxdtj,ywymrdd";

    NSRange range = [menuKey rangeOfString:m.num];
    if ( range.location != NSNotFound)
    {
        NSRange range1 = [shangbaoKey rangeOfString:m.num];
        if (range1.location != NSNotFound) {

            int tag =[[dict valueForKey:m.num] intValue];

            ShangBaoLiuTableViewController *liu=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ShangBaoliutable"];
            liu.buttag=tag;
             liu.tittleStr=m.name;
            [self presentViewController:liu animated:YES completion:nil];

        }else{
            UIStoryboard *story = [UIStoryboard storyboardWithName:m.storyboardName bundle:[NSBundle mainBundle]];
            UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:m.storyboardID];
            [self presentViewController:changyongController animated:YES completion:nil];
        }
    }
    else if ([m.num isEqualToString:@"jsq"]||[m.num isEqualToString:@"jsqq"]||[m.num isEqualToString:@"formm"])
    {
        UIStoryboard *story = [UIStoryboard storyboardWithName:m.storyboardName bundle:[NSBundle mainBundle]];
        UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:m.storyboardID];
        [self presentViewController:changyongController animated:YES completion:nil];


    }

    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提醒"
                                                      message:@"您没有访问该模块的权限"
                                                     delegate:self
                                            cancelButtonTitle:@"知道了"
                                            otherButtonTitles: nil];
        [alert show];



    }
   
    
}

- (IBAction)SetBtnPress:(id)sender
{
   //   UIStoryboard *story = [UIStoryboard storyboardWithName:@"SetView" bundle:[NSBundle mainBundle]];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Set" bundle:[NSBundle mainBundle]];
     UIViewController *setController = [story instantiateViewControllerWithIdentifier:@"Set"];
    [self presentViewController:setController animated:YES completion:nil];
}
@end




































