//
//  BdListModel.h
//  Re-OA
//
//  Created by admin on 15/3/31.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BdListModel : NSObject
@property (nonatomic,strong) NSString *bdid;
@property (nonatomic,strong) NSString *bdno;
@property (nonatomic,strong) NSString *carno;
@property (strong, nonatomic) NSString *wuzi;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *BangDanState;
@property (strong, nonatomic) NSString *dengji;
-(id)initWithJson:(NSDictionary *)json;
@end
