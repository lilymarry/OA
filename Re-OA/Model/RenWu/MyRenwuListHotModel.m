//
//  MyRenwuListHotModel.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/4.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "MyRenwuListHotModel.h"

@implementation MyRenwuListHotModel
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
            self.Ta_Area  = [json objectForKey:@"Ta_Area"];
            self.Ta_Description  = [json objectForKey:@"Ta_Description"];
            self.Taop_Iscomplete =[json objectForKey:@"Taop_Iscomplete"];
            self.Ta_Number  = [json objectForKey:@"Ta_Number"];
            
            self.Taop_ISRelease  = [json objectForKey:@"Taop_ISRelease"];
            self.Taop_ISFAudit  = [json objectForKey:@"Taop_ISFAudit"];
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
    [aCoder encodeObject:self.Ta_Area forKey:@"Ta_Area"];
    [aCoder encodeObject:self.Ta_Description forKey:@"zx_Ta_Description"];
    [aCoder encodeObject:self.Ta_Number forKey:@"Ta_Number"];
    
    [aCoder encodeObject:self.Taop_ISRelease forKey:@"Taop_ISRelease"];
    [aCoder encodeObject:self.Taop_ISFAudit forKey:@"Taop_ISFAudit"];

    
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
        self.Ta_Area = [aDecoder decodeObjectForKey:@"Ta_Area"];
        self.Ta_Description  = [ aDecoder decodeObjectForKey:@"zx_Ta_Description"];
        
        self.Ta_Number  = [aDecoder decodeObjectForKey:@"Ta_Number"];
        
        self.Taop_ISRelease  = [ aDecoder decodeObjectForKey:@"Taop_ISRelease"];
        
        self.Taop_ISFAudit  = [aDecoder decodeObjectForKey:@"Taop_ISFAudit"];

        
    }
    return self;
}


@end
