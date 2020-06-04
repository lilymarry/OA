#import <UIKit/UIKit.h>
typedef  void (^finishBlock)(NSArray *names,NSArray *uids);
@interface ToPerViewController : UITableViewController<UITextFieldDelegate>
@property(nonatomic,copy) finishBlock block;
-(id)initWithBlock:(finishBlock)ablock;
@end
