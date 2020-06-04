//
//  NingHeCell2.h
//  Re-OA
//
//  Created by admin on 16/4/21.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NingHeCell2PicDelegate <NSObject>

@optional
- (void)showNingHeCell2DisPlayImageView:(NSString *)imaName andUserId:(NSString *)uid;
@end
@interface NingHeCell2 : UITableViewCell
{
    NSString *userid ;
}
@property (weak, nonatomic) IBOutlet UILabel *lab_txtTGZZ;
@property (weak, nonatomic) IBOutlet UILabel *lab_txtZF;
@property (weak, nonatomic) IBOutlet UILabel *lab_txtZBGG;
@property (weak, nonatomic) IBOutlet UILabel *lab_txtXQCCL;
@property (weak, nonatomic) IBOutlet UILabel *lab_txtXWDHRQ;
@property (weak, nonatomic) IBOutlet UILabel *lab_txtDPYL;

@property (weak, nonatomic) IBOutlet UILabel *lab_txtYYL;
@property (weak, nonatomic) IBOutlet UILabel *lab_txtSYKH;
@property (weak, nonatomic) IBOutlet UILabel *lab_txtKHJSFS;
@property (weak, nonatomic) IBOutlet UITextView *lab_txtBZ;


@property (weak, nonatomic) IBOutlet UILabel *lab_remark;
@property (weak, nonatomic) IBOutlet UILabel *lab_shangbaoRen;
@property (weak, nonatomic) IBOutlet UILabel *lab_state;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
@property(strong,nonnull)NSMutableArray *imageArrs;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) id<NingHeCell2PicDelegate> delegate;
- (void)refresPictureView:(NSArray *)lists  withUid:(NSString *)uid;

@end
