#import <UIKit/UIKit.h>

@interface PersonalViewController : UITableViewController
@property(nonatomic,copy)void (^selectedBlock)(NSString *name,NSString *uid);
@property(nonatomic)BOOL isHideSearch;
@end
