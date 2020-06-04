//
//  OrderSummaryModel.m
//  Re-OA
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "OrderSummaryModel.h"

@implementation OrderSummaryModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.AfterDiscountAmount=dict[@"AfterDiscountAmount"];
        self.BasePaperAmount= dict[@"BasePaperAmount"];
        self.BasePaperProportion= dict[@"BasePaperProportion"] ;
        self.BeforeDiscountAmount=dict[@"BeforeDiscountAmount"];
        self.Cube= dict[@"Cube"] ;
        self.CustomerNum=dict[@"CustomerNum"];
        self.GrossProfit=dict[@"GrossProfit"];
        self.MeterNum= dict[@"MeterNum"];
        self.ModelsNum= dict[@"ModelsNum"] ;
        self.SalesMan=dict[@"SalesMan"];
        self.Square= dict[@"Square"] ;
    }
    return self;
}
@end
