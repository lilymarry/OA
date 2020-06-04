//
//  phoneLocationWebAPI.h
//  Re-OA
//
//  Created by admin on 15/1/15.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface phoneLocationWebAPI : NSObject
//发送当前用户坐标
+(void)userLocationWithId:(NSString *)uid  userName :(NSString *)username x :(NSString *)x y:(NSString *)y success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//获取用户列表
+(void)getUserlistWithId:(NSString *)uid   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

+(void)getUserInMapWithTpe: (NSString *) type  uid :(NSString *)uid  stime:(NSString *)stm etime :(NSString *)etm    success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
@end
