
#import <UIKit/UIKit.h>
#import "RenWuDelegate.h"
@interface ChooseUserViewController : UITableViewController<UITextFieldDelegate>

@property (weak,nonatomic) id<RenWuChooseUserNotification> chooseUserDelegate;

@end
