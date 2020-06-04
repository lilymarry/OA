

#import <UIKit/UIKit.h>
#import "JXCDelegate.h"

@interface JXCChuKuDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lab_num;
@property (weak, nonatomic) IBOutlet UIButton *btn_div;
@property (weak, nonatomic) IBOutlet UILabel *lab_kufanghao;
@property (weak, nonatomic) IBOutlet UILabel *lab_duoweihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_shuliang;
@property (weak, nonatomic) IBOutlet UILabel *lab_zhongliang;

@property (weak,nonatomic) id<JXCRuKuDetailCellDelegate> chuKuDetailCellDelegate;

+(JXCChuKuDetailCell*)initJXCChuKuDetailCellForTarget:(id)targetObject ;

@end
