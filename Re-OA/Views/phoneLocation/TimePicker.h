#import <UIKit/UIKit.h>

@interface TimePicker : UIView
@property(copy,nonatomic)NSString *start;
@property(copy,nonatomic)NSString *end;
@property(strong,nonatomic)void(^timeBlock)(NSString *time);
@end
