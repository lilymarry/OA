
#import <UIKit/UIKit.h>

@interface MyRenWuReceivedDetailViewController : UIViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgrenwu;
@property (weak, nonatomic) IBOutlet UILabel *labUserName;
@property (weak, nonatomic) IBOutlet UITextView *twTitle;
@property (weak, nonatomic) IBOutlet UITextView *twContent;
@property (weak, nonatomic) IBOutlet UILabel *labsdate;
@property (weak, nonatomic) IBOutlet UILabel *labedate;

@property (weak, nonatomic) IBOutlet UITextView *twDesc;

@property (strong,nonatomic) NSString *ta_id;
@property (weak, nonatomic) IBOutlet UIImageView *imgUpload;
@property (weak, nonatomic) IBOutlet UIButton *picDelBtn;
- (IBAction)deleSelectPicPress:(id)sender;

@end
