//
//  BdListModel.m
//  Re-OA
//
//  Created by admin on 15/3/31.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "BdListModel.h"

@implementation BdListModel
-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.bdid  = [json objectForKey:@"bdid"];
            self.bdno = [json objectForKey:@"bdno"];
            self.carno = [json objectForKey:@"carno"];
            self.wuzi=[json objectForKey:@"wznm"];
            self.time=[json objectForKey:@"tm"];
            self.BangDanState=[json objectForKey:@"fqbs"];
            self.dengji=[json objectForKey:@"lvnm"];
        }
    }
    return self;
}
@end
