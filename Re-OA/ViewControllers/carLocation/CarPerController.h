#import <UIKit/UIKit.h>

@interface CarPerController : UITableViewController
@property(nonatomic,copy)void (^selectedBlock)(NSString *name, NSString *uid);
@property(nonatomic)BOOL isHideSearch;
@end
