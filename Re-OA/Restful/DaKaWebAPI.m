

#import "DaKaWebAPI.h"
#import "NetRequestTool.h"
#import "URL.h"
#import <BMapKit.h>

//网络接口
#define dkRequestList [NSString stringWithFormat:@"%@/Wap/WapAtWorkHandler.ashx",kDomain]


@implementation DaKaWebAPI

+(void)requestDakaInfoByUID:(NSString *)uid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"uid":uid,@"method":@"serTm"};
    [[NetRequestTool sharedRequest] requestCommon:param URL:dkRequestList success:success fail:fail];
}

+(void)requestDakaActionByUID:(NSString *)uid AndType:(NSString*)type AndCoornidate:(CLLocationCoordinate2D)coor  success:(void (^)(NSArray *))success fail:(void (^)())fail{
    
    CLLocationCoordinate2D loca2D = CLLocationCoordinate2DMake(coor .latitude , coor.longitude );
    NSDictionary *baidu = BMKConvertBaiduCoorFrom(loca2D,BMK_COORDTYPE_GPS);
    CLLocationCoordinate2D trans = BMKCoorDictionaryDecode(baidu);
    
    NSDictionary * param = @{@"uid":uid,@"typ":type,@"x":[NSString stringWithFormat:@"%lf", trans.longitude],@"y":[NSString stringWithFormat:@"%lf",trans.latitude],@"method":@"pcard"};
    [[NetRequestTool sharedRequest] requestCommon:param URL:dkRequestList success:success fail:fail];
}

@end
