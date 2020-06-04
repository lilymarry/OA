//
//  PaperBoardOrderExTittle1.h
//  Re-OA
//
//  Created by imac-1 on 2016/12/16.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseDateView.h"
#import "RenWuDelegate.h"
#import "TimeTittleView.h"
@protocol getDelegate <NSObject>
-(void)getTime:(NSString *)st;
@end
@interface PaperBoardOrderExTittle1 : UIView<timeTittleDelegate>
{
    
    PaperBoardOrderExTittle1 *view;
    
}

@property (weak,nonatomic) id<getDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lab_num;

-(PaperBoardOrderExTittle1  *)instanceChooseView;

-(void)refreshlab:(NSString *)str;

@end
