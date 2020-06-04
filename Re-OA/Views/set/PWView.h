#import <UIKit/UIKit.h>
#define kAlertWidth 245.0f
#define kAlertHeight 160.0f
@protocol okButtonDelegate <NSObject>
-(void)doButton:(id)sender;
@end
@protocol cancelButtonDelegate <NSObject>
-(void)cancelButton:(id)sender;
@end
@interface PWView : UIView<UITextFieldDelegate>

@property (nonatomic , assign)id okDelegate;
@property (nonatomic , assign)id cancelDelegate;
@property (strong, nonatomic)  UITextField *yuanPW;
@property (strong, nonatomic) UITextField *xinPW;
@property (strong, nonatomic) UITextField *quePW;


@end
