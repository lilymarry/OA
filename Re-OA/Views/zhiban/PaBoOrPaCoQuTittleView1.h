//
//  PaBoOrPaCoQuTittleView.h
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "RenWuDelegate.h"
#import "TimeTittleView.h"
@protocol getTimeDelegate <NSObject>
-(void)getTime:(NSString *)st;
@end
@interface PaBoOrPaCoQuTittleView1 : UIView<timeTittleDelegate>
@property (weak,nonatomic) id<getTimeDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
-(PaBoOrPaCoQuTittleView1  *)instanceChooseView;
-(void)refreshLab:(NSString *)str;

@end
