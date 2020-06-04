//
//  NingHePaperModel.m
//  Re-OA
//
//  Created by admin on 16/4/22.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "NingHePaperModel.h"

@implementation NingHePaperModel
-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.batcha = [json objectForKey:@"batcha"];
            self.ctm = [json objectForKey:@"ctm"];
            self.doPNm = [json objectForKey:@"doPNm"];
      
            self.fmTp = [json objectForKey:@"fmTp"];
            self.fnm = [json objectForKey:@"fnm"];
            self.fonm = [json objectForKey:@"fonm"];
            self.fstate = [json objectForKey:@"fstate"];
             self.khnm = [json objectForKey:@"khnm"];
            
            self.montha=[json objectForKey:@"montha"];
            self.nowfs = [json objectForKey:@"nowfs"];
            self.odnum = [json objectForKey:@"odnum"];
            self.pm = [json objectForKey:@"pm"];
            self.remark = [json objectForKey:@"remark"];
            self.size = [json objectForKey:@"size"];
           
            self.txtTGZZ = [json objectForKey:@"txtTGZZ"];
            self.txtZF = [json objectForKey:@"txtZF"];
            
            self.txtZBGG = [json objectForKey:@"txtZBGG"];
            self.txtXQCCL = [json objectForKey:@"txtXQCCL"];
            self.txtXWDHRQ = [json objectForKey:@"txtXWDHRQ"];
            self.txtDPYL = [json objectForKey:@"txtDPYL"];
            self.txtYYL = [json objectForKey:@"txtYYL"];
            
            self.txtSYKH=[json objectForKey:@"txtSYKH"];
            self.txtKHJSFS = [json objectForKey:@"txtKHJSFS"];
            self.txtBZ = [json objectForKey:@"txtBZ"];
            
          //  self.pic=[json objectForKey:@"pic"];
           
            
            
            
            
            
            
        }
    }
    return self;
}
@end
