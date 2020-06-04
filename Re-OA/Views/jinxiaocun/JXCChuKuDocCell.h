

#import <UIKit/UIKit.h>

@interface JXCChuKuDocCell : UITableViewCell

@property (strong,nonatomic) NSString *dengjiIndex;

@property (weak, nonatomic) IBOutlet UILabel *lab_bangdanhao;
@property (weak, nonatomic) IBOutlet UILabel *lab_chepaihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_tihuodanwei;
@property (weak, nonatomic) IBOutlet UILabel *lab_wuzimingcheng;
@property (weak, nonatomic) IBOutlet UITextField *tf_dengjitf;

+(instancetype)initWithNib;

@end
