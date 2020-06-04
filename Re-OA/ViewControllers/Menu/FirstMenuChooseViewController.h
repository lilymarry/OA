
#import <UIKit/UIKit.h>
#import "MenuDelegate.h"

@interface FirstMenuChooseViewController : UITableViewController

@property (nonatomic,weak) id<favoriteMenuSettingNotification> refreshMenudelegate;

@end
