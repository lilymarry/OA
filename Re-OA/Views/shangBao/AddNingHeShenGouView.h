//
//  AddNingHeShenGouView.h
//  Re-OA
//
//  Created by imac-1 on 2017/5/16.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NingHeShenGouModel.h"
@protocol NingHeShenGouModelDelegate <NSObject>
-(void)getNingHeShenGouModel:(NingHeShenGouModel *)model;
@end
@interface AddNingHeShenGouView : UIView
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_danwei;
@property (weak, nonatomic) IBOutlet UITextField *tf_shuliang;
@property (weak, nonatomic) IBOutlet UITextField *tf_beiZhu;
@property (weak,nonatomic) id<NingHeShenGouModelDelegate> delegate;
- (IBAction)truePress:(id)sender;
- (IBAction)closeViewPress:(id)sender;
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;
-(AddNingHeShenGouView *)instanceChooseView;

@end
