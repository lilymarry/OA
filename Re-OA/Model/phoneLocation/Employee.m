//
//  Employee.m
//  OA-Demo
//
//  Created by 柳文杰 on 14-7-24.
//  Copyright (c) 2014年 ChinaLoong. All rights reserved.
//

#import "Employee.h"

@implementation Employee
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
    
        self.userName=dict[@"userName"];
      
        self.latitude= [[dict[@"userPoint"] objectAtIndex:0]objectForKey:@"y"];
        self.longitude= [[dict[@"userPoint"] objectAtIndex:0]objectForKey:@"x"];
        self.time=dict[@"time"];
             self.zt=dict[@"zt"];
    }
    return self;
}   
@end
