//
//  DingModel.m
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "DingModel.h"

@implementation DingModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.SinglePitMeters=dict[@"SinglePitMeters"];
        self.SinglePitAmount= dict[@"SinglePitAmount"];
        self.SinglePitSquare= dict[@"SinglePitSquare"] ;
        
        self.DoublePitAmount=dict[@"DoublePitAmount"];
        self.DoublePitMeters= dict[@"DoublePitMeters"] ;
        self.DoublePitSquare=dict[@"DoublePitSquare"];
        
        self.ThreePitAmount=dict[@"ThreePitAmount"];
        self.ThreePitMeters= dict[@"ThreePitMeters"];
        self.ThreePitSquare= dict[@"ThreePitSquare"] ;
        
        self.TwoLayersAmount=dict[@"TwoLayersAmount"];
        self.TwoLayersMeters= dict[@"TwoLayersMeters"] ;
        self.TwoLayersSquare=dict[@"TwoLayersSquare"];
        
        
        self.ThreeLayersAmount=dict[@"ThreeLayersAmount"];
        self.ThreeLayersMeters=dict[@"ThreeLayersMeters"];
        self.ThreeLayersSquare= dict[@"ThreeLayersSquare"];
        
        self.FourLayersAmount=dict[@"FourLayersAmount"];
        
        
        self.FourLayersMeters=dict[@"FourLayersMeters"];
        self.FourLayersMeters= dict[@"FourLayersMeters"];
        
        self.FiveLayersAmount= dict[@"FiveLayersAmount"] ;
        self.FiveLayersMeters=dict[@"FiveLayersMeters"];
        self.FiveLayersSquare= dict[@"FiveLayersSquare"] ;
        
        self.SevenLayersAmount=dict[@"SevenLayersAmount"];
        self.SevenLayersMeters=dict[@"SevenLayersMeters"];
        self.SevenLayersSquare= dict[@"SevenLayersSquare"];
        
        self.TotalPitAmount= dict[@"TotalPitAmount"] ;
        self.TotalPitMeters=dict[@"TotalPitMeters"];
        self.TotalPitSquare= dict[@"TotalPitSquare"] ;
        self.ReducedPitSquare=dict[@"ReducedPitSquare"];
        
        self.CustomerNum=dict[@"CustomerNum"];
        self.OrderNum=dict[@"OrderNum"];
    }
    return self;
}
@end
