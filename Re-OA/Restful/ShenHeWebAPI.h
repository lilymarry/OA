

#import <Foundation/Foundation.h>

@interface ShenHeWebAPI : NSObject
+(NSString*)smallImgUrlPathWithUid:(NSString*)uid;
+(NSString*)largeImgUrlPathWithUid:(NSString*)uid;
+(NSString*)voiceUrlPathWithUid:(NSString*)uid;
//未审核聊表
+(void)requestListByUID:(NSString *)userid
                AndType:(NSString*)type
                AndAdstate:(NSString*)Adstate
                success:(void(^)(NSArray *renwuArr))success fail:(void(^)())fail;

+(void)requestApproveAnyByUID:(NSString *)userid
                     AndadTyp:(NSString *)adTyp
                       Andacl:(NSString *)acl
                      success:(void (^)(NSArray *))success fail:(void (^)())fail;

+(void)requestListByfpiId:(NSString *)fpiId
                  success:(void (^)(NSMutableArray *))success fail:(void (^)())fail;


+(void)requestShenHeHandleByu_id:(NSString *)u_id
                Andfpiid:(NSString*)fpiid
             AndadTyp:(NSString*)adTyp
             Andftyp:(NSString*)ftyp
             AndtoFsId:(NSString*)toFsId
             Andvoi:(NSString*)voi
             Andpic:(NSString*)pic
             Andcon:(NSString*)con
             Andtit:(NSString*)tit
             Andpric:(NSString*)pric
                success:(void(^)(NSArray *renwuArr))success fail:(void(^)())fail;
//审核刷新
//+(void)requestListByUID:(NSString *)userid
//                AndType:(NSString *)type
//             AndAdstate:(NSString*)Adstate
//                   pkey:(NSString *)fpiid
//                   rnum:(NSString *)rNum
//                success:(void (^)(NSArray *))success fail:(void (^)())fail;
//审核未读条数
+(void)requestNumNotCompleteShenHeWithUid:(NSString *)uid ftyp:(NSString *)styp adstate:(NSString *)adstate success:(void (^)(NSArray *))success fail:(void (^)())fail;

+(void)requestShenHePersonWithFtyp:(NSString *)styp  success:(void (^)(NSArray *))success fail:(void (^)())fail;

+(void)requestListByUID:(NSString *)userid
                AndType:(NSString *)type
             AndAdstate:(NSString*)Adstate
                   pkey:(NSString *)fpiid
                   rnum:(NSString *)rNum
                     st:(NSString *)st
                     et:(NSString *)et
                  ouser:(NSString *)ouser
                  titkey:(NSString *)titkey
                success:(void (^)(NSArray *))success fail:(void (^)())fail;
@end
