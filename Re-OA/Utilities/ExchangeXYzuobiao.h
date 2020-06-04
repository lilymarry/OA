#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@interface ExchangeXYzuobiao : NSObject
+(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps;
// GPS坐标转谷歌坐标
+ (CLLocationCoordinate2D)getBaiduLocFromGoogleLocLat:(CGFloat)fGoogleLat lng:(CGFloat)fGoogleLng;
@end
