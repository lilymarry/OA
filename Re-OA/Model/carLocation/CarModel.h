//
//  CarModel.h
//  Re-OA
//
//  Created by admin on 15/1/23.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
@property(nonatomic,copy)NSString *userName;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *km;
-(instancetype)initWithDic:(NSDictionary *)dict;
@end
