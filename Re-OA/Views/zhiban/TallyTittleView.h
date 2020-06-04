//
//  TallyTittleView.h
//  Re-OA
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "RenWuDelegate.h"
#import "TimeTittleView.h"
@protocol getTimeDelegate <NSObject>
-(void)getTime:(NSString *)st  et :(NSString *)et ;
@end
@interface TallyTittleView : UIView<timeTittleDelegate>

@property (weak,nonatomic) id<getTimeDelegate> delegate;


-(TallyTittleView  *)instanceChooseView;

@end
