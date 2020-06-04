//
//  NingHeCell.h
//  Re-OA
//
//  Created by admin on 16/4/12.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NingHeCellPicDelegate <NSObject>

@optional
- (void)showZhiLiangDisPlayImageView:(NSString *)imaName andUserId:(NSString *)uid;
@end
@interface NingHeCell : UITableViewCell
{

    NSString *userid;
}
@property (weak, nonatomic) IBOutlet UILabel *lab_khnm;
@property (weak, nonatomic) IBOutlet UILabel *lab_odcode;
@property (weak, nonatomic) IBOutlet UILabel *lab_size;
@property (weak, nonatomic) IBOutlet UILabel *lab_pm;
@property (weak, nonatomic) IBOutlet UILabel *lab_odnum;
@property (weak, nonatomic) IBOutlet UILabel *lab_err;
@property (weak, nonatomic) IBOutlet UITextView *lab_reason;
@property (weak, nonatomic) IBOutlet UITextView *lab_opinion;
@property (weak, nonatomic) IBOutlet UILabel *lab_shangbaoRen;
@property (weak, nonatomic) IBOutlet UILabel *lab_state;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;

@property(strong,nonnull)NSMutableArray *imageArrs;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) id<NingHeCellPicDelegate> delegate;
- (void)refresPictureView:(NSArray *)lists  withUid:(NSString *)uid;

@end
