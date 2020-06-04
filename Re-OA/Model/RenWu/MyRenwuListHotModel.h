//
//  MyRenwuListHotModel.h
//  Re-OA
//
//  Created by imac-1 on 2016/11/4.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRenwuListHotModel : NSObject
@property (nonatomic,strong) NSString *Ta_Area;
@property (nonatomic,strong) NSString *Ta_Description;
@property (nonatomic,strong) NSString *Ta_Id;
@property (nonatomic,strong) NSString *Ta_Iscomplete;//整体任务完成进度
@property (nonatomic,strong) NSString *Taop_Iscomplete;//个人任务完成进度
@property (nonatomic,strong) NSString *Ta_Lssueddate;


@property (nonatomic,strong) NSString *Ta_Username;


@property (nonatomic,strong) NSString *Ta_Number;

@property (nonatomic,strong) NSString *Taop_ISRelease;
@property (nonatomic,strong) NSString *Taop_ISFAudit;

-(id)initWithJson:(NSDictionary *)json;

@end
