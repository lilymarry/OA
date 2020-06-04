//
//  ShangBaoList.h
//  Re-OA
//
//  Created by admin on 15/1/27.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShangBaoList : NSObject
@property (copy, nonatomic) NSString *fmtp;
@property (copy, nonatomic) NSString *fnm;

@property (copy, nonatomic) NSString *fpId;
@property (copy, nonatomic) NSString *typeId;



@property (strong, nonatomic) NSDictionary *infoDic;


+ (ShangBaoList *) standartUserInfo;
@end
