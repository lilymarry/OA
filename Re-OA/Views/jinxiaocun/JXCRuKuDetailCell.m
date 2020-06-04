
#import "JXCRuKuDetailCell.h"

@implementation JXCRuKuDetailCell

+(JXCRuKuDetailCell*)initJXCRuKuDetailCellForTarget:(id)targetObject
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JXCRuKuDetailCell" owner:nil options:nil];
    JXCRuKuDetailCell *view= [nibView objectAtIndex:0];
    view.ruKuDetailCellDelegate=targetObject;

       return view;
}


- (IBAction)deleteBtnHandle:(id)sender {
    
    if (self.ruKuDetailCellDelegate != nil) {
        [self.ruKuDetailCellDelegate deleteCellHandleByRowIndex:self];
    }
}

@end
