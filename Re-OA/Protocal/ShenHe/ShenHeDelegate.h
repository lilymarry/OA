

#ifndef Re_OA_ShenHeDelegate_h
#define Re_OA_ShenHeDelegate_h

@protocol ShenHeNotification <NSObject>

@optional
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;
-(void)closingTheChooseMode;
-(void)closingThePickViewChooseMode:(void (^)())closedHandle;
@end

@protocol ShenHeSelectDelegate <NSObject>
@optional
-(void)selectTheTypeID:(int)tid;
-(void)selectTheChooseBtn;
-(void)chooseAll;
-(void)clearAll;
-(void)actionSheetBtnHandle:(int)btnIndex;
-(void)hasReadyForSubmitWithcon:(NSString*)con Andfsid:(NSString*)fsid;
@end

#endif
