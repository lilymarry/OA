//
//  BaoJingParentCell.h
//  Re-OA
//
//  Created by imac-1 on 15/4/24.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaoJingParentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lab_ssgc;
@property (weak, nonatomic) IBOutlet UILabel *lab_bjtm;
@property (weak, nonatomic) IBOutlet UILabel *lab_dq;
@property (weak, nonatomic) IBOutlet UILabel *lab_lxmc;
@property (weak, nonatomic) IBOutlet UIImageView *img_arrow;
@property (assign,nonatomic) BOOL isExpend;


+(instancetype)initWithNib;
-(void)expendTheArrowImageView;


@end
