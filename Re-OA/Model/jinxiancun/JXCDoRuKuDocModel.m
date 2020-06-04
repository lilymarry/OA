//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "JXCDoRuKuDocModel.h"

@implementation JXCDoRuKuDocModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.lvnm  = [json objectForKey:@"lvnm"];
 self.wznm  = [json objectForKey:@"wznm"];
 self.bdno  = [json objectForKey:@"bdno"];
 self.carno  = [json objectForKey:@"carno"];
 self.ghcmp  = [json objectForKey:@"ghcmp"];
 self.bdid  = [json objectForKey:@"bdid"];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.lvnm forKey:@"zx_lvnm"];
[aCoder encodeObject:self.wznm forKey:@"zx_wznm"];
[aCoder encodeObject:self.bdno forKey:@"zx_bdno"];
[aCoder encodeObject:self.carno forKey:@"zx_carno"];
[aCoder encodeObject:self.ghcmp forKey:@"zx_ghcmp"];
[aCoder encodeObject:self.bdid forKey:@"zx_bdid"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.lvnm = [aDecoder decodeObjectForKey:@"zx_lvnm"];
 self.wznm = [aDecoder decodeObjectForKey:@"zx_wznm"];
 self.bdno = [aDecoder decodeObjectForKey:@"zx_bdno"];
 self.carno = [aDecoder decodeObjectForKey:@"zx_carno"];
 self.ghcmp = [aDecoder decodeObjectForKey:@"zx_ghcmp"];
 self.bdid = [aDecoder decodeObjectForKey:@"zx_bdid"];
 
    }
    return self;
}



@end
