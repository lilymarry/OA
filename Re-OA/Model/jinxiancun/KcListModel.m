//
//  KcListModel.m
//  Re-OA
//
//  Created by admin on 15/4/8.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "KcListModel.h"

@implementation KcListModel
-(id)initWithDic:(NSDictionary *)dic;
{
    self = [super init];
    if(self)
    {
        if(dic != nil)
        {
            self.dwid  = [dic objectForKey:@"dwid"];
            self.dwnm = [dic objectForKey:@"dwnm"];
            self.kfnm = [dic objectForKey:@"kfnm"];
            self.jianshu=[dic objectForKey:@"jianshu"];
            self.kg=[dic objectForKey:@"kg"];
            self.kfid=[dic objectForKey:@"kfid"];
            self.gcid=[dic objectForKey:@"gcid"];
        }
    }
    return self;
}

@end
