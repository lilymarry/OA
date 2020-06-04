//
//  ZhiZhangModel.m
//  Re-OA
//
//  Created by admin on 15/6/10.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "ZhiZhangModel.h"

@implementation ZhiZhangModel
-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.tit = [json objectForKey:@"tit"];
            self.pbnm = [json objectForKey:@"pbnm"];
            self.yi = [json objectForKey:@"yi"];
            self.er = [json objectForKey:@"er"];
            self.san = [json objectForKey:@"san"];
            self.si = [json objectForKey:@"si"];
            self.wu = [json objectForKey:@"wu"];
            self.liu= [json objectForKey:@"liu"];
            self.qi = [json objectForKey:@"qi"];
            self.ref = [json objectForKey:@"refer"];//
            self.report = [json objectForKey:@"report"];
            self.workp= [json objectForKey:@"workp"];
            self.doPNm = [json objectForKey:@"doPNm"];
            self.fstate = [json objectForKey:@"fstate"];
            self.ct  = [json objectForKey:@"ctm"];
            self.fmTp = [json objectForKey:@"fmTp"];
            self.fnm = [json objectForKey:@"fnm"];
            self.khnm = [json objectForKey:@"khnm"];
            self.uid = [json objectForKey:@"u_id"];
            
            self.inrefer=[json objectForKey:@"inrefer"];//
            
            self.xiuqiu1 = [json objectForKey:@"xiuqiu1"];
            self.xiuqiu2 = [json objectForKey:@"xiuqiu2"];
            self.xiuqiu3  = [json objectForKey:@"xiuqiu3"];
            self.gouzhijianshu1 = [json objectForKey:@"gouzhijianshu1"];
            self.gouzhijianshu2 = [json objectForKey:@"gouzhijianshu2"];
            self.gouzhijianshu3 = [json objectForKey:@"gouzhijianshu3"];
            
            
            
            
            
            
        }
    }
    return self;
}
@end
