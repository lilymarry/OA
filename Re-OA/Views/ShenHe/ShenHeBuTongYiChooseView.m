
#import "ShenHeBuTongYiChooseView.h"
#import "ScreenHelper.h"

@interface ShenHeBuTongYiChooseView (){}

@end

@implementation ShenHeBuTongYiChooseView

-(ShenHeBuTongYiChooseView *)instanceChooseViewWithArrayData:(NSMutableArray*)arr
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShenHeBuTongYiChooseView" owner:nil options:nil];
    ShenHeBuTongYiChooseView *view= [nibView lastObject];
    [view setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_WIDTH], 300)];
    [UIView animateWithDuration:0.2 animations:^(){
        [view setFrame:CGRectMake(0,[ScreenHelper SCREEN_HEIGHT]-300, [ScreenHelper SCREEN_WIDTH],300)];
    }completion:^(BOOL finished){
    } ];
    view.dataArr=[[NSMutableArray alloc] initWithArray:arr] ;
    view.pwChoose.dataSource=view;
    view.pwChoose.delegate=view;
    view.twCon.delegate=view;
    return view;
}

- (IBAction)submitHandle:(id)sender {
    NSObject<ShenHeSelectDelegate> *tmpDele=self.submitDelegate;
    NSString *con =(![@"点此输入" isEqualToString:self.twCon.text])?[self.twCon.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]:@"";
    
    NSInteger index=  [self.pwChoose selectedRowInComponent:0];
    NSDictionary *dict=(self.dataArr!=nil && self.dataArr.count>0)? [self.dataArr objectAtIndex:index]:nil;
    NSString *fsid= (dict!=nil)?[dict valueForKey:@"fsid"]:@"";
    [tmpDele hasReadyForSubmitWithcon:con Andfsid:fsid];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArr.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSDictionary *dict= [self.dataArr objectAtIndex:row];
    NSString *str= [dict valueForKey:@"fsnm"];
    return str;
}

-(void)closingThePickViewChooseMode:(void (^)())closedHandle{
    [UIView animateWithDuration:0.2 animations:^(){
        [self setFrame:CGRectMake(0, [ScreenHelper SCREEN_HEIGHT], [ScreenHelper SCREEN_HEIGHT], 300)];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
        [self endEditing:YES];
        if (closedHandle) {
            closedHandle();
        }
    }];
}

//隐藏编辑
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
    CGRect frame=CGRectMake(0, [ScreenHelper SCREEN_HEIGHT]-300, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.5f animations:^{
        self.frame=frame;
    }];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([@"点此输入" isEqualToString:self.twCon.text]) {
        self.twCon.text=@"";
    }
    CGRect frame=self.frame;
    frame.origin.y=frame.origin.y- 250;
    [UIView animateWithDuration:0.5f animations:^{
        self.frame=frame;
    }];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([@"" isEqualToString:self.twCon.text]) {
        self.twCon.text=@"点此输入";
    }
}

@end
