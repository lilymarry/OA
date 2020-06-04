//
//  TallyModel.h
//  Re-OA
//
//  Created by 123 on 16/3/13.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TallyModel : NSObject
@property (nonatomic,copy)NSString * State ;
@property (nonatomic,copy)NSString * StateApprove ;
@property(nonatomic,copy)NSString * SetMan;
@property (nonatomic,copy) NSString *TallyMan;
@property (nonatomic,copy) NSString *DeliveryMan;
@property (nonatomic,copy) NSString * PrintMan ;
@property (nonatomic,copy)NSString * Stevedore ;

@property (nonatomic,copy)NSString * Code   ;

@property(nonatomic,copy)NSString * SetDate  ;
@property (nonatomic,copy) NSString *PrintTime ;

@property (nonatomic,copy) NSString *VehicleCode ;
@property (nonatomic,copy)NSString *  Driver ;

@property(nonatomic,copy)NSString * DeliveryDate;
@property (nonatomic,copy) NSString *RateFreight ;

@property (nonatomic,copy) NSString * Freight;
@property (nonatomic,copy)NSString *  TheoryFreight ;
@property (nonatomic,copy)NSString *   PlateNumber  ;



@property (nonatomic,copy) NSString * CustomAmount ;
@property (nonatomic,copy)NSString * Mileage ;

@property (nonatomic,copy)NSString *MoneyDelivery   ;

@property(nonatomic,copy)NSString * Volume ;
@property (nonatomic,copy) NSString *VolumePrice ;

@property (nonatomic,copy) NSString *Weight ;
@property (nonatomic,copy)NSString *  fnGetTallyCustomName ;

@property(nonatomic,copy)NSString * Mobile ;
@property (nonatomic,copy) NSString *OrderAmount ;

@property (nonatomic,copy) NSString * ReturnAmount;
@property (nonatomic,copy) NSString * ReturnTime;


@property (nonatomic,copy)NSString *  HasDelivery ;
@property (nonatomic,copy)NSString *   DeliveryHasPrinted  ;


@property (nonatomic,copy) NSString * HasFreight ;
@property (nonatomic,copy)NSString * SquareAmount ;

@property (nonatomic,copy)NSString *SquareFiveLayers  ;

@property(nonatomic,copy)NSString * SquareFiveLayersPrice ;

@property(nonatomic,copy)NSString * FreightSquare ;


@property (nonatomic,copy) NSString * TheoryFreightSquare ;

@property (nonatomic,copy) NSString *CustomSubsidy ;
@property (nonatomic,copy)NSString *  OrderSubsidy ;

@property(nonatomic,copy)NSString * Remark;
@property (nonatomic,copy) NSString *Sequence ;

@property (nonatomic,copy)NSString *  BillAmount ;

@property(nonatomic,copy)NSString * FreightByCustomOnly;
@property (nonatomic,copy) NSString *RateByCustomOnly ;

@property (nonatomic,copy) NSString * SID;
@property (nonatomic,copy)NSString *  ItemTotal;
-(instancetype)initWithDic:(NSDictionary *)dict;

@end
