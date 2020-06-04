#import "RizhiWebAPI.h"
#import "URL.h"
#import "NetRequestTool.h"
@implementation RizhiWebAPI
//日志接口
#define RizhiRequest [NSString stringWithFormat:@"%@/Wap/WapJournalHandler.ashx?",kDomain]
//我的日志list
+(void)myRizhiRequestlistID:(NSString *)uid startTime:(NSString *)stime edTime :(NSString *)etime success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"qdate":stime,@"hdate":etime,@"method":@"JournalOwnData"};
    [[NetRequestTool sharedRequest]request :dic URL:RizhiRequest success:success fail:fail];
}
//刷新我的日志list
+(void)myRizhiRequestlistID:(NSString *)uid startTime:(NSString *)stime edTime :(NSString *)etime joid:(NSString *)joid page:(NSString *)page success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"qdate":stime,@"hdate":etime,@"method":@"JournalOwnData" ,@"joid":joid,@"page":page};
    [[NetRequestTool sharedRequest]request :dic URL:RizhiRequest success:success fail:fail];
}
//全部rizhi
+(void)allRizhiRequestlistID:(NSString *)uid startTime:(NSNull *)stime edTime :(NSNull *)etime success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"qdate":stime,@"hdate":etime,@"method":@"JournalMarkingData" };
    [[NetRequestTool sharedRequest]request:dic URL:RizhiRequest success:success fail:fail];
}
//刷新全部rizhi
+(void)allRizhiRequestlistID:(NSString *)uid startTime:(NSString *)stime edTime :(NSString *)etime joid:(NSString *)joid  page:(NSString *)page success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"qdate":stime,@"hdate":etime,@"method":@"JournalMarkingData" ,@"joid":joid,@"page":page};
    [[NetRequestTool sharedRequest]request:dic URL:RizhiRequest success:success fail:fail];
}
//创建日志
+(void)addRizhiRequestlistID:(NSString *)uid tittleName:(NSString *)tittle userName :(NSString *)userName andContent:(NSString *)description success:(void(^)(NSArray *arr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"title":tittle,@"uid":uid,@"username":userName,@"description":description,@"method":@"AddJournal"};
    [[NetRequestTool sharedRequest]request:dic URL:RizhiRequest success:success fail:fail];
}
//评论日志
+(void)AddCommentJournal:(NSString *)jid context:(NSString *)description username:(NSString *)userName userId :(NSString*)uid success:(void(^)(NSArray *arr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"joid":jid,@"description":description,@"username":userName,@"uid":uid,@"method":@"AddCommentJournal"};
    [[NetRequestTool sharedRequest]request:dic URL:RizhiRequest success:success fail:fail];
}
//评论内容
+(void)AddCommentJournal:(NSString *)jid  success:(void(^)(NSArray *arr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"joid":jid,@"method":@"GetCommentJournal"};
    [[NetRequestTool sharedRequest]request:dic URL:RizhiRequest success:success fail:fail];
    
}
//查看日志详情
+(void)scanJournalDetail:(NSString *)jid type :(NSString *)type success:(void(^)(NSArray *arr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"joid":jid,@"method":@"JournalCommentData",@"type":type};
    [[NetRequestTool sharedRequest]request:dic URL:RizhiRequest success:success fail:fail];
}

+(void)deleteSingleRiZhi:(NSString *)joid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"joid":joid,@"method":@"DelJournal"};
    [[NetRequestTool sharedRequest] request:param URL:RizhiRequest success:success fail:fail];
}

@end