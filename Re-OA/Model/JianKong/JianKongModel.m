//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "JianKongModel.h"

@implementation JianKongModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.tdlxnm  = [json objectForKey:@"tdlxnm"];
 self.ip  = [json objectForKey:@"ip"];
 self.dvrnm  = [json objectForKey:@"dvrnm"];
 self.dknw  = [json objectForKey:@"dknw"];
 self.dvrpwd  = [json objectForKey:@"dvrpwd"];
 self.dkzx  = [json objectForKey:@"dkzx"];
 self.td  = [json objectForKey:@"td"];
 self.tdnm  = [json objectForKey:@"tdnm"];
 self.gcid  = [json objectForKey:@"gcid"];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.tdlxnm forKey:@"zx_tdlxnm"];
[aCoder encodeObject:self.ip forKey:@"zx_ip"];
[aCoder encodeObject:self.dvrnm forKey:@"zx_dvrnm"];
[aCoder encodeObject:self.dknw forKey:@"zx_dknw"];
[aCoder encodeObject:self.dvrpwd forKey:@"zx_dvrpwd"];
[aCoder encodeObject:self.dkzx forKey:@"zx_dkzx"];
[aCoder encodeObject:self.td forKey:@"zx_td"];
[aCoder encodeObject:self.tdnm forKey:@"zx_tdnm"];
[aCoder encodeObject:self.gcid forKey:@"zx_gcid"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.tdlxnm = [aDecoder decodeObjectForKey:@"zx_tdlxnm"];
 self.ip = [aDecoder decodeObjectForKey:@"zx_ip"];
 self.dvrnm = [aDecoder decodeObjectForKey:@"zx_dvrnm"];
 self.dknw = [aDecoder decodeObjectForKey:@"zx_dknw"];
 self.dvrpwd = [aDecoder decodeObjectForKey:@"zx_dvrpwd"];
 self.dkzx = [aDecoder decodeObjectForKey:@"zx_dkzx"];
 self.td = [aDecoder decodeObjectForKey:@"zx_td"];
 self.tdnm = [aDecoder decodeObjectForKey:@"zx_tdnm"];
 self.gcid = [aDecoder decodeObjectForKey:@"zx_gcid"];
 
    }
    return self;
}



@end
