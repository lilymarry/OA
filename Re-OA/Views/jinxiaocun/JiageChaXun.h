//
//  JiageChaXun.h
//  Re-OA
//
//  Created by admin on 15/4/15.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "SelectPIckView.h"
#import "RenWuDelegate.h"

@protocol getViewDataDelegate <NSObject>
-(void)getJiaGechaXunViewData:(NSString *)st andEt:(NSString *)et dengji:(NSDictionary *)dengjiDic zhonglei:(NSDictionary *)zhongleiDic ;
@end

@interface JiageChaXun : UIView<RenWuDateChooseDelegate,okButtonDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf_fistTime;
@property (weak, nonatomic) IBOutlet UITextField *tf_lastTime;
@property (weak, nonatomic) IBOutlet UITextField *tf_lv;
@property (weak, nonatomic) IBOutlet UITextField *tf_kind;
@property (strong,nonatomic)JiageChaXun *view;
@property (strong, nonatomic)  NSArray *hwlv;
@property (strong, nonatomic)  NSArray *dqxx;
@property (weak,nonatomic) id<RenWuDateChooseDelegate> delegate;
@property(weak,nonatomic)id <getViewDataDelegate>dataDelegate;
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;

- (IBAction)surePress:(id)sender;
-(JiageChaXun *)instanceJiageChaXun;
@end
