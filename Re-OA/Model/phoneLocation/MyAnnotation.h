//
//  MyAnnotation.h
//  UI高级-地图
//
//  Created by Ibokan on 14-1-14.
//  Copyright (c) 2014年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BMapKit.h>
@interface MyAnnotation : NSObject<BMKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;



// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) int tag;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle ;
@end
