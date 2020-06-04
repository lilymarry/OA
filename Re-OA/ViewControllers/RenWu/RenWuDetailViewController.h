
#import <UIKit/UIKit.h>
#import "MyReceivedReWuDetailModel.h"

@interface RenWuDetailViewController : UIViewController<UITableViewDataSource>

@property (strong,nonatomic) NSString *ta_id;
@property (weak, nonatomic) IBOutlet UIImageView *imgrenwu;
@property (weak, nonatomic) IBOutlet UILabel *labUserName;
@property (weak, nonatomic) IBOutlet UITextView *twTitle;
@property (weak, nonatomic) IBOutlet UITextView *twContent;
@property (weak, nonatomic) IBOutlet UILabel *labsdate;
@property (weak, nonatomic) IBOutlet UILabel *labedate;
@property (weak, nonatomic) IBOutlet UIImageView *imgFlag;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
