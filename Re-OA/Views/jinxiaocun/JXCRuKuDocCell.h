
#import <UIKit/UIKit.h>

@interface JXCRuKuDocCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_bangdanhao;
@property (weak, nonatomic) IBOutlet UILabel *lab_chepaihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_dengji;
@property (weak, nonatomic) IBOutlet UILabel *lab_songhuodanwei;
@property (weak, nonatomic) IBOutlet UILabel *lab_wuzimingcheng;


+(instancetype)initWithNib;
@end
