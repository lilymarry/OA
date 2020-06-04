
#import "JXCAddRuKuChooseView.h"
#import "ScreenHelper.h"

@interface JXCAddRuKuChooseView (){
    
}

@end

@implementation JXCAddRuKuChooseView

-(JXCAddRuKuChooseView *)initJXCAddRuKuChooseViewForView:(UIView*)parentview
                                                   taget:(id)object
                                             closedHanld:(void (^)())closedHandle
{
    
    //初始化
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"JXCAddRuKuChoose" owner:nil options:nil];
    JXCAddRuKuChooseView *view= [nibView lastObject];
    
    view.act_duowei.hidden=YES;
    
    view.cangkuIndex=[NSNumber numberWithInt:-1];
    view.duoweiIndex=[NSNumber numberWithInt:-1];
    
    [parentview addSubview:view];
    
    //展现
    [view setFrame:CGRectMake(([ScreenHelper SCREEN_WIDTH]-view.frame.size.width)/2, [ScreenHelper SCREEN_HEIGHT], view.frame.size.width, view.frame.size.height)];
    [UIView animateWithDuration:0.3 animations:^(){
        [view setFrame:CGRectMake(([ScreenHelper SCREEN_WIDTH]-view.frame.size.width)/2, [ScreenHelper SCREEN_HEIGHT]-216-view.frame.size.height, view.frame.size.width, view.frame.size.height)];
    }completion:^(BOOL finished){
        //呈现完毕后进行仓库数据绑定
        //        if (view.dataSource!=nil) {
        //            openedHandle();
        //        }
    } ];
    
    
    //关闭
    view.addChooseViewDelegate = object;
    view.closedHandle=closedHandle;
    return view;
}


//确定添加
- (IBAction)confirm:(id)sender {
    
    if (self.addChooseViewDelegate!=nil) {
        [self.addChooseViewDelegate confirmWithCangkuIndex:self.cangkuIndex AndDuoweiIndex:self.duoweiIndex AndShuliang:self.tf_ShuLiang.text];
    }
}

//手动关闭
- (IBAction)ClosingTheView:(id)sender {
    if (self.closedHandle!=nil) {
        [self didClosingTheView:self.closedHandle];
    }
}

//视图关闭
-(void)didClosingTheView:(void (^)())closedHandle{
    [UIView animateWithDuration:0.3 animations:^(){
        [self setFrame:CGRectMake(self.frame.origin.x, [ScreenHelper SCREEN_HEIGHT], self.frame.size.width, self.frame.size.height)];
    }completion:^(BOOL finished){
        [self removeFromSuperview];
        if (closedHandle!=nil) {
            closedHandle();
        }
    } ];
}





@end
