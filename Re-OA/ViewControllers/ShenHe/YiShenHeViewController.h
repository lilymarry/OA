
#import <UIKit/UIKit.h>
#import "ShenHeDelegate.h"
#import "ShenHeChooseView1.h"
@interface YiShenHeViewController : UITableViewController<ShenHeSelectDelegate,shenHeDataDelegate>
@property (weak,nonatomic) id<ShenHeNotification> closingLittleNotification;
@end
