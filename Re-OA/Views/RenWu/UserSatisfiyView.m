//
//  UserSatisfiyView.m
//  Re-OA
//
//  Created by imac-1 on 2017/1/11.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "UserSatisfiyView.h"
#import "ScreenHelper.h"
//#import "PlaceHolderTextView.h"
@interface UserSatisfiyView ()<UITextViewDelegate>
{
    UIButton *but1;
    UIButton *but2;
    UIButton *but3;
    UIImageView *imagView1;
    UIImageView *imagView2;
    UIImageView *imagView3;
    
    UITextView *text;
    
}
@end
@implementation UserSatisfiyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], 230)];
        view.backgroundColor=[UIColor whiteColor];
        [self addSubview:view];
        
        but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(7, 5, 100, 41);
        
        [but1 setTitle:@"满意" forState:UIControlStateNormal];
        //    [but1 setImage:[UIImage imageNamed:@"nan.png"] forState:UIControlStateNormal];
        //    [but1 setImage:[UIImage imageNamed:@"nv.png"] forState:UIControlStateSelected];
        
        //        [but1 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //        [but1 setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [but1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but1.selected=YES;
        but1.tag=100;
        [but1 addTarget:self action:@selector(buPress:) forControlEvents:UIControlEventTouchUpInside];
        
        imagView1=[[UIImageView alloc]initWithFrame:CGRectMake(3, 10, 20, 20)];
        [but1 addSubview:imagView1];
        imagView1.image=[UIImage imageNamed:@"nv.png"];
        [view addSubview:but1];
        
        
        
        
        
        but2=[UIButton buttonWithType:UIButtonTypeCustom];
        but2.frame=CGRectMake(107, 5, 100, 41);
        [but2 setTitle:@"一般" forState:UIControlStateNormal];
        //    [but2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //    [but2 setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [but2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but1.selected=NO;
        but2.tag=101;
        [but2 addTarget:self action:@selector(buPress:) forControlEvents:UIControlEventTouchUpInside];
        imagView2=[[UIImageView alloc]initWithFrame:CGRectMake(3, 10, 20, 20)];
        [but2 addSubview:imagView2];
        imagView2.image=[UIImage imageNamed:@"nan.png"];
        [view addSubview:but2];
        
        
        
        but3=[UIButton buttonWithType:UIButtonTypeCustom];
        but3.frame=CGRectMake(207, 5, 110, 41);
        [but3 setTitle:@"不满意" forState:UIControlStateNormal];
        //    [but3 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //    [but3 setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [but3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but3.tag=102;
        but3.selected=NO;
        [but3 addTarget:self action:@selector(buPress:) forControlEvents:UIControlEventTouchUpInside];
        imagView3=[[UIImageView alloc]initWithFrame:CGRectMake(3, 10, 20, 20)];
        [but3 addSubview:imagView3];
        imagView3.image=[UIImage imageNamed:@"nan.png"];
        [view addSubview:but3];
        
        
        //   [self setImage];
        
       text=[[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(but3.frame)+2, [ScreenHelper SCREEN_WIDTH], 128)];
        text.text=@"点此输入";
        text.delegate=self;
        text.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [view addSubview:text];
        
        UIButton *bt_qubu=[UIButton buttonWithType:UIButtonTypeRoundedRect];
       
        bt_qubu.frame=CGRectMake(5, CGRectGetMaxY (text.frame)+2,self.frame.size.width-10, 44);
        [bt_qubu setTitle:@"提交" forState:UIControlStateNormal];
        [bt_qubu addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
         [bt_qubu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt_qubu setBackgroundImage:[UIImage imageNamed:@"loginBtn1111.png"] forState:UIControlStateNormal];
        
       
        [view addSubview:bt_qubu];
        
        

        }
        
        
    
    return self;
    
}
-(void)buPress:(id)sender
{
    
    UIButton * button = (UIButton *)sender;
    if (button.selected==YES)
    {
        return;
    }
    else
    {
        for (int i = 100; i<103; i++)
        {
            UIButton * button1 = (UIButton *)[self viewWithTag:i];
            button1.selected = NO;
        }
        button.selected = YES;
    }
    
    [self setImage];
    
}
-(void)setImage
{
    if (but1.selected) {
        imagView1.image=[UIImage imageNamed:@"nv.png"];
    }
    else
    {
        imagView1.image=[UIImage imageNamed:@"nan.png"];
    }
    if (but2.selected) {
        imagView2.image=[UIImage imageNamed:@"nv.png"];
    }
    else
    {
        imagView2.image=[UIImage imageNamed:@"nan.png"];
    }
    if (but3.selected) {
        imagView3.image=[UIImage imageNamed:@"nv.png"];
    }
    else
    {
        imagView3.image=[UIImage imageNamed:@"nan.png"];
    }
    
}
-(void)submit
{
  NSString *type=@"1";
    if (but1.selected) {
      type=@"1";
    }
    
   else if (but2.selected) {
       type=@"2";
    }
    else
    {
      type=@"3";
    }

    if ([self.delegate respondsToSelector:@selector(selectUserSatisfiyWithtype:andText:)]) {
        [self.delegate selectUserSatisfiyWithtype:type andText:text.text];
            [self removeFromSuperview];
    }
    
    

}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([@"点此输入" isEqualToString:textView.text]) {
        textView.text=@"";
    }
//    CGRect frame=self.view.frame;
//    frame.origin.y=frame.origin.y- 158;
//    [UIView animateWithDuration:0.5f animations:^{
//        self.view.frame=frame;
//    }];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([@"" isEqualToString:textView.text]) {
        textView.text=@"点此输入";
    }
//    [self.s endEditing:YES];
//    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    [UIView animateWithDuration:0.5f animations:^{
//        self.view.frame=frame;
//    }];
    
}




@end
