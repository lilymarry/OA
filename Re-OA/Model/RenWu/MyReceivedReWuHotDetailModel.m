//
//  MyReceivedReWuHotDetailModel.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/4.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "MyReceivedReWuHotDetailModel.h"

@implementation MyReceivedReWuHotDetailModel
-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.Ta_Address  = [json objectForKey:@"Ta_Address"];
            self.Ta_Area  = [json objectForKey:@"Ta_Area"];
            self.Ta_Number  = [json objectForKey:@"Ta_Number"];
            self.Ta_Phone  = [json objectForKey:@"Ta_Phone"];
            self.Ta_Source  = [json objectForKey:@"Ta_Source"];
            
            self.Ta_TimeLimit  = [json objectForKey:@"Ta_TimeLimit"];
            self.Ta_Type  = [json objectForKey:@"Ta_Type"];
            
             self.iscomplete  = [json objectForKey:@"iscomplete"];
              self.tadescription  = [json objectForKey:@"tadescription"];
               self.taimg  = [json objectForKey:@"taimg"];
               self.talssueddate  = [json objectForKey:@"talssueddate"];
            
            self.tastopdate  = [json objectForKey:@"tastopdate"];
            self.tauserid  = [json objectForKey:@"tauserid"];
            self.username  = [json objectForKey:@"username"];
            self.Ta_endTime=[json objectForKey:@"tastopdate"];

            
            self.Ta_IsEvaluate  = [json objectForKey:@"Ta_IsEvaluate"];
            self.Ta_Satisfied  = [json objectForKey:@"Ta_Satisfied"];
            self.Ta_SatisfiedDes=[json objectForKey:@"Ta_SatisfiedDes"];
  
        }
    }
    return self;
}

//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.taname forKey:@"zx_taname"];
//    [aCoder encodeObject:self.tadescription forKey:@"zx_tadescription"];
//    [aCoder encodeObject:self.iscomplete forKey:@"zx_iscomplete"];
//    [aCoder encodeObject:self.username forKey:@"zx_username"];
//    [aCoder encodeObject:self.tauserid forKey:@"zx_tauserid"];
//    [aCoder encodeObject:self.tastopdate forKey:@"zx_tastopdate"];
//    [aCoder encodeObject:self.taimg forKey:@"zx_taimg"];
//    [aCoder encodeObject:self.talssueddate forKey:@"zx_talssueddate"];
//    
//}
//
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    if(self)
//    {
//        self.taname = [aDecoder decodeObjectForKey:@"zx_taname"];
//        self.tadescription = [aDecoder decodeObjectForKey:@"zx_tadescription"];
//        self.iscomplete = [aDecoder decodeObjectForKey:@"zx_iscomplete"];
//        self.username = [aDecoder decodeObjectForKey:@"zx_username"];
//        self.tauserid = [aDecoder decodeObjectForKey:@"zx_tauserid"];
//        self.tastopdate = [aDecoder decodeObjectForKey:@"zx_tastopdate"];
//        self.taimg = [aDecoder decodeObjectForKey:@"zx_taimg"];
//        self.talssueddate = [aDecoder decodeObjectForKey:@"zx_talssueddate"];
//        
//    }
//    return self;
//}

@end
