
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface DaKaWebAPI : NSObject

+(void)requestDakaInfoByUID:(NSString *)uid success:(void(^)(NSArray *userDict))success fail:(void(^)())fail;

+(void)requestDakaActionByUID:(NSString *)uid  AndType:(NSString*)type AndCoornidate:(CLLocationCoordinate2D)coor   success:(void(^)(NSArray *userDict))success fail:(void(^)())fail;


@end
