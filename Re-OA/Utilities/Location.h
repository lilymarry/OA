//
//  Location.h
//  OA-Demo
//
//  Created by ChinaLoong on 14-7-23.
//  Copyright (c) 2014年 ChinaLoong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Location : NSObject<CLLocationManagerDelegate>


+(instancetype)sharedLocation;
-(BOOL)checkGPSOpened;
-(void)getCurrentLocationWithBlock:(void(^)(CLLocationCoordinate2D coordinate))block;
@end
