
#import "MyReceivedReWuDetailModel.h"

@implementation MyReceivedReWuDetailModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.taname  = [json objectForKey:@"taname"];
            self.tadescription  = [json objectForKey:@"tadescription"];
            self.iscomplete  = [json objectForKey:@"iscomplete"];
            self.username  = [json objectForKey:@"username"];
            self.tauserid  = [json objectForKey:@"tauserid"];
            self.tastopdate  = [json objectForKey:@"tastopdate"];
            self.taimg  = [json objectForKey:@"taimg"];
            self.talssueddate  = [json objectForKey:@"talssueddate"];
            
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.taname forKey:@"zx_taname"];
    [aCoder encodeObject:self.tadescription forKey:@"zx_tadescription"];
    [aCoder encodeObject:self.iscomplete forKey:@"zx_iscomplete"];
    [aCoder encodeObject:self.username forKey:@"zx_username"];
    [aCoder encodeObject:self.tauserid forKey:@"zx_tauserid"];
    [aCoder encodeObject:self.tastopdate forKey:@"zx_tastopdate"];
    [aCoder encodeObject:self.taimg forKey:@"zx_taimg"];
    [aCoder encodeObject:self.talssueddate forKey:@"zx_talssueddate"];
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.taname = [aDecoder decodeObjectForKey:@"zx_taname"];
        self.tadescription = [aDecoder decodeObjectForKey:@"zx_tadescription"];
        self.iscomplete = [aDecoder decodeObjectForKey:@"zx_iscomplete"];
        self.username = [aDecoder decodeObjectForKey:@"zx_username"];
        self.tauserid = [aDecoder decodeObjectForKey:@"zx_tauserid"];
        self.tastopdate = [aDecoder decodeObjectForKey:@"zx_tastopdate"];
        self.taimg = [aDecoder decodeObjectForKey:@"zx_taimg"];
        self.talssueddate = [aDecoder decodeObjectForKey:@"zx_talssueddate"];
        
    }
    return self;
}



@end
