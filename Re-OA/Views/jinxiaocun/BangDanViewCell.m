//
//  BangDanViewCell.m
//  Re-OA
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "BangDanViewCell.h"

@implementation BangDanViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib ];
//      [_scroll setContentSize:CGSizeMake( self.superview.frame.size.width+50, 44)];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
