

#import <UIKit/UIKit.h>
#import "JXCDelegate.h"

@interface JXCRuKuDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_num;
@property (weak, nonatomic) IBOutlet UIButton *btn_div;
@property (weak, nonatomic) IBOutlet UILabel *lab_kufanghao;
@property (weak, nonatomic) IBOutlet UILabel *lab_duoweihao;
@property (weak, nonatomic) IBOutlet UILabel *lab_shuliang;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;


@property (weak,nonatomic) id<JXCRuKuDetailCellDelegate> ruKuDetailCellDelegate;

+(JXCRuKuDetailCell*)initJXCRuKuDetailCellForTarget:(id)targetObject ;

@end
