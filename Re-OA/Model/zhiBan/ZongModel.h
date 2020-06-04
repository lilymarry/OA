//
//  ZongModel.h
//  Re-OA
//
//  Created by admin on 16/3/22.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZongModel : NSObject
@property (nonatomic,copy)NSString *TotalPitMeters;
@property (nonatomic,copy)NSString *TotalPitAmount;
@property (nonatomic,copy) NSString *TotalPitSquare;
@property (nonatomic,copy)NSString *ReducedPitSquare;
@property (nonatomic,copy)NSString *CustomerNum;
@property (nonatomic,copy)NSString *OrderNum;

@property(nonatomic,copy)  NSString *SinglePitMeters;
@property (nonatomic,copy) NSString *DoublePitMeters;
@property (nonatomic,copy) NSString *ThreePitMeters;

@property (nonatomic,copy)NSString *SinglePitAmount;
@property (nonatomic,copy) NSString *DoublePitAmount;
@property (nonatomic,copy) NSString *ThreePitAmount;

@property (nonatomic,copy)NSString *SinglePitSquare;
@property(nonatomic,copy)NSString *DoublePitSquare;
@property (nonatomic,copy) NSString *ThreePitSquare;

@property (nonatomic,copy) NSString *DeliveryAmount;
@property (nonatomic,copy) NSString *ReturnAmount;
@property (nonatomic,copy)NSString * ReturnDifference ;
@property (nonatomic,copy) NSString *BasePaperWeight;
@property (nonatomic,copy)NSString * BasePaperAmount ;
-(instancetype)initWithDic:(NSDictionary *)dict;
@end
