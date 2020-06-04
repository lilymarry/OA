

#import "JXCChuKuDetailCell.h"

@implementation JXCChuKuDetailCell

+(JXCChuKuDetailCell*)initJXCChuKuDetailCellForTarget:(id)targetObject
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JXCChuKuDetailCell" owner:nil options:nil];
    JXCChuKuDetailCell *view= [nibView objectAtIndex:0];
    view.chuKuDetailCellDelegate=targetObject;
    
    return view;
}


- (IBAction)deleteBtnHandle:(id)sender {
    
    if (self.chuKuDetailCellDelegate != nil) {
        [self.chuKuDetailCellDelegate deleteCellHandleByRowIndex:self];
    }
}


@end
