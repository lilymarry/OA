//
//  JiaGeHuiZongQuXianViewController.h
//  Re-OA
//
//  Created by admin on 15/5/5.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiageChaXun.h"
#import "CSChartsView.h"
@interface JiaGeHuiZongQuXianViewController : UIViewController
@property(nonatomic,strong) CSChartsView *chartsView;
@property(nonatomic,strong) IBOutlet UISegmentedControl *segmentControl;
@end
