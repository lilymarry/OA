#import <UIKit/UIKit.h>
@class PGCategoryView;

@interface PGCategoryView : UIView

@property (nonatomic,strong) UIView *rightView;
@property (strong, nonatomic) UIImageView *toggleView;

@property (nonatomic) BOOL istap;
+(PGCategoryView *)categoryRightView:(UIView *)rightView;
-(void)show;
-(void)hide;

@end
