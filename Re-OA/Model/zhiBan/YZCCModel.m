//
//  YZCCModel.m
//  Re-OA
//
//  Created by imac-1 on 2017/4/10.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "YZCCModel.h"

@implementation YZCCModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forUndefinedKey:key];
    //    if (StringEqual(key, @"id")) {
    //        self.topID = value;
    //    }
}
@end
