//
//  NingHeKeHuInfoCell.h
//  Re-OA
//
//  Created by imac-1 on 2017/5/16.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NingHeKeHuCellPicDelegate <NSObject>

@optional
- (void)showKehuZhiLiangDisPlayImageView:(NSString *)imaName andUserId:(NSString *)uid;
@end
@interface NingHeKeHuInfoCell : UITableViewCell

{
    
    NSString *userid;
}
@property (weak, nonatomic) IBOutlet UILabel *txtMingCheng;
@property (weak, nonatomic) IBOutlet UILabel *txtDiZhi;
@property (weak, nonatomic) IBOutlet UILabel *txtLianXiRen;
@property (weak, nonatomic) IBOutlet UILabel *txtDianHua;
@property (weak, nonatomic) IBOutlet UILabel *txtSanZheng;
@property (weak, nonatomic) IBOutlet UILabel *txtHuanPing;
@property (weak, nonatomic) IBOutlet UILabel *txtYueDingLiang;
@property (weak, nonatomic) IBOutlet UILabel *txtShengChanZhi;
@property (weak, nonatomic) IBOutlet UILabel *txtZiChan;
@property (weak, nonatomic) IBOutlet UILabel *txtZhangQi;
@property (weak, nonatomic) IBOutlet UITextView *txtShuoMing;

@property (weak, nonatomic) IBOutlet UILabel *lab_shangbaoRen;
@property (weak, nonatomic) IBOutlet UILabel *lab_state;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;


@property(strong,nonnull)NSMutableArray *imageArrs;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) id<NingHeKeHuCellPicDelegate> delegate;
- (void)refresPictureView:(NSArray *)lists  withUid:(NSString *)uid;
@end
