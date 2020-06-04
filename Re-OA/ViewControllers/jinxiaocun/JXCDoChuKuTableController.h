

#import <UIKit/UIKit.h>
#import "CommonDelegate.h"

@interface JXCDoChuKuTableController : UITableViewController

@property (strong,nonatomic) NSString *bdid;
@property (weak,nonatomic) id<CommonNotification> commonNotification;
@end
