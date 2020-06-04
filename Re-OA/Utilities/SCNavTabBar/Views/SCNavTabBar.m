//
//  SCNavTabBar.m
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import "SCNavTabBar.h"
#import "CommonMacro.h"
#import "ZhiBanChooseDateView.h"
#import "AlertHelper.h"

@interface SCNavTabBar () <RenWuDateChooseDelegate>
{
    UIScrollView    *_navgationTabBar;      // all items on this scroll view
    //  UIImageView     *_arrowButton;          // arrow button
    
    //  UIView          *_line;                 // underscore show which item selected
    //  SCPopView       *_popView;              // when item menu, will show this view
    
    NSMutableArray  *_items;                // SCNavTabBar pressed item
    NSArray         *_itemsWidth;           // an array of items' width
    //BOOL            _showArrowButton;       // is showed arrow button
    // BOOL            _popItemMenu;           // is needed pop item menu
    
    UITextField *tf_st;
    UITextField *tf_et;
    
    ZhiBanChooseDateView *dateView1;
    ZhiBanChooseDateView *dateView2;
    
    UIView *oneDayView;
    UIView *twoDayView;
    UILabel *timeLable;
    UIButton *seletBtn;
    NSString *destDateString;
}

@end

@implementation SCNavTabBar

- (id)initWithFrame:(CGRect)frame showArrowButton:(BOOL)show
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //_showArrowButton = show;
        [self initConfig];
    }
    return self;
}

#pragma mark -
#pragma mark - Private Methods

- (void)initConfig
{
    _items = [@[] mutableCopy];
    //  _arrowImage = [UIImage imageNamed:SCNavTabbarSourceName(@"arrow.png")];
 //   [self getStateTime];
    [self viewConfig];
//    NSLog(@"WWW!!! %@ %@ %@ %@ ",_nowTime ,_stTime ,_etTime ,_state);
//
//    if ([_state isEqualToString:@"1"]) {
//        [self addOneDayView];
//    }
//    else
//    {
//      [self addTwoDayView];
//    }
 
    //
    //  [self addTapGestureRecognizer];
}

- (void)viewConfig
{
    _navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, SCREEN_WIDTH, NAV_TAB_BAR_HEIGHT)];
    _navgationTabBar.showsHorizontalScrollIndicator = NO;
    [self addSubview:_navgationTabBar];
    
}



- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    CGFloat buttonX = DOT_COORDINATE;
    for (NSInteger index = 0; index < [_itemTitles count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(buttonX, DOT_COORDINATE+44, [widths[index] floatValue], NAV_TAB_BAR_HEIGHT-44);
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // button.backgroundColor=[UIColor yellowColor];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_navgationTabBar addSubview:button];
        
        [_items addObject:button];
        buttonX += [widths[index] floatValue];
        if (index==0) {
            button.selected=YES;
        }
    }
    
    // [self showLineWithButtonWidth:[widths[0] floatValue]];
    return buttonX;
}
//-(void)getStateTime
//{
//    NSDate *date=[NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    destDateString = [dateFormatter stringFromDate:date];
//    
//    
//}
-(NSString *)subTimeWithTime:(NSString *)time
{
    NSString *str=@" ";
    NSRange range = [time rangeOfString:str];//匹配得到的下标
    NSString *   string;
    
    if (range.location!=NSNotFound)
    {
        string = [time substringToIndex:range.location];//截取范围类的字符串
        
        return string;
        
    }
    else
    {
        return  nil;
    }
    
    
}
-(void)addTwoDayView
{
    twoDayView=[[UIView alloc]init];
    //   twoDayView.backgroundColor=[UIColor yellowColor];
    twoDayView.frame=CGRectMake(0, 0, SCREEN_WIDTH+65, 44);
    [_navgationTabBar addSubview:twoDayView];
    
    
    //    NSDate *date=[NSDate date];
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    UILabel *lab=[[UILabel alloc ] initWithFrame:CGRectMake(0, 17, 51, 14)];
    lab.textColor = [UIColor darkGrayColor];
    // lab.backgroundColor=[UIColor yellowColor];
    lab.text=@"查找时间";
    lab.font=[UIFont systemFontOfSize:12];
    [twoDayView addSubview:lab];
    
    
    tf_st=[[UITextField alloc]init];
    tf_st.autocapitalizationType=UITextAutocapitalizationTypeNone;
    tf_st.text=_stTime;
    tf_st.font=[UIFont systemFontOfSize:12];
    tf_st.frame=CGRectMake(CGRectGetMaxX(lab.frame)+2,10,125, 30);
    // tf_st.delegate=self;
    // tf_st.backgroundColor=[UIColor redColor];
    tf_st.textColor=[UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1];
    tf_st.textAlignment=UITextLayoutDirectionLeft;
    [twoDayView addSubview:tf_st];
    
    
    
    UILabel *lab1=[[UILabel alloc ] initWithFrame:CGRectMake(CGRectGetMaxX (tf_st.frame)+1, 17, 15, 14)];
    lab1.textColor = [UIColor darkGrayColor];
    lab1.text=@"到";
    // lab1.backgroundColor=[UIColor yellowColor];
    lab1.font=[UIFont systemFontOfSize:12];
    [twoDayView addSubview:lab1];
    
    
    
    tf_et=[[UITextField alloc]init];
    tf_et.autocapitalizationType=UITextAutocapitalizationTypeNone;
    tf_et.text=_etTime;
    tf_et.font=[UIFont systemFontOfSize:12];
    tf_et.textColor=[UIColor colorWithRed:0.0/255 green:122.0/255 blue:255.0/255 alpha:1];
    
    tf_et.frame=CGRectMake(CGRectGetMaxX (lab1.frame)+1,10,125, 30);
    //tf_et.delegate=self;
    [twoDayView addSubview:tf_et];
    
    
    UIButton *  bt_st=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt_st.frame=CGRectMake(CGRectGetMaxX (tf_et.frame)+1,10,44, 30);
    bt_st.titleLabel .font =[UIFont systemFontOfSize:12];
    [bt_st setTitle:@"确定" forState:UIControlStateNormal];
    [bt_st setTintColor:[UIColor whiteColor]];
    [bt_st setBackgroundImage:[UIImage imageNamed:@"btn11.png"] forState:UIControlStateNormal];
    [bt_st addTarget:self action:@selector(selectData2) forControlEvents:UIControlEventTouchUpInside];
    [twoDayView addSubview:bt_st];
    
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY (bt_st.frame)+2, self.frame.size.width-10, 1)];
    view1.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [twoDayView addSubview:view1];
    
    dateView1 = [ZhiBanChooseDateView instanceChooseDateView];
    dateView1.chooseDateDelegate=self;
    dateView1.dateId=@"1";
    tf_st.inputView=dateView1;
    dateView2 = [ZhiBanChooseDateView instanceChooseDateView];
    dateView2.chooseDateDelegate=self;
    dateView2.dateId=@"2";
    tf_et.inputView=dateView2;
    
    seletBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [seletBtn setTitle:@"某一天" forState:UIControlStateNormal];
    seletBtn.titleLabel .font =[UIFont systemFontOfSize:12];
    [seletBtn setTintColor:[UIColor whiteColor]];
    //  [seletBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [seletBtn setBackgroundImage:[UIImage imageNamed:@"allSelcet.png"] forState:UIControlStateNormal];
    seletBtn.frame=CGRectMake(CGRectGetMaxX(bt_st.frame)+10,10,50,30);
    [seletBtn addTarget:self action:@selector(changView2) forControlEvents:UIControlEventTouchUpInside];
    [twoDayView addSubview:seletBtn];
    
}
-(void)addOneDayView
{
    oneDayView=[[UIView alloc]init];
    //  oneDayView.backgroundColor=[UIColor greenColor];
    oneDayView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [_navgationTabBar addSubview:oneDayView];
    
    UIButton *stbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[stbtn setTitle:@"前一天" forState:UIControlStateNormal];
    stbtn.tintColor=[UIColor clearColor];
    [stbtn setBackgroundColor:[UIColor lightGrayColor]];
    [stbtn setBackgroundImage:[UIImage imageNamed:@"zuo.png"] forState:UIControlStateNormal];
    stbtn.frame=CGRectMake(5, 5, 26,30);
    stbtn.tag=1000;
    [stbtn addTarget:self action:@selector(selectTime1:) forControlEvents:UIControlEventTouchUpInside];
    [oneDayView addSubview:stbtn];
    
    timeLable =[[UILabel alloc]init];
    timeLable.frame=CGRectMake(CGRectGetMaxX(stbtn.frame), 5,120,30);
    timeLable.text=_nowTime;
    timeLable.font=[UIFont systemFontOfSize:12];
    timeLable.textAlignment=NSTextAlignmentCenter;
    [oneDayView addSubview:timeLable];
    
    UIButton *etbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    etbtn.tintColor=[UIColor clearColor];
    [etbtn setTitle:@"后一天" forState:UIControlStateNormal];
    etbtn.tag=1001;
    [etbtn setBackgroundColor:[UIColor lightGrayColor]];
    [etbtn setBackgroundImage:[UIImage imageNamed:@"you.png"] forState:UIControlStateNormal];
    etbtn.frame=CGRectMake(CGRectGetMaxX(timeLable.frame), 5, 26,30);
    [etbtn addTarget:self action:@selector(selectTime1:) forControlEvents:UIControlEventTouchUpInside];
    [oneDayView addSubview:etbtn];
    
    
    UIButton *  bt_st=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt_st.frame=CGRectMake(CGRectGetMaxX (etbtn.frame)+2,5,44, 30);
    bt_st.titleLabel .font =[UIFont systemFontOfSize:12];
    [bt_st setTitle:@"确定" forState:UIControlStateNormal];
    [bt_st setTintColor:[UIColor whiteColor]];
    [bt_st setBackgroundImage:[UIImage imageNamed:@"btn11.png"] forState:UIControlStateNormal];
    [bt_st addTarget:self action:@selector(selectData1) forControlEvents:UIControlEventTouchUpInside];
    [oneDayView addSubview:bt_st];
    
    seletBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [seletBtn setTitle:@"时间段" forState:UIControlStateNormal];
    seletBtn.titleLabel .font =[UIFont systemFontOfSize:12];
    [seletBtn setTintColor:[UIColor whiteColor]];
    //  [seletBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [seletBtn setBackgroundImage:[UIImage imageNamed:@"allSelcet.png"] forState:UIControlStateNormal];
    seletBtn.frame=CGRectMake(CGRectGetMaxX(bt_st.frame)+10, 5,50,30);
    [seletBtn addTarget:self action:@selector(changView1) forControlEvents:UIControlEventTouchUpInside];
    [oneDayView addSubview:seletBtn];
    
    
}
-(void)selectTime1:(UIButton *)sender
{
    UIButton *but= (UIButton *) sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ 00:00",timeLable.text]];
    NSDate *lastDay;
    if (but.tag==1000) {//时区问题 +8
        lastDay = [NSDate dateWithTimeInterval:-24*60*60+8 sinceDate:date];
        
    }
    else
    {
        lastDay = [NSDate dateWithTimeInterval:+24*60*60+8 sinceDate:date];
    }
    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    [dateform setDateFormat:@"yyyy-MM-dd"];
    
    timeLable.text=[dateform stringFromDate:lastDay];
    
    
}
-(void)changView1
{
    if (oneDayView) {
        [oneDayView removeFromSuperview];
    }
    [self addTwoDayView];
    
    
}
-(void)changView2
{
    if (twoDayView) {
        [twoDayView removeFromSuperview];
    }
    [self addOneDayView];
    
    
    
}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid{
    
    if ([dateid isEqualToString:@"1"]) {
        
        tf_st.text=dateStr;
        [tf_st resignFirstResponder];
        
        
    }
    if ([dateid isEqualToString:@"2"]) {
        tf_et.text=dateStr;
        [tf_et resignFirstResponder];
    }
    
    
    
}
-(void)selectData1
{
    
    NSString *st=[NSString stringWithFormat:@"%@ 00:00",timeLable.text];
    NSString *et=[NSString stringWithFormat:@"%@ 23:59",timeLable.text];
    
    // if(tf_st.text.length!=0&&tf_et.text.length!=0)
    // {
    [self.delegate selectTime:st andEndTime:et nowTime:timeLable.text andState:@"1"];
    //  }
    //    else
    //    {
    //        [AlertHelper singleMBHUDShow:@"时间不能为空" ForView:self AndDelayHid:2];
    //    }
    
}
-(void)selectData2
{
    if(tf_st.text.length!=0&&tf_et.text.length!=0)
    {
        [self.delegate selectTime:tf_st.text andEndTime:tf_et.text nowTime:timeLable.text andState:@"2"];
    }
    else
    {
        [AlertHelper singleMBHUDShow:@"时间不能为空" ForView:self AndDelayHid:2];
    }
    
}
//- (void)addTapGestureRecognizer
//{
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
//    [_arrowButton addGestureRecognizer:tapGestureRecognizer];
//}

