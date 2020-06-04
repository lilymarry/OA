//
//  NingHeShenGouShenHeCell.h
//  Re-OA
//
//  Created by imac-1 on 2017/5/16.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NingHeShenGouShenHeCellPicDelegate <NSObject>

@optional
- (void)showShenGouZhiLiangDisPlayImageView:(NSString *)imaName andUserId:(NSString *)uid;
@end

@interface NingHeShenGouShenHeCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>


{
    
    NSString *userid;
}
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *danwei;
@property (weak, nonatomic) IBOutlet UILabel *shuling;
@property (weak, nonatomic) IBOutlet UILabel *beizhu;

@property (weak, nonatomic) IBOutlet UILabel *lab_shangbaoRen;
@property (weak, nonatomic) IBOutlet UILabel *lab_state;
@property (weak, nonatomic) IBOutlet UILabel *lab_time;

@property(strong,nonnull)NSMutableArray *imageArrs;
@property (weak, nonatomic) IBOutlet UITableView *content;


@property(strong,nonatomic)NSArray *data;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) id<NingHeShenGouShenHeCellPicDelegate> delegate;
- (void)refresPictureView:(NSArray *)lists  withUid:(NSString *)uid;
@end
