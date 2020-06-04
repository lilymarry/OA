
#import "RenWuUsersModel.h"

@implementation RenWuUsersModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.uid  = [json objectForKey:@"id"];
            self.name  = [json objectForKey:@"name"];
            self.isChoosed=NO;
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.uid forKey:@"zx_id"];
    [aCoder encodeObject:self.name forKey:@"zx_name"];
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.uid = [aDecoder decodeObjectForKey:@"zx_id"];
        self.name = [aDecoder decodeObjectForKey:@"zx_name"];
        
    }
    return self;
}



@end
