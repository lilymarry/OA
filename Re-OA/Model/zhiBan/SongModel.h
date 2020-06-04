//
//  SongModel.h
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongModel : NSObject
@property(nonatomic,copy)NSString * DeliveryWeight;
@property (nonatomic,copy) NSString *DeliveryAmount;
@property (nonatomic,copy) NSString *ReturnAmount;
@property (nonatomic,copy)NSString * ReturnDifference ;
@property (nonatomic,copy) NSString *DeliverySquare;
@property (nonatomic,copy) NSString *DeliverySaleSquare;
@property (nonatomic,copy)NSString * DeliveryVolume ;
-(instancetype)initWithDic:(NSDictionary *)dict;
@end
