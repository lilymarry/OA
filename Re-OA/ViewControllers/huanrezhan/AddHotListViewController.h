//
//  AddHotListViewController.h
//  Re-OA
//
//  Created by imac-1 on 2016/12/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangHotModel.h"
#import "CommonDelegate.h"
@interface AddHotListViewController : UIViewController
@property(nonatomic,strong)NSString *state;//新增记录 1 详情0
@property(nonatomic,strong)ChangHotModel *_mode;
@property (weak,nonatomic) id<CommonNotification> refreshNotification;
@end
