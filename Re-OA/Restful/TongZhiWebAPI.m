#import "TongZhiWebAPI.h"
#import "URL.h"
#import "NetRequestTool.h"
#define tongZhiApi [NSString stringWithFormat:@"%@/Wap/WapGeneralReminderHandler.ashx?",kDomain]
@implementation TongZhiWebAPI
+(void)tongZhiRequestWithID:(NSString *)uid journalID:(NSString *)jou noticeID:(NSString *)noti taskID:(NSString *)task  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"journal":jou,@"notice":noti,@"task":task,@"method":@"GeneralReminder"};
    [[NetRequestTool sharedRequest]request :dic URL:tongZhiApi success:success fail:fail];
}
+(void)tongZhiRequestWithID:(NSString *)uid journalID:(NSString *)jou noticeID:(NSString *)noti taskID:(NSString *)task  flowID:(NSString *)flow baojing:(NSString *)baojing success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"uid":uid,@"journal":jou,@"notice":noti,@"task":task,@"method":@"GeneralReminder",@"flow":flow,@"baojing":baojing}; 
    [[NetRequestTool sharedRequest]request :dic URL:tongZhiApi success:success fail:fail];
}
@end
