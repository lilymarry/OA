//
//  ReceiptsTittleView.h
//  Re-OA
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "TimeTittleView.h"
@protocol getTimeDelegate <NSObject>
-(void)getTime:(NSString *)st  et :(NSString *)et ;
@end
@interface ReceiptsTittleView : UIView<timeTittleDelegate>

@property (weak,nonatomic) id<getTimeDelegate> delegate;


-(ReceiptsTittleView  *)instanceChooseView;
@end
