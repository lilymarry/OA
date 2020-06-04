//
//  QiModel.h
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiModel : NSObject
@property(nonatomic,copy)NSString * RecieveAmount;
@property (nonatomic,copy) NSString *OtherSales;
@property (nonatomic,copy) NSString *ReturnGoodsAmount;
@property (nonatomic,copy)NSString * DebitAmount ;


@property (nonatomic,copy) NSString * ActualSales;
@property (nonatomic,copy)NSString * GrossProfit ;



@property(nonatomic,copy)NSString * GrossProfitTwo;
@property (nonatomic,copy) NSString *GrossProfitThree;

@property (nonatomic,copy) NSString *EstimatedProfit;
@property (nonatomic,copy)NSString * EstimatedProfitTwo;

@property (nonatomic,copy) NSString * Freight;
@property (nonatomic,copy)NSString * ShareAmount ;

@property (nonatomic,copy) NSString *AuxiliaryAmount;

-(instancetype)initWithDic:(NSDictionary *)dict;
@end
