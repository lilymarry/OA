



#import "LargeImageView.h"
#import "ScreenHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LargeImageView (){
    UIScrollView *_scrollView;
    UIImageView *imageView;
    UIImage *image;
    CGRect scrollRect;
    UIView *backView;
}
@end

@implementation LargeImageView

-(instancetype)initLargeImage:(UIImage*)fromimage OrImgUrl:(NSString*)imageUrl{
    self=[super init];
    if (self) {
        image=fromimage;
        int width=  [ScreenHelper SCREEN_WIDTH];
        int height=  [ScreenHelper SCREEN_HEIGHT];
        
        //窗体
        CGRect backrect=CGRectMake(0, 0, width, height);
        [self setFrame:backrect];
        self.backgroundColor=[UIColor clearColor];
        
        //透明背景
        backView =[[UIView alloc] initWithFrame:backrect];
        backView.backgroundColor=[UIColor blackColor];
        backView.alpha=0.0;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
        tapGesture.numberOfTapsRequired=1;
        [backView addGestureRecognizer:tapGesture];
        
        [self addSubview:backView];
        //scrollview
        scrollRect = CGRectMake(0, 100, width, height-200);
        _scrollView = [[UIScrollView alloc] initWithFrame:scrollRect];
        _scrollView.backgroundColor=[UIColor blackColor];
        _scrollView.alpha=0.0;
        _scrollView.delegate=self;
        _scrollView.maximumZoomScale=2.5;
        [self addSubview:_scrollView];
        //imageview
        imageView =[[UIImageView alloc] init];
        imageView.contentMode= UIViewContentModeScaleAspectFit;
        [imageView setFrame:  CGRectMake(0, 0, width, height-150)];
        [_scrollView addSubview:imageView];
        
        UITapGestureRecognizer *scrolltapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zommImageView:)];
        scrolltapGesture.numberOfTapsRequired=2;
        [_scrollView addGestureRecognizer:scrolltapGesture];
        
        [UIView animateWithDuration:0.3 animations:^(){
            backView.alpha=0.8;
            _scrollView.alpha=1;
        }completion:^(BOOL finished){
            if (fromimage) {
                imageView.image=fromimage;
                _scrollView.contentSize=image.size;
            }else{
                NSURL *url=[NSURL URLWithString:imageUrl];
                [imageView sd_setImageWithURL:url  completed:^(UIImage *sdimage, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    imageView.image=sdimage;
                    _scrollView.contentSize=sdimage.size;
                }];
            }
        } ];
    }
    return self;
}

-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    
    [UIView animateWithDuration:0.3 animations:^(){
        backView.alpha=0;
        _scrollView.alpha=0;
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

-(void)zommImageView:(UITapGestureRecognizer*)gesture{
    CGFloat scale=(_scrollView.zoomScale==1.0)?2.5:1.0;
    [_scrollView setZoomScale:scale animated:YES];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return  imageView;
}

@end
