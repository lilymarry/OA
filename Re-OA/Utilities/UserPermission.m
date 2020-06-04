
#import "UserPermission.h"



static UserPermission *user;
@implementation UserPermission



+ (UserPermission *)standartUserInfo
{
    if (!user)
    {
        user = [[UserPermission alloc] init];
        
    }
    return  user;
}
-(void)setInfoArr:(NSArray *)infoArr
{
    self.ID = [infoArr[0] objectForKey:@"u_Id"];
    self.name = [infoArr[0] objectForKey:@"UNm"];
    self.companyId=[infoArr[0] objectForKey:@"depId"];
    self.companyName=[infoArr[0] objectForKey:@"depNm"];
    self.time=[infoArr[0]objectForKey:@"idate"];
    self.MenuRole = [infoArr[0] objectForKey:@"MenuRole"];
    self.jNum = [infoArr[0] objectForKey:@"jNum"];
    self.x = [infoArr[0] objectForKey:@"x"];
    self.y = [infoArr[0] objectForKey:@"y"];
    self.time= [infoArr[0] objectForKey:@"idate"];
}

@end
