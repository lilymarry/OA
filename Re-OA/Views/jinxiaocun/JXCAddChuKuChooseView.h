

#import <UIKit/UIKit.h>
#import "JXCDelegate.h"


typedef void(^closedHandle)();

@interface JXCAddChuKuChooseView : UIView

@property(nonatomic, copy) closedHandle closedHandle;


@property (weak, nonatomic) IBOutlet UITextField *tf_KuFang;
@property (weak, nonatomic) IBOutlet UITextField *tf_DuoWei;
@property (weak, nonatomic) IBOutlet UITextField *tf_ShuLiang;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *act_duowei;
@property (weak, nonatomic) IBOutlet UITextField *tf_zhongliang;

@property (weak,nonatomic) id<JXCAddChooseViewDelegate> addChooseViewDelegate;

@property (strong,nonatomic)  NSNumber *cangkuIndex;
@property (strong,nonatomic)  NSNumber *duoweiIndex;

-(JXCAddChuKuChooseView *)initJXCAddChuKuChooseViewForView:(UIView*)parentview
                                                   taget:(id)object
                                             closedHanld:(void (^)())closedHandle;
-(void)didClosingTheView:(void (^)())closedHandle;



@end
