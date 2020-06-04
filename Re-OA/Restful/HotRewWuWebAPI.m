//
//  HotRewWuWebAPI.m
//  Re-OA
//
//  Created by imac-1 on 2016/12/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "HotRewWuWebAPI.h"
#import "URL.h"
#import "NetRequestTool.h"
#define rwHotRequestList [NSString stringWithFormat:@"%@/Wap/WapHeatTaskHandler.ashx",kDomain]
@implementation HotRewWuWebAPI
#pragma mark -----热力任务

//热力我的任务接口
+(void)requestHostListByUID:(NSString *)userid AndType:(NSString *)type  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"userid":userid,@"method":@"MyTask",@"maxid":taid,@"page":page};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}
//发布任务接口
+(void)requestReleaseTaskByUID:(NSString *)userid AndType:(NSString *)type  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"userid":userid,@"method":@"ReleaseTask",@"maxid":taid,@"page":page};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}

///我的任务
+(void)requestTaskByUID:(NSString *)userid method:(NSString *)method  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"userid":userid,@"method":method,@"maxid":taid,@"page":page};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}

//全部任务接口
+(void)requestAllTaskByUID:(NSString *)userid AndType:(NSString *)type  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"userid":userid,@"method":@"AllTask",@"maxid":taid,@"page":page};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}
//分配人员任务
+(void)sendPersonListTaid:(NSString *)taid arraycjuserid:(NSString *)arraycjuserid arraycjusername:(NSString *)arraycjusername  success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"Ta_Id":taid,@"method":@"AddPersonnel",@"arraycjuserid":arraycjuserid,@"arraycjusername":arraycjusername};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}
//任务派发人员列表
+(void)requestHotUsersByUID:(NSString *)uid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
{
    NSDictionary * param = @{@"uid":uid,@"method":@"DisplayDepartment"};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}
//工头审核
+(void)AddAuditWithTaid:(NSString *)taid Taop_Describe:(NSString *)Taop_Describe   success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"Ta_Id":taid,@"method":@"AddAudit",@"Taop_FDescribe":Taop_Describe};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}
//热力任务 详情
+(void)requestHotReceivedDetailByUID:(NSString *)userid AndType:(NSString *)type AndTAID:(NSString *)taid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"uid":userid,@"type":type,@"taId":taid,@"method":@"ReleaseHeatTaskDetailed"};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}
//热力图片上传
+(void)requestHotPicByUID:(NSString *)userid AndType:(NSString *)type AndTkonid:(NSString *)tkonid Taop_Longitude:(NSString *)Taop_Longitude Taop_Latitude:(NSString *)Taop_Latitude Taop_Describe:(NSString *)Taop_Describe
                   imaArr:(NSArray *)imaArr success:(void (^)(NSArray *))success fail:(void (^)())fail progress:(void (^)(float))progress{
    NSDictionary * param = @{@"userid":userid,@"type":type,@"tkonid":tkonid,@"Taop_Longitude":Taop_Longitude,@"Taop_Latitude":Taop_Latitude,@"method":@"Img",@"Taop_Describe":Taop_Describe};
    [[NetRequestTool sharedRequest] requestMorePic:param URL:rwHotRequestList images:imaArr success:success
                                              fail:fail progress:progress];
}//热力图片
+(NSString *)HotImgUrlPathWithUid:(NSString*)uid type:(NSString *)type pcName:(NSString *)picNam{
    return  [NSString stringWithFormat:@"%@/Upload/%@/HeatTask/img/%@/%@",kDomain,uid,type,picNam];
}
//上传任务描述
+(void)requestHotDiscriptionByUID:(NSString *)userid AndTodescription:(NSString *)todescription AndTAID:(NSString *)taid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"userid":userid,@"todescription":todescription,@"tkonid":taid,@"method":@"AddHeatTaskOperation"};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}
//任务完成
+(void)requestFinishHotTaop_Id:(NSString *)Taop_Id AndTaop_Taid:(NSString *)Taop_Taid   success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"Taop_Id":Taop_Id,@"Taop_Taid":Taop_Taid,@"method":@"WCHeatTask"};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];
}
//评价
+(void)requestTaskFinishHotTaop_Id:(NSString *)Taop_Id Ta_Satisfied:(NSString *)Ta_Satisfied Ta_SatisfiedDes:(NSString *)Ta_SatisfiedDes   success:(void (^)(NSArray *))success fail:(void (^)())fail
{
    NSDictionary * param = @{@"taId":Taop_Id,@"Ta_Satisfied":Ta_Satisfied,@"Ta_SatisfiedDes":Ta_SatisfiedDes,@"method":@"AddSatisfied"};
    [[NetRequestTool sharedRequest] request:param URL:rwHotRequestList success:success fail:fail];

}




@end
