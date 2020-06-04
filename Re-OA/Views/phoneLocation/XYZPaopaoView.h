//
//  XYZPaopaoView.h
//  xilaikd
//
//  Created by 智发 on 14-7-17.
//  Copyright (c) 2014年 com. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PaopaoViewBtnDelegate<NSObject>

-(void)btnWithCourieName:(NSString *)empName;

@end
@interface XYZPaopaoView : UIView
@property (nonatomic, assign)id<PaopaoViewBtnDelegate>delegate;

@property(nonatomic , strong)UILabel *empName;
@property(nonatomic , strong)UILabel *empAddress;
@property(nonatomic , strong)UILabel *time;
@property(nonatomic , strong)UILabel *km;
@property(nonatomic , strong)UILabel *num;
@property(nonatomic ,strong)NSString * telState;
@property(nonatomic,  strong)UIButton *paopaoImage;

@end
