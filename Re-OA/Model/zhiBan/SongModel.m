//
//  SongModel.m
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "SongModel.h"

@implementation SongModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.DeliveryAmount=dict[@"DeliveryAmount"];
        self.DeliveryWeight= dict[@"DeliveryWeight"];
        self.ReturnAmount= dict[@"ReturnAmount"] ;
        self.ReturnDifference=dict[@"ReturnDifference"];
        self.DeliverySquare= dict[@"DeliverySquare"];
        self.DeliverySaleSquare= dict[@"DeliverySaleSquare"] ;
        self.DeliveryVolume=dict[@"DeliveryVolume"];

        
    }
    return self;
}

@end
