
#import <UIKit/UIKit.h>
#import "ShenHeDelegate.h"

@interface ShenHeChooseModelBtnView : UIView<ShenHeNotification,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) id<ShenHeSelectDelegate> chooseAllDelegate;

-(ShenHeChooseModelBtnView *)instanceChooseView;

@end
