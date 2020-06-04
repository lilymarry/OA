
#import "PersonCell.h"

@interface PersonCell()

@end
@implementation PersonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

       [self setHighlighted:NO];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib ];
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];}

@end
