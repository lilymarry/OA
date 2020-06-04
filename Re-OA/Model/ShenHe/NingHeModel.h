//
//  NingHeModel.h
//  Re-OA
//
//  Created by admin on 16/4/12.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NingHeModel : NSObject
@property (nonatomic,strong) NSString *ctm ;
@property (nonatomic,strong) NSString *doPNm;
@property (nonatomic,strong) NSString *err;
@property (nonatomic,strong) NSString *fmTp ;
@property (nonatomic,strong) NSString *fnm ;
@property (nonatomic,strong) NSString *fonm;
@property (nonatomic,strong) NSString *fstate ;
@property (nonatomic,strong) NSString *khnm ;
@property (nonatomic,strong) NSString *nowfs ;

@property (nonatomic,strong) NSString *odcode ;
@property (nonatomic,strong) NSString *odnum ;
@property (nonatomic,strong) NSString *opinion;
@property (nonatomic,strong) NSString *pm ;
@property (nonatomic,strong) NSString *reason;
@property (nonatomic,strong) NSString *size;

@property (nonatomic,strong) NSString *tit;
@property (nonatomic,strong) NSString *u_id ;

@property (nonatomic,strong) NSString *pic ;


-(id)initWithJson:(NSDictionary *)json;
@end
