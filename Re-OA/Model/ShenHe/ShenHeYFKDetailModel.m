
#import "ShenHeYFKDetailModel.h"

@implementation ShenHeYFKDetailModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.met  = [json objectForKey:@"met"];
            self.fstate  = [json objectForKey:@"fstate"];
            self.nowfs  = [json objectForKey:@"nowfs"];
            self.ctm  = [json objectForKey:@"ctm"];
            self.tit  = [json objectForKey:@"tit"];
            self.proj  = [json objectForKey:@"proj"];
            self.cont  = [json objectForKey:@"cont"];
            self.doPNm  = [json objectForKey:@"doPNm"];
            self.extr  = [json objectForKey:@"extr"];
            self.fnm  = [json objectForKey:@"fnm"];
            self.fmTp  = [json objectForKey:@"fmTp"];
            self.prop  = [json objectForKey:@"prop"];
            self.num  = [json objectForKey:@"num"];
            self.u_id  = [json objectForKey:@"u_id"];
            self.fonm  = [json objectForKey:@"fonm"];
            
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.met forKey:@"zx_met"];
    [aCoder encodeObject:self.fstate forKey:@"zx_fstate"];
    [aCoder encodeObject:self.nowfs forKey:@"zx_nowfs"];
    [aCoder encodeObject:self.ctm forKey:@"zx_ctm"];
    [aCoder encodeObject:self.tit forKey:@"zx_tit"];
    [aCoder encodeObject:self.proj forKey:@"zx_proj"];
    [aCoder encodeObject:self.cont forKey:@"zx_cont"];
    [aCoder encodeObject:self.doPNm forKey:@"zx_doPNm"];
    [aCoder encodeObject:self.extr forKey:@"zx_extr"];
    [aCoder encodeObject:self.fnm forKey:@"zx_fnm"];
    [aCoder encodeObject:self.fmTp forKey:@"zx_fmTp"];
    [aCoder encodeObject:self.prop forKey:@"zx_prop"];
    [aCoder encodeObject:self.num forKey:@"zx_num"];
    [aCoder encodeObject:self.u_id forKey:@"zx_u_id"];
    [aCoder encodeObject:self.fonm forKey:@"zx_fonm"];
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.met = [aDecoder decodeObjectForKey:@"zx_met"];
        self.fstate = [aDecoder decodeObjectForKey:@"zx_fstate"];
        self.nowfs = [aDecoder decodeObjectForKey:@"zx_nowfs"];
        self.ctm = [aDecoder decodeObjectForKey:@"zx_ctm"];
        self.tit = [aDecoder decodeObjectForKey:@"zx_tit"];
        self.proj = [aDecoder decodeObjectForKey:@"zx_proj"];
        self.cont = [aDecoder decodeObjectForKey:@"zx_cont"];
        self.doPNm = [aDecoder decodeObjectForKey:@"zx_doPNm"];
        self.extr = [aDecoder decodeObjectForKey:@"zx_extr"];
        self.fnm = [aDecoder decodeObjectForKey:@"zx_fnm"];
        self.fmTp = [aDecoder decodeObjectForKey:@"zx_fmTp"];
        self.prop = [aDecoder decodeObjectForKey:@"zx_prop"];
        self.num = [aDecoder decodeObjectForKey:@"zx_num"];
        self.u_id = [aDecoder decodeObjectForKey:@"zx_u_id"];
        self.fonm = [aDecoder decodeObjectForKey:@"zx_fonm"];
        
    }
    return self;
}



@end
