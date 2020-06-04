
#import <UIKit/UIKit.h>
@protocol ShenHePicDelegate <NSObject>

@optional
- (void)showDisPlayImageView:(NSString *)imaName andUserId:(NSString *)uid;
@end
@interface ShenHeDetailCell : UITableViewCell
{
    NSString *userid ;
}
@property (weak, nonatomic) IBOutlet UILabel *labfnm;
@property (weak, nonatomic) IBOutlet UILabel *labfstate;

@property (weak, nonatomic) IBOutlet UILabel *labdoPNm;

@property (weak, nonatomic) IBOutlet UILabel *labctm;
@property (weak, nonatomic) IBOutlet UILabel *labtit;
@property (weak, nonatomic) IBOutlet UILabel *labpric;
@property (weak, nonatomic) IBOutlet UITextView *labcon;

@property (weak, nonatomic) IBOutlet UIImageView *imgpic;
@property (weak, nonatomic) IBOutlet UIImageView *imgvoi;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(strong,nonnull)NSMutableArray *imageArrs;
//@property (nonatomic, strong)NSMutableArray *saveImageView;
@property (nonatomic, weak) id<ShenHePicDelegate> delegate;
- (void)refresPictureView:(NSArray *)lists  withUid:(NSString *)uid;
@end
