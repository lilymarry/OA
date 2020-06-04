

#import "JXCRuKuDocCell.h"

@implementation JXCRuKuDocCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib ];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)initWithNib{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JXCRuKuDocCell" owner:nil options:nil];
    return  [nibView lastObject];
}

@end
