//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "BaoJingListModel.h"

@implementation BaoJingListModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.ssgc  = [json objectForKey:@"ssgc"];
 self.bjid  = [json objectForKey:@"bjid"];
 self.dk  = [json objectForKey:@"dk"];
 self.cltm  = [json objectForKey:@"cltm"];
 self.bjtm  = [json objectForKey:@"bjtm"];
 self.dvrpwd  = [json objectForKey:@"dvrpwd"];
 self.dvrnm  = [json objectForKey:@"dvrnm"];
 self.rnum  = [json objectForKey:@"rnum"];
 self.dq  = [json objectForKey:@"dq"];
 self.ygno  = [json objectForKey:@"ygno"];
 self.carno  = [json objectForKey:@"carno"];
 self.td  = [json objectForKey:@"td"];
 self.bz  = [json objectForKey:@"bz"];
 self.ip  = [json objectForKey:@"ip"];
 self.lxmc  = [json objectForKey:@"lxmc"];
        self.isChild= NO;
                self.isExpended= NO;
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ssgc forKey:@"zx_ssgc"];
[aCoder encodeObject:self.bjid forKey:@"zx_bjid"];
[aCoder encodeObject:self.dk forKey:@"zx_dk"];
[aCoder encodeObject:self.cltm forKey:@"zx_cltm"];
[aCoder encodeObject:self.bjtm forKey:@"zx_bjtm"];
[aCoder encodeObject:self.dvrpwd forKey:@"zx_dvrpwd"];
[aCoder encodeObject:self.dvrnm forKey:@"zx_dvrnm"];
[aCoder encodeObject:self.rnum forKey:@"zx_rnum"];
[aCoder encodeObject:self.dq forKey:@"zx_dq"];
[aCoder encodeObject:self.ygno forKey:@"zx_ygno"];
[aCoder encodeObject:self.carno forKey:@"zx_carno"];
[aCoder encodeObject:self.td forKey:@"zx_td"];
[aCoder encodeObject:self.bz forKey:@"zx_bz"];
[aCoder encodeObject:self.ip forKey:@"zx_ip"];
[aCoder encodeObject:self.lxmc forKey:@"zx_lxmc"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.ssgc = [aDecoder decodeObjectForKey:@"zx_ssgc"];
 self.bjid = [aDecoder decodeObjectForKey:@"zx_bjid"];
 self.dk = [aDecoder decodeObjectForKey:@"zx_dk"];
 self.cltm = [aDecoder decodeObjectForKey:@"zx_cltm"];
 self.bjtm = [aDecoder decodeObjectForKey:@"zx_bjtm"];
 self.dvrpwd = [aDecoder decodeObjectForKey:@"zx_dvrpwd"];
 self.dvrnm = [aDecoder decodeObjectForKey:@"zx_dvrnm"];
 self.rnum = [aDecoder decodeObjectForKey:@"zx_rnum"];
 self.dq = [aDecoder decodeObjectForKey:@"zx_dq"];
 self.ygno = [aDecoder decodeObjectForKey:@"zx_ygno"];
 self.carno = [aDecoder decodeObjectForKey:@"zx_carno"];
 self.td = [aDecoder decodeObjectForKey:@"zx_td"];
 self.bz = [aDecoder decodeObjectForKey:@"zx_bz"];
 self.ip = [aDecoder decodeObjectForKey:@"zx_ip"];
 self.lxmc = [aDecoder decodeObjectForKey:@"zx_lxmc"];
 
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone
{
    BaoJingListModel *copy = [[[self class] allocWithZone:zone] init];
    copy.ssgc  = [_ssgc copy];
    copy.bjid  = [_bjid copy];
    copy.dk  = [_dk copy];
    copy.cltm  =[_cltm copy];
    copy.bjtm  = [_bjtm copy];
    copy.dvrpwd  = [_dvrpwd copy];
    copy.dvrnm  = [_dvrnm copy];
    copy.rnum  = [_rnum copy];
    copy.dq  = [_dq copy];
    copy.ygno  = [_ygno copy];
    copy.carno  = [_carno copy];
    copy.td  = [_td copy];
    copy.bz  = [_bz copy];
    copy.ip  = [_ip copy];
    copy.lxmc  = [_lxmc copy];
    copy.isChild= NO;
    copy.isExpended=NO;
    return copy;
}



@end
