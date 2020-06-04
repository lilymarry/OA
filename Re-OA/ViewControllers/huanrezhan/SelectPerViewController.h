//
//  SelectPerViewController.h
//  Re-OA
//
//  Created by imac-1 on 2016/12/29.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^finishBlock)(NSArray *names,NSArray *uids);
@interface SelectPerViewController : UITableViewController<UITextFieldDelegate>
@property(nonatomic,copy) finishBlock block;
-(id)initWithBlock:(finishBlock)ablock;
@end
