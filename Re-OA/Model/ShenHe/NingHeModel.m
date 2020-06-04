//
//  NingHeModel.m
//  Re-OA
//
//  Created by admin on 16/4/12.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "NingHeModel.h"

@implementation NingHeModel
-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
         
            self.ctm = [json objectForKey:@"ctm"];
            self.doPNm = [json objectForKey:@"doPNm"];
            self.err = [json objectForKey:@"err"];
            self.fmTp = [json objectForKey:@"fmTp"];
            self.fnm = [json objectForKey:@"fnm"];
            self.fonm = [json objectForKey:@"fonm"];
            self.fstate = [json objectForKey:@"fstate"];
            self.nowfs = [json objectForKey:@"nowfs"];
            self.odcode = [json objectForKey:@"odcode"];
            self.odnum = [json objectForKey:@"odnum"];
            self.opinion= [json objectForKey:@"opinion"];
            self.pm = [json objectForKey:@"pm"];
            self.reason = [json objectForKey:@"reason"];
            self.size = [json objectForKey:@"size"];
            self.khnm = [json objectForKey:@"khnm"];
            self.tit = [json objectForKey:@"tit"];
            self.u_id = [json objectForKey:@"u_id"];
            self.pic=[json objectForKey:@"pic"];
            
           
        }
    }
    return self;
}
@end
