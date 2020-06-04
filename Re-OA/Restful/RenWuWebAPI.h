
#import <Foundation/Foundation.h>

@interface RenWuWebAPI : NSObject

//图片接口http://192.168.0.253/Upload/11/Task/img/small/
+(NSString*)smallImgUrlPathWithUid:(NSString*)uid;
+(NSString*)largeImgUrlPathWithUid:(NSString*)uid;

#define rwSmallImgUrl 
#define rwLargeImgUrl 
//接收任务详情
+(void)requestReceivedDetailByUID:(NSString *)userid AndType:(NSString*)type AndTAID:(NSString*)taid success:(void(^)(NSArray *renwuArr))success fail:(void(^)())fail;

//点评任务
+(void)sendADianpingByTaopid:(NSString*)taopid Anddescription:(NSString*)description
                     success:(void (^)(NSArray *))success  fail:(void(^)())fail;
//method 固定写法 AddTaskOperation
//回复任务
+(void)doRenWuByuserid:(NSString*)userid
         Andtaid:(NSString*)taid
            Andtkonid:(NSString*)tkonid
            Andtodescription:(NSString*)todescription
            success:(void(^)(NSArray *renwuArr))success
                   fail:(void(^)())fail;
+(void)doRenWuByuserid:(NSString *)userid
               Andtaid:(NSString *)taid
             Andtkonid:(NSString *)tkonid
      Andtodescription:(NSString *)todescription
          AndUploadImg:(NSData *)_imgData
               success:(void (^)(NSArray *))success
                  fail:(void (^)())fail;
//派发任务
+(void)sendARenWuByname:(NSString*)name
         Anddescription:(NSString*)description
            Andstopdate:(NSString*)stopdate
            Andisremind:(NSString*)isremind
             Andiswatch:(NSString*)iswatch
            Andusername:(NSString*)username
              Anduserid:(NSString*)userid
       Andarraycjuserid:(NSString*)arraycjuserid
     Andarraycjusername:(NSString*)arraycjusername
                success:(void(^)(NSArray *renwuArr))success
                   fail:(void(^)())fail;
+(void)sendARenWuByname:(NSString*)name
         Anddescription:(NSString*)description
            Andstopdate:(NSString*)stopdate
            Andisremind:(NSString*)isremind
             Andiswatch:(NSString*)iswatch
            Andusername:(NSString*)username
              Anduserid:(NSString*)userid
       Andarraycjuserid:(NSString*)arraycjuserid
     Andarraycjusername:(NSString*)arraycjusername
           AndUploadImg:(NSData*)img
                success:(void (^)(NSArray *))success
                   fail:(void (^)())fail;

//任务列表
+(void)requestListByUID:(NSString *)userid AndType:(NSString*)type success:(void(^)(NSArray *renwuArr))success fail:(void(^)())fail;
+(void)requestListByUID:(NSString *)userid AndType:(NSString *)type  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail;
// 人员列表
+(void)requestUsersByUID:(NSString *)uid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

//删除任务
+(void)deleteSingleRenWu:(NSString *)taid
               success:(void (^)(NSArray *))success
                  fail:(void (^)())fail;
//未完成任务的数量
+(void)requestNumNotCompleteTaskWithUid:(NSString *)uid success:(void (^)(NSArray *))success fail:(void (^)())fail;

@end
