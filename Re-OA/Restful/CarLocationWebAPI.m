//
//  CarLocationWebAPI.m
//  Re-OA
//
//  Created by admin on 15/1/23.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "CarLocationWebAPI.h"
#import "URL.h"
#import "NetRequestTool.h"
#define carLocusAPI [NSString stringWithFormat:@"%@/Wap/WapCarMapHandler.ashx?",kDomain]
@implementation CarLocationWebAPI
//CarList获取车辆表单

+(void)getCarlistWithSuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
   [[NetRequestTool sharedRequest]request :@{@"method":@"CarList"} URL:carLocusAPI success:success fail:fail];

}
//车辆定位

+(void)getCarInMapWithTpe: (NSString *) type  cid :(NSString *)cid  stime:(NSString *)stm etime :(NSString *)etm    success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
 
    NSDictionary *dic=@{@"tp":type,  @"cid":cid, @"stm":stm,@"etm":etm, @"method":@"carm"};
    
    
    [[NetRequestTool sharedRequest]request :dic URL:carLocusAPI success:success fail:fail];
 

}
@end
