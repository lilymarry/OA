
#import "RenWuTaopListModel.h"

@implementation RenWuTaopListModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
     
       self.Taop_Iscomplete  = [json objectForKey:@"Taop_Iscomplete"];
 self.Taop_Id  = [json objectForKey:@"Taop_Id"];
 self.Taop_IsSee  = [json objectForKey:@"Taop_IsSee"];
 self.Taop_Comment  = [json objectForKey:@"Taop_Comment"];
 self.Taop_Userid  = [json objectForKey:@"Taop_Userid"];
 self.Taop_Date_1  = [json objectForKey:@"Taop_Date_1"];
 self.Taop_Description  = [json objectForKey:@"Taop_Description"];
 self.Taop_UserName  = [json objectForKey:@"Taop_UserName"];
 self.Taop_Img  = [json objectForKey:@"Taop_Img"];
 self.Taop_Taid  = [json objectForKey:@"Taop_Taid"];
 self.Taop_IsTimeout  = [json objectForKey:@"Taop_IsTimeout"];
 
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Taop_Iscomplete forKey:@"zx_Taop_Iscomplete"];
[aCoder encodeObject:self.Taop_Id forKey:@"zx_Taop_Id"];
[aCoder encodeObject:self.Taop_IsSee forKey:@"zx_Taop_IsSee"];
[aCoder encodeObject:self.Taop_Comment forKey:@"zx_Taop_Comment"];
[aCoder encodeObject:self.Taop_Userid forKey:@"zx_Taop_Userid"];
[aCoder encodeObject:self.Taop_Date_1 forKey:@"zx_Taop_Date_1"];
[aCoder encodeObject:self.Taop_Description forKey:@"zx_Taop_Description"];
[aCoder encodeObject:self.Taop_UserName forKey:@"zx_Taop_UserName"];
[aCoder encodeObject:self.Taop_Img forKey:@"zx_Taop_Img"];
[aCoder encodeObject:self.Taop_Taid forKey:@"zx_Taop_Taid"];
[aCoder encodeObject:self.Taop_IsTimeout forKey:@"zx_Taop_IsTimeout"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.Taop_Iscomplete = [aDecoder decodeObjectForKey:@"zx_Taop_Iscomplete"];
 self.Taop_Id = [aDecoder decodeObjectForKey:@"zx_Taop_Id"];
 self.Taop_IsSee = [aDecoder decodeObjectForKey:@"zx_Taop_IsSee"];
 self.Taop_Comment = [aDecoder decodeObjectForKey:@"zx_Taop_Comment"];
 self.Taop_Userid = [aDecoder decodeObjectForKey:@"zx_Taop_Userid"];
 self.Taop_Date_1 = [aDecoder decodeObjectForKey:@"zx_Taop_Date_1"];
 self.Taop_Description = [aDecoder decodeObjectForKey:@"zx_Taop_Description"];
 self.Taop_UserName = [aDecoder decodeObjectForKey:@"zx_Taop_UserName"];
 self.Taop_Img = [aDecoder decodeObjectForKey:@"zx_Taop_Img"];
 self.Taop_Taid = [aDecoder decodeObjectForKey:@"zx_Taop_Taid"];
 self.Taop_IsTimeout = [aDecoder decodeObjectForKey:@"zx_Taop_IsTimeout"];
 
    }
    return self;
}



@end
