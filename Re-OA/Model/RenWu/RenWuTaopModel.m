
#import "RenWuTaopModel.h"

@implementation RenWuTaopModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.taopname  = [json objectForKey:@"taopname"];
 self.taopid  = [json objectForKey:@"taopid"];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.taopname forKey:@"zx_taopname"];
[aCoder encodeObject:self.taopid forKey:@"zx_taopid"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.taopname = [aDecoder decodeObjectForKey:@"zx_taopname"];
 self.taopid = [aDecoder decodeObjectForKey:@"zx_taopid"];
 
    }
    return self;
}



@end
