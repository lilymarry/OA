//
//  TJDisPlayPictureView.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/4.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "TJDisPlayPictureView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HotRewWuWebAPI.h"
#import "UserPermission.h"
#import "ScreenHelper.h"
#import "ImageHelper.h"
@interface TJDisPlayPictureView()<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UILabel *lblAlter ;

    UILabel *timelab ;

    
    UIButton * clorkBt;
    
    UITextView *describeFeild;
    
   // UIButton *addbt;
    
   // NSURL *url;
}
@property (nonatomic, strong)NSMutableArray *imageArrs;
@property (nonatomic, strong)NSMutableArray *saveImageView;
@end
@implementation TJDisPlayPictureView
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
    lblAlter = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 21)];
    [lblAlter setText:@""];
    [lblAlter setFont:[UIFont systemFontOfSize:14]];
    [lblAlter setTextAlignment:NSTextAlignmentLeft];
    [lblAlter setTextColor:[UIColor grayColor]];
   // [lblAlter setBackgroundColor:[UIColor redColor]];
    [self addSubview:lblAlter];
    
    describeFeild =[[UITextView alloc]initWithFrame:CGRectMake(10, 21, self.frame.size.width-20, 60)];
 //  [describeFeild setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self addSubview:describeFeild];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(-60, CGRectGetMaxY(describeFeild.frame)+2, [ScreenHelper SCREEN_WIDTH]+60, 70)];
   // scrollView.showsVerticalScrollIndicator = NO;
   // scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    //[scrollView setBackgroundColor:[UIColor redColor]];
    [self addSubview:scrollView];
 
    
//    timelab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblAlter.frame)+2, 0,200, 21)];
//    [timelab setText:@""];
//    [timelab setFont:[UIFont systemFontOfSize:14]];
//    [timelab setTextAlignment:NSTextAlignmentLeft];
//    [timelab setTextColor:[UIColor grayColor]];
//    [timelab setBackgroundColor:[UIColor clearColor]];
//    [self addSubview:timelab];
    
    
//    clorkBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    [clorkBt setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH]-30, 0, 25, 21)];
//    [clorkBt setBackgroundColor:[UIColor clearColor]];
//    [clorkBt addTarget:self action:@selector(setClork:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:clorkBt];
    
    
    
}
-(void)getIma
{
//    // [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
//    //  NSData *data ;
//    if ([typeStr isEqualToString:@"1"]) {
//        //    data = [self imageTransformData:self.editedImage];
//        if (![self.imagDatas containsObject:self.editedImage]) {
//            //
//            [self.imagDatas addObject:self.editedImage];
//            //          //  self->imgNum.hidden = NO;
//            //          //  [self->imgNum setText:[NSString stringWithFormat:@"%ld",(long)self.imagDatas.count]];
//        }
//    }
//    else if ([typeStr isEqualToString:@"2"])
//    {
//        //   data = [self imageTransformData:self.editedImage2];
//        if (![self.imagDatas2 containsObject:self.editedImage2]) {
//            
//            [self.imagDatas2 addObject:self.editedImage2];
//            
//        }
//        
//    }
//    else
//    {
//        //  data = [self imageTransformData:self.editedImage3];
//        if (![self.imagDatas3 containsObject:self.editedImage3]) {
//            
//            [self.imagDatas3 addObject:self.editedImage3];
//            
//        }
//    }
//    
//    
//    [self performSelectorOnMainThread:@selector(mainWork) withObject:nil waitUntilDone:NO];
    
    
    
    
}
-(void)mainWork
{
    //  [AlertHelper hideAllHUDsForView:self.view];
//    [pictureView refresPictureView:self.imagDatas];
//    [pictureView2 refresPictureView:self.imagDatas2];
//    [pictureView3 refresPictureView:self.imagDatas3];
    //    if (self.imagDatas.count>0) {
    //        ischooseImg=YES;
    //
    //    }
    //    else
    //    {
    //        ischooseImg=NO;
    //    }
    
}

- (void)refresPictureView:(NSArray *)lists withType:(NSString *)type andUsid:(NSString *)uid andDecri:(NSString *)decri
{
   
    
    if ([type isEqualToString:@"RH"]) {
        [lblAlter setText:@"入户图片"];
    }
    else if ([type isEqualToString:@"XL"])
    {
        [lblAlter setText:@"完成图片"];

    }
    else
    {
        [lblAlter setText:@"其他图片"];

    }
    describeFeild.text=[NSString stringWithFormat:@"图片描述：%@",decri];
    
    self.imageArrs = (NSMutableArray *)lists;
  //  [self performSelectorInBackground:@selector(getIma) withObject:nil];

    int imgNum =(int) self.imageArrs.count;
    //    int imgNum = 6;
    for (UIImageView *imageView in _saveImageView) {
        [imageView removeFromSuperview];
    }
  //  int minx=5;
  //  CGFloat  viewWidth =scrollView.bounds.size.height/2;
    CGFloat  viewWidth =60;
    CGFloat  viewHeight =60;
    scrollView.contentSize = CGSizeMake((viewWidth+5) *(imgNum+1), 0);
 //   CGFloat  viewY = scrollView.bounds.size.height/8;
//    CGFloat  viewHeight = scrollView.bounds.size.height/2;

    for (int i = 0 ; i < imgNum; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(5+viewWidth)*i, 5, viewWidth, viewHeight)];
 
        NSString *imgurlstr=[HotRewWuWebAPI HotImgUrlPathWithUid:uid type:type pcName:self.imageArrs[i]];
        NSURL *url=[NSURL URLWithString:imgurlstr];
        
        [imageView   sd_setImageWithURL:url                                placeholderImage:[UIImage imageNamed:@"nopicture"]
                                         options:0
                                       completed:^(UIImage *image,
                                                   NSError *error,
                                                   SDImageCacheType cacheType,
                                                   NSURL *imageURL){
                                          imageView.image=[ImageHelper hotImageWithImage:image];
                                       
                                       }];

        [imageView setUserInteractionEnabled:YES];
        imageView.tag =i;
        [scrollView addSubview:imageView];
        [_saveImageView addObject:imageView];
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage:)];
        [imageView addGestureRecognizer:singleTap];
    
    }
    if (_time.length>0) {
        timelab.text=_time;
        [clorkBt setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
        
        
        
    }

    
}

-(void)whenClickImage:(UITapGestureRecognizer *)gestureRecognizer
{
    
    UIImageView *imgView=(UIImageView *)[gestureRecognizer view];
   
    if ([self.delegate respondsToSelector:@selector(showDisPlayImageView:andType:)]) {
        [self.delegate showDisPlayImageView: self.imageArrs[imgView.tag ] andType:_typeStr];
    
    }
    
}

-(void)setClork:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(getImag:andla:)]) {
        [self.delegate getImag:_lo andla:_la];
        
    }

}

@end
