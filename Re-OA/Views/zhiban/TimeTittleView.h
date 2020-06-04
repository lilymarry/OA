//
//  TimeTittleView.h
//  Re-OA
//
//  Created by admin on 16/3/23.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhiBanChooseDateView.h"
@protocol timeTittleDelegate <NSObject>

-(void)selectTime:(NSString *)st andEndTime:(NSString *)et nowTime:(NSString *)nowTime andState:(NSString *)sta;

@end
@interface TimeTittleView : UIView<RenWuDateChooseDelegate>
@property (weak,nonatomic) id<timeTittleDelegate> delegate;
//时间段按钮 1隐藏 2 显示
- (id)initWithFrame:(CGRect)frame andMode:( NSString *) pilaing andBtnState:(NSString *) BtnState;
@end
