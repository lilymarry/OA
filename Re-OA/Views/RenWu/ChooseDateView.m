
#import "ChooseDateView.h"
#import "ScreenHelper.h"

@implementation ChooseDateView

+(ChooseDateView *)instanceChooseDateView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"RenWuDateChooseView" owner:nil options:nil];
     

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

@end
