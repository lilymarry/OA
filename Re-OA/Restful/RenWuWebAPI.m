
#import "URL.h"
#import "RenWuWebAPI.h"
#import "NetRequestTool.h"
//网络接口
#define rwRequestList [NSString stringWithFormat:@"%@/Wap/WapTaskHandler.ashx",kDomain]


@implementation RenWuWebAPI

+(NSString *)smallImgUrlPathWithUid:(NSString*)uid{
    return [NSString stringWithFormat:@"%@/Upload/%@/Task/img/small/",kDomain,uid];
}
+(NSString *)largeImgUrlPathWithUid:(NSString*)uid{
    return  [NSString stringWithFormat:@"%@/Upload/%@/Task/img/",kDomain,uid];
}

+(void)sendADianpingByTaopid:(NSString*)taopid Anddescription:(NSString*)description
                         success:(void (^)(NSArray *))success
                   fail:(void (^)())fail{
    
    NSDictionary * param = @{@"taopid":taopid,@"description":description,@"method":@"SubmitComments"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
    
}

+(void)doRenWuByuserid:(NSString *)userid
               Andtaid:(NSString *)taid
             Andtkonid:(NSString *)tkonid
      Andtodescription:(NSString *)todescription
               success:(void (^)(NSArray *))success
                  fail:(void (^)())fail{

    NSDictionary * param = @{@"userid":userid
                             ,@"taid":taid
                             ,@"tkonid":tkonid
                             ,@"todescription":todescription
                             ,@"method":@"AddTaskOperation"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];

}

+(void)doRenWuByuserid:(NSString *)userid
               Andtaid:(NSString *)taid
             Andtkonid:(NSString *)tkonid
      Andtodescription:(NSString *)todescription
                               AndUploadImg:(NSData *)_imgData
               success:(void (^)(NSArray *))success
                  fail:(void (^)())fail{
    
    NSDictionary * param = @{@"userid":userid
                             ,@"taid":taid
                             ,@"tkonid":tkonid
                             ,@"todescription":todescription
                             ,@"method":@"AddTaskOperation"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList imageData:_imgData success:success fail:fail];
    
}



+(void)requestReceivedDetailByUID:(NSString *)userid AndType:(NSString *)type AndTAID:(NSString *)taid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"uid":userid,@"type":type,@"taId":taid,@"method":@"ReleaseTaskDetailed"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
}

+(void)sendARenWuByname:(NSString*)name
         Anddescription:(NSString*)description
            Andstopdate:(NSString*)stopdate
            Andisremind:(NSString*)isremind
             Andiswatch:(NSString*)iswatch
            Andusername:(NSString*)username
              Anduserid:(NSString*)userid
       Andarraycjuserid:(NSString*)arraycjuserid
     Andarraycjusername:(NSString*)arraycjusername
                success:(void (^)(NSArray *))success
                   fail:(void (^)())fail{
    
    NSDictionary * param = @{@"name":name
                             ,@"description":description
                             ,@"stopdate":stopdate
                             ,@"isremind":isremind
                             ,@"iswatch":iswatch
                             ,@"username":username
                             ,@"userid":userid
                             ,@"arraycjuserid":arraycjuserid
                             ,@"arraycjusername":arraycjusername
                             ,@"method":@"AddTask"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
    
}

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
                   fail:(void (^)())fail{
    
    NSDictionary * param = @{@"name":name
                             ,@"description":description
                             ,@"stopdate":stopdate
                             ,@"isremind":isremind
                             ,@"iswatch":iswatch
                             ,@"username":username
                             ,@"userid":userid
                             ,@"arraycjuserid":arraycjuserid
                             ,@"arraycjusername":arraycjusername
                             ,@"method":@"AddTask"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList imageData:img success:success fail:fail];
    
}

+(void)requestListByUID:(NSString *)userid AndType:(NSString *)type success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"userid":userid,@"type":type,@"method":@"ReleaseTaskList"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
}
//任务列表刷新
+(void)requestListByUID:(NSString *)userid AndType:(NSString *)type  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"userid":userid,@"type":type,@"method":@"ReleaseTaskList",@"taid":taid,@"page":page};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
}
//任务派发人员
+(void)requestUsersByUID:(NSString *)uid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
{
    NSDictionary * param = @{@"uid":uid,@"method":@"DisplayDepartment"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
}

+(void)deleteSingleRenWu:(NSString *)taid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"taid":taid,@"method":@"DelTask"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
}
//
+(void)requestNumNotCompleteTaskWithUid:(NSString *)uid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"userid":uid,@"method":@"NotCompleteTaskCount"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
}


@end
