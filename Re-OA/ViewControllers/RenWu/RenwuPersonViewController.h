//
//  RenwuPersonViewController.h
//  Re-OA
//
//  Created by admin on 15/9/23.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^finishBlock)(NSArray *names,NSArray *uids);
@interface RenwuPersonViewController : UITableViewController
@property(nonatomic,copy) finishBlock block;
-(id)initWithBlock:(finishBlock)ablock;
@property(nonatomic,strong) NSString * isinGongGao;
@end
