
#import "MenuModel.h"
#import "NSUserDefaultsHelper.h"
#import "URL.h"
@interface MenuModel ()

@end

@implementation MenuModel

-(MenuModel *)initWithNum:(NSString *)num
                  AndName:(NSString *)name
             AndImageName:(NSString *)imageName
         AndListImageName:(NSString *)listImageName
           AndIsChangYong:(BOOL)isChangYong
               AndNibName:(NSString *)nibName
        AndStoryboardName:(NSString*)storyboardName
          AndStoryboardID:(NSString*)storyboardID
   AndparamsForController:(NSDictionary*)param

{
    self = [super init];
    if (self) {
        self.num=num;
        self.name=name;
        self.imageName=imageName;
        self.listImageName=listImageName;
        self.nibName=nibName;
        self.isChangYong=isChangYong;
        self.storyboardName=storyboardName;
        self.storyboardID=storyboardID;
        self.paramsForController=param;
        
        
    }
    return self;
}

+(NSMutableArray *)menusOfQuanBu
{
    
    NSMutableArray *menuData =[NSMutableArray new];
    
    //",,,,gg_fb,,,rw_fb,rw_qb,,,,,,,";
    MenuModel *m= [[MenuModel alloc ] initWithNum:@"dk" AndName:@"打卡" AndImageName:@"daka-412@3x.png" AndListImageName:@"qiandao-150@3x.png" AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"Orther" AndStoryboardID:@"DaKa" AndparamsForController:nil ];
    [menuData addObject:m];
    m= [[MenuModel alloc ] initWithNum:@"sjdw" AndName:@"手机定位" AndImageName:@"shoujidingwei-412@3x.png" AndListImageName:@"shoujidingwei-150@3x.png"  AndIsChangYong:NO  AndNibName:@"" AndStoryboardName:@"PhLocation" AndStoryboardID:@"ph" AndparamsForController:nil ];
    [menuData addObject:m];
    m= [[MenuModel alloc ] initWithNum:@"sh" AndName:@"审核" AndImageName:@"shenhe-412@3x.png"  AndListImageName:@"shenhe-150@3x.png"  AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"ShenHe" AndStoryboardID:@"ShenHe" AndparamsForController:nil ];
    [menuData addObject:m];
    
    //------------------------------------------------------------------------------------------------
    m= [[MenuModel alloc ] initWithNum:@"sb" AndName:@"上报" AndImageName:@"shangbao-412@3x.png"  AndListImageName:@"shangbao-150@3x.png"  AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"ShangBao" AndStoryboardID:@"ShangBao" AndparamsForController:nil ];
    m.childMenu=[NSMutableArray new];
    [menuData addObject:m];
    
 #pragma ------new 上报列表 通鑫达
//    MenuModel *m1= [[MenuModel alloc ] initWithNum:@"cwsb" AndName:@"费用报销" AndImageName:@"baoxiao1.png" AndListImageName:@"baoxiao_1.png" AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
//    
//    m1= [[MenuModel alloc ] initWithNum:@"rssb" AndName:@"财务上报" AndImageName:@"caiwu.png" AndListImageName:@"caiwu_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
//    
//    m1= [[MenuModel alloc ] initWithNum:@"scsb" AndName:@"费用申请" AndImageName:@"shenqing.png"  AndListImageName:@"shenqing_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
//    
//    m1= [[MenuModel alloc ] initWithNum:@"xzsb" AndName:@"行政上报" AndImageName:@"xingzheng.png" AndListImageName:@"xingzheng_1.png"    AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
//    
//    m1= [[MenuModel alloc ] initWithNum:@"ywsb" AndName:@"业务上报" AndImageName:@"yewu.png"  AndListImageName:@"yewu_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
    
#pragma ------old 上报列表
    MenuModel *m1= [[MenuModel alloc ] initWithNum:@"cwsb" AndName:@"财务上报" AndImageName:@"caiwu.png" AndListImageName:@"caiwu_1.png" AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
    [m.childMenu addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"rssb" AndName:@"人事上报" AndImageName:@"renshi.png" AndListImageName:@"renshi_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
    [m.childMenu addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"scsb" AndName:@"生产上报" AndImageName:@"shengchan.png"  AndListImageName:@"shengchan_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
    [m.childMenu addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"xzsb" AndName:@"行政上报" AndImageName:@"xingzheng.png" AndListImageName:@"xingzheng_1.png"    AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
    [m.childMenu addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"ywsb" AndName:@"业务上报" AndImageName:@"yewu.png"  AndListImageName:@"yewu_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
    [m.childMenu addObject:m1];
    
     //------------------------------------------------------------------------------------------------
    
    m= [[MenuModel alloc ] initWithNum:@"gg" AndName:@"公告" AndImageName:@"gonggao-412@3x.png"  AndListImageName:@"gonggao-150@3x.png"  AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"gongGao" AndStoryboardID:@"gongGao" AndparamsForController:nil ];
    [menuData addObject:m];
    m= [[MenuModel alloc ] initWithNum:@"cldw" AndName:@"车辆定位" AndImageName:@"cheliangdingwei-412@3x.png"     AndListImageName:@"qichedingwei-150@3x.png" AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"CarLocation" AndStoryboardID:@"car" AndparamsForController:nil ];
    [menuData addObject:m];
    
    m= [[MenuModel alloc ] initWithNum:@"rw" AndName:@"工作任务" AndImageName:@"gongzuorenwu-412@3x.png"  AndListImageName:@"gongzuorenwu-150@3x.png"  AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"RenWu" AndStoryboardID:@"RenWu" AndparamsForController:nil ];
    [menuData addObject:m];
    
//  //热力任务
 //  m= [[MenuModel alloc ] initWithNum:@"rw" AndName:@"工作任务" AndImageName:@"gongzuorenwu-412@3x.png"  AndListImageName:@"gongzuorenwu-150@3x.png"  AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"RenWuHot" AndStoryboardID:@"RenWuHot" AndparamsForController:nil ];
//   [menuData addObject:m];
    
    
    m= [[MenuModel alloc ] initWithNum:@"rz" AndName:@"工作日志" AndImageName:@"gongzuorizhi-412@3x.png" AndListImageName:@"gongzuorizhi-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"rizhi" AndStoryboardID:@"rizhi" AndparamsForController:nil ];
    [menuData addObject:m];
    
    
     //------------------------------------------------------------------------------------------------

//    m= [[MenuModel alloc ] initWithNum:@"jxc" AndName:@"进销存" AndImageName:@"jinxiaocun-412@3x.png"  AndListImageName:@"jinxiaocun-150@3x.png"  AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"JinXiaoCun" AndStoryboardID:@"jinxiaocun" AndparamsForController:nil ];
//    m.childMenu=[NSMutableArray new];
//    [menuData addObject:m];
//
//    m1= [[MenuModel alloc ] initWithNum:@"ylzj" AndName:@"原料质检" AndImageName:@"zhijian-412@3x.png" AndListImageName:@"zhijian-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"ZhiJian" AndStoryboardID:@"ZhiJian" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
//
//    m1= [[MenuModel alloc ] initWithNum:@"ylrk" AndName:@"原料入库" AndImageName:@"yuanliaoruku-412@3x.png" AndListImageName:@"yuanliaoruku-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"RuKu" AndStoryboardID:@"RuKu" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
//
//    m1= [[MenuModel alloc ] initWithNum:@"ylck" AndName:@"成品出库" AndImageName:@"chengpinchuku-412@3x.png" AndListImageName:@"chengpinchuku-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"ChuKu" AndStoryboardID:@"ChuKu" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
//
//    m1= [[MenuModel alloc ] initWithNum:@"cccx" AndName:@"仓存查询" AndImageName:@"cangcun-412@3x.png" AndListImageName:@"cangcun-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"CangCun" AndStoryboardID:@"CangCun" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
   

    
  
//     m1= [[MenuModel alloc ] initWithNum:@"ssbd" AndName:@"实时磅单" AndImageName:@"shishi-412@3x.png" AndListImageName:@"shishi-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"BangDan" AndStoryboardID:@"BangDan" AndparamsForController:nil ];
//     [m.childMenu addObject:m1];

//    m1= [[MenuModel alloc ] initWithNum:@"jgcx" AndName:@"价格查询" AndImageName:@"jiage-412@3x.png" AndListImageName:@"jiage-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"jiaGe" AndStoryboardID:@"Jiage" AndparamsForController:nil ];
//    [m.childMenu addObject:m1];
//
//     m1= [[MenuModel alloc ] initWithNum:@"bjcx" AndName:@"报警" AndImageName:@"baojing-412@3x.png" AndListImageName:@"baojing-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"BaoJing" AndStoryboardID:@"baojing" AndparamsForController:nil ];
//
//     [m.childMenu addObject:m1];
   
 

    
    m= [[MenuModel alloc ] initWithNum:@"sxt" AndName:@"监控视频" AndImageName:@"jiankongshipin-412@3x.png" AndListImageName:@"jiankongshipin-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"JianKong" AndStoryboardID:@"jiankong" AndparamsForController:nil];
   //   [m.childMenu addObject:m1];
     [menuData addObject:m];
   
    //------------------------------------------------------------------------------------------------

 
  m= [[MenuModel alloc ] initWithNum:@"jsq" AndName:@"计算器" AndImageName:@"jisuanqi-412@3x.png" AndListImageName:@"jisuanqi-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"ZhiBanJisuanqi" AndStoryboardID:@"zhizh" AndparamsForController:nil ];
        [menuData addObject:m];
    
    m= [[MenuModel alloc ] initWithNum:@"form" AndName:@"统计报表" AndImageName:@"baobiao.png" AndListImageName:@"baobiao1.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"ZhiBan" AndStoryboardID:@"ZhiBan" AndparamsForController:nil ];
    [menuData addObject:m];

    
//    m= [[MenuModel alloc ] initWithNum:@"jsqq" AndName:@"换热站记录" AndImageName:@"ic_main_hotyunxinglie.png" AndListImageName:@"ic_set_baobiaotongji.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"HotChang" AndStoryboardID:@"HotChang" AndparamsForController:nil ];
//    [menuData addObject:m];
//
//      //热力报表
//    m= [[MenuModel alloc ] initWithNum:@"form" AndName:@"统计报表" AndImageName:@"baobiao.png" AndListImageName:@"baobiao1.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"line" AndStoryboardID:@"line" AndparamsForController:nil ];
//    [menuData addObject:m];
    
    if (menuData.count>0) {
        return menuData;
    }
    
    return nil;
}


+(NSMutableArray *)menusOfChangYong
{
    NSMutableArray *menuData =[NSMutableArray new];
    NSMutableArray *menuData_t= [self menusOfQuanBu];
    NSArray *favorMenuIDsArr=[NSUserDefaultsHelper menuIDFromTheFavorite];
    
    if (favorMenuIDsArr&&favorMenuIDsArr.count) {
        for (NSString *menuID in favorMenuIDsArr) {
            for (MenuModel *m in menuData_t) {
                if ( [menuID isEqual: m.num]) {
                    m.isChangYong=YES;
                    [menuData addObject:m];
                }
                if (m.childMenu&&m.childMenu.count>0) {
                    for (MenuModel *m1 in m.childMenu) {
                        if ([menuID  isEqual: m1.num]) {
                            m1.isChangYong=YES;
                            [menuData addObject:m1];
                        }
                    }
                }
                
            }
        }
    }
    
    MenuModel *m= [[MenuModel alloc ] initWithNum:@"0" AndName:@"添加常用" AndImageName:@"tianjia-412@3x.png" AndListImageName:@""  AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
    [menuData addObject:m];
    if (menuData.count>0) {
        return menuData;
    }
    return nil;
}


+(NSMutableArray *)menuListOfFirstChoose
{
    NSMutableArray *menuData =[self menusOfQuanBu];
    
    NSArray *favorMenuIDsArr=[NSUserDefaultsHelper menuIDFromTheFavorite];
    
    if (favorMenuIDsArr&&favorMenuIDsArr.count) {
        for (NSString *menuID in favorMenuIDsArr) {
            for (MenuModel *m in menuData) {
                if ([menuID isEqual: m.num]) {
                    m.isChangYong=YES;
                }
                if (m.childMenu&&m.childMenu.count>0) {
                    for (MenuModel *m1 in m.childMenu) {
                        if ([menuID isEqual: m1.num]) {
                            m1.isChangYong=YES;
                        }
                    }
                }
            }
        }
    }
    
    if (menuData.count>0) {
        return menuData;
    }
    
    return nil;
    
}


+(NSMutableArray *)menuListOfSecondChooseForParentMenu:(MenuModel *)parentMenu
{
    return nil;
}


@end
