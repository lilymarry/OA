//
//  paBoOrPaCoQuCustom_detailTittleView.h
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
@interface paBoOrPaCoQuCustom_detailTittleView1 : UIView<timeTittleDelegate>
{
    
        
        paBoOrPaCoQuCustom_detailTittleView1 *view;
        
    
}
@property (weak,nonatomic) id<getTimeDelegate> delegate;

-(paBoOrPaCoQuCustom_detailTittleView1  *)instanceChooseView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
-(void)refreshLab:(NSString *)str;
@end
