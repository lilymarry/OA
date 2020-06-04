//
//  BaoJingParentCell.m
//  Re-OA
//
//  Created by imac-1 on 15/4/24.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "BaoJingParentCell.h"



@implementation BaoJingParentCell


+(instancetype)initWithNib{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"BaojingParentCell" owner:nil options:nil];
    BaoJingParentCell *cell=  [nibView lastObject];
    cell.isExpend=NO;
    return cell;
}

-(void)expendTheArrowImageView{
    self.isExpend= !self.isExpend? YES:NO;
    if (self.isExpend) {
        [UIView animateWithDuration:0.5 animations:^(){
            self.img_arrow.transform = CGAffineTransformMakeRotation(1);
        }];
        

    }else{
        CGAffineTransform rotate = CGAffineTransformMakeRotation( 1.0 / 180.0 * 3.14 );
        [self.img_arrow setTransform:rotate];
    }
    
}




@end
