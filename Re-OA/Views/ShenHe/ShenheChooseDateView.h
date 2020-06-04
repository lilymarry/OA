//
//  ShenheChooseDateView.h
//  Re-OA
//
//  Created by admin on 15/11/3.
//  Copyright © 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenWuDelegate.h"
@interface ShenheChooseDateView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datapicker;
@property (weak, nonatomic)  NSString *dateId;
@property (nonatomic) id<RenWuDateChooseDelegate> chooseDateDelegate;
+(ShenheChooseDateView *)instanceChooseDateView;
@end
