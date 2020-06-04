//
//  KcDetailListModel.h
//  Re-OA
//
//  Created by admin on 15/4/8.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KcDetailListModel : NSObject
@property (nonatomic,strong) NSString *wuZiname;
@property (nonatomic,strong) NSString *num;
@property (nonatomic,strong) NSString *weight;
@property (strong, nonatomic) NSString *dengji;
@property (strong, nonatomic) NSString *leixing;

-(id)initWithDic:(NSDictionary *)dic;
@end
