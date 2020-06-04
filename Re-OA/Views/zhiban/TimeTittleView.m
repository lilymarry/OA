//
//  TimeTittleView.m
//  Re-OA
//
//  Created by admin on 16/3/23.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "TimeTittleView.h"
#import "ChooseDateView.h"
#import "ScreenHelper.h"
@implementation TimeTittleView
{
  //  UIScrollView    *_navgationTabBar;      // all items on this scroll view
    //  UIImageView     *_arrowButton;          // arrow button
    
    //  UIView          *_line;                 // underscore show which item selected
    //  SCPopView       *_popView;              // when item menu, will show this view
    
 //   NSMutableArray  *_items;                // SCNavTabBar pressed item
  //  NSArray         *_itemsWidth;           // an array of items' width
    //BOOL            _showArrowButton;       // is showed arrow button
    // BOOL            _popItemMenu;           // is needed pop item menu
    
    UITextField *tf_st;
    UITextField *tf_et;
    
    ChooseDateView *st_view;
    ChooseDateView *et_view;
    ChooseDateView *time_view;

    
    
    UIView *oneDayView;
    UIView *twoDayView;
    UITextField *timeLable;
    UIButton *seletBtn;
    NSString *destDateString;
    

}
- (id)initWithFrame:(CGRect)frame andMode:(NSString *) pilaing  andBtnState:(NSString *) BtnState
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSDate *date=[NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        destDateString = [dateFormatter stringFromDate:date];

        if ([pilaing isEqualToString:@"1"] ) {
            [self addOneDayViewWithState:BtnState];
        }
        else
        {
            [self addTwoDayView];

        }
        
    }
    return self;
    
}
-(void)addTwoDayView
{
    twoDayView=[[UIView alloc]init];
    //   twoDayView.backgroundColor=[UIColor yellowColor];
    twoDayView.frame=CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH]+80, 44);
    [self addSubview:twoDayView];
    
    
    
    UILabel *lab=[[UILabel alloc ] initWithFrame:CGRectMake(0, 17, 51, 14)];
    lab.textColor = [UIColor darkGrayColor];
    // lab.backgroundColor=[UIColor yellowColor];
    lab.text=@"查找时间";
    lab.font=[UIFont systemFontOfSize:12];
    [twoDayView addSubview:lab];
    
    
    tf_st=[[UITextField alloc]init];
    tf_st.autocapitalizationType=UITextAutocapitalizationTypeNone;
    tf_st.text=destDateString;
    tf_st.font=[UIFont systemFontOfSize:12];
    tf_st.frame=CGRectMake(CGRectGetMaxX(lab.frame)+2,10,105, 30);
    // tf_st.delegate=self;
    // tf_st.backgroundColor=[UIColor redColor];
    tf_st.textColor=[UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1];
    tf_st.textAlignment=UITextLayoutDirectionLeft;
    [twoDayView addSubview:tf_st];
    
    
    
    UILabel *lab1=[[UILabel alloc ] initWithFrame:CGRectMake(CGRectGetMaxX (tf_st.frame)+1, 17, 15, 14)];
    lab1.textColor = [UIColor darkGrayColor];
    lab1.text=@"到";
    // lab1.backgroundColor=[UIColor yellowColor];
    lab1.font=[UIFont systemFontOfSize:12];
    [twoDayView addSubview:lab1];
    
    
    
    tf_et=[[UITextField alloc]init];
    tf_et.autocapitalizationType=UITextAutocapitalizationTypeNone;
    tf_et.text=destDateString;
    tf_et.font=[UIFont systemFontOfSize:12];
    tf_et.textColor=[UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1];
    
    tf_et.frame=CGRectMake(CGRectGetMaxX (lab1.frame)+1,10,105, 30);
    //tf_et.delegate=self;
    [twoDayView addSubview:tf_et];
    
    
    UIButton *  bt_st1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt_st1.frame=CGRectMake(CGRectGetMaxX (tf_et.frame)+1,10,44, 30);
    bt_st1.titleLabel .font =[UIFont systemFontOfSize:12];
    [bt_st1 setTitle:@"确定" forState:UIControlStateNormal];
    [bt_st1 setTintColor:[UIColor whiteColor]];
    [bt_st1 setBackgroundImage:[UIImage imageNamed:@"btn11.png"] forState:UIControlStateNormal];
    [bt_st1 addTarget:self action:@selector(selectData2) forControlEvents:UIControlEventTouchUpInside];
    [twoDayView addSubview:bt_st1];
    
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (bt_st1.frame)+2, self.frame.size.width-10, 1)];
    view1.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [twoDayView addSubview:view1];
    
    st_view = [ChooseDateView instanceChooseDateView];
    st_view.chooseDateDelegate=self;
    st_view.dateId=@"1";
    
    et_view = [ChooseDateView instanceChooseDateView];
    et_view.chooseDateDelegate=self;
    et_view.dateId=@"2";

    tf_st.inputView=st_view;
    tf_et.inputView=et_view;
    
    seletBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [seletBtn setTitle:@"某一天" forState:UIControlStateNormal];
    seletBtn.titleLabel .font =[UIFont systemFontOfSize:12];
    [seletBtn setTintColor:[UIColor whiteColor]];
    //  [seletBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [seletBtn setBackgroundImage:[UIImage imageNamed:@"allSelcet.png"] forState:UIControlStateNormal];
    seletBtn.frame=CGRectMake(CGRectGetMaxX(bt_st1.frame)+10,10,50,30);
    [seletBtn addTarget:self action:@selector(changView2) forControlEvents:UIControlEventTouchUpInside];
    [twoDayView addSubview:seletBtn];
    
}
-(void)addOneDayViewWithState:(NSString *)state
{
    oneDayView=[[UIView alloc]init];
    //  oneDayView.backgroundColor=[UIColor greenColor];
    oneDayView.frame=CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], 44);
    [self addSubview:oneDayView];
    
    UIButton *stbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[stbtn setTitle:@"前一天" forState:UIControlStateNormal];
    stbtn.tintColor=[UIColor clearColor];
    [stbtn setBackgroundColor:[UIColor lightGrayColor]];
    [stbtn setBackgroundImage:[UIImage imageNamed:@"zuo.png"] forState:UIControlStateNormal];
    stbtn.frame=CGRectMake(5, 5, 26,30);
    stbtn.tag=1000;
    [stbtn addTarget:self action:@selector(selectTime1:) forControlEvents:UIControlEventTouchUpInside];
    [oneDayView addSubview:stbtn];
    
    
