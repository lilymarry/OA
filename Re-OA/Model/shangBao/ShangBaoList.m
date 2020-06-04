//
//  ShangBaoList.m
//  Re-OA
//
//  Created by admin on 15/1/27.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "ShangBaoList.h"


static ShangBaoList *user;
@implementation ShangBaoList



+ (ShangBaoList *)standartUserInfo
{
    if (!user)
    {
        user = [[ShangBaoList alloc] init];
        
    }
    return  user;
}
-(void)setinfoDic:(NSDictionary *)infoArr
{
    self.fmtp = [infoArr objectForKey:@"fmtp"];
    self.fnm = [infoArr objectForKey:@"fnm"];
    self.fpId=[infoArr objectForKey:@"fpId"];
    
    
    
    
    
    
}
@end
