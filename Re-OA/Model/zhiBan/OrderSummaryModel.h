//
//  OrderSummaryModel.h
//  Re-OA
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderSummaryModel : NSObject
@property(nonatomic,copy)NSString * AfterDiscountAmount;
@property (nonatomic,copy) NSString *BasePaperAmount;
@property (nonatomic,copy) NSString *BasePaperProportion;
@property (nonatomic,copy)NSString * BeforeDiscountAmount ;


@property (nonatomic,copy) NSString * Cube ;
@property (nonatomic,copy)NSString * CustomerNum ;

@property (nonatomic,copy)NSString * GrossProfit  ;

@property(nonatomic,copy)NSString * MeterNum;
@property (nonatomic,copy) NSString *ModelsNum;

@property (nonatomic,copy) NSString *SalesMan;
@property (nonatomic,copy)NSString *  Square;


-(instancetype)initWithDic:(NSDictionary *)dict;
@end
