#import "ShenHeChooseModelBtnView.h"
#import "ScreenHelper.h"

@implementation ShenHeChooseModelBtnView

-(ShenHeChooseModelBtnView *)instanceChooseView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"AllChooseMenu" owner:nil options:nil];
    ShenHeChooseModelBtnView *view= [nibView lastObject];
    [view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 49)];
    [UIView animateWithDuration:0.2 animations:^(){
        [view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT]-49, [ScreenHelper SCREEN_WIDTH], 49)];
    }completion:^(BOOL finished){
    } ];
    return view;
}

- (IBAction)chooseBtnClickHandle:(id)sender {
    UIButton *btn= sender;
    btn.selected =(btn.isSelected)?NO:YES;
    
    if (btn.selected) {
        NSObject<ShenHeSelectDelegate> *tmpDele=self.chooseAllDelegate;
        [tmpDele chooseAll];
    }else{
        NSObject<ShenHeSelectDelegate> *tmpDele=self.chooseAllDelegate;
        [tmpDele clearAll];
    }
}

- (IBAction)moreBtnClickHandle:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"批量操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"同意" otherButtonTitles:@"驳回",@"不同意", nil];
    sheet.tag=10000;
    [sheet showInView:self.window];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSObject<ShenHeSelectDelegate> *tmpDele=self.chooseAllDelegate;
    [tmpDele actionSheetBtnHandle:(int)buttonIndex];
}

-(void)closingTheChooseMode{
    [UIView animateWithDuration:0.3 animations:^(){
        [self setFrame:CGRectMake(0,  [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 49)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

@end
