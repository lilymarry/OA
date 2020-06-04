//
//  PaiPingModel.h
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaiPingModel : NSObject
@property(nonatomic,copy)NSString *TwoLayersSchedulingSquare;
@property (nonatomic,copy) NSString *ThreeLayersSchedulingSquare;
@property (nonatomic,copy) NSString *FourLayersSchedulingSquare;
@property (nonatomic,copy)NSString *FiveLayersSchedulingSquare;
@property (nonatomic,copy)NSString *SixLayersSchedulingSquare;
@property (nonatomic,copy)NSString *SevenLayersSchedulingSquare;
@property (nonatomic,copy)NSString *TotalLayersSchedulingSquare;
-(instancetype)initWithDic:(NSDictionary *)dict;
@end
