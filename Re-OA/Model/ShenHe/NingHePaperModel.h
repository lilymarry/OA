//
//  NingHePaperModel.h
//  Re-OA
//
//  Created by admin on 16/4/22.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NingHePaperModel : NSObject
@property (nonatomic,strong) NSString *batcha ;
@property (nonatomic,strong) NSString *ctm;
@property (nonatomic,strong) NSString *doPNm;
@property (nonatomic,strong) NSString *fmTp ;
@property (nonatomic,strong) NSString *fnm ;
@property (nonatomic,strong) NSString *fonm;
@property (nonatomic,strong) NSString *fstate ;
@property (nonatomic,strong) NSString *khnm ;
@property (nonatomic,strong) NSString *montha;
@property (nonatomic,strong) NSString *nowfs ;
@property (nonatomic,strong) NSString *odnum ;
@property (nonatomic,strong) NSString *pm ;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *size;
@property (nonatomic,strong) NSString *tit;
@property (nonatomic,strong) NSString *u_id;

@property (nonatomic,strong) NSString *txtTGZZ ;
@property (nonatomic,strong) NSString *txtZF;
@property (nonatomic,strong) NSString *txtZBGG;
@property (nonatomic,strong) NSString *txtXQCCL ;
@property (nonatomic,strong) NSString *txtXWDHRQ ;
@property (nonatomic,strong) NSString *txtDPYL;
@property (nonatomic,strong) NSString *txtYYL ;
@property (nonatomic,strong) NSString *txtSYKH ;
@property (nonatomic,strong) NSString *txtKHJSFS;
@property (nonatomic,strong) NSString *txtBZ ;


//@property (nonatomic,strong) NSString *pic ;


-(id)initWithJson:(NSDictionary *)json;
@end