//    tf_et=[[UITextField alloc]init];
//   
//    tf_et.text=destDateString;
//    tf_et.font=[UIFont systemFontOfSize:12];
//    tf_et.textColor=[UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1];

    
    timeLable =[[UITextField alloc]init];
    timeLable.frame=CGRectMake(CGRectGetMaxX(stbtn.frame), 5,120,30);
    timeLable.autocapitalizationType=UITextAutocapitalizationTypeNone;
    timeLable.text=destDateString;
    timeLable.font=[UIFont systemFontOfSize:12];
    timeLable.textAlignment=NSTextAlignmentCenter;
    [oneDayView addSubview:timeLable];
    
    time_view = [ChooseDateView instanceChooseDateView];
    time_view.chooseDateDelegate=self;
    time_view.dateId=@"3";
    timeLable.inputView=time_view;
    
    UIButton *etbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    etbtn.tintColor=[UIColor clearColor];
    [etbtn setTitle:@"后一天" forState:UIControlStateNormal];
    etbtn.tag=1001;
    [etbtn setBackgroundColor:[UIColor lightGrayColor]];
    [etbtn setBackgroundImage:[UIImage imageNamed:@"you.png"] forState:UIControlStateNormal];
    etbtn.frame=CGRectMake(CGRectGetMaxX(timeLable.frame), 5, 26,30);
    [etbtn addTarget:self action:@selector(selectTime1:) forControlEvents:UIControlEventTouchUpInside];
    [oneDayView addSubview:etbtn];
    
    
    UIButton *  bt_st=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt_st.frame=CGRectMake(CGRectGetMaxX (etbtn.frame)+2,5,44, 30);
    bt_st.titleLabel .font =[UIFont systemFontOfSize:12];
    [bt_st setTitle:@"确定" forState:UIControlStateNormal];
    [bt_st setTintColor:[UIColor whiteColor]];
    [bt_st setBackgroundImage:[UIImage imageNamed:@"btn11.png"] forState:UIControlStateNormal];
    [bt_st addTarget:self action:@selector(selectData1) forControlEvents:UIControlEventTouchUpInside];
    [oneDayView addSubview:bt_st];
    
    if ([state isEqualToString:@"1"]) {
        seletBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [seletBtn setTitle:@"时间段" forState:UIControlStateNormal];
        seletBtn.titleLabel .font =[UIFont systemFontOfSize:12];
        [seletBtn setTintColor:[UIColor whiteColor]];
        //  [seletBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [seletBtn setBackgroundImage:[UIImage imageNamed:@"allSelcet.png"] forState:UIControlStateNormal];
        seletBtn.frame=CGRectMake(CGRectGetMaxX(bt_st.frame)+10, 5,50,30);
        [seletBtn addTarget:self action:@selector(changView1) forControlEvents:UIControlEventTouchUpInside];
        [oneDayView addSubview:seletBtn];

    }
    
    
}
-(void)selectTime1:(UIButton *)sender
{
    UIButton *but= (UIButton *) sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
  
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 00:00",timeLable.text]];
    NSDate *lastDay;
    if (but.tag==1000) {//时区问题 +8
        lastDay = [NSDate dateWithTimeInterval:-24*60*60+8 sinceDate:date];
        
    }
    else
    {
        lastDay = [NSDate dateWithTimeInterval:+24*60*60+8 sinceDate:date];
    }
    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    [dateform setDateFormat:@"yyyy-MM-dd"];
    
    timeLable.text=[dateform stringFromDate:lastDay];
    
    
}
-(void)changView1
{
    if (oneDayView) {
        [oneDayView removeFromSuperview];
    }
    [self addTwoDayView];
    
    
}
-(void)changView2
{
    if (twoDayView) {
        [twoDayView removeFromSuperview];
    }
    [self addOneDayViewWithState:@"1"];
    
    
    
}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid{
    
    if ([dateid isEqualToString:@"1"]) {
        
        tf_st.text=dateStr;
        [tf_st resignFirstResponder];
        
        
    }
    else  if ([dateid isEqualToString:@"2"]) {
        tf_et.text=dateStr;
        [tf_et resignFirstResponder];
    }
    else{
        timeLable.text=dateStr;
        [timeLable resignFirstResponder];
    
    }
    
    
    
}
-(void)selectData1
{
   //  NSLog(@"22222222222222");
    
    NSString *st=[NSString stringWithFormat:@"%@ 00:00",timeLable.text];
    NSString *et=[NSString stringWithFormat:@"%@ 23:59",timeLable.text];
    
   //  if(tf_st.text.length!=0&&tf_et.text.length!=0)
  //   {
    [self.delegate selectTime:st andEndTime:et nowTime:timeLable.text andState:@"1"];
  //    }
  //      else
  //      {
           // [AlertHelper singleMBHUDShow:@"时间不能为空" ForView:self AndDelayHid:2];
   //     }
    
}
-(void)selectData2
{
   // if(tf_st.text.length!=0&&tf_et.text.length!=0)
   /// {
    NSString *st=[NSString stringWithFormat:@"%@ 00:00",tf_st.text];
    NSString *et=[NSString stringWithFormat:@"%@ 23:59",tf_et.text];
       [self.delegate selectTime:st andEndTime:et nowTime:timeLable.text andState:@"2"];
   // }
   // else
  //  {
       // [AlertHelper singleMBHUDShow:@"时间不能为空" ForView:self AndDelayHid:2];
  //  }
    
}
@end
