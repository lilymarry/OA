
#import <UIKit/UIKit.h>
#import "JXCDelegate.h"

@interface JXCCommonAddCell : UITableViewCell<JXCAddCellDelegate>

@property (weak,nonatomic) id<JXCAddCellDelegate> addCellDelegate;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UIImageView *scanIma;
- (IBAction)scanPress:(id)sender;


-(JXCCommonAddCell*)initWithNibWithModle:(BOOL)mode;


@end
