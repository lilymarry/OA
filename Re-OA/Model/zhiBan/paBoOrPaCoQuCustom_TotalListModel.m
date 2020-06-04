//
//  paBoOrPaCoQuCustom_TotalListModel.m
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "paBoOrPaCoQuCustom_TotalListModel.h"

@implementation paBoOrPaCoQuCustom_TotalListModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.CustomCode=dict[@"CustomCode"];
        self.Abbreviation= dict[@"Abbreviation"] ;
        self.Region= dict[@"Region"] ;
        self.BusinessMan=dict[@"BusinessMan"];

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
        
 
    }
    return self;
}
@end
