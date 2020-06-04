//
//  ZhiBanChooseDateView.m
//  Re-OA
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "ZhiBanChooseDateView.h"

@implementation ZhiBanChooseDateView

+(ZhiBanChooseDateView *)instanceChooseDateView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ZhiBanChooseDateView" owner:nil options:nil];
    
    
    return [nibView objectAtIndex:0];
}

- (IBAction)confirmDate:(id)sender {
    
    NSObject<RenWuDateChooseDelegate> *tmpDele=self.chooseDateDelegate;
    NSDate *date=self.datapicker.date;
    NSString *dateStr=[self stringFromDate:date];
    [tmpDele chooseTheDate:dateStr withId:_dateId];
    
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


@end
