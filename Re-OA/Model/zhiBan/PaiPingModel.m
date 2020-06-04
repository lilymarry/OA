//
//  PaiPingModel.m
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaiPingModel.h"

@implementation PaiPingModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.TwoLayersSchedulingSquare=dict[@"TwoLayersSchedulingSquare"];
        self.ThreeLayersSchedulingSquare= dict[@"ThreeLayersSchedulingSquare"];
        self.FourLayersSchedulingSquare= dict[@"FourLayersSchedulingSquare"] ;
        self.FiveLayersSchedulingSquare=dict[@"FiveLayersSchedulingSquare"];
        self.SixLayersSchedulingSquare= dict[@"SixLayersSchedulingSquare"] ;
        self.SevenLayersSchedulingSquare= dict[@"SevenLayersSchedulingSquare"] ;
        self.TotalLayersSchedulingSquare=dict[@"TotalLayersSchedulingSquare"];
    
    }
    return self;
}
@end
