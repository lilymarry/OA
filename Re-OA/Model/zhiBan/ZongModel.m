//
//  ZongModel.m
//  Re-OA
//
//  Created by admin on 16/3/22.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "ZongModel.h"

@implementation ZongModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.TotalPitAmount= dict[@"TotalPitAmount"] ;
        self.TotalPitMeters=dict[@"TotalPitMeters"];
        self.TotalPitSquare= dict[@"TotalPitSquare"] ;
        self.ReducedPitSquare=dict[@"ReducedPitSquare"];
        self.CustomerNum=dict[@"CustomerNum"];
        self.OrderNum=dict[@"OrderNum"];
        self.ReturnAmount= dict[@"ReturnAmount"] ;
        self.ReturnDifference=dict[@"ReturnDifference"];
        self.DeliveryAmount=dict[@"DeliveryAmount"];
        self.BasePaperAmount= dict[@"BasePaperAmount"] ;
        self.BasePaperWeight=dict[@"BasePaperWeight"];
        
        self.SinglePitMeters=dict[@"SinglePitMeters"];
        self.SinglePitAmount= dict[@"SinglePitAmount"];
        self.SinglePitSquare= dict[@"SinglePitSquare"] ;
        
        self.DoublePitAmount=dict[@"DoublePitAmount"];
        self.DoublePitMeters= dict[@"DoublePitMeters"] ;
        self.DoublePitSquare=dict[@"DoublePitSquare"];
        
        self.ThreePitAmount=dict[@"ThreePitAmount"];
        self.ThreePitMeters= dict[@"ThreePitMeters"];
        self.ThreePitSquare= dict[@"ThreePitSquare"] ;
        
    }
    return self;
}
@end
