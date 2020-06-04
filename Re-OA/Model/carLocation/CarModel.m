//
//  CarModel.m
//  Re-OA
//
//  Created by admin on 15/1/23.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.userName=dict[@"carName"];
        self.latitude= [[dict[@"carPoint"] objectAtIndex:0]objectForKey:@"y"];
        self.longitude= [[dict[@"carPoint"] objectAtIndex:0]objectForKey:@"x"];
        self.time=dict[@"time"];
        //self.km=dict[@""];
    }
    return self;
}
@end
