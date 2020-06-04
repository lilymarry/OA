//
//  OrderSummaryTittleView.h
//  Re-OA
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "ChooseDateView.h"
#import "TimeTittleView.h"
@protocol getTimeDelegate <NSObject>
-(void)getTime:(NSString *)st  et :(NSString *)et ;
@end
@interface OrderSummaryTittleView : UIView<timeTittleDelegate>
@property (weak,nonatomic) id<getTimeDelegate> delegate;


-(OrderSummaryTittleView  *)instanceChooseView;
@end
