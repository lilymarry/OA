//
//  NingHeCell2.m
//  Re-OA
//
//  Created by admin on 16/4/21.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "NingHeCell2.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ShenHeWebAPI.h"
#import "UserPermission.h"
#import "ScreenHelper.h"
#import "ImageHelper.h"
@implementation NingHeCell2

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib ];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)refresPictureView:(NSArray *)lists  withUid:(NSString *)uid
{
    
    
    
    userid=uid;
    self.imageArrs = (NSMutableArray *)lists;
    //  [self performSelectorInBackground:@selector(getIma) withObject:nil];
    
    int imgNum =(int) self.imageArrs.count;
    //    int imgNum = 6;
    //    for (UIImageView *imageView in _saveImageView) {
    //        [imageView removeFromSuperview];
    //    }
    //  int minx=5;
    //  CGFloat  viewWidth =scrollView.bounds.size.height/2;
    CGFloat  viewWidth =60;
    CGFloat  viewHeight =60;
    _scrollView.contentSize = CGSizeMake((viewWidth+5) *(imgNum+1), 0);
    //   CGFloat  viewY = scrollView.bounds.size.height/8;
    //    CGFloat  viewHeight = scrollView.bounds.size.height/2;
    
    for (int i = 0 ; i < imgNum; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(5+viewWidth)*i, 5, viewWidth, viewHeight)];
        NSString *imgurlstr=[[ShenHeWebAPI smallImgUrlPathWithUid:uid] stringByAppendingString:_imageArrs[i]];
        
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
        [_scrollView addSubview:imageView];
        //  [_saveImageView addObject:imageView];
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage:)];
        [imageView addGestureRecognizer:singleTap];
        
    }
    
    
}

-(void)whenClickImage:(UITapGestureRecognizer *)gestureRecognizer
{
    
    UIImageView *imgView=(UIImageView *)[gestureRecognizer view];
    
    if ([self.delegate respondsToSelector:@selector(showNingHeCell2DisPlayImageView: andUserId:)]) {
        [self.delegate showNingHeCell2DisPlayImageView: self.imageArrs[imgView.tag ] andUserId:userid];
        
    }
    
}



@end
