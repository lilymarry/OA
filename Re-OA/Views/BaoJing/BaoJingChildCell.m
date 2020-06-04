

#import "BaoJingChildCell.h"

@implementation BaoJingChildCell


+(instancetype)initWithNibAndIndexPath:(NSIndexPath*)indexPath AndTarget:(id)targetObject{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"BaoJingChildCell" owner:nil options:nil];
    
    BaoJingChildCell *cell=  [nibView lastObject];
    
    cell.indexPath=indexPath;
    cell.img_play.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(playeTheVideo:)];
    tapGesture.numberOfTapsRequired=1;
    [cell.img_play addGestureRecognizer:tapGesture];

    cell.baoJingPlayImageDelegate=targetObject;
    
    return  cell;
}

-(void)playeTheVideo:(UITapGestureRecognizer*)gesture{
    
    if (self.baoJingPlayImageDelegate) {
        [self.baoJingPlayImageDelegate willAppearPlayViewHandle:self.indexPath];
    }
}


@end
