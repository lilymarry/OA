//
//  TJShowImageView.m
//  TJLike
//
//  Created by IPTV_MAC on 15/5/4.
//  Copyright (c) 2015年 IPTV_MAC. All rights reserved.
//

#import "TJShowImageView.h"
#import "UIImageView+AFNetworking.h"
#import "ScreenHelper.h"
@interface TJShowImageView ()<UIScrollViewDelegate,UIActionSheetDelegate>
{
    BOOL      isScreen;
    CGPoint   startPoint;
    CGFloat touchX;
    CGFloat touchY;
    CGFloat scrX;
}
@property (nonatomic, strong) NSArray   *imageLists;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UIImageView    *curImageView;
@property (nonatomic, strong) UIActionSheet *saveSheet;
@property (nonatomic, strong) UIPageControl *pageC;
@property (assign, nonatomic) NSUInteger imageCount;
@property(strong ,nonatomic) NSString *uid;

@end

@implementation TJShowImageView

- (instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images AndUserId:(NSString *)uid
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageLists = [[NSMutableArray alloc] init];
        
//        [self.imageLists addObject:[images objectAtIndex:0]];
//        [self.imageLists addObject:[images objectAtIndex:0]];
        
        self.imageLists = images;
        _imageCount = self.imageLists.count;
        self.backgroundColor = [UIColor blackColor];
        _imageArray = [[NSMutableArray alloc] init];
        _uid=uid;
        [self buildUI];
        
    }
    return self;
}

- (void)buildUI
{
    _scrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH],  [ScreenHelper SCREEN_HEIGHT]))];
    [_scrollView setContentSize:CGSizeMake([ScreenHelper SCREEN_WIDTH] *self.imageLists.count, 0)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.userInteractionEnabled = YES;
    [self addSubview:_scrollView];
    
    
    _pageC = [UIPageControl new];
    CGSize size = [_pageC sizeForNumberOfPages:_imageCount];
    _pageC.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageC.center = CGPointMake([ScreenHelper SCREEN_WIDTH]/2, [ScreenHelper SCREEN_HEIGHT]-80);
    _pageC.numberOfPages = _imageCount;
    _pageC.pageIndicatorTintColor = [UIColor grayColor];
    _pageC.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageC.userInteractionEnabled = NO;
    _pageC.currentPage = _currentImageIndex;
    [self addSubview:_pageC];

    for (int i = 0; i < [self.imageLists count];i++) {
        
        NSDictionary *dic=self.imageLists[i];
        NSString *str=[NSString stringWithFormat:@"%@",dic[@"mpThumbnail"]];
        NSURL *iurl=[NSURL URLWithString:str];

        UIImageView *largeImageView = [[UIImageView alloc] init];
        [largeImageView setImageWithURL:iurl placeholderImage:[UIImage imageNamed:@"news_list_default"]];
    
    
        [largeImageView setFrame:CGRectMake(i * [ScreenHelper SCREEN_WIDTH], 0, [ScreenHelper SCREEN_WIDTH] , [ScreenHelper SCREEN_HEIGHT])];
        largeImageView.contentMode = UIViewContentModeScaleAspectFit;
        largeImageView.tag = i +100;
        [_imageArray addObject:largeImageView];
        [_scrollView addSubview:largeImageView];
    }
    //self.curImageView = [_imageArray objectAtIndex:0];
    
    //点击
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapCurrentView:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGesture];
    //双击
    UITapGestureRecognizer *tapDoubleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapDoubleCurrentView:)];
    tapDoubleGesture.numberOfTapsRequired = 2;
    tapDoubleGesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapDoubleGesture];
    [tapGesture requireGestureRecognizerToFail:tapDoubleGesture];
    //长按
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongCurrentView:)];
    longGesture.minimumPressDuration = 1.0f;
    [self addGestureRecognizer:longGesture];
    

}


- (void)showLargeView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGSize size = self.scrollView.bounds.size;

    
    
    CGAffineTransform newTransform = CGAffineTransformScale(self.scrollView.transform, 0.01, 0.01);
    [_scrollView setTransform:newTransform];
    _scrollView.center = startPoint;
    
    [UIView animateWithDuration:0.25 animations:^{
        CGAffineTransform newTransform2 =  CGAffineTransformConcat(self.scrollView.transform,  CGAffineTransformInvert(self.scrollView.transform));
        [self.scrollView setTransform:newTransform2];
        self.scrollView.alpha = 1.0;
        self.scrollView.center = CGPointMake(size.width/2, size.height/2);
        
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    }];
    
}

- (void)hideLargeView
{
    [UIView animateWithDuration:0.25 animations:^{
        
        CGAffineTransform newTransform =  CGAffineTransformScale(self.scrollView.transform, 0.01, 0.01);
        [self.scrollView setTransform:newTransform];
        self.scrollView.center = CGPointMake(startPoint.x, startPoint.y);
        
    } completion:^(BOOL finished) {
        
        [_scrollView removeFromSuperview];
        [self removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
}


- (void)handleTapCurrentView:(UITapGestureRecognizer *)tapGesture
{
    [self hideLargeView];
    if (self.tapHideBlock) {
        self.tapHideBlock();
    }
    
}

- (void)handleTapDoubleCurrentView:(UITapGestureRecognizer *)tapGesture
{
    touchX = [tapGesture locationInView:tapGesture.view].x;
    touchY = [tapGesture locationInView:tapGesture.view].y;
    
    //    @weakify(self);
    
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        //        @strongify(self);
        
        
        if (isScreen) {
            _scrollView.zoomScale = 1;
            isScreen = NO;
        }
        else{
            
            _scrollView.zoomScale = 2.0;
            
            [weakSelf.scrollView setContentOffset:CGPointMake(touchX, 0)];
            
            isScreen = YES;
            
        }
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)handleLongCurrentView:(UILongPressGestureRecognizer *)longfGesture
{
    
    if(UIGestureRecognizerStateBegan == longfGesture.state) {
        // Called on start of gesture, do work here
        _saveSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
        _saveSheet.actionSheetStyle = UIBarStyleDefault;
        
        [_saveSheet showInView:self];
    }
    
    if(UIGestureRecognizerStateChanged == longfGesture.state) {
        // Do repeated work here (repeats continuously) while finger is down
    }
    
    if(UIGestureRecognizerStateEnded == longfGesture.state) {
        // Do end work here when finger is lifted
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   scrX = scrollView.contentOffset.x/[ScreenHelper SCREEN_WIDTH];
    //self.curImageView = [_imageArray objectAtIndex:scrX];
    self.currentImageIndex = scrX;
    [_pageC setCurrentPage:self.currentImageIndex];

}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    if (scrollView.tag -100 == scrX) {
        
     //   [self.curImageView setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    }
   
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (scrollView.tag -100 == scrX) {
        if (scale > _scrollView.minimumZoomScale) {
            isScreen = YES;
        }
        else{
            isScreen = NO;
        }
    }
   
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView.tag -100 == scrX) {
        return self.curImageView;
    }
    return nil;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
        
        
        UIImageWriteToSavedPhotosAlbum(self.curImageView.image, self,selectorToCall, NULL);
    }
}

- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
        
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alterView show];
        
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}


#pragma mark - UIScrollView的代理方法
#pragma mark 当scrollView正在滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 设置页码
    _pageC.currentPage = page;
}
@end
