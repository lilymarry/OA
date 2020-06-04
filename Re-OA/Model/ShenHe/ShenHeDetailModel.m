#import "ShenHeDetailModel.h"

@implementation ShenHeDetailModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.fstate  = [json objectForKey:@"fstate"];
            self.tit  = [json objectForKey:@"tit"];
            self.ctm  = [json objectForKey:@"ctm"];
            self.pric  = [json objectForKey:@"pric"];
            self.doPNm  = [json objectForKey:@"doPNm"];
            self.pic  = [json objectForKey:@"pic"];
            self.fnm  = [json objectForKey:@"fnm"];
            self.fmTp  = [json objectForKey:@"fmTp"];
            self.con  = [json objectForKey:@"con"];
            self.voi  = [json objectForKey:@"voi"];
            self.u_id  = [json objectForKey:@"u_id"];
            self.fonm  = [json objectForKey:@"fonm"];
            self.nowfs  = [json objectForKey:@"nowfs"];
            
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fstate forKey:@"zx_fstate"];
    [aCoder encodeObject:self.tit forKey:@"zx_tit"];
    [aCoder encodeObject:self.ctm forKey:@"zx_ctm"];
    [aCoder encodeObject:self.pric forKey:@"zx_pric"];
    [aCoder encodeObject:self.doPNm forKey:@"zx_doPNm"];
    [aCoder encodeObject:self.pic forKey:@"zx_pic"];
    [aCoder encodeObject:self.fnm forKey:@"zx_fnm"];
    [aCoder encodeObject:self.fmTp forKey:@"zx_fmTp"];
    [aCoder encodeObject:self.con forKey:@"zx_con"];
    [aCoder encodeObject:self.voi forKey:@"zx_voi"];
    [aCoder encodeObject:self.u_id forKey:@"zx_u_id"];
    [aCoder encodeObject:self.fonm forKey:@"zx_fonm"];
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.fstate = [aDecoder decodeObjectForKey:@"zx_fstate"];
        self.tit = [aDecoder decodeObjectForKey:@"zx_tit"];
        self.ctm = [aDecoder decodeObjectForKey:@"zx_ctm"];
        self.pric = [aDecoder decodeObjectForKey:@"zx_pric"];
        self.doPNm = [aDecoder decodeObjectForKey:@"zx_doPNm"];
        self.pic = [aDecoder decodeObjectForKey:@"zx_pic"];
        self.fnm = [aDecoder decodeObjectForKey:@"zx_fnm"];
        self.fmTp = [aDecoder decodeObjectForKey:@"zx_fmTp"];
        self.con = [aDecoder decodeObjectForKey:@"zx_con"];
        self.voi = [aDecoder decodeObjectForKey:@"zx_voi"];
        self.u_id = [aDecoder decodeObjectForKey:@"zx_u_id"];
        self.fonm = [aDecoder decodeObjectForKey:@"zx_fonm"];
        
    }
    return self;
}



@end
