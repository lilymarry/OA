//
//  KcDetailListModel.m
//  Re-OA
//
//  Created by admin on 15/4/8.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "KcDetailListModel.h"

@implementation KcDetailListModel
-(id)initWithDic:(NSDictionary *)dic;
{
    self = [super init];
    if(self)
    {
        if(dic != nil)
        {
            self.wuZiname  = [dic objectForKey:@"hwzlnm"];
            self.num = [dic objectForKey:@"jianshuhe"];
            self.weight = [dic objectForKey:@"kghe"];
            self.leixing=[dic objectForKey:@"hwlx"];
            self.dengji=[dic objectForKey:@"hwlv"];
           
        }
    }
    return self;
}

@end
