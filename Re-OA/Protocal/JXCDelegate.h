
#ifndef Re_OA_JXCDelegate_h
#define Re_OA_JXCDelegate_h

//出入库详情界面 <添加cell> 的协议
@protocol JXCAddCellDelegate <NSObject>
@optional
-(void)clickingAddCellHandle;
-(void)scanTiaoMaPress;
@end



//入库 <库房，剁位界面> 的协议
@protocol JXCCommonChooseViewDelegate <NSObject>
@optional
-(void)confirmChooseView:(UIPickerView*)pickview AtIndex:(NSInteger)index;
@end



//入库 <添加明细界面> 的协议
@protocol JXCAddChooseViewDelegate <NSObject>
@optional
-(void)textvalueHasChanged;
-(void)confirmWithCangkuIndex:(NSNumber*)cangkuIndex AndDuoweiIndex:(NSNumber*)duoweiIndex AndShuliang:(NSString*)shuliang;

-(void)confirmWithCangkuIndex:(NSNumber*)cangkuIndex AndDuoweiIndex:(NSNumber*)duoweiIndex AndShuliang:(NSString*)shuliang AndZhongliang:(NSString*)zhongliang;
@end

//入库 <明细详情界面> 的协议
@protocol JXCRuKuDetailCellDelegate <NSObject>
@optional
-(void)deleteCellHandleByRowIndex:(id)sender;

@end




#endif
