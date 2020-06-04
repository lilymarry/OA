
#import "ShenHeWebAPI.h"
#import "URL.h"
#import "NetRequestTool.h"

//网络接口
#define shRequestList [NSString stringWithFormat:@"%@/Wap/WapFlowHandler.ashx",kDomain]

@implementation ShenHeWebAPI
+(NSString *)smallImgUrlPathWithUid:(NSString*)uid{
    return [NSString stringWithFormat:@"%@/Upload/%@/FLow/pic/small/",kDomain,uid];
}
+(NSString *)largeImgUrlPathWithUid:(NSString*)uid{
    return  [NSString stringWithFormat:@"%@/Upload/%@/FLow/pic/",kDomain,uid];
}
+(NSString *)voiceUrlPathWithUid:(NSString *)uid{
    return  [NSString stringWithFormat:@"%@/Upload/%@/FLow/voi/",kDomain,uid];
}
///
//审批详情 /Wap/WapFlowHandler.ashx?fpiId=50&method=fLocus
+(void)requestListByfpiId:(NSString *)fpiId
                  success:(void (^)(NSMutableArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"fpiId":fpiId,@"method":@"fLocus"};
    [[NetRequestTool sharedRequest] request:param URL:shRequestList success:success fail:fail];
}

//未审批列表  Wap/WapFlowHandler.ashx?u_id=13&method=adList&Adstate=0&ftyp=2
+(void)requestListByUID:(NSString *)userid
                AndType:(NSString *)type
             AndAdstate:(NSString*)Adstate
                success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"u_id":userid,@"ftyp":type,@"Adstate":Adstate,@"method":@"adList",};
    [[NetRequestTool sharedRequest] request:param URL:shRequestList success:success fail:fail];
}

+(void)requestListByUID:(NSString *)userid
                AndType:(NSString *)type
             AndAdstate:(NSString*)Adstate
                   pkey:(NSString *)fpiid
                   rnum:(NSString *)rNum
                     st:(NSString *)st
                      et:(NSString *)et
                  ouser:(NSString *)ouser
                  titkey:(NSString *)titkey
                success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"u_id":userid,@"ftyp":type,@"Adstate":Adstate,@"method":@"adList",@"pkey":fpiid,@"rNum":rNum,@"sttm":st,@"edtm":et ,@"ouser": ouser,@"titkey":titkey};
    [[NetRequestTool sharedRequest] request:param URL:shRequestList success:success fail:fail];
}

//批量   u_id=12&method=manyAd&acl=[{"ftyp":"3","fpiid":"34"},{"ftyp":"3","fpiid":"32"}]&adTyp=1
+(void)requestApproveAnyByUID:(NSString *)userid
                     AndadTyp:(NSString *)adTyp
                       Andacl:(NSString *)acl
                      success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"u_id":userid,@"adTyp":adTyp,@"acl":acl,@"method":@"manyAd"};
    [[NetRequestTool sharedRequest] request:param URL:shRequestList success:success fail:fail];
}

//审核操作   pric=&tit=&u_id=12&method=fNext&fpiid=73&adTyp=2&ftyp=1&toFsId=77&voi=&pic=&con=gg  1:同意  2:不同意  3:驳回
+(void)requestShenHeHandleByu_id:(NSString *)u_id
                        Andfpiid:(NSString *)fpiid
                        AndadTyp:(NSString *)adTyp
                         Andftyp:(NSString *)ftyp
                       AndtoFsId:(NSString *)toFsId
                          Andvoi:(NSString *)voi
                          Andpic:(NSString *)pic
                          Andcon:(NSString *)con
                          Andtit:(NSString *)tit
                         Andpric:(NSString *)pric
                         success:(void (^)(NSArray *))success
                            fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"fNext"
                             ,@"pric":pric
                             ,@"tit":tit
                             ,@"u_id":u_id
                             ,@"fpiid":fpiid
                             ,@"adTyp":adTyp
                             ,@"ftyp":ftyp
                             ,@"toFsId":toFsId
                             ,@"voi":voi
                             ,@"pic":pic
                             ,@"con":con
                             };
    [[NetRequestTool sharedRequest] request:param URL:shRequestList success:success fail:fail];
    
}

+(void)requestNumNotCompleteShenHeWithUid:(NSString *)uid ftyp:(NSString *)styp adstate:(NSString *)adstate success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"uid":uid,@"method":@"adcount",@"ftyp":styp,@"adstate":adstate};
    [[NetRequestTool sharedRequest] request:param URL:shRequestList success:success fail:fail];
}

+(void)requestShenHePersonWithFtyp:(NSString *)styp  success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"rtuser",@"ftyp":styp};
    [[NetRequestTool sharedRequest] request:param URL:shRequestList success:success fail:fail];
}

@end
















