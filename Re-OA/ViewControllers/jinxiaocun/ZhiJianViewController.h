
#import <UIKit/UIKit.h>
#import "BdListModel.h"
#import "CommonDelegate.h"
@interface ZhiJianViewController : UIViewController
@property (weak,nonatomic) id<CommonNotification> refreshNotification;
@property (strong, nonatomic)  NSString *bdnum;
@property (strong, nonatomic)  NSString *carNum;
@property (strong, nonatomic)   BdListModel *model;
@end
