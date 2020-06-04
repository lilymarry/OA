#import "PhoneLocationViewController.h"
//#import <MapKit/MapKit.h>
#import "PersonalViewController.h"
#import "phoneLocationWebAPI.h"
#import "UserPermission.h"
#import "MyAnnotation.h"
#import "Employee.h"
#import "History.h"
//#import "ExchangeXYzuobiao.h"
#import "AlertHelper.h"
#import <BMapKit.h>
#define kBarH 50
#define kBarBtnCount 3
@interface PhoneLocationViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate>
{
  //  CLLocationManagerDelegate,
    History *_popView;
    BMKMapView *_mapView;
    UIButton *_allbtn;
    UIView *_toolBar;
    UIButton *_currentBtn;
    UIView *_currentPop;
    PersonalViewController *_perList;
    //MyAnnotation *_annotation;
    //NSMutableArray *_annoArr;
    
    BMKGeoCodeSearch* _geocodesearch;
}
@end

@implementation PhoneLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //_annoArr=[NSMutableArray array];
    [self addMapView];
    [self addMenuToolBar];
    CLLocationCoordinate2D dingweiZhongxin=CLLocationCoordinate2DMake([[UserPermission standartUserInfo].y doubleValue], [[UserPermission standartUserInfo].x doubleValue]);
    
    [self showMap:CLLocationCoordinate2DMake(dingweiZhongxin.latitude  ,dingweiZhongxin.longitude ) span:BMKCoordinateSpanMake(0.04, 0.04)];
    
    
}
-(void)addMapView
{
    _mapView=[[BMKMapView alloc]init];
    _mapView.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    _mapView.mapType=BMKMapTypeStandard;
    _mapView.rotateEnabled=YES;
    _mapView.delegate=self;
    [self.view addSubview:_mapView];
}
#pragma mark - mapView delegate
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    BMKAnnotationView * aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"aView"];
    if (aView == nil)
    {
        aView = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"aView"];
        
    }
    aView.annotation = annotation;
    aView.canShowCallout = YES;
     NSRange range1=[annotation.title rangeOfString: @"日期"];
    if (range1.location!=0 && range1.location!=NSNotFound) {
        aView.image =[UIImage imageNamed:@"ic_loc_2.png"];
    }else{
        NSRange range=[annotation.title rangeOfString: @"在线"];
        aView.image =(range.location!=0 && range.location!=NSNotFound)?[UIImage imageNamed:@"ic_loc.png"]:[UIImage imageNamed:@"ic_loc_1.png"];
    }
    aView.bounds=CGRectMake(0, 0, 20, 25);
    return aView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    BMKPointAnnotation *point= view.annotation;
    if (point.subtitle.length==0) {
        [[NSUserDefaults standardUserDefaults ]setObject:point.title forKey:@"POIname"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = point.coordinate;
        _geocodesearch =[[BMKGeoCodeSearch alloc]init];
        _geocodesearch.delegate=self;
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag)
        {
        }
        else
        {
            [AlertHelper singleMBHUDShow:@"地址解析失败 " ForView:self.view AndDelayHid:1.5];

        }
    }
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //NSLog(@"%@",result.address);
    MyAnnotation *ann=[[MyAnnotation alloc]initWithCoordinate:result.location title:[[NSUserDefaults standardUserDefaults]objectForKey:@"POIname"] subtitle:result.address  ];
        [_mapView addAnnotation:ann];
}

