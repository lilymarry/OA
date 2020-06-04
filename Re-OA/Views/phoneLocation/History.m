#import "History.h"
#import "TimePicker.h"
#import "TimeChoose.h"
#import "PersonalViewController.h"
#import "CarPerController.h"
#define kBtnW 50
@interface History()
{
    UIView* _optView;
    
    UITextField *_name;
    TimePicker *_picker;
    
    TimeChoose *stimeBtn;
    TimeChoose *etimeBtn;
    
    PersonalViewController *_personal;
    CarPerController *_carper;
    
    //历史查询列表
    UITableView* _hisList;
    NSMutableArray* _hisListData;

}
@end
@implementation History

- (id)initWithFrame:(CGRect)frame Type:(BOOL)isCar
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        [self createSubView:isCar];
    }
    return self;
}
-(void)createSubView:(BOOL)isCar
{
    CGFloat x=5;
    CGFloat y=10;
    CGFloat w;
   
    if (isCar)
    {
         w=self.frame.size.width-10;
        
    }
    else
    {
       
        w =self.frame.size.width*0.5-12.5;


    }
    CGFloat h=35;
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy/MM/dd"];
    NSString *date=[format stringFromDate:[NSDate date]];
    NSString *stitle=[NSString stringWithFormat:@"查找时间:%@",date];
    NSString *etitle=[NSString stringWithFormat:@"到%@",date];
    
    
    //开始时间选择
    stimeBtn= [TimeChoose buttonWithType:UIButtonTypeCustom];
    stimeBtn.titleLabel.font=[UIFont systemFontOfSize:11];
    [stimeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [stimeBtn setTitle:stitle forState:UIControlStateNormal];
    
    [stimeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    stimeBtn.frame=CGRectMake(x, y, w, h);
    [stimeBtn addTarget:self action:@selector(timeChoose:) forControlEvents:UIControlEventTouchUpInside];
    stimeBtn.tag=1000;
    [self addSubview:stimeBtn];
    
    //结束时间选择
    
    if (!isCar) {
        etimeBtn =[TimeChoose buttonWithType:UIButtonTypeCustom];
        
        [etimeBtn setTitle:etitle forState:UIControlStateNormal];
        [etimeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        etimeBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        [etimeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        etimeBtn.frame=CGRectMake(CGRectGetMaxX(stimeBtn.frame)+5, y, w, h);
        [etimeBtn addTarget:self action:@selector(timeChoose:) forControlEvents:UIControlEventTouchUpInside];
        etimeBtn.tag=1001;
        [self addSubview:etimeBtn];
    }

     

    if (isCar) {
        _carper=[[CarPerController alloc]init];
        _carper.isHideSearch=YES;
        __weak typeof(self) weakself=self;
        [_carper setSelectedBlock:^(NSString *name, NSString *uid) {
            __strong typeof(self) strongself=weakself;
            ///////////
            NSString *st=[[strongself->stimeBtn titleLabel].text substringFromIndex:5];
            NSString *et=@"";
            if (weakself.finishBlock) {
                weakself.finishBlock(st,et,name,uid);
             //     weakself.finishBlock1(st,name,uid);
            }
        }];
        _carper.view.frame=CGRectMake(x*0.5, CGRectGetMaxY(stimeBtn.frame)+5, self.frame.size.width-x, self.frame.size.height- CGRectGetMaxY(stimeBtn.frame)-40);
        [self addSubview:_carper.view];
    
    }else
    {
        _personal=[[PersonalViewController alloc]init];
        __weak typeof(self) weakself=self;
        _personal.isHideSearch=YES;
        [_personal setSelectedBlock:^(NSString *name,NSString *uid) {
     
        __strong typeof(self) strongself=weakself;
            NSString *st=[[strongself->stimeBtn titleLabel].text substringFromIndex:5];
        
            NSString *et=[[strongself->etimeBtn  titleLabel].text substringFromIndex:1];
            if (weakself.finishBlock) {
              //  weakself.finishBlock1(st,name,uid);
                 weakself.finishBlock(st,et,name,uid);
            }

            
        }];
        _personal.view.frame=CGRectMake(x*0.5, CGRectGetMaxY(stimeBtn.frame)+5, self.frame.size.width-x, self.frame.size.height- CGRectGetMaxY(stimeBtn.frame)-40);
        [self addSubview:_personal.view];

    }
}
-(void)timeChoose:(UIButton *)sender
{
    [self.superview endEditing:YES];
    if (!_picker) {
        _picker=[[TimePicker alloc]initWithFrame:CGRectMake(0, self.superview.frame.size.height-220, self.superview.frame.size.width, 220)];
    }
    __block NSString *start;
    __block NSString *end;
    
    [_picker setTimeBlock:^(NSString *time) {
        if (time) {
            if (sender.tag==1000) {
                start=time;
                [sender setTitle:[NSString stringWithFormat:@"查找日期:%@",time] forState:UIControlStateNormal];
            }
            else if (sender.tag==1001)
            {
                end=time;
                [sender setTitle:[NSString stringWithFormat:@"到%@",time] forState:UIControlStateNormal];
            }
            
        }
    }];
    [self.superview addSubview:_picker];
}
-(void)removeFromSuperview
{
    [super  removeFromSuperview];
    [_picker removeFromSuperview];
}

@end
