
#ifndef Re_OA_CommonDelegate_h
#define Re_OA_CommonDelegate_h

@protocol CommonNotification <NSObject>

@optional
-(void)refreshingDataList;
@end



@protocol BackgroudViewDelegate <NSObject>

@optional
-(void)willClosingbgviewHandle;
@end

#endif
