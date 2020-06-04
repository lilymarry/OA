#import <UIKit/UIKit.h>
@protocol okButtonDelegate <NSObject>
-(void)doButtonWithSelectRow:(NSString *)row state:(int )state selectRow:(int)selectrow;
@end


@interface SelectPIckView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic)id<okButtonDelegate>delegate;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic)int  state;
@property(nonatomic)int selectRow;
@property (strong, nonatomic)  UIPickerView *pickView;
@property(weak,nonatomic)NSString *selected;
- (void)sureBtnPress:(id)sender;
-(void)reloaPickView;
@end
