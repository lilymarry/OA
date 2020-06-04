
#import "JXCDoRuKuMXModel.h"

@implementation JXCDoRuKuMXModel



-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.danw  = [json objectForKey:@"danw"];
            self.num  = [json objectForKey:@"num"];
            self.kfid  = [json objectForKey:@"kfid"];
            self.kfmc  = [json objectForKey:@"kfmc"];
            self.dwid  = [json objectForKey:@"dwid"];
            self.dwnm  = [json objectForKey:@"dwnm"];
            self.kg  = [json objectForKey:@"kg"];
        }
    }
    return self;
}


@end
