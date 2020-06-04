//
//  ZhiZhangModel.h
//  Re-OA
//
//  Created by admin on 15/6/10.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhiZhangModel : NSObject
@property (nonatomic,strong) NSString *tit ;
@property (nonatomic,strong) NSString *pbnm;
@property (nonatomic,strong) NSString *qi;
@property (nonatomic,strong) NSString *liu ;
@property (nonatomic,strong) NSString *wu ;
@property (nonatomic,strong) NSString *si;
@property (nonatomic,strong) NSString *san ;
@property (nonatomic,strong) NSString *er ;
@property (nonatomic,strong) NSString *yi ;

@property (nonatomic,strong) NSString *ref ;
@property (nonatomic,strong) NSString *report ;
@property (nonatomic,strong) NSString *workp;
@property (nonatomic,strong) NSString *doPNm ;
@property (nonatomic,strong) NSString *fstate;
@property (nonatomic,strong) NSString *ct;

@property (nonatomic,strong) NSString *fmTp;
@property (nonatomic,strong) NSString *fnm ;

@property (nonatomic,strong) NSString *khnm ;
@property (nonatomic,strong) NSString *uid;

@property (nonatomic,strong) NSString *inrefer;

@property (nonatomic,strong) NSString *gouzhijianshu1;

@property (nonatomic,strong) NSString *gouzhijianshu2;
@property (nonatomic,strong) NSString *gouzhijianshu3 ;

@property (nonatomic,strong) NSString *xiuqiu1 ;
@property (nonatomic,strong) NSString *xiuqiu2;

@property (nonatomic,strong) NSString *xiuqiu3;

-(id)initWithJson:(NSDictionary *)json;
@end
