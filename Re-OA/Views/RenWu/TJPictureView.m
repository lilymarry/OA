//
//  TJPictureView.m
//  TJLike
//
//  Created by IPTV_MAC on 15/4/12.
//  Copyright (c) 2015年 IPTV_MAC. All rights reserved.
//

#import "TJPictureView.h"
#import "ImageHelper.h"


@interface TJPictureView()<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UIButton *addbt;
}
@property (nonatomic, strong)NSMutableArray *imageArrs;
@property (nonatomic, strong)NSMutableArray *saveImageView;

@end

@implementation TJPictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _saveImageView = [[NSMutableArray alloc] init];
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
//    scrollView.backgroundColor = [UIColor redColor];
    [self addSubview:scrollView];
//    UILabel *lblAlter = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 21 -20, self.frame.size.width, 21)];
//    [lblAlter setText:@"上传图片"];
//    [lblAlter setFont:[UIFont systemFontOfSize:14]];
//    [lblAlter setTextAlignment:NSTextAlignmentCenter];
//    [lblAlter setTextColor:[UIColor grayColor]];
//    [lblAlter setBackgroundColor:[UIColor clearColor]];
//    [self addSubview:lblAlter];
    
}
- (void)refresPictureView:(NSArray *)lists
{
    self.imageArrs = (NSMutableArray *)lists;
    int imgNum =(int) self.imageArrs.count;
//    int imgNum = 6;
    for (UIImageView *imageView in _saveImageView) {
        [imageView removeFromSuperview];
    }
    [addbt removeFromSuperview];
//    CGFloat  viewWidth =self.frame.size.height/2;
//    scrollView.contentSize = CGSizeMake((viewWidth + 20) *imgNum+100, 0);
//    CGFloat  viewY = self.frame.size.height/8;
//    CGFloat  viewHeight = self.frame.size.height/2;
    //int minx=5;
    CGFloat  viewWidth =60;
    CGFloat  viewHeight =60;
    scrollView.contentSize = CGSizeMake((viewWidth+5) *(imgNum+1), 0);
    for (int i = 0 ; i < imgNum; i ++) {
     
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i + 1)*(scrollView.contentSize.width-100 - imgNum * viewWidth)/(imgNum +1) + i *(viewWidth +10), viewY+20, viewWidth, viewHeight)];
      UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(5+viewWidth)*i, 5, viewWidth, viewHeight)];
        UIImage *data = [self.imageArrs objectAtIndex:i];
        
        [imageView setImage:[ImageHelper hotImageWithImage:data]];
        [imageView setUserInteractionEnabled:YES];
       // imageView.tag = 100 +i;
        imageView.tag =i;
        [scrollView addSubview:imageView];
        [_saveImageView addObject:imageView];
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage:)];
        [imageView addGestureRecognizer:singleTap];
     
        
        
       UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setFrame:CGRectMake(viewWidth - 22, -6, 25, 25)];
        [bt setBackgroundColor:[UIColor redColor]];
        [bt.layer setMasksToBounds:YES];
        bt.layer.cornerRadius = 15;
        [bt setTitle:@"X" forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bt.tag = i;
        [bt addTarget:self action:@selector(deletNowIma:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:bt];
        
     
       
    }
    addbt  = [UIButton buttonWithType:UIButtonTypeCustom];
    [addbt setFrame:CGRectMake(5+(5+viewWidth)*imgNum , 5, viewWidth, viewHeight)];
    [addbt setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [addbt.layer setMasksToBounds:YES];
    addbt.layer.cornerRadius = 15;
    [addbt setTitle:@"+" forState:UIControlStateNormal];
    [addbt.titleLabel setFont:[UIFont systemFontOfSize:40]];
    [addbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addbt.tag = 8000;
    [addbt addTarget:self action:@selector(deletNowIma:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addbt];
    [_saveImageView addObject:addbt];
  

}
-(void)deletNowIma:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag!=8000) {
        [self.imageArrs removeObjectAtIndex:button.tag];
        UIImageView *imgView = (UIImageView *)[self.saveImageView objectAtIndex:button.tag];
        [imgView removeFromSuperview];
        [self.saveImageView removeObjectAtIndex:button.tag];

    }

       if ([self.delegate respondsToSelector:@selector(removeImageView:andType:)]) {
        [self.delegate removeImageView:(int)button.tag andType:_typeStr];
    }


}

-(void)whenClickImage:(UITapGestureRecognizer *)gestureRecognizer
{
    
    UIImageView *imgView=(UIImageView *)[gestureRecognizer view];
    if ([self.delegate respondsToSelector:@selector(showImageView: andType:)]) {
        [self.delegate showImageView:(int)imgView.tag andType:_typeStr];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
