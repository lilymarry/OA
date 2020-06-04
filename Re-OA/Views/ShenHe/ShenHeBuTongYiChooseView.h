
#import <UIKit/UIKit.h>
#import "ShenHeDelegate.h"

@interface ShenHeBuTongYiChooseView : UIView<UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,ShenHeNotification>
@property (weak, nonatomic) IBOutlet UITextView *twCon;
@property (weak, nonatomic) IBOutlet UIPickerView *pwChoose;
@property (strong, nonatomic) NSMutableArray *dataArr;

@property (weak,nonatomic) id<ShenHeSelectDelegate> submitDelegate;

-(ShenHeBuTongYiChooseView *)instanceChooseViewWithArrayData:(NSMutableArray*)arr;
@end
