//
//  ShenHeAboutViewController.h
//  Re-OA
//
//  Created by admin on 16/4/18.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShenHeDelegate.h"
#import "ShenHeChooseView1.h"
@interface ShenHeAboutViewController : UITableViewController<ShenHeSelectDelegate,shenHeDataDelegate>
@property (weak,nonatomic) id<ShenHeNotification> closingLittleNotification;


@end
