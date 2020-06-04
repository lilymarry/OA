//
//  ChangeHostWebAPI.h
//  Re-OA
//
//  Created by imac-1 on 2016/12/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeHostWebAPI : NSObject
//换热站列表
+(void)requestChangHotPageCount:(NSString *)PageCount page:(NSString *)page  MaxId:(NSString *)MaxId success:(void (^)(NSArray *))success fail:(void (^)())fail;
 
//新增记录
+(void)addHotChangeHTR_Userid:(NSString *)HTR_Userid HTR_Username:(NSString *)HTR_Username  HTR_SiteName:(NSString *)HTR_SiteName HTR_M:(NSString *)HTR_M
                    HTR_Mark1:(NSString *)HTR_Mark1  HTR_Consumption1:(NSString *)HTR_Consumption1
                    HTR_Mark2:(NSString *)HTR_Mark2  HTR_Consumption2:(NSString *)HTR_Consumption2
                    HTR_Mark3:(NSString *)HTR_Mark3  HTR_Consumption3:(NSString *)HTR_Consumption3 HTR_Fault:(NSString *)HTR_Fault  HTR_Date:(NSString *)HTR_Date  HTR_Id:(NSString *)HTR_Id

                      success:(void (^)(NSArray *))success fail:(void (^)())fail;
//站点
+(void)requestChangHotlistsuccess:(void (^)(NSArray *))success fail:(void (^)())fail;
//折线图
+(void)requestlineWithMethod:(NSString *)method getSiteName:(NSString *)getSiteName  getStartDate:(NSString *)getStartDate getEndDate:(NSString *)getEndDate success:(void (^)(NSArray *))success fail:(void (^)())fail;

@end

