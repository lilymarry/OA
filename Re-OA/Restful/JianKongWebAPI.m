//
//  JianKongWebAPI.m
//  Re-OA
//
//  Created by imac-1 on 15/6/9.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JianKongWebAPI.h"
#import "NetRequestTool.h"
#import "URL.h"
//网络接口
#define jkRequestList [NSString stringWithFormat:@"%@/Wap/WapJXCHandler.ashx",kDomain]

@implementation JianKongWebAPI
//获取区域工厂信息
+(void)gongChangQuYuSuecss:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"sxdqgc"};
    [[NetRequestTool sharedRequest] request:param URL:jkRequestList success:success fail:fail];
    
}
//获取工厂内部 厂区划分
+(void)GongChangHuaFen:(NSString *)gcid Suecss:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"sxleixing",@"gcid":gcid};
    [[NetRequestTool sharedRequest] request:param URL:jkRequestList success:success fail:fail];


}
+(void)requestJianKongListWithgcid:(NSString *)gcid lxid:(NSString *)lxid
success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"sxdata",@"gcid":gcid,@"lxid":lxid};
    [[NetRequestTool sharedRequest] request:param URL:jkRequestList success:success fail:fail];
}

//ip
+(void)requestIPsuccess:(void (^)(NSArray *))success fail:(void (^)())fail{
 
    [[NetRequestTool sharedRequest] request:nil URL:kGetIP_API success:success fail:fail];
}


@end
