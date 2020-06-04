#import <Foundation/Foundation.h>

@interface TongZhiWebAPI : NSObject
+(void)tongZhiRequestWithID:(NSString *)uid journalID:(NSString *)jou noticeID:(NSString *)noti taskID:(NSString *)task  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)tongZhiRequestWithID:(NSString *)uid journalID:(NSString *)jou noticeID:(NSString *)noti taskID:(NSString *)task  flowID:(NSString *)flow baojing:(NSString *)baojing success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
@end
