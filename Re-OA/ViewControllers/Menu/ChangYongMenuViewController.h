
#import <UIKit/UIKit.h>
#import "MenuDelegate.h"
#import "LocationTracker.h"

@interface ChangYongMenuViewController : UIViewController<favoriteMenuSettingNotification>
@property LocationTracker * locationTracker;
@property (nonatomic) NSTimer* locationUpdateTimer;
@end
