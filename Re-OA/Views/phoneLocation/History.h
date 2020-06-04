#import <UIKit/UIKit.h>

@interface History : UIView

@property(nonatomic)BOOL isCar;

@property(nonatomic,copy)void (^perMapBlock)(NSString *start,NSString *end,NSString *name);

@property(nonatomic,copy)void (^finishBlock)(NSString *start,NSString *end,NSString *name,NSString *uid);

//@property(nonatomic,copy)void (^finishBlock1)(NSString *start,NSString *name,NSString *uid);
-(id)initWithFrame:(CGRect)frame Type:(BOOL)isCar;
@end
