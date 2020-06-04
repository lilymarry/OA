//
//  CarLocationWebAPI.h
//  Re-OA
//
//  Created by admin on 15/1/23.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarLocationWebAPI : NSObject
+(void)getCarlistWithSuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

//车辆定位

+(void)getCarInMapWithTpe: (NSString *) type  cid :(NSString *)cid  stime:(NSString *)stm etime :(NSString *)etm    success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
@end
