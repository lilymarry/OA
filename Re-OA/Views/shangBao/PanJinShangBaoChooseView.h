#import <UIKit/UIKit.h>

@protocol PanjinDelegate <NSObject>
@optional
-(void)selectTheTypeID:(int)tid;
@end
@interface PanJinShangBaoChooseView : UIView
@property (weak, nonatomic) IBOutlet UIView *jiekuanView;
@property (weak, nonatomic) IBOutlet UIView *fukuanView;
@property (weak, nonatomic) IBOutlet UIView *baoxiaoView;

@property (weak,nonatomic) id<PanjinDelegate> panjinDelegate;

-(PanJinShangBaoChooseView *)instanceChooseView;

-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;
@end
