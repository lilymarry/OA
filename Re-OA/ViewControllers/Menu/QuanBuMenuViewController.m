  
#import "QuanBuMenuViewController.h"
#import "MenuFrameView.h"
#import "MenuModel.h"
#import "ScreenHelper.h"
#import "RenWuWebAPI.h"
#import "UserPermission.h"
#import "UIView+Badge.h"
#import "ShenHeWebAPI.h"

#import "AlertHelper.h"
@interface QuanBuMenuViewController ()<FavoriteMenuDataSource,setViewDelegate>
{
    NSMutableArray *menuData;
    MenuFrameView *frameView;
    int number;
    UIButton *renWuBtn;
    UIButton *shenHeBtn;
}
@end

@implementation QuanBuMenuViewController

int quanbuwanggeCount=1;
int quanbuwanggeDivNum=0;
int quanbuwanggeDiffNum=0;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    renWuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    shenHeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationItem.title=[NSString stringWithFormat:@"欢迎 %@",[UserPermission standartUserInfo].name];
  
    menuData=[MenuModel menusOfQuanBu];
    [self createWangGe];
    
    frameView=[[MenuFrameView alloc] initForIphoneScreen];
    frameView.MenuFrameViewDelegate=self;
    frameView.setViewDelegate=self;
    self.view=frameView;
     [self createWangGe];
    
    [self menusFromFavoriteSetting];
}
-(void)puchSetView:(id)sender
{
  //  UIStoryboard *story = [UIStoryboard storyboardWithName:@"SetView" bundle:[NSBundle mainBundle]];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Set" bundle:[NSBundle mainBundle]];
    UIViewController *setController = [story instantiateViewControllerWithIdentifier:@"Set"];
    [self presentViewController:setController animated:YES completion:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
   

    [RenWuWebAPI requestNumNotCompleteTaskWithUid:[UserPermission standartUserInfo].ID success:^(NSArray *num){
      
        renWuBtn.badge.badgeValue=[[num[0]objectForKey:@"count"] intValue];
      ;
        
    } fail:^(){
//        [AlertHelper hideAllHUDsForView:self.view];
       
    }];
    
    [ShenHeWebAPI requestNumNotCompleteShenHeWithUid:[UserPermission standartUserInfo].ID  ftyp:@"" adstate:@"0" success:^(NSArray *num){
     
        shenHeBtn.badge.badgeValue=[[num[0]objectForKey:@"rzt"] intValue];
        
    } fail:^(){
    
        
    }];
   
    
}
//网格背景图
-(void)createWangGe
{
    //计算背景图数量
    quanbuwanggeDivNum= (int)menuData.count/9;
    quanbuwanggeDiffNum= menuData.count%9;
    
    if (quanbuwanggeDivNum==0)
    {
        quanbuwanggeCount=1;
    }else if (quanbuwanggeDiffNum==0)
    {
        quanbuwanggeCount= quanbuwanggeDivNum;
    }else if(quanbuwanggeDiffNum!=0)
    {
        quanbuwanggeCount=quanbuwanggeDivNum+1;
    }
    
    [frameView buildingBackgroundOfWangGe:quanbuwanggeCount];
}

-(void)menusFromFavoriteSetting
{
    float side=frameView.menuSV.frame.size.width/3.0;
    int y=0;
  
    if ( self.view.frame.size.height==812)
    {
        y=25;
    }

    for (int j =0; j<quanbuwanggeCount; j++) {    //每一页
        for (int i=j*9; i<menuData.count&&i<(j+1)*9; i++) {
            MenuModel *m= [menuData objectAtIndex:i];
            CGRect rect;
            
            if (i-(j*9)<3)   //第一行
            {
                rect = CGRectMake((i%3+3*j)*side, y, side, side);
            }else if (i-(j*9)<6) //第二行
            {
                rect = CGRectMake((i%3+3*j)*side, side+y, side, side);
            }else
            {
                rect = CGRectMake((i%3+3*j)*side, side*2+y, side, side);
            }
            
            
            UIButton *btn =[[UIButton alloc] initWithFrame:rect];
            [btn setBackgroundImage:[UIImage imageNamed:m.imageName] forState:UIControlStateNormal];
            [btn setTag:i+100];
            [btn addTarget:self action:@selector(redirectViewController:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if (btn.tag==106)
            {
                renWuBtn= btn;
               

            }
            if (btn.tag==102)
            {
                shenHeBtn=btn;
            }

            [frameView.menuSV addSubview:btn];
            
        }
    }
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
  
 
    NSString *menuKey= [UserPermission standartUserInfo].MenuRole;
    NSRange range = [menuKey rangeOfString:m.num];
    if ( range.location != NSNotFound)
    {
        UIStoryboard *story = [UIStoryboard storyboardWithName:m.storyboardName bundle:[NSBundle mainBundle]];
        UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:m.storyboardID];
        [self presentViewController:changyongController animated:YES completion:nil];
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
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Set" bundle:[NSBundle mainBundle]];
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"SetView" bundle:[NSBundle mainBundle]];
    UIViewController *setController = [story instantiateViewControllerWithIdentifier:@"Set"];
    [self presentViewController:setController animated:YES completion:nil];
}

@end















