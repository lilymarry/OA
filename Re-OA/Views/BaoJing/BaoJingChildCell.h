//
//  BaoJingParentCell.h
//  Re-OA
//
//  Created by imac-1 on 15/4/24.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaojingDelegate.h"

@interface BaoJingChildCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_bz;
@property (weak, nonatomic) IBOutlet UILabel *lab_ygno;
@property (weak, nonatomic) IBOutlet UILabel *lab_carno;
@property (weak, nonatomic) IBOutlet UILabel *lab_cltm;


@property (weak, nonatomic) IBOutlet UIImageView *img_play;

@property(weak, nonatomic   ) id<BaoJingPlayImageDelegate> baoJingPlayImageDelegate;

@property (strong,nonatomic) NSIndexPath* indexPath;

+(instancetype)initWithNibAndIndexPath:(NSIndexPath*)indexPath AndTarget:(id)targetObject;

@end
