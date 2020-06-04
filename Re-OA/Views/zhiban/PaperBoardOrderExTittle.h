//
//  PaperBoardOrderExTittle.h
//  Re-OA
//
//  Created by admin on 16/3/29.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "RenWuDelegate.h"
#import "TimeTittleView.h"
@protocol getDelegate <NSObject>
-(void)getTime:(NSString *)st;
@end
@interface PaperBoardOrderExTittle : UIView<timeTittleDelegate>
{
    
    PaperBoardOrderExTittle *view;
    
}

@property (weak,nonatomic) id<getDelegate> delegate;

-(PaperBoardOrderExTittle  *)instanceChooseView;

@end
