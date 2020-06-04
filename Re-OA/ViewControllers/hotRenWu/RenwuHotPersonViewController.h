//
//  RenwuHotPersonViewController.h
//  Re-OA
//
//  Created by imac-1 on 2016/11/22.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^finishBlock)(NSArray *names,NSArray *uids);
@interface RenwuHotPersonViewController : UITableViewController
@property(nonatomic,copy) finishBlock block;
-(id)initWithBlock:(finishBlock)ablock;
@end
