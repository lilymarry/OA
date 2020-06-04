//
//  paBoOrPaCoQuCustom_detailModel.h
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paBoOrPaCoQuCustom_detailModel : NSObject
@property (nonatomic,copy)NSString * ItemTotal ; // 客户代号
@property (nonatomic,copy)NSString * OrderCode ;//客户简称
@property (nonatomic,copy)NSString * PaperBoardName ; //区域,
@property(nonatomic,copy)NSString * PaperBoardCodeProduce; //业务员,
@property(nonatomic,copy)NSString * PaperKai; //折合平方
@property(nonatomic,copy)NSString * PaperWidth;//立方
@property (nonatomic,copy) NSString *PaperBoardLength;//纸度

@property (nonatomic,copy) NSString *OrderNum;//款数
@property (nonatomic,copy) NSString * SaleAmount ;//修边损耗量
@property (nonatomic,copy)NSString * PaperBoardSpecifications ;//米数
@property (nonatomic,copy)NSString * ValuationSpecifications   ;//二层米数

@property(nonatomic,copy)NSString * PproducteExplain  ;//单坑米数
@property (nonatomic,copy) NSString *DeliveryExplain ;//双坑米数
@property (nonatomic,copy) NSString *BasePaperSquarePrice ;//三坑米数

@property (nonatomic,copy)NSString *  SquarePrice ;//平方
@property(nonatomic,copy)NSString * BasePaperAmount;//二层平方
@property (nonatomic,copy) NSString *ProcessingCost ;//单坑平方

@property (nonatomic,copy) NSString * BasePaperPercent;//双坑平方
@property (nonatomic,copy)NSString *  Cube ;//三坑平方
@property (nonatomic,copy)NSString *   Square  ;//原纸金额
@property (nonatomic,copy) NSString * OrderDateTime ;//二层原纸金额
@property (nonatomic,copy)NSString * ScheduleNum ;//单坑原纸金额

@property (nonatomic,copy)NSString *DeliveryDateTime   ;//双坑原纸金额
@property(nonatomic,copy)NSString * CustomPurchaseNum ;//三坑原纸金额
@property (nonatomic,copy) NSString *CustomCode ;//折后金额
@property (nonatomic,copy) NSString *Abbreviation ;//二层折后金额
@property (nonatomic,copy)NSString *  PaperPrice ;//单坑折后金额
@property(nonatomic,copy)NSString * Trimming ;//双坑折后金额
@property (nonatomic,copy) NSString *TrimmingRatio ;//三坑折后金额
@property (nonatomic,copy) NSString * Salesman;//预警款数

@property (nonatomic,copy)NSString *  DeliveryNum ;//单坑折后金额
@property(nonatomic,copy)NSString * TallyNum ;//双坑折后金额
@property (nonatomic,copy) NSString *CarNum ;//三坑折后金额
@property (nonatomic,copy) NSString * PrintDateTime;//预警款数




-(instancetype)initWithDic:(NSDictionary *)dict;
@end
