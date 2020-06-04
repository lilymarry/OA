
#ifndef Re_OA_RenWuDelegate_h
#define Re_OA_RenWuDelegate_h

@protocol RenWuChooseUserNotification <NSObject>

-(void)setTheChooseUser:(NSMutableArray*)userArr;
@end

@protocol RenWuDateChooseDelegate <NSObject>
-(void)chooseTheDate:(NSString*)dateStr withId:(NSString *)dateid;
@end




#endif
