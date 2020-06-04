//
//  TimeQuYuhuizongView.h
//  Re-OA
//
//  Created by admin on 15/4/21.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "SelectPIckView.h"
#import "RenWuDelegate.h"
@protocol getTimeQuYuhuizongViewDataDelegate <NSObject>
-(void)getTimeQuYuhuizongViewData:(NSString *)st   dengji:(NSDictionary *)dengjiDic zhonglei:(NSDictionary *)zhongleiDic leiXing:(NSDictionary *)leixing;
@end
@interface TimeQuYuhuizongView : UIView<RenWuDateChooseDelegate,okButtonDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tf_time;
@property (weak, nonatomic) IBOutlet UITextField *tf_kind;
@property (weak, nonatomic) IBOutlet UITextField *tf_lv;
@property (weak, nonatomic) IBOutlet UITextField *tf_leixing;
@property(strong ,nonatomic)TimeQuYuhuizongView *view;
@property (weak,nonatomic) id<RenWuDateChooseDelegate> delegate;
@property(weak,nonatomic)id <getTimeQuYuhuizongViewDataDelegate>dataDelegate;
- (IBAction)chaXunPress:(id)sender;
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;
-(TimeQuYuhuizongView *)instanceJiageChaXun;
@end
