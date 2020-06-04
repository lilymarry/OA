
#import "BaoXiaoModel.h"

@implementation BaoXiaoModel

-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
    
            self.ctm  = [json objectForKey:@"ctm"];
            self.doPNm = [json objectForKey:@"doPNm"];
            self.dep = [json objectForKey:@"dep"];
            self.fmTp = [json objectForKey:@"fmTp"];
            self.fnm = [json objectForKey:@"fnm"];
            self.fonm = [json objectForKey:@"fonm"];
            self.fstate = [json objectForKey:@"fstate"];
            self.met = [json objectForKey:@"met"];
            self.nowfs = [json objectForKey:@"nowfs"];
            self.num = [json objectForKey:@"num"];
            self.pers = [json objectForKey:@"pers"];
            self.tit = [json objectForKey:@"tit"];
            self.u_id = [json objectForKey:@"u_id"];
            self.det = [json objectForKey:@"det"];

        }
    }
    return self;
}

@end
