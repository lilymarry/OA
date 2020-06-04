//
//  ShenHeChooseView1.m
//  Re-OA
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 姜任鹏. All rights reserved.
//

#import "ShenHeChooseView1.h"
//#import "TimePicker.h"
#import "ShenheChooseDateView.h"
//@class SelectShenHePerson;
//#import "ShenhenPersonViewController.h"
@implementation ShenHeChooseView1
{
    
    // UIButton *bt_st;
    // UIButton *bt_et;
    UIButton *bt_select;
    // TimePicker *_picker;
    UIButton *bt_selectPerson;
    NSString *perId;
    
    // SelectShenHePerson *preson;
    UITextField *tf_st;
    UITextField *tf_et;
    UITextField *tf_cont;
    ShenheChooseDateView *dateView1;
    ShenheChooseDateView *dateView2;
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)initWithFrame:(CGRect)frame andMode:( BOOL) pilaing
{
    self = [super initWithFrame:frame];
    if (self)
    {
        bt_select=[UIButton buttonWithType:UIButtonTypeCustom];
        bt_select.tag=2006;
        
        perId=[[NSString alloc]init];
        
        //        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        //        [format setDateFormat:@"yyyy-MM-dd"];
        //        NSString *date=[format stringFromDate:[NSDate date]];
        //        NSString *stitle=[NSString stringWithFormat:@"%@",date];
        //        NSString *etitle=[NSString stringWithFormat:@"%@",date];
        
        UIScrollView *   _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,self.bounds.size.width,self.bounds.size.height)];
      
        _scrollerView.contentSize = CGSizeMake(self.bounds.size.width,568);
        [self addSubview:_scrollerView];
        
        self.backgroundColor=[UIColor whiteColor];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _scrollerView.frame.size.width, 44)];
        view.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_scrollerView addSubview:view];
        
        
        UILabel *labV=[[UILabel alloc ] initWithFrame:CGRectMake(5, 8
                                                                 , 40, 28)];
        labV.textColor = [UIColor darkGrayColor];
        labV.text=@"功能项";
        labV.font=[UIFont systemFontOfSize:12];
        [_scrollerView addSubview:labV];
        
        UIButton *quedin=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        quedin.frame=CGRectMake(_scrollerView.frame.size.width-50, 8,50, 30);
        [quedin setTitle:@"确定" forState:UIControlStateNormal];
        [quedin addTarget:self action:@selector(sureBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollerView addSubview:quedin];
        
        UILabel *labb=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY (view.frame)+10, 70, 14)];
        labb.textColor = [UIColor darkGrayColor];

        labb.text=@"模糊查找";
        labb.font=[UIFont systemFontOfSize:14];
        [_scrollerView addSubview:labb];
        
        
        tf_cont=[[UITextField alloc]init];
        tf_cont.borderStyle= UITextBorderStyleNone;
        tf_cont.placeholder=@"点此输入查找的标题";
        tf_cont.font=[UIFont systemFontOfSize:12];
        tf_cont.frame=CGRectMake(CGRectGetMaxX (labb.frame)+3, CGRectGetMaxY (view.frame)+3,_scrollerView.frame.size.width-70, 30);
        tf_cont.delegate=self;
      //  tf_cont.textColor=[UIColor blueColor];
        tf_cont.textAlignment=UITextLayoutDirectionLeft;
        [_scrollerView addSubview:tf_cont];
        
        
        UIView *view11=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (labb.frame)+10, _scrollerView.frame.size.width-10, 1)];
        view11.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_scrollerView addSubview:view11];
        
        
        
        
        
        
        UILabel *lab=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY (view11.frame)+10, 70, 14)];
        lab.textColor = [UIColor darkGrayColor];
        lab.text=@"查找时间";
        lab.font=[UIFont systemFontOfSize:14];
        [_scrollerView addSubview:lab];
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (lab.frame)+10, _scrollerView.frame.size.width-10, 1)];
        view1.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_scrollerView addSubview:view1];
        
        UILabel *la1=[[UILabel alloc ] initWithFrame:CGRectMake(2, CGRectGetMaxY (view1.frame)+9, 14, 14)];
        la1.textColor = [UIColor darkGrayColor];
        la1.text=@"从";
        la1.font=[UIFont systemFontOfSize:14];
        [_scrollerView addSubview:la1];
        
        //        bt_st=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        //        bt_st.frame=CGRectMake(8, CGRectGetMaxY (view1.frame)+2,86, 30);
        //        bt_st.titleLabel .font =[UIFont systemFontOfSize:12];
        //        [bt_st setTitle:@"选择时间" forState:UIControlStateNormal];
        //        [bt_st addTarget:self action:@selector(timeChoose:) forControlEvents:UIControlEventTouchUpInside];
        //        bt_st.tag=1000;
        //        [self addSubview:bt_st];
        
        tf_st=[[UITextField alloc]init];
        tf_st.autocapitalizationType=UITextAutocapitalizationTypeNone;
        tf_st.text=@"选择时间";
        tf_st.font=[UIFont systemFontOfSize:12];
        tf_st.frame=CGRectMake(18, CGRectGetMaxY (view1.frame)+2,86, 30);
        tf_st.delegate=self;
        tf_st.textColor=[UIColor blueColor];
        tf_st.textAlignment=UITextLayoutDirectionLeft;
        [_scrollerView addSubview:tf_st];
        
        dateView1 = [ShenheChooseDateView instanceChooseDateView];
        dateView1.chooseDateDelegate=self;
        dateView1.dateId=@"1";
        tf_st.inputView=dateView1;
        
        UILabel *lab1=[[UILabel alloc ] initWithFrame:CGRectMake(CGRectGetMaxX (tf_st.frame)+2, CGRectGetMaxY (view1.frame)+9, 17, 14)];
        lab1.textColor = [UIColor darkGrayColor];
        lab1.text=@"到";
        lab1.font=[UIFont systemFontOfSize:14];
        [_scrollerView addSubview:lab1];
        

        tf_et=[[UITextField alloc]init];
        tf_et.autocapitalizationType=UITextAutocapitalizationTypeNone;
        tf_et.text=@"选择时间";
        tf_et.font=[UIFont systemFontOfSize:12];
        tf_et.textColor=[UIColor blueColor];
        tf_et.frame=CGRectMake(CGRectGetMaxX (lab1.frame)+2, CGRectGetMaxY (view1.frame)+2,86, 30);
        tf_et.delegate=self;
        [_scrollerView addSubview:tf_et];
        
        dateView2 = [ShenheChooseDateView instanceChooseDateView];
        dateView2.chooseDateDelegate=self;
        dateView2.dateId=@"2";
        tf_et.inputView=dateView2;
        
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (tf_et.frame)+8, _scrollerView.frame.size.width-10, 1)];
        view2.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_scrollerView addSubview:view2];
        
        
        UILabel *lab2=[[UILabel alloc ] initWithFrame:CGRectMake(5, CGRectGetMaxY (view2.frame)+9, 43, 21)];
        lab2.textColor = [UIColor darkGrayColor];
        lab2.text=@"申请人";
        lab2.font=[UIFont systemFontOfSize:14];
        [_scrollerView addSubview:lab2];
        
        bt_selectPerson=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt_selectPerson.frame=CGRectMake(CGRectGetMaxX (lab2.frame)+9, CGRectGetMaxY (view2.frame)+2,141, 30);
        [bt_selectPerson setTitle:@"点此选择" forState:UIControlStateNormal];
        [bt_selectPerson addTarget:self action:@selector(selectPerson:) forControlEvents:UIControlEventTouchUpInside];
        //bt_selectPerson.tag=1001;
        bt_selectPerson.titleLabel .font =[UIFont systemFontOfSize:12];
        [_scrollerView addSubview:bt_selectPerson];
        
        UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (lab2.frame)+8, _scrollerView.frame.size.width-10, 1)];
        view3.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_scrollerView addSubview:view3];
        
        UIButton *bt_cw=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt_cw.frame=CGRectMake(5, CGRectGetMaxY (view3.frame)+2,self.frame.size.width-10, 44);
        [bt_cw setTitle:@"财务审核" forState:UIControlStateNormal];
        [bt_cw addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        bt_cw.tag=2001;
        bt_cw.titleLabel .font =[UIFont systemFontOfSize:12];
        // bt_cw.backgroundColor=[UIColor redColor];
        [_scrollerView addSubview:bt_cw];
        //  bt_select.tag=2001;
        
        UIImageView *cwIcon=[[UIImageView alloc]init];
        cwIcon.frame=CGRectMake(0, 12, 24, 24);
        cwIcon.image=[UIImage imageNamed:@"caiwu-150@3x.png"];
        [bt_cw addSubview:cwIcon];
        
        //        cwIcon1=[[UIImageView alloc]init];
        //        cwIcon1.frame=CGRectMake(self.frame.size.width-50, 12, 24, 24);
        //        cwIcon1.image=[UIImage imageNamed:@"unRemBtn.png"];
        //        cwIcon1.tag=3001;
        //        [bt_cw addSubview:cwIcon1];
        
        
        
        UIView *lin1=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (bt_cw.frame)+1, self.frame.size.width-10, 1)];
        lin1.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_scrollerView addSubview:lin1];
        
        UIButton *bt_sh=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt_sh.frame=CGRectMake(5, CGRectGetMaxY (lin1.frame)+2,self.frame.size.width-10, 44);
        [bt_sh setTitle:@"人事审核" forState:UIControlStateNormal];
        [bt_sh addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        bt_sh.tag=2002;
        bt_sh.titleLabel .font =[UIFont systemFontOfSize:12];
        [_scrollerView addSubview:bt_sh];
        
        UIImageView *shIcon=[[UIImageView alloc]init];
        shIcon.frame=CGRectMake(0, 12, 24, 24);
        shIcon.image=[UIImage imageNamed:@"renshi-150@3x.png"];
        [bt_sh addSubview:shIcon];
        
        //        shIcon1=[[UIImageView alloc]init];
        //        shIcon1.frame=CGRectMake(self.frame.size.width-50, 12, 24, 24);
        //        shIcon1.image=[UIImage imageNamed:@"unRemBtn.png"];
        //        shIcon1.tag=3002;
        //        [bt_sh addSubview:shIcon1];
        
        
        
        UIView *lin2=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (bt_sh.frame)+1, self.frame.size.width-10, 1)];
        lin2.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_scrollerView addSubview:lin2];
        
        UIButton *bt_xz=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt_xz.frame=CGRectMake(5, CGRectGetMaxY (lin2.frame)+2,self.frame.size.width-10, 44);
        [bt_xz setTitle:@"行政审核" forState:UIControlStateNormal];
        [bt_xz addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        bt_xz.tag=2003;
        bt_xz.titleLabel .font =[UIFont systemFontOfSize:12];
        [_scrollerView addSubview:bt_xz];
        
        UIImageView *xzIcon=[[UIImageView alloc]init];
        xzIcon.frame=CGRectMake(0, 15, 24, 24);
        xzIcon.image=[UIImage imageNamed:@"xingzheng-150@3x.png"];
        [bt_xz addSubview:xzIcon];
        
        //        xzIcon1=[[UIImageView alloc]init];
        //        xzIcon1.frame=CGRectMake(self.frame.size.width-50, 15, 24, 24);
        //        xzIcon1.image=[UIImage imageNamed:@"unRemBtn.png"];
        //        xzIcon1.tag=3003;
        //        [bt_xz addSubview:xzIcon1];
        
        UIView *lin3=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (bt_xz.frame)+1, self.frame.size.width-10, 1)];
        lin3.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_scrollerView addSubview:lin3];
        
        UIButton *bt_yw=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt_yw.frame=CGRectMake(5, CGRectGetMaxY (bt_xz.frame)+2,self.frame.size.width-10, 44);
        [bt_yw setTitle:@"业务审核" forState:UIControlStateNormal];
        [bt_yw addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        bt_yw.tag=2004;
        bt_yw.titleLabel .font =[UIFont systemFontOfSize:12];
        [_scrollerView addSubview:bt_yw];
        
        UIImageView *ywIcon=[[UIImageView alloc]init];
        ywIcon.frame=CGRectMake(0, 15, 24, 24);
        ywIcon.image=[UIImage imageNamed:@"yewu-150@3x.png"];
        [bt_yw addSubview:ywIcon];
        
        //        ywIcon1=[[UIImageView alloc]init];
        //        ywIcon1.frame=CGRectMake(self.frame.size.width-50, 15, 24, 24);
        //        ywIcon1.image=[UIImage imageNamed:@"unRemBtn.png"];
        //        ywIcon1.tag=3004;
        //        [bt_yw addSubview:ywIcon1];
        
        
        
        UIView *lin4=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (bt_yw.frame)+1, self.frame.size.width-10, 1)];
        lin4.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_scrollerView addSubview:lin4];
        
        UIButton *bt_sc=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt_sc.frame=CGRectMake(5, CGRectGetMaxY (bt_yw.frame)+2,self.frame.size.width-10, 44);
        [bt_sc setTitle:@"生产审核" forState:UIControlStateNormal];
        [bt_sc addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        bt_sc.tag=2005;
        bt_sc.titleLabel .font =[UIFont systemFontOfSize:12];
        [_scrollerView addSubview:bt_sc];
        
        
        
        UIView *lin5=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (bt_sc.frame)+1, self.frame.size.width-10, 1)];
        lin5.backgroundColor=[UIColor darkGrayColor];
        [_scrollerView addSubview:lin5];
        
        UIImageView *scIcon=[[UIImageView alloc]init];
        scIcon.frame=CGRectMake(0, 15, 24, 24);
        scIcon.image=[UIImage imageNamed:@"shengchan-150@3x.png"];
        [bt_sc addSubview:scIcon];
        
        //        scIcon1=[[UIImageView alloc]init];
        //        scIcon1.frame=CGRectMake(self.frame.size.width-50, 15, 24, 24);
        //        scIcon1.image=[UIImage imageNamed:@"unRemBtn.png"];
        //        scIcon1.tag=3005;
        //        [bt_sc addSubview:scIcon1];
        
        UIButton *bt_qubu=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        bt_qubu.frame=CGRectMake(5, CGRectGetMaxY (lin5.frame)+2,self.frame.size.width-10, 44);
        [bt_qubu setTitle:@"选择全部" forState:UIControlStateNormal];
        [bt_qubu addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        bt_qubu.tag=2006;
        bt_qubu.selected=YES;
        bt_qubu.titleLabel .font =[UIFont systemFontOfSize:12];
        [_scrollerView addSubview:bt_qubu];
        
        
        
        UIImageView *qbIcon=[[UIImageView alloc]init];
        qbIcon.frame=CGRectMake(0, 15, 24, 24);
        qbIcon.image=[UIImage imageNamed:@"quanbushenhe.png"];
        [bt_qubu addSubview:qbIcon];
        
        UIView *lin6=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (bt_qubu.frame)+1, self.frame.size.width-10, 1)];
        lin6.backgroundColor=[UIColor darkGrayColor];
        [_scrollerView addSubview:lin6];
        
        
        if (pilaing) {
            UIButton *bt_piliang=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            bt_piliang.frame=CGRectMake(5, CGRectGetMaxY (bt_qubu.frame)+2,self.frame.size.width-10, 44);
            [bt_piliang setTitle:@"批量选择" forState:UIControlStateNormal];
            [bt_piliang addTarget:self action:@selector(selectpiliang:) forControlEvents:UIControlEventTouchUpInside];
            bt_piliang.tag=1004;
            bt_piliang.titleLabel .font =[UIFont systemFontOfSize:12];
            [_scrollerView addSubview:bt_piliang];
            
            UIImageView *plIcon=[[UIImageView alloc]init];
            plIcon.frame=CGRectMake(0, 15, 24, 24);
            plIcon.image=[UIImage imageNamed:@"quanbushenhe.png"];
            [bt_piliang addSubview:plIcon];
            
            
            UIView *lin6=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (bt_piliang.frame)+1, self.frame.size.width-10, 1)];
            lin6.backgroundColor=[UIColor darkGrayColor];
            [_scrollerView addSubview:lin6];
        }
        
        
    }
    return self;
    
}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid{
    
        if ([dateid isEqualToString:@"1"]) {
      
            tf_st.text=dateStr;
            [tf_st resignFirstResponder];
      
       
    }
    if ([dateid isEqualToString:@"2"]) {
                 tf_et.text=dateStr;
            [tf_et resignFirstResponder];
        }
        
   
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

-(int)timeWithLaterWithtime1:(NSString *)time1 andTime2:(NSString *)time2
{
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *dateA = [formatter dateFromString:time1]; //下单日期
    NSDate *dateB = [formatter dateFromString:time2]; //交期
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        // NSLog(@"Date1  is in the future");
        return 0;
    }
    else if (result == NSOrderedAscending){
        //  NSLog(@"Date1 is in the past");
        return 1;
        
    }
    else
    {
        //  NSLog(@"Both dates are the same");
        return 2;
    }
    
    
}

