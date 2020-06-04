#import <Foundation/Foundation.h>

@interface RizhiWebAPI : NSObject

+(void)myRizhiRequestlistID:(NSString *)uid startTime:(NSString *)stime edTime :(NSString *)etime success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)addRizhiRequestlistID:(NSString *)uid tittleName:(NSString *)tittle userName :(NSString *)userName andContent:(NSString *)description success:(void(^)(NSArray *arr))success fail:(void(^)())fail;
+(void)allRizhiRequestlistID:(NSString *)uid startTime:(NSString *)stime edTime :(NSString *)etime success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)AddCommentJournal:(NSString *)jid context:(NSString *)description username:(NSString *)userName userId :(NSString*)uid success:(void(^)(NSArray *arr))success fail:(void(^)())fail;
+(void)AddCommentJournal:(NSString *)jid  success:(void(^)(NSArray *arr))success fail:(void(^)())fail;
+(void)scanJournalDetail:(NSString *)jid type :(NSString *)type success:(void(^)(NSArray *arr))success fail:(void(^)())fail;
+(void)myRizhiRequestlistID:(NSString *)uid startTime:(NSString *)stime edTime :(NSString *)etime joid:(NSString *)joid page:(NSString *)page success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)allRizhiRequestlistID:(NSString *)uid startTime:(NSString *)stime edTime :(NSString *)etime joid:(NSString *)joid  page:(NSString *)page success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

+(void)deleteSingleRiZhi:(NSString *)joid success:(void (^)(NSArray *))success fail:(void (^)())fail;
@end
