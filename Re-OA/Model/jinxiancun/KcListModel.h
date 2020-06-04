//
//  KcListModel.h
//  Re-OA
//
//  Created by admin on 15/4/8.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KcListModel : NSObject
@property (nonatomic,strong) NSString *dwid;
@property (nonatomic,strong) NSString *dwnm;
@property (nonatomic,strong) NSString *kfnm;
@property (strong, nonatomic) NSString *jianshu;
@property (strong, nonatomic) NSString *kg;
@property (strong, nonatomic) NSString *kfid;
@property (strong, nonatomic) NSString *gcid;
-(id)initWithDic:(NSDictionary *)dic;
@end
