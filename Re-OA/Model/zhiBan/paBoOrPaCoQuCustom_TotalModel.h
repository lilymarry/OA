//
//  paBoOrPaCoQuCustom_TotalModel.h
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paBoOrPaCoQuCustom_TotalModel : NSObject

@property (nonatomic,copy)NSString * ItemTotal ; // 全部条数
@property (nonatomic,copy)NSString * ReducedSquare ;//折合平方
@property(nonatomic,copy)NSString * Cube;//立方
@property (nonatomic,copy) NSString *PaperSize;//纸度
@property (nonatomic,copy) NSString *Num;//款数
@property (nonatomic,copy) NSString * TrimmingLoss ;//修边损耗量
@property (nonatomic,copy)NSString * Meters ;//米数
@property (nonatomic,copy)NSString * TwoLayersMeters   ;//二层米数
@property(nonatomic,copy)NSString * SinglePitMeters  ;//单坑米数
@property (nonatomic,copy) NSString *DoublePitMeters ;//双坑米数
@property (nonatomic,copy) NSString *ThreePitMeters ;//三坑米数
@property (nonatomic,copy)NSString *  Square ;//平方
@property(nonatomic,copy)NSString * TwoLayersSquare;//二层平方
@property (nonatomic,copy) NSString *SinglePitSquare ;//单坑平方
@property (nonatomic,copy) NSString * DoublePitSquare;//双坑平方
@property (nonatomic,copy)NSString *  ThreePitSquare ;//三坑平方
@property (nonatomic,copy)NSString *   Amount  ;//原纸金额
@property (nonatomic,copy) NSString * TwoLayersAmount ;//二层原纸金额
@property (nonatomic,copy)NSString * SinglePitAmount ;//单坑原纸金额
@property (nonatomic,copy)NSString *DoublePitAmount   ;//双坑原纸金额
@property(nonatomic,copy)NSString * ThreePitAmount ;//三坑原纸金额
@property (nonatomic,copy) NSString *SaleAmount ;//折后金额
@property (nonatomic,copy) NSString *SaleTwoLayersAmount ;//二层折后金额
@property (nonatomic,copy)NSString *  SaleSinglePitAmount ;//单坑折后金额
@property(nonatomic,copy)NSString * SaleDoublePitAmount ;//双坑折后金额
@property (nonatomic,copy) NSString *SaleThreePitAmount ;//三坑折后金额
@property (nonatomic,copy) NSString * WariningNum;//预警款数
@property (nonatomic,copy) NSString * TrimmingRatio;//修边率
@property (nonatomic,copy)NSString *  GateNum ;//门幅数量
@property (nonatomic,copy)NSString *   AverageWidth  ;//平均幅宽
@property (nonatomic,copy) NSString * MetersProportion ;//原纸比例
@property (nonatomic,copy)NSString * TwoLayersMeterProportion ; //二层原纸比例
@property (nonatomic,copy)NSString *SinglePitMeterProportion  ;  //单坑原纸比例
@property(nonatomic,copy)NSString * DoublePitMeterProportion ;  //双坑原纸比例
@property(nonatomic,copy)NSString * ThreePitMetersProportion ;  //三坑原纸比例
@property (nonatomic,copy) NSString * ProcessCost ;  //加工费
@property (nonatomic,copy) NSString *TwoLayersProcessCost ; //二层加工费
@property (nonatomic,copy)NSString *  SinglePitProcessCost ;   //单坑加工费
@property(nonatomic,copy)NSString * DoublePitProcessCost;    //双坑加工费
@property (nonatomic,copy) NSString *ThreePitProcessCost ;   //三坑加工费
@property (nonatomic,copy)NSString *  GrossProfit ; //毛利润
@property(nonatomic,copy)NSString * WariningProportion; //预警比例

-(instancetype)initWithDic:(NSDictionary *)dict;
@end
