
#import <UIKit/UIKit.h>
#import "LocationTracker.h"
@protocol FavoriteMenuDataSource <NSObject>

//委托常用界面vc去生成菜单
-(void)menusFromFavoriteSetting;

@end

@protocol setViewDelegate <NSObject>
-(void)puchSetView:(id)sender;
@end

@interface MenuFrameView : UIView<UIScrollViewDelegate>

@property (nonatomic,weak) id<FavoriteMenuDataSource> MenuFrameViewDelegate;
@property (nonatomic,weak) id<setViewDelegate> setViewDelegate;

@property (nonatomic,strong) UIScrollView *menuSV;
@property (nonatomic,strong) UIPageControl *pageCrt;

-(void)initOtherViews;
-(instancetype)initForIphoneScreen;
-(void)resizeMenuSVContentSizeByWanggeCount:(int)count;
-(void)resetNumberOfPages:(int)count;
-(void)buildingBackgroundOfWangGe:(int)wanggeCount;
@end
