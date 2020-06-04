

#import <UIKit/UIKit.h>
#import "ShenHeDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "CommonDelegate.h"
@interface WeiShenHeDetailViewController : UITableViewController<UIActionSheetDelegate,UIAlertViewDelegate,ShenHeSelectDelegate>
@property (strong,nonatomic) NSString *fpiId;
@property (strong,nonatomic) NSString *ftyp;
@property (strong,nonatomic) NSString *cmtp;
@property (strong,nonatomic) NSString *fo;
@property (strong,nonatomic) NSString *okbak;
@property (strong,nonatomic) NSMutableArray *toFsArr;
@property (weak,nonatomic) id<ShenHeNotification> closingPickViewNotification;

@property (retain, nonatomic) AVAudioPlayer *avPlay;
@property (strong,nonatomic) NSString *fmTp;
@property(strong,nonatomic) NSString *x;
@property(strong,nonatomic) NSString *y;

@property (weak,nonatomic) id<CommonNotification> refreshNotification;

@end
