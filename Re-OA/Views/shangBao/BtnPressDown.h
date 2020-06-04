#import <UIKit/UIKit.h>

@protocol touchS <NSObject>

- (void)startChangeView;
- (void)endChangeView;

@end

@interface BtnPressDown : UIView

@property (weak,nonatomic) IBOutlet id Downdelegate;

@end
