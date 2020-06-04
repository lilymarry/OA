//
//  BoardReturnModel.h
//  Re-OA
//
//  Created by 123 on 16/3/13.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoardReturnModel : NSObject

@property (nonatomic,copy)NSString * Code ;
@property (nonatomic,copy)NSString * Date ;


@property(nonatomic,copy)NSString * DeliveryCode;
@property (nonatomic,copy) NSString *OrderCode;
@property (nonatomic,copy) NSString *PbrAmount;



@property (nonatomic,copy) NSString * Money ;
@property (nonatomic,copy)NSString * Freight ;

@property (nonatomic,copy)NSString * FreightSquare  ;

@property(nonatomic,copy)NSString * MoneyRateOfDiscount ;
@property (nonatomic,copy) NSString *Reason ;

@property (nonatomic,copy) NSString *PricePaperBoard;
@property (nonatomic,copy)NSString *  CustomCode ;

@property(nonatomic,copy)NSString * Abbreviation;
@property (nonatomic,copy) NSString *CustomName ;

@property (nonatomic,copy) NSString * PaperBoardCode;
@property (nonatomic,copy)NSString *  RateOfDiscount ;
@property (nonatomic,copy)NSString *   PaperBoardWidth  ;



@property (nonatomic,copy) NSString * PaperBoardLength ;
@property (nonatomic,copy)NSString * PerVolumeAmount ;

@property (nonatomic,copy)NSString *PerSquareMeterAmount  ;

@property(nonatomic,copy)NSString * PerSquareMeterFiveLayersAmount ;
@property (nonatomic,copy) NSString * PricSpec ;

@property (nonatomic,copy) NSString *SpecEx ;
@property (nonatomic,copy)NSString *  MastPerson ;

@property(nonatomic,copy)NSString * SecondPerson;
@property (nonatomic,copy) NSString *PlateNumber ;

@property (nonatomic,copy) NSString * PlateNumberEx;
@property (nonatomic,copy)NSString *  Driver ;
@property (nonatomic,copy)NSString *   State  ;


@property (nonatomic,copy) NSString * SetDate ;
@property (nonatomic,copy)NSString * SetMan ;

@property (nonatomic,copy)NSString *ProcessMode  ;

@property(nonatomic,copy)NSString * PboAmount ;
@property (nonatomic,copy) NSString * TimeBeginProduce ;

@property (nonatomic,copy) NSString *TeamName ;
@property (nonatomic,copy)NSString *  ReturnAmount ;

@property(nonatomic,copy)NSString * PitCode;
@property (nonatomic,copy) NSString *DeliveryMan ;

@property (nonatomic,copy) NSString * SID;
@property (nonatomic,copy)NSString *  ItemTotal ;
-(instancetype)initWithDic:(NSDictionary *)dict;
@end
