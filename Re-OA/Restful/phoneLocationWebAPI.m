//
//  phoneLocationWebAPI.m
//  Re-OA
//
//  Created by admin on 15/1/15.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "phoneLocationWebAPI.h"
#import "NetRequestTool.h"
#import "URL.h"
@implementation phoneLocationWebAPI
 #define PhoneLocusAPI [NSString stringWithFormat:@"%@/Wap/WapUserMapHandler.ashx?",kDomain]
//发送当前用户坐标
+(void)userLocationWithId:(NSString *)uid  userName :(NSString *)username x :(NSString *)x y:(NSString *)y success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"u_id":uid,@"uname":username, @"x":x,@"y":y,@"method":@"InMapUserLocus"};
    
    
    [[NetRequestTool sharedRequest]request :dic URL:PhoneLocusAPI success:success fail:fail];
}
//获取人员列表
+(void)getUserlistWithId:(NSString *)uid   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{

    NSDictionary *dic=@{@"uid":uid,@"method":@"DisplayDepartment"};
    
    
    [[NetRequestTool sharedRequest]request :dic URL:PhoneLocusAPI success:success fail:fail];

}
//获取人员具体位置
+(void)getUserInMapWithTpe: (NSString *) type  uid :(NSString *)uid  stime:(NSString *)stm etime :(NSString *)etm    success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{   //tp  类别（all全部， his历史， one个人）
       NSDictionary *dic=@{@"tp":type,  @"u_id":uid, @"stm":stm,@"etm":etm, @"method":@"usrm"};
    
    
    [[NetRequestTool sharedRequest]request :dic URL:PhoneLocusAPI success:success fail:fail];

}
@end
