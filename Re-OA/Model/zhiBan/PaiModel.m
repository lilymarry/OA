//
//  PaiModel.m
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaiModel.h"

@implementation PaiModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.SchedulingAmount=dict[@"SchedulingAmount"];
        self.SchedulingMeters= dict[@"SchedulingMeters"];
        self.SchedulingWeight= dict[@"SchedulingWeight"] ;
        self.NotSchedulingMeters=dict[@"NotSchedulingMeters"];

        
    }
    return self;
}

@end
