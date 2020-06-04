#import "PWView.h"

@implementation PWView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self.backgroundColor=[UIColor whiteColor];
        
        _yuanPW=[[UITextField alloc]initWithFrame:CGRectMake(20, 10,self.frame.size.width-40 , 44)];
        _yuanPW.placeholder=@" 原密码";
        _yuanPW.delegate=self;
        [_yuanPW setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:_yuanPW];
        
        _xinPW=[[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY (_yuanPW.frame)+20, self.frame.size.width-40, 44)];
        _xinPW.placeholder=@" 新密码";
        _xinPW.delegate=self;
        [_xinPW setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:_xinPW];
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=[UIColor whiteColor];
        line.frame=CGRectMake(20, CGRectGetMaxY (_xinPW.frame)+1, self.frame.size.width-40, 1);
        [self addSubview:line];
        
        _quePW=[[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY (_xinPW.frame)+2,self.frame.size.width-40, 44)];
        _quePW.placeholder=@" 再输入一次新密码";
        _quePW.delegate=self;
        [_quePW setBorderStyle:UITextBorderStyleRoundedRect];
         [self addSubview:_quePW];

        UIButton *ChangeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        ChangeBtn.frame=CGRectMake(20, CGRectGetMaxY(_quePW.frame)+20, self.frame.size.width-40, 44);
        [ChangeBtn setTitle:@"修改" forState:UIControlStateNormal];
        [ChangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [ ChangeBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [ChangeBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn1111.png"] forState:UIControlStateNormal];
        [self addSubview:ChangeBtn];}
    return self;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_yuanPW resignFirstResponder];
    [_xinPW resignFirstResponder];
    [_quePW resignFirstResponder];
    return YES;
}
-(void)change:(id)sender
{
  if (self.okDelegate !=nil && [self.okDelegate respondsToSelector:@selector(doButton:)])
  {
    [self.okDelegate doButton:sender];
  }
}
-(void)cancell:(id)sender
{
    if (self.cancelDelegate !=nil && [self.cancelDelegate respondsToSelector:@selector(cancelButton:)])
    {
        [self.okDelegate cancelButton:sender];
    }
}
@end
