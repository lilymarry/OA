//
//  JianKongWebAPI.h
//  Re-OA
//
//  Created by imac-1 on 15/6/9.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JianKongWebAPI : NSObject
+(void)gongChangQuYuSuecss:(void (^)(NSArray *))success fail:(void (^)())fail;
+(void)GongChangHuaFen:(NSString *)gcid Suecss:(void (^)(NSArray *))success fail:(void (^)())fail;
+(void)requestJianKongListWithgcid:(NSString *)gcid lxid:(NSString *)lxid
                           success:(void (^)(NSArray *))success fail:(void (^)())fail;
+(void)requestIPsuccess:(void (^)(NSArray *))success fail:(void (^)())fail;

@end
