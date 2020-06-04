
#import <UIKit/UIKit.h>
#import "RenWuDelegate.h"
#import "CommonDelegate.h"
@interface AddRenWuViewController : UIViewController<RenWuDateChooseDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//RenWuChooseUserNotification,
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextView *txtUsers;
@property (weak, nonatomic) IBOutlet UIImageView *imgUpload;
@property (weak, nonatomic) IBOutlet UISwitch *swiAlter;
@property (weak, nonatomic) IBOutlet UISwitch *swiWatch;
@property (weak, nonatomic) IBOutlet UITextView *txtDesc;
@property (strong, nonatomic) NSArray * TextArr;
@property (weak, nonatomic) IBOutlet UIButton *picDelBtn;
@property (weak,nonatomic) id<CommonNotification> refreshNotification;
@end
