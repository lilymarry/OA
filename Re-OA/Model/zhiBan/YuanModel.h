//
//  YuanModel.h
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YuanModel : NSObject
@property(nonatomic,copy)NSString * WorkBackWeight;
@property (nonatomic,copy) NSString *WorkBackAmount;
@property (nonatomic,copy) NSString *InventoryLossWeight;
@property (nonatomic,copy)NSString * InventoryLossAmount ;
@property (nonatomic,copy) NSString *BasePaperWeight;
@property (nonatomic,copy)NSString * BasePaperAmount ;
-(instancetype)initWithDic:(NSDictionary *)dict;
@end
