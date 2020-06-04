//
//  ShangBMapViewController.m
//  Re-OA
//
//  Created by admin on 15/7/23.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "ShangBMapViewController.h"
#import <BMapKit.h>
//#import "ExchangeXYzuobiao.h"
#import "MyAnnotation.h"
@interface ShangBMapViewController ()<BMKGeoCodeSearchDelegate>
{
      BMKMapView *_mapView;
    BMKGeoCodeSearch* _geocodesearch;
}
@end

@implementation ShangBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _mapView=[[BMKMapView alloc]init];
     _mapView.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
     _mapView.mapType=BMKMapTypeStandard;
     _mapView.rotateEnabled=YES;
    [self.view addSubview:_mapView];
    
 
    CLLocationCoordinate2D loca2D=CLLocationCoordinate2DMake([self.y doubleValue], [self.x doubleValue]);
  //  NSDictionary *baidu = BMKConvertBaiduCoorFrom(loca2D,BMK_COORDTYPE_GPS);
   // CLLocationCoordinate2D trans = BMKCoorDictionaryDecode(baidu);
   // 地图显示范围
    BMKCoordinateRegion region;
 
    region.center=loca2D;
    region.span=BMKCoordinateSpanMake(0.04, 0.04);
    [_mapView setRegion:region];
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = loca2D;
    _geocodesearch =[[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate=self;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"sccuess");
    }
    else
    {
        NSLog(@"err");
    }
}
-(void)getData
{


}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        MyAnnotation *ann=[[MyAnnotation alloc]initWithCoordinate:result.location title:@"上报位置" subtitle:result.address ];
        [_mapView addAnnotation:ann];
}

    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
