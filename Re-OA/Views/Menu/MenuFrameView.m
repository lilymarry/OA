
#import "MenuFrameView.h"
#import "ScreenHelper.h"
#import "UserPermission.h"

@interface MenuFrameView ()
{
    NSMutableDictionary *dic;
    UIImageView *bannerIV;
}
@end

@implementation MenuFrameView

@synthesize menuSV;
@synthesize pageCrt;

-(instancetype)initForIphoneScreen{
    CGRect  viewRect = CGRectMake(0,0,[ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT]);
    self = [super initWithFrame:viewRect];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initOtherViews];

    }
    return self;
}
#pragma mark


-(void)change:(id)sender
{
    [self.setViewDelegate puchSetView:sender];
}
-(void)initOtherViews
{
    int yx=0;
    if ( self.bounds.size.height==812)
    {
        yx=44;
    }
    UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0, yx, self.frame.size.width, 64)];
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-50, 10, 140, 44)];
   // navView.backgroundColor=[UIColor redColor];
    name.font = [UIFont systemFontOfSize:16.0];
  
    name.text= [NSString stringWithFormat:@"欢迎 %@",[UserPermission standartUserInfo].name] ;
    [navView addSubview:name];
    [self addSubview:navView];

    UIButton *setBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame=CGRectMake(self.frame.size.width-50, 10, 35, 35);
    [setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ setBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [setBtn setBackgroundImage:[UIImage imageNamed:@"NavIndexSettings"] forState:UIControlStateNormal];
    [navView addSubview:setBtn];
    CGFloat y;
    if ( self.bounds.size.height==480)
    {
       y=60;
    }
    if ( self.bounds.size.height==812)
    {
        y=150;
    }
    else
    {
        y=108;
    }
    CGRect  viewRect = [ScreenHelper resizeCGRectX:0
                                                 Y:64
                                             Width:320
                                            Height:y];
    bannerIV = [[UIImageView alloc] initWithFrame:viewRect];
    bannerIV.image=[UIImage imageNamed:@"logo-1242w420h@3x"];
    [self addSubview:bannerIV];
    
    
    viewRect = [ScreenHelper resizeCGRectX:0
                                         Y:64+y
                                     Width:321 //321
                                    Height:320];
    menuSV = [[UIScrollView alloc] initWithFrame:viewRect];
    menuSV.scrollEnabled=YES;
    menuSV.bounces=NO;
    menuSV.showsVerticalScrollIndicator=NO;
    menuSV.showsHorizontalScrollIndicator=NO;
    menuSV.pagingEnabled=YES;
    menuSV.delegate=self;
    [self addSubview:menuSV];
    
    viewRect = [ScreenHelper resizeCGRectX:0
                                         Y:384+y
                                     Width:320
                                    Height:30];//30
    pageCrt = [[UIPageControl alloc] initWithFrame:viewRect];
    [pageCrt setCurrentPageIndicatorTintColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
    [pageCrt setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [pageCrt setNumberOfPages:1];
    [pageCrt addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageCrt];
}
-(void)resizeMenuSVContentSizeByWanggeCount:(int)count
{
    CGSize size= CGSizeMake((count>1)?menuSV.frame.size.width*count:menuSV.frame.size.width,menuSV.frame.size.height);
    menuSV.contentSize=size;
}
-(void)resetNumberOfPages:(int)count
{
    [pageCrt setNumberOfPages:count];
}
-(void)buildingBackgroundOfWangGe:(int)wanggeCount
{
    [self resizeMenuSVContentSizeByWanggeCount:wanggeCount];
    [self resetNumberOfPages:wanggeCount];
    //添加背景图
    for (int i=1; i<=wanggeCount; i++) {
        
        UIImageView *wanggeview= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wangge-1243w1242h@3x.png"]];
        CGRect viewRect = [ScreenHelper resizeCGRectX:(i-1)*321
                                                    Y:0
                                                Width:321
                                               Height:320];
        wanggeview.frame=viewRect;
        [ self.menuSV addSubview:wanggeview];
    }
    
    //委托主界面去生成菜单
    [self.MenuFrameViewDelegate menusFromFavoriteSetting];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float pageWidth = self.menuSV.frame.size.width;
    int currentPage = self.menuSV.contentOffset.x / pageWidth;
    self.pageCrt.currentPage = currentPage;
}
- (IBAction)changePage:(UIPageControl*)pageControl{
    int currentPage = (int)self.pageCrt.currentPage;
    [self.menuSV setContentOffset:CGPointMake(menuSV.frame.size.width * currentPage, 0) animated:YES];
}
@end
