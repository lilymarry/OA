
#import "URL.h"
#import "BaoJingWebAPI.h"
#import "NetRequestTool.h"
//网络接口
#define rwRequestList [NSString stringWithFormat:@"%@/Wap/WapJXCHandler.ashx",kDomain]

@implementation BaoJingWebAPI

+(void)requestBaoJingListWithjblx:(NSString *)jblx
                          Andpkey:(NSString*)pkey
                          Andrnum:(NSString*)rnum
                          Andtop:(NSString*)top
                          Andiszx:(NSString*)iszx
                          success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"method":@"jblist",@"jblx":jblx,@"pkey":pkey,@"rnum":rnum,@"top:":top,@"iszx":iszx};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
}

//获取列表新数据
+(void)requestNewBaoJingListWithjblx:(NSString *)jblx
                             Andpkey:(NSString*)pkey
                             Andiszx:(NSString*)iszx
                             success:(void (^)(NSArray *))success fail:(void (^)())fail
{
    NSDictionary * param = @{@"method":@"jbnew",@"jblx":jblx,@"pkey":pkey,@"iszx":iszx};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
}
//报警类型
+(void)requestBaoJIngLeiXingSuccess:(void (^)(NSArray *))success fail:(void (^)())fail
{
    NSDictionary * param = @{@"method":@"jbtyp"};
    [[NetRequestTool sharedRequest] request:param URL:rwRequestList success:success fail:fail];
}



@end
