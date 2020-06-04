//
//  Employee.h
//  OA-Demo
//
//  Created by 柳文杰 on 14-7-24.
//  Copyright (c) 2014年 ChinaLoong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject

//@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *userName;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *zt;

-(instancetype)initWithDic:(NSDictionary *)dict;
@end
