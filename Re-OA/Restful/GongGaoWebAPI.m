#import "GongGaoWebAPI.h"
#import "URL.h"
#import "NetRequestTool.h"
@implementation GongGaoWebAPI
//公告接口
#define GongGaoRequest [NSString stringWithFormat:@"%@/Wap/WapNoticeHandler.ashx?",kDomain]
//公告用户人员列表
+(void)gongGaoPresonRequestlistID:(NSString *)uid  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"method":@"DisplayDepartment"};
    [[NetRequestTool sharedRequest]request :dic URL:GongGaoRequest success:success fail:fail];
}
//添加公告
+(void)addGongGaoRequestID:(NSString *)uid tittle:(NSString *)tit description:(NSString *)content acceptName:(NSString *)nameStr acceptID:(NSString *)nameID  userName:(NSString *) Username success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"title":tit,@"description":content,@"arraycjusername": nameStr,@"arraycjuserid": nameID, @"method":@"AddNotice",@"username":Username};
    [[NetRequestTool sharedRequest]request :dic URL:GongGaoRequest success:success fail:fail];
}
//全部公告
+(void)allGongGaoRequestID:(NSString *)uid sTime:(NSString *)stime eTime:(NSString *)etime  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"qdate":stime,@"hdate":etime, @"method":@"NoticeMarkingData"};
    [[NetRequestTool sharedRequest]request :dic URL:GongGaoRequest success:success fail:fail];
}
//已发布公告
+(void)myGongGaoRequestID:(NSString *)uid sTime:(NSString *)stime eTime:(NSString *)etime  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"qdate":stime,@"hdate":etime, @"method":@"NoticeOwnData"};
    [[NetRequestTool sharedRequest]request :dic URL:GongGaoRequest success:success fail:fail];
    
}
//刷新全部公告
+(void)allGongGaoRequestID:(NSString *)uid sTime:(NSString *)stime eTime:(NSString *)etime  neid:(NSString *)neid page:(NSString *)page success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"qdate":stime,@"hdate":etime, @"method":@"NoticeMarkingData",@"neid":neid,@"page":page};
    [[NetRequestTool sharedRequest]request :dic URL:GongGaoRequest success:success fail:fail];
}
//刷新已发布公告
+(void)myGongGaoRequestID:(NSString *)uid sTime:(NSString *)stime eTime:(NSString *)etime  neid:(NSString *)neid  page:(NSString *)page  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"qdate":stime,@"hdate":etime, @"method":@"NoticeOwnData",@"neid":neid,@"page":page};
    [[NetRequestTool sharedRequest]request :dic URL:GongGaoRequest success:success fail:fail];
    
}
//公告详细内容
+(void)gongGaoDetailedID:(NSString *)uid  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"neid":uid, @"method":@"NoticeDetailed"};
    [[NetRequestTool sharedRequest]request :dic URL:GongGaoRequest success:success fail:fail];

}

+(void)deleteSingleGongGao:(NSString *)neid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"neid":neid,@"method":@"DelNotice"};
    [[NetRequestTool sharedRequest] request:param URL:GongGaoRequest success:success fail:fail];
}
@end
