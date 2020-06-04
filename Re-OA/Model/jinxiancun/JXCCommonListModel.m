
#import "JXCCommonListModel.h"

@implementation JXCCommonListModel


-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
    if(json != nil)
    {
       self.tm  = [json objectForKey:@"tm"];
 self.wznm  = [json objectForKey:@"wznm"];
 self.bdno  = [json objectForKey:@"bdno"];
 self.carno  = [json objectForKey:@"carno"];
 self.fqbs  = [json objectForKey:@"fqbs"];
 self.bdid  = [json objectForKey:@"bdid"];
         self.lvnm  = [json objectForKey:@"lvnm"];
        
        for (NSString *key in json.allKeys) {
            if ([@"shouhdw" isEqualToString:key]) {
                self.shouhdw=[json objectForKey:@"shouhdw"];
            }
            if ([@"songhdw" isEqualToString:key]) {
                self.songhdw=[json objectForKey:@"songhdw"];
            }

        }
        
    }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.tm forKey:@"zx_tm"];
[aCoder encodeObject:self.wznm forKey:@"zx_wznm"];
[aCoder encodeObject:self.bdno forKey:@"zx_bdno"];
[aCoder encodeObject:self.carno forKey:@"zx_carno"];
[aCoder encodeObject:self.fqbs forKey:@"zx_fqbs"];
[aCoder encodeObject:self.bdid forKey:@"zx_bdid"];

}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.tm = [aDecoder decodeObjectForKey:@"zx_tm"];
 self.wznm = [aDecoder decodeObjectForKey:@"zx_wznm"];
 self.bdno = [aDecoder decodeObjectForKey:@"zx_bdno"];
 self.carno = [aDecoder decodeObjectForKey:@"zx_carno"];
 self.fqbs = [aDecoder decodeObjectForKey:@"zx_fqbs"];
 self.bdid = [aDecoder decodeObjectForKey:@"zx_bdid"];
 
    }
    return self;
}



@end
