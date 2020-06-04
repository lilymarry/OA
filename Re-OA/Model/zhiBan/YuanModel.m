//
//  YuanModel.m
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "YuanModel.h"

@implementation YuanModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.WorkBackAmount=dict[@"WorkBackAmount"];
        self.WorkBackWeight= dict[@"WorkBackWeight"];
        self.InventoryLossAmount= dict[@"InventoryLossAmount"] ;
        self.InventoryLossWeight=dict[@"InventoryLossWeight"];
        self.BasePaperAmount= dict[@"BasePaperAmount"] ;
        self.BasePaperWeight=dict[@"BasePaperWeight"];
        
    }
    return self;
}
@end
