

#import <UIKit/UIKit.h>

typedef void(^hiddenHandle)();

@interface BackgroudView : UIView

@property(nonatomic, copy) hiddenHandle hiddenHandle;

+(void)showTheBackgroudViewToView:(UIView*)parentView showedHandle:(void (^)())showedHandle  hiddenHandle:(void (^)())hiddenHandle;
+(void)hidTheBackgroudviewFromParentView:(UIView*)parentView hiddenHandle:(void(^)())hiddenHandle;

@end
