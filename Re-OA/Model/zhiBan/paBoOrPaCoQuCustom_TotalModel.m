//
//  paBoOrPaCoQuCustom_TotalModel.m
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "paBoOrPaCoQuCustom_TotalModel.h"

@implementation paBoOrPaCoQuCustom_TotalModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.ItemTotal=dict[@"ItemTotal"];
        self.ReducedSquare= dict[@"ReducedSquare"];
        self.Cube=dict[@"Cube"];
        self.PaperSize=dict[@"PaperSize"];
        self.Num= dict[@"Num"];
        self.TrimmingLoss= dict[@"TrimmingLoss"] ;
        self.Meters=dict[@"Meters"];
        
        self.TwoLayersMeters=dict[@"TwoLayersMeters"];
        self.SinglePitMeters=dict[@"SinglePitMeters"];
        
        self.DoublePitMeters=dict[@"DoublePitMeters"];
        self.ThreePitMeters= dict[@"ThreePitMeters"];
        self.Square= dict[@"Square"] ;
        self.TwoLayersSquare= dict[@"TwoLayersSquare"] ;
        self.SinglePitSquare=dict[@"SinglePitSquare"];
        self.DoublePitSquare= dict[@"DoublePitSquare"];
        
        
        self.ThreePitSquare= dict[@"ThreePitSquare"] ;
        self.Amount=dict[@"Amount"];
        self.TwoLayersAmount=dict[@"TwoLayersAmount"];
        self.SinglePitAmount= dict[@"SinglePitAmount"];
        self.DoublePitAmount= dict[@"DoublePitAmount"] ;
        self.ThreePitAmount=dict[@"ThreePitAmount"];
        self.SaleAmount=dict[@"SaleAmount"];
        self.SaleTwoLayersAmount=dict[@"SaleTwoLayersAmount"];
        self.SaleSinglePitAmount= dict[@"SaleSinglePitAmount"] ;
        self.SaleDoublePitAmount=dict[@"SaleDoublePitAmount"];
        self.SaleThreePitAmount= dict[@"SaleThreePitAmount"];
        
        
        self.WariningNum= dict[@"WariningNum"] ;
        self.TrimmingRatio= dict[@"TrimmingRatio"] ;
        self.GateNum= dict[@"GateNum"] ;
        self.AverageWidth=dict[@"AverageWidth"];
        self.MetersProportion= dict[@"MetersProportion"] ;
        self.TwoLayersMeterProportion=dict[@"TwoLayersMeterProportion"];
        self.SinglePitMeterProportion=dict[@"SinglePitMeterProportion"];
        self.DoublePitMeterProportion= dict[@"DoublePitMeterProportion"];
        self.ThreePitMetersProportion= dict[@"ThreePitMetersProportion"] ;
        self.ProcessCost=dict[@"ProcessCost"];
        self.TwoLayersProcessCost=dict[@"TwoLayersProcessCost"];
        self.SinglePitProcessCost=dict[@"SinglePitProcessCost"];
        self.DoublePitProcessCost= dict[@"DoublePitProcessCost"] ;
        
        
        
        self.ThreePitProcessCost= dict[@"ThreePitProcessCost"];
        self.GrossProfit= dict[@"GrossProfit"] ;
        self.WariningProportion=dict[@"WariningProportion"];

        
      
        
        
        
        
    }
    return self;
}

@end
