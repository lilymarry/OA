

#import "JinXiaoCunMenuTableController.h"
#import "MenuModel.h"
#import "JGCXListView.h"
#import "ScreenHelper.h"
@interface JinXiaoCunMenuTableController ()<selectButtonTagDelegate>
{
    NSMutableArray *arr;
}
@property (weak, nonatomic) IBOutlet UITableViewCell *BangDanCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *cangCunCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *jiageCell;
@end

@implementation JinXiaoCunMenuTableController
{
    UIView *bgView ; //遮罩层
    BOOL isChooseMode;
    JGCXListView *view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *menuData =[NSMutableArray new];
    MenuModel *m1= [[MenuModel alloc ] initWithNum:@"ylzj" AndName:@"原料质检" AndImageName:@"zhijian-412@3x.png" AndListImageName:@"zhijian-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"ZhiJian" AndStoryboardID:@"ZhiJian" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"ylrk" AndName:@"原料入库" AndImageName:@"yuanliaoruku-412@3x.png" AndListImageName:@"yuanliaoruku-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"RuKu" AndStoryboardID:@"RuKu" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"ylck" AndName:@"成品出库" AndImageName:@"chengpinchuku-412@3x.png" AndListImageName:@"chengpinchuku-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"ChuKu" AndStoryboardID:@"ChuKu" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"cccx" AndName:@"仓存查询" AndImageName:@"cangcun-412@3x.png" AndListImageName:@"cangcun-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"CangCun" AndStoryboardID:@"CangCun" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    
    
    
    m1= [[MenuModel alloc ] initWithNum:@"ssbd" AndName:@"实时磅单" AndImageName:@"shishi-412@3x.png" AndListImageName:@"shishi-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"BangDan" AndStoryboardID:@"BangDan" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"jgcx" AndName:@"价格查询" AndImageName:@"jiage-412@3x.png" AndListImageName:@"jiage-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"jiaGe" AndStoryboardID:@"Jiage" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"bjcx" AndName:@"报警" AndImageName:@"baojing-412@3x.png" AndListImageName:@"baojing-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"BaoJing" AndStoryboardID:@"baojing" AndparamsForController:nil ];
    
    [menuData addObject:m1];
    
    
    
    
    m1= [[MenuModel alloc ] initWithNum:@"sxt" AndName:@"监控视频" AndImageName:@"jiankongshipin-412@3x.png" AndListImageName:@"jiankongshipin-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"JianKong" AndStoryboardID:@"jiankong" AndparamsForController:nil];
    [menuData addObject:m1];
    

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoRuku:)];
    tapGesture.numberOfTapsRequired=1;
    [self.rukucell addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *jiageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectJiageLIst:)];
    jiageGesture.numberOfTapsRequired=1;
    [self.jiageCell addGestureRecognizer:jiageGesture];
   
    tapGesture=nil;
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoChuku:)];
    tapGesture.numberOfTapsRequired=1;
    [self.chukucell addGestureRecognizer:tapGesture];
    
    tapGesture=nil;
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotobaoJing:)];
    tapGesture.numberOfTapsRequired=1;
    [self.baojingCell addGestureRecognizer:tapGesture];
    
    tapGesture=nil;
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotojiankong:)];
    tapGesture.numberOfTapsRequired=1;
    [self.jianKongCell addGestureRecognizer:tapGesture];
    
    tapGesture=nil;
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotozhijian:)];
    tapGesture.numberOfTapsRequired=1;
    [self.zhijianCell addGestureRecognizer:tapGesture];
    
    tapGesture=nil;
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoBangDan:)];
    tapGesture.numberOfTapsRequired=1;
    [self.BangDanCell addGestureRecognizer:tapGesture];
    tapGesture=nil;
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoCangCun:)];
    tapGesture.numberOfTapsRequired=1;
    [self.cangCunCell addGestureRecognizer:tapGesture];
    
    
}
-(void)gotobaoJing:(UITapGestureRecognizer*)gesture{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"BaoJing" bundle:[NSBundle mainBundle]];
    UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"baojing"];
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)gotojiankong:(UITapGestureRecognizer*)gesture{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"JianKong" bundle:[NSBundle mainBundle]];
    UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"jiankong"];
    [self presentViewController:controller animated:YES completion:nil];
}


-(void)gotoRuku:(UITapGestureRecognizer*)gesture{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"RuKu" bundle:[NSBundle mainBundle]];
    UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"RuKu"];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)gotozhijian:(UITapGestureRecognizer*)gesture{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"ZhiJian" bundle:[NSBundle mainBundle]];
    UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"ZhiJian"];
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)gotoBangDan:(UITapGestureRecognizer*)gesture{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"BangDan" bundle:[NSBundle mainBundle]];
    UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"BangDan"];
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)gotoCangCun:(UITapGestureRecognizer*)gesture{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"CangCun" bundle:[NSBundle mainBundle]];
    UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"CangCun"];
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)selectJiageLIst:(UITapGestureRecognizer*)gesture{
  
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"jiaGe" bundle:[NSBundle mainBundle]];
    UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"Jiage"];
    [self presentViewController:controller animated:YES completion:nil];
    
//    if (!isChooseMode) {
//        [self  showThebgview];
//        view =[[JGCXListView alloc]  instanceJiageChaXun];
//        view.delegate=self;
//        [self.view.window addSubview:view];
//    }
}

-(void)gotoChuku:(UITapGestureRecognizer*)gesture{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"ChuKu" bundle:[NSBundle mainBundle]];
    UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"ChuKu"];
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)getButtonTag:(int)tagId
{
    switch (tagId) {
        case 1:{
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"JinXiaoCun" bundle:[NSBundle mainBundle]];
            UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"jia1"];
            [self.navigationController pushViewController:controller animated:YES ];
        }
            break;
        case 2:{
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"JinXiaoCun" bundle:[NSBundle mainBundle]];
            UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"jiag2"];
            [self.navigationController pushViewController:controller animated:YES ];
        }
            break;
        case 3:{
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"JinXiaoCun" bundle:[NSBundle mainBundle]];
            UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"jiage3"];
            [self.navigationController pushViewController:controller animated:YES ];
        }
            break;
        case 4:{
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"JinXiaoCun" bundle:[NSBundle mainBundle]];
            UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"jiage4"];
            [self.navigationController pushViewController:controller animated:YES ];
        }
            break;
        case 5:{
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"JinXiaoCun" bundle:[NSBundle mainBundle]];
            UITabBarController *controller = [story instantiateViewControllerWithIdentifier:@"jiage5"];
            [self.navigationController pushViewController:controller animated:YES ];
        }
            break;

        default:
            break;
    }
    [self hidThebgview];
    [view closingTheLittleMenu:nil];

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

- (IBAction)redirectToManScene:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
