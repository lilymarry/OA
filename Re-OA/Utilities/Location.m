//
//  Location.m
//  OA-Demo
//
//  Created by ChinaLoong on 14-7-23.
//  Copyright (c) 2014年 ChinaLoong. All rights reserved.
//

#import "Location.h"
@interface Location()
{
    CLLocationManager *_manager;
    CLLocation *_location;
}

@property(nonatomic,copy)void (^currentLocation)(CLLocationCoordinate2D coordinate);

@end
@implementation Location
static  Location *singl;
+(instancetype)sharedLocation
{
    if (!singl) {
        singl=[[Location alloc]init];
    }
    return singl;
}
-(void)getCurrentLocationWithBlock:(void(^)(CLLocationCoordinate2D coordinate))block
{
    self.currentLocation = block;
    _manager =[[CLLocationManager alloc]init];
    _manager.delegate=self;
    _manager.desiredAccuracy=kCLLocationAccuracyBest;
    
    if([[[UIDevice currentDevice] systemVersion]intValue]>=8.0)
    {
        
       // [_manager requestAlwaysAuthorization];
        [_manager requestWhenInUseAuthorization];

        
    }
    if(![CLLocationManager locationServicesEnabled])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请开启定位:设置 > 隐私 > 位置 > 定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"进入设置", nil];
        [alert show];
        
        
    }else
    {
        [_manager startUpdatingLocation];
        
    }
}


-(BOOL)checkGPSOpened{
    
    _manager =[[CLLocationManager alloc]init];
    _manager.delegate=self;
    _manager.desiredAccuracy=kCLLocationAccuracyBest;
    
    if([[[UIDevice currentDevice] systemVersion]intValue]>=8.0)
    {
      //  [_manager requestAlwaysAuthorization];
          [_manager requestWhenInUseAuthorization];
    }
    if(![CLLocationManager locationServicesEnabled])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请开启定位:设置 > 隐私 > 位置 > 定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"进入设置", nil];
        [alert show];
        return NO;
    }
    return YES;
}



//#pragma mark locationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
 //   self.currentLocation = block;

    _location=[locations lastObject];
    if (_location) {
        
        
        if (self.currentLocation) {
            [_manager stopUpdatingLocation];
            self.currentLocation(_location.coordinate);
        }
        
    }
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"定位失败,请稍后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    //   [[NSNotificationCenter defaultCenter]postNotificationName:@"locationError" object:@"err"];
    //  NSLog(@"error=%@",error);
}


@end
