//
//  UserSatisfiyView.h
//  Re-OA
//
//  Created by imac-1 on 2017/1/11.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserSatisfiyDelegate <NSObject>
@optional
-(void)selectUserSatisfiyWithtype:(NSString *)type andText:(NSString *)text;
@end

@interface UserSatisfiyView : UIView
@property(weak,nonatomic)id<UserSatisfiyDelegate>delegate;

- (id)initWithFrame:(CGRect)frame;
@end
