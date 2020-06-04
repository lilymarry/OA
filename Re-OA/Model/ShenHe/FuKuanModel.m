
#import "FuKuanModel.h"

@implementation FuKuanModel

-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            
            self.ctm  = [json objectForKey:@"ctm"];
            self.doPNm = [json objectForKey:@"doPNm"];
            self.extr = [json objectForKey:@"extr"];
            self.fmTp = [json objectForKey:@"fmTp"];
            self.fnm = [json objectForKey:@"fnm"];
            self.fonm = [json objectForKey:@"fonm"];
            self.fstate = [json objectForKey:@"fstate"];
            self.met = [json objectForKey:@"met"];
            self.nowfs = [json objectForKey:@"nowfs"];
            self.num = [json objectForKey:@"num"];
            self.cont = [json objectForKey:@"cont"];
            self.tit = [json objectForKey:@"tit"];
            self.u_id = [json objectForKey:@"u_id"];
            self.proj = [json objectForKey:@"proj"];
            self.prop = [json objectForKey:@"prop"];
        }
    }
    return self;
}

@end
