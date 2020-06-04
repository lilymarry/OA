
#import <UIKit/UIKit.h>
#import "ShenHeDelegate.h"
#import "CommonDelegate.h"
#import "ShenHeChooseView1.h"
@interface WeiShenHeViewController : UITableViewController<ShenHeSelectDelegate,UIAlertViewDelegate,CommonNotification,shenHeDataDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *littleMenu;
@property (weak,nonatomic) id<ShenHeNotification> closingLittleNotification;
@property (weak,nonatomic) id<ShenHeNotification> closingChooseModeNotification;
@end
