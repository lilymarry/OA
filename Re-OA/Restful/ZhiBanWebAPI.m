//
//  ZhiBanWebAPI.m
//  Re-OA
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "ZhiBanWebAPI.h"


#import "NetRequestTool.h"
#import "URL.h"
//网络接口
#define zhiBanAPI [NSString stringWithFormat:@"%@/Wap/WapReportHandler.ashx",kDomain]

@implementation ZhiBanWebAPI

//6.经营汇总
+(void)managementSummaryWithStartDate:(NSString *)StartDate endDate:(NSString *)endDate Suecss:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"managementSummary",@"StartDate":StartDate,@"EndDate":endDate};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
    
}
//5.业务员订单
+(void)businessManOrderSummaryWithStartDate:(NSString *)StartDate endDate:(NSString *)endDate
   success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"businessManOrderSummary",@"StartDate":StartDate,@"EndDate":endDate,@"type":@"1"};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
}
//1、收款明细
+(void)receiptsWithStartDate:(NSString *)StartDate endDate:(NSString *)endDate endCount:(NSString *)endCount count:(NSString *)count maxid:(NSString *)maxid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"receipts",@"StartDate":StartDate,@"EndDate":endDate,@"endCount":endCount,@"count":count,@"maxId":maxid};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
}
//2.退款明细
+(void)paperBoardReturnWithStartDate:(NSString *)StartDate endDate:(NSString *)endDate endCount:(NSString *)endCount count:(NSString *)count maxid:(NSString *)maxid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"paperBoardReturn",@"StartDate":StartDate,@"EndDate":endDate,@"endCount":endCount,@"count":count,@"maxId":maxid};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
    
}
//3 理货统计
+(void)tallyWithStartDate:(NSString *)StartDate endDate:(NSString *)endDate endCount:(NSString *)endCount count:(NSString *)count maxid:(NSString *)maxid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"tally",@"StartDate":StartDate,@"EndDate":endDate,@"endCount":endCount,@"count":count,@"maxId":maxid};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];

}
//4 送货统计
+(void)deliveryWithSendStartDate:(NSString *)SendStartDate SendEndDate:(NSString *)SendEndDate ReturnStartDate:(NSString *)ReturnStartDate ReturnEndDate:(NSString *)ReturnEndDate endCount:(NSString *)endCount count:(NSString *)count maxid:(NSString *)maxid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"delivery",@"SendStartDate":SendStartDate,@"SendEndDate":SendEndDate,@"ReturnStartDate":ReturnStartDate,@"ReturnEndDate":ReturnEndDate,@"endCount":endCount,@"count":count,@"maxId":maxid};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
}

//8.每日下单统计
+(void)paBoOrPaCoQuCustomWithSearchDate:(NSString *)SearchDate  endCount:(NSString *)endCount count:(NSString *)count maxid:(NSString *)maxid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"paBoOrPaCoQuCustom",@"SearchDate":SearchDate,@"endCount":endCount,@"count":count,@"maxId":maxid};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
}
//9.每日下单详情
+(void)paBoOrPaCoQuPaBoOrderDetailWithSearchDate:(NSString *)SearchDate CustomNum:(NSString *)CustomNum  endCount:(NSString *)endCount count:(NSString *)count maxid:(NSString *)maxid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"paBoOrPaCoQuPaBoOrder",@"SearchDate":SearchDate,@"CustomNum":CustomNum,@"endCount":endCount,@"count":count,@"maxId":maxid};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
}
//10.预警信息
+(void)paperBoardOrderExWithSearchDate:(NSString *)SearchDate OrderExNum:(NSString *)OrderExNum  endCount:(NSString *)endCount count:(NSString *)count maxid:(NSString *)maxid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"paperBoardOrderEx",@"SearchDate":SearchDate,@"OrderExNum":OrderExNum,@"endCount":endCount,@"count":count,@"maxId":maxid};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
}

//1.根据用户ID和时间获取可查看业务员的订单统计
+(void)ReportBusinessManOrderWithSearchDate:(NSString *)SearchDate  uid:(NSString *)uid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"ReportBusinessManOrder",@"date":SearchDate,@"uid":uid};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
}
//2.根据业务员和时间获取纸箱厂订单统计
+(void)ReportDayOrderWithSearchDate:(NSString *)SearchDate  yw:(NSString *)yw  success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"ReportDayOrder",@"date":SearchDate,@"yw":yw};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
}
//3.根据纸箱厂CODE和时间获取订单详情
+(void)ReportDayDetailWithSearchDate:(NSString *)SearchDate  CustomNum:(NSString *)CustomNum  success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"ReportDayDetail",@"date":SearchDate,@"CustomNum":CustomNum};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
}
//原纸仓存
+(void)getyZcWithsuccess:(void (^)(NSArray *))success fail:(void (^)())fail{
   // NSDictionary * param = @{@"method":@"yzcc"};
    NSDictionary * param = @{@"method":@"yuanzhicangcun"};
    [[NetRequestTool sharedRequest] request:param URL:zhiBanAPI success:success fail:fail];
    
}


@end
