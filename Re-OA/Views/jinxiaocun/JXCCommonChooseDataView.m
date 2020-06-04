
#import "JXCCommonChooseDataView.h"
#import "ScreenHelper.h"
#import "AlertHelper.h"

@implementation JXCCommonChooseDataView


- (IBAction)confirmTheChioce:(id)sender {

    NSInteger index=  [self.pickview selectedRowInComponent:0];
    if (index!=-1) {
        if (self.commonChooseViewDelegate!=nil) {
            [self.commonChooseViewDelegate confirmChooseView:self.pickview AtIndex:index ];
        }
    }else{
        [AlertHelper singleAlertShow:@"没有数据～！"];
    }
    
    
}

+(JXCCommonChooseDataView*)initJXCCommonChooseDataViewAndTarget:(id)object
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JXCCommonChooseDataView" owner:nil options:nil];
    JXCCommonChooseDataView *view= [nibView objectAtIndex:0];
    
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, [ScreenHelper SCREEN_WIDTH], view.frame.size.height)];
    
    view.commonChooseViewDelegate=object;
    view.pickview.delegate=object;

    return view;
}


@end
