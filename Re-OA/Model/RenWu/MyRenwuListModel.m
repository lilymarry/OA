
#import "MyRenwuListModel.h"

@implementation MyRenwuListModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.Ta_Lssueddate  = [json objectForKey:@"Ta_Lssueddate"];
            self.Ta_Iscomplete  = [json objectForKey:@"Ta_Iscomplete"];
            self.Ta_Id  = [json objectForKey:@"Ta_Id"];
            self.Ta_Username  = [json objectForKey:@"Ta_Username"];
            self.Ta_Name  = [json objectForKey:@"Ta_Name"];
            self.Ta_Description  = [json objectForKey:@"Ta_Description"];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Ta_Lssueddate forKey:@"zx_Ta_Lssueddate"];
    [aCoder encodeObject:self.Ta_Iscomplete forKey:@"zx_Ta_Iscomplete"];
    [aCoder encodeObject:self.Ta_Id forKey:@"zx_Ta_Id"];
    [aCoder encodeObject:self.Ta_Username forKey:@"zx_Ta_Username"];
    [aCoder encodeObject:self.Ta_Name forKey:@"zx_Ta_Name"];
    [aCoder encodeObject:self.Ta_Description forKey:@"zx_Ta_Description"];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.Ta_Lssueddate = [aDecoder decodeObjectForKey:@"zx_Ta_Lssueddate"];
        self.Ta_Iscomplete = [aDecoder decodeObjectForKey:@"zx_Ta_Iscomplete"];
        self.Ta_Id = [aDecoder decodeObjectForKey:@"zx_Ta_Id"];
        self.Ta_Username = [aDecoder decodeObjectForKey:@"zx_Ta_Username"];
        self.Ta_Name = [aDecoder decodeObjectForKey:@"zx_Ta_Name"];
        self.Ta_Description  = [ aDecoder decodeObjectForKey:@"zx_Ta_Description"];
        
    }
    return self;
}



@end
