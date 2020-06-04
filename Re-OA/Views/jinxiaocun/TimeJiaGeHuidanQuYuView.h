//
//  TimeJiaGeHuidanQuYuView.h
//  Re-OA
//
//  Created by admin on 15/4/21.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "SelectPIckView.h"
#import "RenWuDelegate.h"
@protocol getTimeJiaGeHuidanQuYuViewDelegate <NSObject>
-(void)getTimeQuYuhuizongViewData:(NSString *)st   quyu:(NSDictionary *)quyuDic zhonglei:(NSDictionary *)zhongleiDic leiXing:(NSDictionary *)leixing;
@end
@interface TimeJiaGeHuidanQuYuView : UIView<RenWuDateChooseDelegate,okButtonDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf_time;

@property (weak, nonatomic) IBOutlet UITextField *tf_kind;
@property (weak, nonatomic) IBOutlet UITextField *tf_leixing;
@property (weak, nonatomic) IBOutlet UITextField *tf_quyu;
@property(strong ,nonatomic)TimeJiaGeHuidanQuYuView *view;
@property (weak,nonatomic) id<RenWuDateChooseDelegate> delegate;
@property(weak,nonatomic)id <getTimeJiaGeHuidanQuYuViewDelegate>dataDelegate;
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;
-(TimeJiaGeHuidanQuYuView *)instanceJiageChaXun;
- (IBAction)chaXunpress:(id)sender;

@end
