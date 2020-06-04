//
//  JGCXQuYuHuiZongView.h
//  Re-OA
//
//  Created by admin on 15/4/20.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "SelectPIckView.h"
#import "RenWuDelegate.h"

@protocol getJGCXQuYuHuiZongViewDataDelegate <NSObject>
-(void)getJGCXQuYuHuiZongViewViewData:(NSString *)st  et :(NSString *)et dengji:(NSDictionary *)dengjiDic zhonglei:(NSDictionary *)zhongleiDic yewu:(NSDictionary *)yeWudic quyu:(NSDictionary *)quyu leiXing:(NSDictionary *)leixing;
@end
@interface JGCXQuYuHuiZongView : UIView<RenWuDateChooseDelegate,okButtonDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tf_firstTime;
@property (weak, nonatomic) IBOutlet UITextField *tf_lastTime;
@property (weak, nonatomic) IBOutlet UITextField *tf_lv;
@property (weak, nonatomic) IBOutlet UITextField *tf_kind;
@property (weak, nonatomic) IBOutlet UITextField *tf_yewu;
@property (weak, nonatomic) IBOutlet UITextField *tf_quyu;
@property (weak, nonatomic) IBOutlet UITextField *tf_leiXing;
@property(strong ,nonatomic)JGCXQuYuHuiZongView *view;
@property (weak,nonatomic) id<RenWuDateChooseDelegate> delegate;
@property(weak,nonatomic)id <getJGCXQuYuHuiZongViewDataDelegate>dataDelegate;
- (IBAction)surePress:(id)sender;
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;
-(JGCXQuYuHuiZongView *)instanceJiageChaXun;
@end
