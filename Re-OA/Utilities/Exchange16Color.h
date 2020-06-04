//
//  Exchange16Color.h
//  16进制 颜色转化
//
//  Created by admin on 15/5/29.
//  Copyright (c) 2015年 xiexukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Exchange16Color : NSObject
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end
