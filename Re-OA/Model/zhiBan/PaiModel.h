//
//  PaiModel.h
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaiModel : NSObject
@property(nonatomic,copy)NSString *SchedulingMeters;
@property (nonatomic,copy) NSString *SchedulingAmount;
@property (nonatomic,copy) NSString *SchedulingWeight;
@property (nonatomic,copy)NSString *NotSchedulingMeters;

-(instancetype)initWithDic:(NSDictionary *)dict;
@end
