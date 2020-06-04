//
//  receiptsModel.h
//  Re-OA
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface receiptsModel : NSObject
@property(nonatomic,copy)NSString * Abbreviation;
@property (nonatomic,copy) NSString *BusinessMan;
@property (nonatomic,copy) NSString *IsStop;
@property (nonatomic,copy)NSString * Code ;


@property (nonatomic,copy) NSString * CustomCode ;
@property (nonatomic,copy)NSString * ReceiptsDate ;

@property (nonatomic,copy)NSString * Money  ;

@property(nonatomic,copy)NSString * SetDate;
@property (nonatomic,copy) NSString *SetMan;

@property (nonatomic,copy) NSString *Remark;
@property (nonatomic,copy)NSString *  Type;

@property(nonatomic,copy)NSString * State;
@property (nonatomic,copy) NSString *ConfirmDate;

@property (nonatomic,copy) NSString *ConfirmMan;
@property (nonatomic,copy)NSString *  BillCode ;
@property (nonatomic,copy)NSString *   SID  ;
@property (nonatomic,copy)NSString *  ItemTotal ;
-(instancetype)initWithDic:(NSDictionary *)dict;
@end
