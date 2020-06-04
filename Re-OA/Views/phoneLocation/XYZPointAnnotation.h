//
//  XYZPointAnnotation.h
//  xilaikd
//
//  Created by 智发 on 14-7-17.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import "BMKPointAnnotation.h"

@interface XYZPointAnnotation : BMKPointAnnotation
@property(nonatomic , strong)NSString *empName;
@property(nonatomic , strong)NSString *empAddress;
@property(nonatomic , strong)NSString *time;
@property(nonatomic , strong)NSString *km;
@property(nonatomic , strong)NSString *num;
@property(nonatomic,strong )NSString * telState;

@end