- (void)itemPressed:(UIButton *)button
{
    // button.selected=YES;
    NSInteger index = [_items indexOfObject:button];
    [_delegate itemDidSelectedWithIndex:index];
}

//- (void)functionButtonPressed
//{
//    _popItemMenu = !_popItemMenu;
//    [_delegate shouldPopNavgationItemMenu:_popItemMenu height:[self popMenuHeight]];
//}

- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    
    for (NSString *title in titles)
    {
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        NSNumber *width = [NSNumber numberWithFloat:size.width + 40.0f];
        [widths addObject:width];
    }
    
    return widths;
}

- (void)viewShowShadow:(UIView *)view shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    // view.layer.shadowRadius = shadowRadius;//阴影半径
    //  view.layer.shadowOpacity = shadowOpacity; //设置阴影的透明度(0~1之间，0表示完全透明)
}

//- (CGFloat)popMenuHeight
//{
//    CGFloat buttonX = DOT_COORDINATE;
//    CGFloat buttonY = ITEM_HEIGHT;
//    CGFloat maxHeight = SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - NAV_TAB_BAR_HEIGHT;
//    for (NSInteger index = 0; index < [_itemsWidth count]; index++)
//    {
//        buttonX += [_itemsWidth[index] floatValue];
//
//        @try {
//            if ((buttonX + [_itemsWidth[index + 1] floatValue]) >= SCREEN_WIDTH)
//            {
//                buttonX = DOT_COORDINATE;
//                buttonY += ITEM_HEIGHT;
//            }
//        }
//        @catch (NSException *exception) {
//
//        }
//        @finally {
//
//        }
//    }
//
//    buttonY = (buttonY > maxHeight) ? maxHeight : buttonY;
//    return buttonY;
//}
/*
 - (void)popItemMenu:(BOOL)pop
 {
 if (pop)
 {
 // [self viewShowShadow:_arrowButton shadowRadius:DOT_COORDINATE shadowOpacity:DOT_COORDINATE];
 [UIView animateWithDuration:0.5f animations:^{
 _navgationTabBar.hidden = YES;
 // _arrowButton.transform = CGAffineTransformMakeRotation(M_PI);
 } completion:^(BOOL finished) {
 [UIView animateWithDuration:0.2f animations:^{
 if (!_popView)
 {
 _popView = [[SCPopView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, self.frame.size.height - NAVIGATION_BAR_HEIGHT)];
 _popView.delegate = self;
 _popView.itemNames = _itemTitles;
 [self addSubview:_popView];
 }
 _popView.hidden = NO;
 }];
 }];
 }
 else
 {
 [UIView animateWithDuration:0.5f animations:^{
 _popView.hidden = !_popView.hidden;
 // _arrowButton.transform = CGAffineTransformIdentity;
 } completion:^(BOOL finished) {
 _navgationTabBar.hidden = !_navgationTabBar.hidden;
 // [self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
 }];
 }
 
 }
 */