- (void)selectType:(id )sender
{
    [tf_et resignFirstResponder];
    [tf_st resignFirstResponder];
    [tf_cont resignFirstResponder];
    UIButton * button = (UIButton *)sender;
    
    if (button.selected==YES)
    {
        return;
    }
    else
    {
        
        for (int i = 2001; i<=2006; i++)
        {
            UIButton * button1 = (UIButton *)[self viewWithTag:i];
            button1.selected = NO;
        }
        button.selected = YES;
        bt_select.tag=   button.tag;
    }
    
    
}
- (void)sureBtnPress:(id)sender
{
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *date=[format stringFromDate:[NSDate date]];
    NSString *stitle=[NSString stringWithFormat:@"%@",date];
    
    int result2=[self timeWithLaterWithtime1:stitle andTime2:tf_st.text];
    int result1=[self timeWithLaterWithtime1:tf_st.text andTime2:tf_et.text];
    
    if (result2==1)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"起始时间早于当前时间,请重选" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
   else if (result1==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"终止时间早于起始时间,请重选" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
 
   else
   {
    NSString *typ=[NSString stringWithFormat:@"%ld",(long)bt_select.tag-2000];
    if ([self.dDelegate respondsToSelector:@selector(selectSheHeWithSt:andName:et:type:tittle:)])
    {
        [self.dDelegate selectSheHeWithSt:tf_st.text andName:perId et:tf_et.text type:typ tittle:tf_cont.text];
        // [preson removeFromSuperview];
        [self removeFromSuperview];
    }
  }
}

-(void)selectPerson:(id)sender
{
    [tf_et resignFirstResponder];
    [tf_st resignFirstResponder];
    [tf_cont resignFirstResponder];
    int  tag=(int)bt_select.tag-2000;
    if (tag==6) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"没有选择审核类型" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else
    {
        SelectShenHePerson*  preson=[[SelectShenHePerson alloc]initWithFrame:self.bounds];
        preson.datDelegate=self;
        preson.type=[NSString stringWithFormat:@"%ld",(long)bt_select.tag-2000];
        [self addSubview:preson];
    }
}
-(void)selectPresonWithNum:(NSString *)num andName:(NSString *)name
{
    perId=num;
    [bt_selectPerson setTitle:name forState:UIControlStateNormal];
    
    
}


-(void)selectpiliang:(id)sender
{
    if ([self.dDelegate respondsToSelector:@selector(selecPiliang)])
    {
        [self.dDelegate selecPiliang];
        [self removeFromSuperview];
    }
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  
    
    [textField resignFirstResponder];

    return YES;
}


@end
