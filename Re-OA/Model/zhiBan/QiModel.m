//
//  QiModel.m
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "QiModel.h"

@implementation QiModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.RecieveAmount=dict[@"RecieveAmount"];
        self.OtherSales= dict[@"OtherSales"];
        self.ReturnGoodsAmount= dict[@"ReturnGoodsAmount"] ;
        self.DebitAmount=dict[@"DebitAmount"];
        self.ActualSales= dict[@"ActualSales"] ;
        self.GrossProfit=dict[@"GrossProfit"];
        
        self.GrossProfitTwo=dict[@"GrossProfitTwo"];
        self.GrossProfitThree= dict[@"GrossProfitThree"];
        self.EstimatedProfit= dict[@"EstimatedProfit"] ;
        self.EstimatedProfitTwo=dict[@"EstimatedProfitTwo"];
        self.Freight= dict[@"Freight"] ;
        self.ShareAmount=dict[@"ShareAmount"];
        
        self.AuxiliaryAmount=dict[@"AuxiliaryAmount"];
        
    }
    return self;
}
@end
