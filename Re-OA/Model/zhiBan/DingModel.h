//
//  DingModel.h
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DingModel : NSObject
@property(nonatomic,copy)NSString *SinglePitMeters;
@property (nonatomic,copy)NSString *SinglePitAmount;
@property (nonatomic,copy)NSString *SinglePitSquare;

@property (nonatomic,copy) NSString *DoublePitMeters;
@property (nonatomic,copy) NSString *DoublePitAmount;
@property(nonatomic,copy)NSString *DoublePitSquare;

@property (nonatomic,copy) NSString *ThreePitMeters;
@property (nonatomic,copy) NSString *ThreePitAmount;
@property (nonatomic,copy) NSString *ThreePitSquare;

@property (nonatomic,copy)NSString *TwoLayersMeters;
@property (nonatomic,copy)NSString *TwoLayersAmount;
@property (nonatomic,copy)NSString *TwoLayersSquare;

@property (nonatomic,copy) NSString *ThreeLayersMeters;
@property (nonatomic,copy) NSString *ThreeLayersAmount;
@property (nonatomic,copy) NSString *ThreeLayersSquare;

@property (nonatomic,copy) NSString *FourLayersMeters;
@property (nonatomic,copy) NSString *FourLayersAmount;
@property (nonatomic,copy) NSString *FourLayersSquare;

@property (nonatomic,copy)NSString *FiveLayersMeters;
@property (nonatomic,copy)NSString *FiveLayersAmount;
@property (nonatomic,copy)NSString *FiveLayersSquare;

@property (nonatomic,copy)NSString *SevenLayersMeters;
@property (nonatomic,copy)NSString *SevenLayersAmount;
@property (nonatomic,copy)NSString *SevenLayersSquare;


@property (nonatomic,copy)NSString *TotalPitMeters;
@property (nonatomic,copy)NSString *TotalPitAmount;
@property (nonatomic,copy) NSString *TotalPitSquare;
@property (nonatomic,copy)NSString *ReducedPitSquare;


@property (nonatomic,copy)NSString *CustomerNum;
@property (nonatomic,copy)NSString *OrderNum;



-(instancetype)initWithDic:(NSDictionary *)dict;
@end
