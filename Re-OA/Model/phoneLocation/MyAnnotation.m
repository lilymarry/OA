//
//  MyAnnotation.m
//  UI高级-地图
//
//  Created by Ibokan on 14-1-14.
//  Copyright (c) 2014年 ibokan. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
//-(id)init
//{
//    if (self=[super init]) {
//        
//        _coordinate.latitude=0;
//        _coordinate.longitude=0;
//        _title=nil;
//        self=[self initWithCoordinate:_coordinate title:_title subtitle:_subtitle];
//    }
//    return self;
//}
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle {
    if (self=[super init]) {
        self.coordinate=coordinate;
        self.title=title;
        self.subtitle=subtitle;
        }
    return self;
}
@end
