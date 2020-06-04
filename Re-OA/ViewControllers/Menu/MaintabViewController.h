//
//  MaintabViewController.h
//  Re-OA
//
//  Created by admin on 15/9/17.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationTracker.h"
@interface MaintabViewController : UITabBarController

@property LocationTracker * locationTracker;
@property (nonatomic) NSTimer* locationUpdateTimer;
@end
