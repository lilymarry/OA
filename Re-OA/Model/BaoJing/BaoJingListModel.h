//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器   http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface BaoJingListModel : NSObject<NSCoding,NSCopying>

@property (nonatomic,strong) NSString *ssgc;
@property (nonatomic,strong) NSString *bjid;
@property (nonatomic,strong) NSString *dk;
@property (nonatomic,strong) NSString *cltm;
@property (nonatomic,strong) NSString *bjtm;
@property (nonatomic,strong) NSString *dvrpwd;
@property (nonatomic,strong) NSString *dvrnm;
@property (nonatomic,strong) NSString *rnum;
@property (nonatomic,strong) NSString *dq;
@property (nonatomic,strong) NSString *ygno;
@property (nonatomic,strong) NSString *carno;
@property (nonatomic,strong) NSString *td;
@property (nonatomic,strong) NSString *bz;
@property (nonatomic,strong) NSString *ip;
@property (nonatomic,strong) NSString *lxmc;
@property (assign,nonatomic) BOOL isChild;
@property (assign,nonatomic) BOOL isExpended;


-(id)initWithJson:(NSDictionary *)json;

@end
