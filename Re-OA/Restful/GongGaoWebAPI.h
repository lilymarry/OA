#import <Foundation/Foundation.h>

@interface GongGaoWebAPI : NSObject
//公告用户人员列表
+(void)gongGaoPresonRequestlistID:(NSString *)uid  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//增加公告
+(void)addGongGaoRequestID:(NSString *)uid tittle:(NSString *)tit description:(NSString *)content acceptName:(NSString *)nameStr acceptID:(NSString *)nameID  userName:(NSString *) Username success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//全部公告
+(void)allGongGaoRequestID:(NSString *)uid sTime:(NSString *)stime eTime:(NSString *)etime  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//已发布公告
+(void)myGongGaoRequestID:(NSString *)uid sTime:(NSString *)stime eTime:(NSString *)etime  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//公告详细内容
+(void)gongGaoDetailedID:(NSString *)uid  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)myGongGaoRequestID:(NSString *)uid sTime:(NSString *)stime eTime:(NSString *)etime  neid:(NSString *)neid  page:(NSString *)page  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)allGongGaoRequestID:(NSString *)uid sTime:(NSString *)stime eTime:(NSString *)etime  neid:(NSString *)neid page:(NSString *)page success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)deleteSingleGongGao:(NSString *)neid success:(void (^)(NSArray *))success fail:(void (^)())fail;

@end

