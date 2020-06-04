#import "CarLocViewController.h"
#import "History.h"
#import "CarPerController.h"
#import "Employee.h"
//#import <CoreLocation/CoreLocation.h>
//#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "AlertHelper.h"
#import "CarLocationWebAPI.h"
//#import "ExchangeXYzuobiao.h"
#import "UserPermission.h"
#import "CarModel.h"
#import <BMapKit.h>
#import "CustomOverlayView.h"
//#import <BaiduMapAPI/BMapKit.h>
//#import "TittleStroe.h"

#import "XYZPointAnnotation.h"
#import "XYZPaopaoView.h"

#define IOS_VERSION_7_0 ([[[UIDevice currentDevice] systemVersion]floatValue]>6.0)?(YES):(NO)
#define kBarH 50
#define kBarBtnCount 3


@interface CarLocViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,PaopaoViewBtnDelegate>
{  //CLLocationManagerDelegate
    UIView *_toolBar;
    History *_popView;
    CarPerController *_perList;
    UIButton *_currentBtn;
    UIView *_currentPop;
    UIButton *_allbtn;
    BMKMapView *_mapView;
    //MyAnnotation *_annotation;
    NSMutableArray *_annoArr;
    //NSMutableArray *_allPerson;
   // NSMutableArray *_personal;
   // NSMutableArray *_history;
    NSTimer *timer;
    BOOL isfirstShowOneCar;
    
    UIView *HisTimeToolBar;
    UILabel *timeLable;
    
    //UILabel *nameLable;
    NSString *perUid;
    NSString *time;
    
    CustomOverlay* custom2;
    UIButton *biaoZhuBtn;
    
    NSArray *allData;
    
    BMKGeoCodeSearch* _geocodesearch;
    BOOL isInHis;
    
  //  NSString *tittleStr;
    
  //  int num;
}

//@property(nonatomic ,strong )TittleStroe * Stittle;

@end

@implementation CarLocViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   // num=0;
    isInHis=NO;
    isfirstShowOneCar=NO;
    _annoArr=[NSMutableArray array];
    [self addMapView];
    [self addMenuToolBar];
    perUid=[[NSString alloc]init];
    _geocodesearch=[[BMKGeoCodeSearch alloc]init];
    
    //_allPerson=[NSMutableArray array];
   // _personal=[NSMutableArray array];
   // _history=[NSMutableArray array];
   // _Stittle=[[TittleStroe alloc]init];
    CLLocationCoordinate2D dingweiZhongxin=CLLocationCoordinate2DMake([[UserPermission standartUserInfo].y doubleValue], [[UserPermission standartUserInfo].x doubleValue]);
    
    [self showMap:CLLocationCoordinate2DMake(dingweiZhongxin.latitude  ,dingweiZhongxin.longitude ) span:BMKCoordinateSpanMake(0.04, 0.04)];
    
    [self addBtnWithBiaoZhu];
     biaoZhuBtn.hidden=YES;
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"POIname"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate=self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate=nil;
    
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


