
#import <UIKit/UIKit.h>
#import <BMapKit.h>
#import "LoginViewController.h"
#import "UserPermission.h"
//#import "APService.h"
#import "URL.h"
#import "NetRequestTool.h"
static NSString *appKey = JpuchKey;
static NSString *channel = @"Publish channel";
static BOOL isProduction = isProductionKey;
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    int timerCount;
    NSTimer  *timer;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong ,nonatomic) BMKMapManager *mapManager;
@end
