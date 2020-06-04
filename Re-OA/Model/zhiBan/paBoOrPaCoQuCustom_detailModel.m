//
//  paBoOrPaCoQuCustom_detailModel.m
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "paBoOrPaCoQuCustom_detailModel.h"

@implementation paBoOrPaCoQuCustom_detailModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.ItemTotal=dict[@"ItemTotal"];
        self.OrderCode= dict[@"OrderCode"] ;
        self.PaperBoardName= dict[@"PaperBoardName"] ;
        self.PaperBoardCodeProduce=dict[@"PaperBoardCodeProduce"];
        
        self.PaperKai= dict[@"PaperKai"];
        self.PaperWidth=dict[@"PaperWidth"];
        self.PaperBoardLength=dict[@"PaperBoardLength"];
        self.OrderNum= dict[@"OrderNum"];
        self.SaleAmount= dict[@"SaleAmount"] ;
        self.PaperBoardSpecifications=dict[@"PaperBoardSpecifications"];
        
        self.ValuationSpecifications=dict[@"ValuationSpecifications"];
        self.PproducteExplain=dict[@"PproducteExplain"];
        
        self.DeliveryExplain=dict[@"DeliveryExplain"];
        self.BasePaperSquarePrice= dict[@"BasePaperSquarePrice"];
        self.SquarePrice= dict[@"SquarePrice"] ;
        self.BasePaperAmount= dict[@"BasePaperAmount"] ;
        self.ProcessingCost=dict[@"ProcessingCost"];
        self.BasePaperPercent= dict[@"BasePaperPercent"];
        
        
        self.Cube= dict[@"Cube"] ;
        self.Square=dict[@"Square"];
        self.OrderDateTime=dict[@"OrderDateTime"];
        self.ScheduleNum= dict[@"ScheduleNum"];
        self.DeliveryDateTime= dict[@"DeliveryDateTime"] ;
        self.CustomPurchaseNum=dict[@"CustomPurchaseNum"];
    
        self.CustomCode=dict[@"CustomCode"];
        self.Abbreviation= dict[@"Abbreviation"] ;
        self.PaperPrice=dict[@"PaperPrice"];
        self.Trimming= dict[@"Trimming"];
        self.TrimmingRatio= dict[@"TrimmingRatio"] ;
        
        self.Salesman=dict[@"Salesman"];
        self.DeliveryNum= dict[@"DeliveryNum"] ;
        self.TallyNum=dict[@"TallyNum"];
        self.CarNum= dict[@"CarNum"];
        self.PrintDateTime= dict[@"PrintDateTime"] ;
        
    }
    return self;
}
@end
