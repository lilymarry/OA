//
//  NingHeShenGouModel.m
//  Re-OA
//
//  Created by imac-1 on 2017/5/16.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "NingHeShenGouModel.h"

@implementation NingHeShenGouModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    
    [aCoder encodeObject:self.dawei forKey:@"dawei"];
    [aCoder encodeObject:self.shuliang forKey:@"shuliang"];
    
    [aCoder encodeObject:self.beizhu forKey:@"beizhu"];
   
    
    
}

// 当一个对象从文件中读取的时候，系统会调用该方法，重写该方法
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.dawei=[aDecoder decodeObjectForKey:@"dawei"];
        self.shuliang=[aDecoder decodeObjectForKey:@"shuliang"];
        
        self.beizhu=[aDecoder decodeObjectForKey:@"beizhu"];
    }
    return self;
}
@end
