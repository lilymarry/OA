//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器   http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface JianKongModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *tdlxnm;
@property (nonatomic,strong) NSString *ip;
@property (nonatomic,strong) NSString *dvrnm;
@property (nonatomic,strong) NSString *dknw;
@property (nonatomic,strong) NSString *dvrpwd;
@property (nonatomic,strong) NSString *dkzx;
@property (nonatomic,strong) NSString *td;
@property (nonatomic,strong) NSString *tdnm;
@property (nonatomic,strong) NSString *gcid;
 


-(id)initWithJson:(NSDictionary *)json;

@end
