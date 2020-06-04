//
//  XYZPaopaoView.m
//  xilaikd
//
//  Created by 智发 on 14-7-17.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import "XYZPaopaoView.h"

@implementation XYZPaopaoView
@synthesize paopaoImage,empName,telState,km,num,time,empAddress;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        self.backgroundColor = [UIColor redColor];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:self.frame];
        image.image = [UIImage imageNamed:@"paopao"];
        [self addSubview:image];
        
//        UIImageView *empImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 50)];
//        empImageView.image = [UIImage imageNamed:@"CouPic1"];
//        [self addSubview:empImageView];
        
        empName = [[UILabel alloc]initWithFrame:CGRectMake(50, 10,self.frame.size.width-50,20)];
        empName.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:empName];
//        
        
        time= [[UILabel alloc]initWithFrame:CGRectMake(50, 25, 90, 20)];
        time.font = [UIFont systemFontOfSize:8.0f];
        [self addSubview:time];
        
        km = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(time.frame)+2, 25, 90, 20)];
        km.font = [UIFont systemFontOfSize:10.0f];
        [self addSubview:km];
        
        num= [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 90, 20)];
        num.font = [UIFont systemFontOfSize:13.0f];
        num.hidden=YES;
        [self addSubview:num];
        
       // if ([telState isEqualToString:@"1"]) {
            paopaoImage=[UIButton buttonWithType:UIButtonTypeCustom];
            paopaoImage.frame=CGRectMake(5, 10, 40, 40);
            [paopaoImage setBackgroundImage:[UIImage imageNamed:@"telBtn.png"] forState:UIControlStateNormal];
            [paopaoImage addTarget:self action:@selector(buPress:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:paopaoImage];
    //    }
        empAddress = [[UILabel alloc]initWithFrame:CGRectMake(50, 27, self.frame.size.width-50, 40)];
        empAddress.numberOfLines=0;
        empAddress.font = [UIFont systemFontOfSize:8.0f];
       // empAddress.text=@"111111";
        [self addSubview:empAddress];

    }
    return self;
}
-(void)buPress:(id)sender
{

    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(btnWithCourieName:)])
    {
        [self.delegate btnWithCourieName:empName.text];
    }


}
@end
