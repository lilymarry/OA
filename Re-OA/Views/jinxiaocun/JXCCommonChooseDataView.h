
#import <UIKit/UIKit.h>
#import "JXCDelegate.h"


@interface JXCCommonChooseDataView : UIView
@property (weak, nonatomic) IBOutlet UIPickerView *pickview;

@property (weak,nonatomic) id<JXCCommonChooseViewDelegate> commonChooseViewDelegate;

+(JXCCommonChooseDataView*)initJXCCommonChooseDataViewAndTarget:(id)object;

@end
