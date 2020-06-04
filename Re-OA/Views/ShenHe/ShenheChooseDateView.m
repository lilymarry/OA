//
//  ShenheChooseDateView.m
//  Re-OA
//
//  Created by admin on 15/11/3.
//  Copyright © 2015年 姜任鹏. All rights reserved.
//

#import "ShenheChooseDateView.h"

@implementation ShenheChooseDateView

+(ShenheChooseDateView *)instanceChooseDateView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShenHeChooseDateView" owner:nil options:nil];
    
    
    return [nibView objectAtIndex:0];
}

- (IBAction)confirmDate:(id)sender {
    
    NSObject<RenWuDateChooseDelegate> *tmpDele=self.chooseDateDelegate;
    NSDate *date=self.datapicker.date;
    NSString *dateStr=[self stringFromDate:date];
    [tmpDele chooseTheDate:dateStr withId:_dateId];
    
    //    NSDate *date = self.datapicker.date;
    //    NSString *dateStr = [self stringFromDate:date];
    //    if ([self.chooseDateDelegate respondsToSelector:@selector(chooseTheDate:withId:)])
    //    {
    //      [self.chooseDateDelegate chooseTheDate:dateStr withId:_dateId];
    //    }
    
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
-(IBAction)clearDate:(id)sender
{
    NSObject<RenWuDateChooseDelegate> *tmpDele=self.chooseDateDelegate;
   // NSDate *date=self.datapicker.date;
    NSString *dateStr=@"选择时间";
    [tmpDele chooseTheDate:dateStr withId:_dateId];

}

@end