#pragma mark -
#pragma mark - Public Methods
//- (void)setArrowImage:(UIImage *)arrowImage
//{
//    _arrowImage = arrowImage ? arrowImage : _arrowImage;
//   // _arrowButton.image = _arrowImage;
//}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    _currentItemIndex = currentItemIndex;
    
    //   CGFloat flag = _showArrowButton ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    CGFloat flag = SCREEN_WIDTH;
    for (UIButton *but in _items) {
        if (but.selected) {
            but.selected=NO;
        }
    }
    UIButton *button = _items[currentItemIndex];
    button.selected=YES;
    if (button.frame.origin.x + button.frame.size.width > flag)
    {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width - flag;
        if (_currentItemIndex < [_itemTitles count] - 1)
        {
            offsetX = offsetX + 40.0f;
        }
        
        [_navgationTabBar setContentOffset:CGPointMake(offsetX, DOT_COORDINATE) animated:YES];
    }
    else
    {
        [_navgationTabBar setContentOffset:CGPointMake(DOT_COORDINATE, DOT_COORDINATE) animated:YES];
    }
    
    //    [UIView animateWithDuration:0.2f animations:^{
    //        _line.frame = CGRectMake(button.frame.origin.x + 2.0f, _line.frame.origin.y, [_itemsWidth[currentItemIndex] floatValue] - 4.0f, _line.frame.size.height);
    //    }];
}

- (void)updateData
{
    // _arrowButton.backgroundColor = self.backgroundColor;
    //  NSLog(@"updateData!!! %@ %@ %@ %@ ",_nowTime ,_stTime ,_etTime ,_state);
    _itemsWidth = [self getButtonsWidthWithTitles:_itemTitles];
    if (_itemsWidth.count)
    {
        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navgationTabBar.contentSize = CGSizeMake(contentWidth, DOT_COORDINATE);
    }
    [self refresh];
}
- (void)refresh
{
    tf_st.text=_stTime;
    tf_et.text=_etTime;
    timeLable.text=_nowTime;
    if ([_state isEqualToString:@"1"]) {
        [self addOneDayView];
    }
    else
    {
        [self addTwoDayView];
    }

}
//- (void)refresh
//{
//    [self popItemMenu:_popItemMenu];
//}

#pragma mark - SCFunctionView Delegate Methods
#pragma mark -
- (void)itemPressedWithIndex:(NSInteger)index
{
    //  [self functionButtonPressed];
    [_delegate itemDidSelectedWithIndex:index];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
