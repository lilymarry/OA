
#import <UIKit/UIKit.h>

@interface JXCCommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_BangDanHao;
@property (weak, nonatomic) IBOutlet UILabel *lab_BangDanRiQi;
@property (weak, nonatomic) IBOutlet UILabel *lab_ChePaiHao;

@property (weak, nonatomic) IBOutlet UILabel *lab_Dengji;
@property (weak, nonatomic) IBOutlet UILabel *lab_WuZiMing;
@property (weak, nonatomic) IBOutlet UILabel *lab_zuofei;

+(instancetype)initWithNib;

@end
