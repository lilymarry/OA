
#import <UIKit/UIKit.h>
#import "RenWuDelegate.h"

@interface ChooseDateView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datapicker;
@property (weak, nonatomic)  NSString *dateId;
@property (nonatomic) id<RenWuDateChooseDelegate> chooseDateDelegate;
+(ChooseDateView *)instanceChooseDateView;
@end
