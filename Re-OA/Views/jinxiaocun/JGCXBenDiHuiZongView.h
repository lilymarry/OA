//
//  JGCXBenDiHuiZongView.h
//  Re-OA
//
//  Created by admin on 15/4/20.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "SelectPIckView.h"
#import "RenWuDelegate.h"
@protocol getJGCXBenDiHuiZongViewDataDelegate <NSObject>
-(void)getJGCXBenDiHuiZongViewViewData:(NSString *)st  leixing:(NSDictionary *)dengjiDic zhonglei:(NSDictionary *)zhongleiDic ;
@end

@interface JGCXBenDiHuiZongView : UIView<RenWuDateChooseDelegate,okButtonDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf_firstTime;
@property (weak, nonatomic) IBOutlet UITextField *tf_kind;
@property (weak, nonatomic) IBOutlet UITextField *tf_leixing;
@property(strong,nonatomic)JGCXBenDiHuiZongView *view;
@property (weak,nonatomic) id<RenWuDateChooseDelegate> delegate;
@property(weak,nonatomic)id <getJGCXBenDiHuiZongViewDataDelegate>dataDelegate;
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;
- (IBAction)surePress:(id)sender;
-(JGCXBenDiHuiZongView *)instanceJiageChaXun;
@end