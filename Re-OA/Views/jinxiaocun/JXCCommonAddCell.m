
#import "JXCCommonAddCell.h"


@interface JXCCommonAddCell()

@end

@implementation JXCCommonAddCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib ];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)scanPress:(id)sender {
    NSObject<JXCAddCellDelegate> *tmpDele=self.addCellDelegate;
    [tmpDele scanTiaoMaPress];
}

-(JXCCommonAddCell*)initWithNibWithModle:(BOOL)mode{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JXCCommonAddCell" owner:nil options:nil];
    
    self=  [nibView lastObject];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickingAddCell)];
    tapGesture.numberOfTapsRequired=1;
    [self addGestureRecognizer:tapGesture];
    if (!mode) {
        _scanBtn.hidden=YES;
        _scanIma.hidden=YES;
    }

    return self;
}

-(void)clickingAddCell{
    NSObject<JXCAddCellDelegate> *tmpDele=self.addCellDelegate;
    [tmpDele clickingAddCellHandle];

}


@end
