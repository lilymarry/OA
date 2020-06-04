#import "TimePicker.h"
@interface TimePicker()
{
    UIDatePicker *_pickerView;
}
@end
@implementation TimePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
        [self timePickerView];

    }
    return self;
}
-(void)timePickerView
{
    UIButton *cancle=[UIButton buttonWithType:UIButtonTypeCustom];
    cancle.frame=CGRectMake(0, 0, 50, 40);
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancle];
    
//    UIButton *qikong=[UIButton buttonWithType:UIButtonTypeCustom];
//    qikong.frame=CGRectMake(CGRectGetMaxX(cancle.frame)+2, 0, 50, 40);
//    [qikong setTitle:@"清空" forState:UIControlStateNormal];
//    [qikong setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [qikong addTarget:self action:@selector(qikong) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:qikong];
    
    UIView *vorline=[[UIView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 2)];
    vorline.backgroundColor=[UIColor blackColor];
    [self addSubview:vorline];
    UIButton *sure=[UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame=CGRectMake(self.frame.size.width-50, 0, 50, 40);
    [sure setTitle:@"完成" forState:UIControlStateNormal];
    [sure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sure];
    
    _pickerView=[[UIDatePicker alloc]init];
    _pickerView.tintColor=[UIColor whiteColor];
    _pickerView.frame=CGRectMake(0, 40, self.frame.size.width, self.frame.size.height);
    _pickerView.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _pickerView.datePickerMode=UIDatePickerModeDate;
    [_pickerView addTarget:self action:@selector(startTime:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pickerView];
}
-(void)cancle
{
    [self removeFromSuperview];
}
-(void)sure
{
    if ([self.start isEqualToString:@""]||[self.start isEqualToString:@""]) {
        
    }else
    {
       self.timeBlock(self.start);
    }
    [self cancle];
}
-(void)startTime:(UIDatePicker *)sender
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    self.start=[formatter stringFromDate:_pickerView.date];
}
//-(void)qikong
//{
//    if (self.start.length!=0) {
//        
//    
//        self.timeBlock(@"选择时间");
//    }
//    [self cancle];
//}

@end
