
#import "ShenHeListModel.h"

@implementation ShenHeListModel

-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.fstate  = [json objectForKey:@"fstate"];
            self.tit  = [json objectForKey:@"tit"];
            self.fpiId  = [json objectForKey:@"fpiId"];
            self.ctm  = [json objectForKey:@"ctm"];
            self.fpiAd  = [json objectForKey:@"fpiAd"];
            self.Nowfs  = [json objectForKey:@"Nowfs"];
            self.fnm  = [json objectForKey:@"fnm"];
            self.opPNm  = [json objectForKey:@"opPNm"];
            self.fpId  = [json objectForKey:@"fpId"];
            self.con  = [json objectForKey:@"con"];
            self.fo  = [json objectForKey:@"fo"];
            self.ftyp  = [json objectForKey:@"ftyp"];
            self.isSeleted=NO;
            self.fmTp  = [json objectForKey:@"fmTp"];
            self.cmTp  = [json objectForKey:@"cmTp"];
            
            self.toFs =[json objectForKey:@"toFs"];
            
            self.rNum=[json objectForKey:@"rNum"];
              self.x=[json objectForKey:@"x"];
              self.y=[json objectForKey:@"y"];
            
            self.okbak=[json objectForKey:@"okbak"];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fstate forKey:@"zx_fstate"];
    [aCoder encodeObject:self.tit forKey:@"zx_tit"];
    [aCoder encodeObject:self.fpiId forKey:@"zx_fpiId"];
    [aCoder encodeObject:self.ctm forKey:@"zx_ctm"];
    [aCoder encodeObject:self.fpiAd forKey:@"zx_fpiAd"];
    [aCoder encodeObject:self.Nowfs forKey:@"zx_Nowfs"];
    [aCoder encodeObject:self.fnm forKey:@"zx_fnm"];
    [aCoder encodeObject:self.opPNm forKey:@"zx_opPNm"];
    [aCoder encodeObject:self.fpId forKey:@"zx_fpId"];
    [aCoder encodeObject:self.con forKey:@"zx_con"];
    [aCoder encodeObject:self.fo forKey:@"zx_fo"];
     [aCoder encodeObject:self.okbak forKey:@"okbak"];
    [aCoder encodeObject:self.rNum forKey:@"zx_rnum"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.fstate = [aDecoder decodeObjectForKey:@"zx_fstate"];
        self.tit = [aDecoder decodeObjectForKey:@"zx_tit"];
        self.fpiId = [aDecoder decodeObjectForKey:@"zx_fpiId"];
        self.ctm = [aDecoder decodeObjectForKey:@"zx_ctm"];
        self.fpiAd = [aDecoder decodeObjectForKey:@"zx_fpiAd"];
        self.Nowfs = [aDecoder decodeObjectForKey:@"zx_Nowfs"];
        self.fnm = [aDecoder decodeObjectForKey:@"zx_fnm"];
        self.opPNm = [aDecoder decodeObjectForKey:@"zx_opPNm"];
        self.fpId = [aDecoder decodeObjectForKey:@"zx_fpId"];
        self.con = [aDecoder decodeObjectForKey:@"zx_con"];
        self.fo = [aDecoder decodeObjectForKey:@"zx_fo"];
        
        self.rNum=[aDecoder decodeObjectForKey:@"zx_rnum"];
        
        self.okbak=[aDecoder decodeObjectForKey:@"okbak"];
        
    }
    return self;
}



@end