-(void)addMapView
{
    _mapView=[[BMKMapView alloc]init];
    _mapView.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    _mapView.mapType=BMKMapTypeStandard;
    _mapView.rotateEnabled=YES;
    _mapView.delegate=self;
    [self.view addSubview:_mapView];
}
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
    [_allbtn addTarget:self action:@selector(mapCarWithAll:) forControlEvents:UIControlEventTouchUpInside];
    _allbtn.enabled=YES;
    UIButton *personal=[self createButton:@"单车" index:index++];
    [personal addTarget:self action:@selector(mapCarWithPer:) forControlEvents:UIControlEventTouchUpInside];
    personal.enabled=YES;
    UIButton *history=[self createButton:@"历史" index:index++];
    [history addTarget:self action:@selector(mapCarWithHis:) forControlEvents:UIControlEventTouchUpInside];
    history.enabled=YES;
}
-(void)addHisTimeToolBar
{
    
    HisTimeToolBar=[[UIView alloc]init];
    HisTimeToolBar.backgroundColor=[UIColor whiteColor];
    HisTimeToolBar.frame=CGRectMake(0, CGRectGetMaxY(_toolBar.frame), self.view.frame.size.width, 30);
    [self.view addSubview:HisTimeToolBar];
    
    UIButton *stbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [stbtn setTitle:@"前一天" forState:UIControlStateNormal];
    [stbtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [stbtn setBackgroundImage:[UIImage imageNamed:@"zuo.png"] forState:UIControlStateNormal];
    stbtn.frame=CGRectMake(5, 2, 26,26);
    stbtn.tag=1000;
    [stbtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
    [HisTimeToolBar addSubview:stbtn];
    
    UIButton *etbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [etbtn setTitle:@"后一天" forState:UIControlStateNormal];
    etbtn.tag=1001;
    [etbtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [etbtn setBackgroundImage:[UIImage imageNamed:@"you.png"] forState:UIControlStateNormal];
    etbtn.frame=CGRectMake(CGRectGetMaxX(self.view.frame)-50, 2, 26,26);
    [etbtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
    [HisTimeToolBar addSubview:etbtn];
    
    timeLable =[[UILabel alloc]init];
    timeLable.frame=CGRectMake(CGRectGetMaxX(stbtn.frame), 2, self.view.frame.size.width-stbtn.frame.size.width-etbtn.frame.size.width, 26);
    timeLable.text=@"当前时间";
    timeLable.textAlignment=NSTextAlignmentCenter;
    [HisTimeToolBar addSubview:timeLable];
}
-(void)addBtnWithBiaoZhu
{
     biaoZhuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [biaoZhuBtn setTitle:@"" forState:UIControlStateNormal];
    [biaoZhuBtn setTintColor:[UIColor clearColor]];
    [biaoZhuBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [biaoZhuBtn setBackgroundImage:[UIImage imageNamed:@"xianshi.png"] forState:UIControlStateNormal];
    [biaoZhuBtn setBackgroundImage:[UIImage imageNamed:@"quxiao.png"] forState:UIControlStateSelected];
    biaoZhuBtn.frame=CGRectMake(5, self.view.frame.size.height-100, 50,26);
    [biaoZhuBtn addTarget:self action:@selector(biaoZhu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:biaoZhuBtn];
}
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
    [_toolBar addSubview:btn];
    return btn;
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
    aView.bounds=CGRectMake(0, 0, 80, 85);
   // aView.image = [UIImage imageNamed:@"ic_loc.png"];

    XYZPointAnnotation *point=aView.annotation;
    XYZPaopaoView *paopaoView = [[XYZPaopaoView alloc]initWithFrame:CGRectMake(0, 0, 200, 90)];
    paopaoView.empName.text = point.empName;
    paopaoView.empAddress.text = point.empAddress;
    paopaoView.time.text=point.time;
    paopaoView.km.text=point.km;
    paopaoView.num.text=point.num;

    paopaoView.telState=point.telState;
    paopaoView.delegate=self;

    if (isInHis) {
        int weiz=[point.num intValue];
        
        if (weiz==0) {
            aView.image = [UIImage imageNamed:@"qi.png"];
        }
        else if(weiz==allData.count-1)
        {
            aView.image = [UIImage imageNamed:@"zhong.png"];
        }
        
        else
        {
            aView.image = [UIImage imageNamed:@"dian2.png"];
            
        }
    }
    else
    {
    
        aView.image = [UIImage imageNamed:@"ic_loc.png"];
    
    }
    
    if (![paopaoView.telState isEqualToString:@"3"]) {
        paopaoView.km.hidden=YES;
   
    }

   aView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:paopaoView];
  
    return aView;
     
}

-(void)btnWithCourieName:(NSString *)empName
{
    NSString *str=@"/";
    NSRange range = [empName rangeOfString:str];//匹配得到的下标
    NSString *   string;

    if (range.location!=NSNotFound)
    {
        string = [empName substringFromIndex:range.length+range.location];//截取范围类的字符串
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"是否拨打电话" message:string delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"拨打", nil];
                    alert.tag=100;
                    [alert show];
         }
    else
    {
        string=@"暂无电话";
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"是否拨打电话" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }


}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    XYZPointAnnotation *point= view.annotation;
    if (point.empAddress.length==0) {
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:point.empName,@"name",point.time,@"time",point.km,@"km",point.num,@"num",point.telState,@"telState", nil];
    [[NSUserDefaults standardUserDefaults ]setObject:dic forKey:@"POIname"];
    [[NSUserDefaults standardUserDefaults]synchronize];
        
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = point.coordinate;
    _geocodesearch =[[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate=self;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
        {
          //  [_mapView removeAnnotation:point];
        }
    else
     {
           [AlertHelper singleMBHUDShow:@"网络错误!" ForView:self.view AndDelayHid:1.5];
         
    }
   }
  
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"POIname"];
    XYZPointAnnotation *temp = [[XYZPointAnnotation alloc]init];
    temp.empName=dic[@"name"];
    temp.coordinate = result.location;
    temp.empAddress = result.address;
    temp.telState=dic[@"telState"];
    temp.time=dic[@"time"];
    temp.km=dic[@"km"];
    temp.num=dic[@"num"];
    [_mapView addAnnotation:temp];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"POIname"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
}
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[CustomOverlay class]])
    {
        CustomOverlayView* cutomView = [[CustomOverlayView alloc] initWithOverlay:overlay];
        cutomView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
       // cutomView.strokeColor = [UIColor colorWithRed:110 green:1.03 blue:207 alpha:1];
        cutomView.lineWidth = 3.0;
        return cutomView;
    }
    return nil;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100)
    {
        if (buttonIndex==1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",alertView.message]]];
        }
    }
}
#pragma mark - 按钮点击事件
-(void)mapCarWithAll:(UIButton *)sender
{
    [timer invalidate];
    biaoZhuBtn.hidden=YES;
    HisTimeToolBar.hidden=YES;
    [HisTimeToolBar removeFromSuperview];
    
    [_mapView removeOverlay:custom2];
    [self delectBiaoZhu];
    isInHis=NO;
    [AlertHelper singleMBHUDShow:@"获取数据中..." ForView:self.view];
    [self changeBtnSelected:sender popView:nil];
    [CarLocationWebAPI getCarInMapWithTpe:@"all" cid:@"" stime:@"" etime:@"" success:^(NSArray *locList)
     {
        [_mapView removeOverlay:custom2];
         if (locList.count==0)
         {
             [AlertHelper hideAllHUDsForView:self.view];
             [AlertHelper singleMBHUDShow:@"无定位数据" ForView:self.view AndDelayHid:1.5];
             return ;
         }
         CarModel *em1=[[CarModel alloc]initWithDic:locList[0]];
        for (NSDictionary *dict in locList)
         {
             CarModel *em=[[CarModel alloc]initWithDic:dict];
             CLLocationCoordinate2D loca2D = CLLocationCoordinate2DMake([em.latitude doubleValue], [em.longitude doubleValue]);
             XYZPointAnnotation *temp = [[XYZPointAnnotation alloc]init];
             
             temp.coordinate = loca2D;
             temp.empName = em.userName;
             temp.time = em.time;
             temp.telState=@"1";
             [_mapView addAnnotation:temp];
            
         }
         [self showMap:CLLocationCoordinate2DMake([em1.latitude doubleValue], [em1.longitude doubleValue]) span:BMKCoordinateSpanMake(0.04, 0.04)];
         [AlertHelper hideAllHUDsForView:self.view];
     } fail:^(){
         [AlertHelper hideAllHUDsForView:self.view];
         [AlertHelper singleMBHUDShow:@"网络请求失败" ForView:self.view AndDelayHid:1.5];
     }];
}
-(void)mapCarWithPer:(UIButton *)sender
{
    [timer invalidate];
    biaoZhuBtn.hidden=YES;
    isInHis=NO;
    [_mapView removeOverlay:custom2];
    [self delectBiaoZhu];
    [HisTimeToolBar removeFromSuperview];
      if (!_perList) {
        _perList=[[CarPerController alloc]init];
        CGFloat y=_toolBar.frame.origin.y+_toolBar.frame.size.height+5;
        _perList.view.frame=CGRectMake(0, 0,  self.view.frame.size.width-20, 0);
        [UIView animateWithDuration:0.3 animations:^(){
            _perList.view.frame=CGRectMake(10, y, self.view.frame.size.width-20, self.view.frame.size.height-y-10);
        }];
    }
   
    __unsafe_unretained  CarPerController *per=_perList;
    [per setSelectedBlock:^(NSString *name,NSString *uid) {
        isfirstShowOneCar=NO;
        sender.selected=NO;
        [per.view removeFromSuperview];
  
        timer=   [NSTimer timerWithTimeInterval:10 target:self selector:@selector(showTheDrvingCar) userInfo:uid repeats:YES];
        [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [timer fire];
    }];
    [self changeBtnSelected:sender popView:_perList.view];
}
-(void)showTheDrvingCar{
    NSString *uid= timer.userInfo;
    [_mapView removeOverlay:custom2];
    [self delectBiaoZhu];
    [AlertHelper singleMBHUDShow:@"获取数据中..." ForView:self.view];

    [CarLocationWebAPI getCarInMapWithTpe:@"one" cid:uid stime:@"" etime:@"" success:^(NSArray *locList)
     {
    
         if (locList.count==0)
         {
             [AlertHelper hideAllHUDsForView:self.view];
             [AlertHelper singleMBHUDShow:@"无定位数据" ForView:self.view AndDelayHid:1.5];
             return ;
         }
         
         CarModel *em=[[CarModel alloc]initWithDic:locList[0]];
         CLLocationCoordinate2D loca2D = CLLocationCoordinate2DMake([em.latitude doubleValue], [em.longitude doubleValue]);
         XYZPointAnnotation *temp = [[XYZPointAnnotation alloc]init];
         temp.coordinate = loca2D;
         temp.telState=@"2";
         temp.empName = em.userName;
         temp.time = em.time;
      
         [_mapView addAnnotation:temp];
         
            if (!isfirstShowOneCar) {
              [self showMap:CLLocationCoordinate2DMake(loca2D.latitude, loca2D.longitude) span:BMKCoordinateSpanMake(0.04, 0.04)];
             isfirstShowOneCar=YES;
         }
         [AlertHelper hideAllHUDsForView:self.view];
     }fail:^{
         [AlertHelper hideAllHUDsForView:self.view];
         [AlertHelper singleMBHUDShow:@"网络请求失败" ForView:self.view AndDelayHid:1.5];
     }];
}
-(void)mapCarWithHis:(UIButton *)sender
{

    [timer invalidate];
    biaoZhuBtn.hidden=YES;
    isInHis=NO;
    [_mapView removeOverlay:custom2];
    [self delectBiaoZhu];
    [HisTimeToolBar removeFromSuperview];
    
   if (!_popView) {
        _popView=[[History alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_toolBar.frame)+5, self.view.frame.size.width-20, self.view.frame.size.height-20-CGRectGetMaxY(_toolBar.frame)) Type:YES];
    }
    __unsafe_unretained CarLocViewController *mapVC=self;
    __unsafe_unretained History *his=_popView;
    [his setFinishBlock:^(NSString *st, NSString *et, NSString *name,NSString *uid)
     {
         
         sender.selected=NO;
         [his removeFromSuperview];
         [mapVC addHisTimeToolBar];
          biaoZhuBtn.hidden=NO;
          timeLable.text=st;
          perUid =uid;
          isInHis=YES;
         [mapVC addHisWithTime:st puid:uid];
        }];
    [self changeBtnSelected:sender popView:_popView];
}
-(void)addHisWithTime:(NSString *)tim puid:(NSString *)uid
{
    biaoZhuBtn.enabled=YES;
    [self delectBiaoZhu];
    [_mapView removeOverlay:custom2];
     allData=nil;
    [AlertHelper singleMBHUDShow:@"获取数据中..." ForView:self.view];
    [CarLocationWebAPI getCarInMapWithTpe:@"his" cid:uid stime:tim  etime:@"" success:^(NSArray *locList) {
    
        if (locList.count==0)
        {
             biaoZhuBtn.enabled=NO;
            [AlertHelper hideAllHUDsForView:self.view];
            [AlertHelper singleMBHUDShow:@"无历史定位数据" ForView:self.view AndDelayHid:1.5];
            return ;
        }
      
        allData=locList;
        int coun=(int)locList.count;
        BMKMapPoint * temppoints2 = new BMKMapPoint[coun];
         NSDictionary *dic=locList[0];
        CarModel *em1=[[CarModel alloc]initWithDic:dic];
        
        
        CLLocationCoordinate2D loca = CLLocationCoordinate2DMake([em1.latitude doubleValue], [em1.longitude doubleValue]);
        [self showMap:CLLocationCoordinate2DMake(loca.latitude ,loca.longitude ) span:BMKCoordinateSpanMake(0.04, 0.04)];
        
        
        for (int i=0; i<coun; i++)
        {
            NSDictionary *dict=locList[i];
            CarModel *em=[[CarModel alloc]initWithDic:dict];
          
        
           CLLocationCoordinate2D loca2D = CLLocationCoordinate2DMake([em.latitude doubleValue], [em.longitude doubleValue]);
            BMKMapPoint pt = BMKMapPointForCoordinate(loca2D);
            temppoints2[i].x = pt.x;
            temppoints2[i].y = pt.y;
         //   [self showMap:CLLocationCoordinate2DMake(loca2D.latitude ,loca2D.longitude ) span:BMKCoordinateSpanMake(0.04, 0.04)];
        }
        custom2 = [[CustomOverlay alloc] initWithPoints:temppoints2 count:coun];
  
        [_mapView addOverlay:custom2];
        delete temppoints2;

        [AlertHelper hideAllHUDsForView:self.view];
    }fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络请求失败" ForView:self.view AndDelayHid:1.5];
    }];
}
-(void)biaoZhu:(UIButton *)sender
{
   
    if (allData.count >0) {
        sender.selected=!sender.selected;
        if (sender.selected)
        {
            [_annoArr removeAllObjects];
            [AlertHelper singleMBHUDShow:@"获取数据中..." ForView:self.view];
            [self performSelectorInBackground:@selector(addBiaoZhu) withObject:nil];
           //  [self addBiaoZhu];
        }
        else
        {
            [self delectBiaoZhu];
        }
        
    }
    else
    {
        biaoZhuBtn.selected=NO;
    }
}
-(void)addBiaoZhu
{
    [self delectBiaoZhu];
  
    NSDictionary *dic=allData[0];
    CarModel *em1=[[CarModel alloc]initWithDic:dic];
    CLLocationCoordinate2D loc2D = CLLocationCoordinate2DMake([em1.latitude doubleValue], [em1.longitude doubleValue]);
    double distance=0;
    for (int i=0; i<allData.count ;i++ ) {
        
         NSDictionary *dict=allData[i];
      
        CarModel *em=[[CarModel alloc]initWithDic:dict];
       
        CLLocationCoordinate2D loca2D = CLLocationCoordinate2DMake([em.latitude doubleValue], [em.longitude doubleValue]);
    
        
        if (i!=0) {
            NSDictionary *nextdict=allData[i-1];
            CarModel *nextem=[[CarModel alloc]initWithDic:nextdict];
            CLLocationCoordinate2D nextloca2D = CLLocationCoordinate2DMake([nextem.latitude doubleValue], [nextem.longitude doubleValue]);

            BMKMapPoint sta=BMKMapPointForCoordinate(loca2D);//第二个点
            BMKMapPoint et=BMKMapPointForCoordinate(nextloca2D);//第一个点
            distance +=[self ditanseWithLoca1:et andLoca2:sta];
        }
        XYZPointAnnotation *temp = [[XYZPointAnnotation alloc]init];
        temp.coordinate = loca2D;
        temp.empName = em.userName;
        temp.time = em.time;
        temp.telState=@"3";
        temp.km = [NSString stringWithFormat:@"%0.2fkm",distance];
        temp.num=[NSString stringWithFormat:@"%d",i ];
        [_annoArr addObject:temp];
      //  [_mapView addAnnotation:temp];
    }
    //sleep(5);
    [self showMap:CLLocationCoordinate2DMake(loc2D.latitude , loc2D.longitude ) span:BMKCoordinateSpanMake(0.04, 0.04)];
 //   [AlertHelper hideAllHUDsForView:self.view];
   [self performSelectorOnMainThread:@selector(mainWork) withObject:nil waitUntilDone:NO];
}
-(void)mainWork
{
    //NSLog(@"the main thread is %@",[NSThread currentThread]);
    
    [_mapView addAnnotations:_annoArr];
   
    [AlertHelper hideAllHUDsForView:self.view];
    
     
}
-(double)ditanseWithLoca1:(BMKMapPoint )loca1 andLoca2:(BMKMapPoint )loca2
{
    
    CLLocationDistance dis =BMKMetersBetweenMapPoints(loca1, loca2);
  
    return  dis/1000 ;

}
-(void)delectBiaoZhu
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
}
-(void)selectTime:(UIButton *)sender
{
    [biaoZhuBtn setSelected:NO];
    UIButton *but= (UIButton *) sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 00:00:00",timeLable.text]];
    NSDate *lastDay;
    if (but.tag==1000) {//时区问题 +8
        lastDay = [NSDate dateWithTimeInterval:-24*60*60+8 sinceDate:date];
        
    }
    else
    {
        lastDay = [NSDate dateWithTimeInterval:+24*60*60+8 sinceDate:date];
    }
    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    [dateform setDateFormat:@"yyyy/MM/dd"];
    
    timeLable.text=[dateform stringFromDate:lastDay];
    
    [self addHisWithTime:timeLable.text puid:perUid];
    
}
-(void)changeBtnSelected:(UIButton *)sender popView:(UIView *)pop
{
    if (sender.selected==NO) {
         biaoZhuBtn.selected=NO;
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

-(void)showMap:(CLLocationCoordinate2D )coordinate span:(BMKCoordinateSpan)span
{
    //地图显示范围
    BMKCoordinateRegion region;
    region.center=coordinate;
    region.span=span;
    [_mapView setRegion:region];
}


- (IBAction)lastBtnPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
