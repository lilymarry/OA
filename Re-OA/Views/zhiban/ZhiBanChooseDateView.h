//
//  ZhiBanChooseDateView.h
//  Re-OA
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenWuDelegate.h"
@interface ZhiBanChooseDateView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datapicker;
@property (weak, nonatomic)  NSString *dateId;
@property (nonatomic) id<RenWuDateChooseDelegate> chooseDateDelegate;
+(ZhiBanChooseDateView *)instanceChooseDateView;
@end