#pragma mark - 添加导航栏下面的工具条
-(void)addMenuToolBar
{
    _toolBar=[[UIView alloc]init];
    _toolBar.backgroundColor=[UIColor whiteColor];
    CGFloat y=64;
    if ( self.view.frame.size.height==812)
    {
        y=84;
    }
    _toolBar.frame=CGRectMake(0, y, self.view.frame.size.width, kBarH);
    [self.view addSubview:_toolBar];
    int index=0;
    _allbtn=[self createButton:@"全部" index:index++];
    [_allbtn addTarget:self action:@selector(mapWithAll:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *personal=[self createButton:@"个人" index:index++];
    [personal addTarget:self action:@selector(mapWithPer:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *history=[self createButton:@"历史" index:index++];
    [history addTarget:self action:@selector(mapWithHis:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)showMap:(CLLocationCoordinate2D )coordinate span:(BMKCoordinateSpan)span
{
    //地图显示范围
    BMKCoordinateRegion region;
    region.center=coordinate;
    region.span=span;
    [_mapView setRegion:region];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate=self;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate=nil;

  
}
-(void)delectBiaoZhu
{
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
}
#pragma mark - 四个按钮点击事件

-(void)mapWithAll:(UIButton *)sender
{
    [self delectBiaoZhu];
    [AlertHelper MBHUDShow:@"获取中" ForView:self.view AndDelayHid:30];
    
    
   [phoneLocationWebAPI getUserInMapWithTpe:@"all" uid:[UserPermission standartUserInfo].ID stime:@"" etime:@"" success:^(NSArray *locList)
     {  // [_mapView removeAnnotations:_annoArr];
         
         if (locList &&locList.count==0)
         {
             [AlertHelper hideAllHUDsForView:self.view];
             [AlertHelper singleMBHUDShow:@"无定位数据" ForView:self.view AndDelayHid:1.5];
             
             return ;
         }
      //    Employee *em1=[[Employee alloc]initWithDic:locList[0]];
         for (NSDictionary *dict in locList)
         {
             Employee *em=[[Employee alloc]initWithDic:dict];
            // CLGeocoder *geocoder=[[CLGeocoder alloc]init];
             CLLocationCoordinate2D loca2D = CLLocationCoordinate2DMake([em.latitude doubleValue], [em.longitude doubleValue]);
            // NSDictionary *baidu = BMKConvertBaiduCoorFrom(loca2D,BMK_COORDTYPE_GPS);
             //CLLocationCoordinate2D trans = BMKCoorDictionaryDecode(baidu);
            NSString *nameStateStr= [NSString stringWithFormat:@"%@%@,%@",em.userName,([@"1" isEqualToString: em.zt  ])?@"在线":@"离线",em.time];
             MyAnnotation *ann=[[MyAnnotation alloc]initWithCoordinate:loca2D title:nameStateStr subtitle:nil ];
             [_mapView addAnnotation:ann];
             
         }
      //   [self showMap:CLLocationCoordinate2DMake([em1.latitude doubleValue], [em1.longitude doubleValue]) span:BMKCoordinateSpanMake(0.2, 0.2)];
         [AlertHelper hideAllHUDsForView:self.view];

     } fail:^(){
         [AlertHelper hideAllHUDsForView:self.view];
         [AlertHelper singleMBHUDShow:@"网络请求失败" ForView:self.view AndDelayHid:1.5];
         return ;
     }];
    [self changeBtnSelected:sender popView:nil];
}



-(void)mapWithPer:(UIButton *)sender
{
    [self delectBiaoZhu];
    if (!_perList) {
        _perList=[[PersonalViewController alloc]init];
        [self becomeFirstResponder];
        CGFloat y=CGRectGetMaxY(_toolBar.frame);
        CGRect popFrame=CGRectMake(10, y, self.view.frame.size.width-20, self.view.frame.size.height-y-10);
        _perList.view.frame=popFrame;
    }
    __unsafe_unretained PhoneLocationViewController*mapVC=self;
    __unsafe_unretained PersonalViewController *per=_perList;
    __block PhoneLocationViewController *blockSelf = self;
    [_perList setSelectedBlock:^(NSString *name,NSString *uid)
     {
         [AlertHelper MBHUDShow:@"获取中" ForView:blockSelf.view AndDelayHid:30];
         [per.view removeFromSuperview];
         [phoneLocationWebAPI getUserInMapWithTpe:@"one" uid:uid stime:@"" etime:@"" success:^(NSArray *locList)
          {
            //  [mapVC->_mapView removeAnnotations:mapVC->_annoArr];
              if (locList.count==0)
              {
                  [AlertHelper hideAllHUDsForView:blockSelf.view];
                  [AlertHelper singleMBHUDShow:@"无定位数据" ForView:blockSelf.view AndDelayHid:1.5];
                  return ;
              }
               //  Employee *em1=[[Employee alloc]initWithDic:locList[0]];
             
             //   CLLocationCoordinate2D newdingweiZhongxin  = [ExchangeXYzuobiao zzTransGPS:dingweiZhongxin];
            //   [mapVC showMap:CLLocationCoordinate2DMake([em1.latitude doubleValue] , [em1.longitude doubleValue] ) span:BMKCoordinateSpanMake(0.01, 0.01)];;
           //   for (NSDictionary *dict in locList)
            //  {
                  Employee *em=[[Employee alloc]initWithDic:locList[0]];
                  //CLGeocoder *geocoder=[[CLGeocoder alloc]init];
                  CLLocationCoordinate2D loca2D = CLLocationCoordinate2DMake([em.latitude doubleValue], [em.longitude doubleValue]);
                 // NSDictionary *baidu = BMKConvertBaiduCoorFrom(loca2D,BMK_COORDTYPE_GPS);
                 // CLLocationCoordinate2D trans = BMKCoorDictionaryDecode(baidu);
                   NSString *nameStateStr=[NSString stringWithFormat:@"%@%@,%@",em.userName,([@"1" isEqualToString: em.zt  ])?@"在线":@"离线",em.time];
                  MyAnnotation *ann=[[MyAnnotation alloc]initWithCoordinate:loca2D title:nameStateStr subtitle:nil];
                  [mapVC->_mapView  addAnnotation:ann];
                  
          //      }
           [mapVC showMap:loca2D span:BMKCoordinateSpanMake(0.2, 0.2)];
              [AlertHelper hideAllHUDsForView:blockSelf.view];
          } fail:^(){
               [AlertHelper hideAllHUDsForView:blockSelf.view];
              [AlertHelper singleMBHUDShow:@"网络请求失败" ForView:blockSelf.view AndDelayHid:1.5];
          }];
         
     }];
    [self changeBtnSelected:sender popView:_perList.view];
}
-(void)mapWithHis:(UIButton *)sender
{
    [self delectBiaoZhu];
    if (!_popView) {
        _popView=[[History alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_toolBar.frame), self.view.frame.size.width-20, self.view.frame.size.height-20-CGRectGetMaxY(_toolBar.frame)) Type:NO];
    }
    PhoneLocationViewController *mapVC=self;
    __unsafe_unretained History *his=_popView;
    [his setFinishBlock:^(NSString *st, NSString *et, NSString *name,NSString *uid) {
        //NSLog(@"person----- %@ %@ ",st ,et);
        sender.selected=NO;
        [his removeFromSuperview];
         [AlertHelper MBHUDShow:@"获取中" ForView:self.view AndDelayHid:30];
        [phoneLocationWebAPI getUserInMapWithTpe:@"his" uid:uid stime:st etime:et success:^(NSArray *userInfo)
         {
           //  [_mapView removeAnnotations:_annoArr];
             if (userInfo.count==0) {
                 [AlertHelper hideAllHUDsForView:self.view];
                 [AlertHelper singleMBHUDShow:@"无历史定位数据" ForView:self.view AndDelayHid:1.5];
                 return ;
             }
             Employee *em1=[[Employee alloc]initWithDic:userInfo[0]];
             for (NSDictionary *dict in userInfo)
             {
                  Employee *em=[[Employee alloc]initWithDic:dict];
                
                 CLLocationCoordinate2D test = CLLocationCoordinate2DMake([em.latitude doubleValue], [em.longitude doubleValue]);
               //  NSDictionary *baidu = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
               //  CLLocationCoordinate2D trans = BMKCoorDictionaryDecode(baidu);
                  NSString *nameStateStr=[NSString stringWithFormat:@"%@日期%@",em.userName,em.time];
                 MyAnnotation *ann=[[MyAnnotation alloc]initWithCoordinate:test title:nameStateStr subtitle:nil ];
                 [mapVC->_mapView  addAnnotation:ann];
             }
             [mapVC showMap:CLLocationCoordinate2DMake([em1.latitude doubleValue], [em1.longitude doubleValue]) span:BMKCoordinateSpanMake(0.2, 0.2)];;
             [AlertHelper hideAllHUDsForView:self.view];
             
         } fail:^{
              [AlertHelper hideAllHUDsForView:self.view];
             [AlertHelper singleMBHUDShow:@"网络请求失败" ForView:self.view AndDelayHid:1.5];
         }];
    }];
    [self changeBtnSelected:sender popView:_popView];
}
-(void)changeBtnSelected:(UIButton *)sender popView:(UIView *)pop
{
        if (sender.selected==NO) {
            _currentBtn.selected=NO;
            [_currentPop removeFromSuperview];
            [self.view addSubview:pop];
            _currentPop=pop;
            sender.selected=YES;
            _currentBtn=sender;
        }else
            if (sender==_currentBtn) {
                sender.selected=NO;
                [pop removeFromSuperview];
                return;
            }
}

#pragma mark - 创建工具条上面的按钮
-(UIButton *)createButton:(NSString *)title index:(int)index
{
    CGFloat border=10;
    CGFloat x=(self.view.frame.size.width/kBarBtnCount)*index+border;
    CGFloat width=(self.view.frame.size.width-(kBarBtnCount+1)*border)/kBarBtnCount-border;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn11.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn2.png"] forState:UIControlStateSelected];
    btn.frame=CGRectMake(x, border, width, kBarH-border*2);
    btn.tag=100+index;
    [_toolBar addSubview:btn];
    return btn;
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    // Add code to clean up any of your own resources that are no longer necessary.
    
    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidLoad
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}
- (IBAction)lastBtnPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
