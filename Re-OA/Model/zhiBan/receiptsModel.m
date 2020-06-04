//
//  receiptsModel.m
//  Re-OA
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "receiptsModel.h"

@implementation receiptsModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.Abbreviation=dict[@"Abbreviation"];
        self.BusinessMan= dict[@"BusinessMan"];
        self.IsStop= dict[@"IsStop"] ;
        self.Code=dict[@"Code"];
        self.CustomCode= dict[@"CustomCode"] ;
        self.ReceiptsDate=dict[@"ReceiptsDate"];
        self.Money=dict[@"Money"];
        self.SetDate= dict[@"SetDate"];
        self.SetMan= dict[@"SetMan"] ;
        self.Remark=dict[@"Remark"];
        self.Type= dict[@"Type"] ;
        
        self.State=dict[@"State"];
        self.ConfirmDate= dict[@"ConfirmDate"];
        self.ConfirmMan= dict[@"ConfirmMan"] ;
        self.BillCode=dict[@"BillCode"];
        self.SID= dict[@"SID"] ;
        self.ItemTotal=dict[@"ItemTotal"];
    }
    return self;
}
@end
