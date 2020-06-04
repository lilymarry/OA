//
//  MyReceivedReWuHotDetailModel.h
//  Re-OA
//
//  Created by imac-1 on 2016/11/4.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyReceivedReWuHotDetailModel : NSObject

@property (nonatomic,strong) NSString *Ta_Address;
@property (nonatomic,strong) NSString *Ta_Area;
@property (nonatomic,strong) NSString *Ta_Number;
@property (nonatomic,strong) NSString *Ta_Phone;
@property (nonatomic,strong) NSString *Ta_Source;

@property (nonatomic,strong) NSString *Ta_TimeLimit;
@property (nonatomic,strong) NSString *Ta_Type;

@property (nonatomic,strong) NSString *iscomplete;

@property (nonatomic,strong) NSString *tadescription;
@property (nonatomic,strong) NSString *taimg;
@property (nonatomic,strong) NSString *talssueddate;

@property (nonatomic,strong) NSString *tastopdate;
@property (nonatomic,strong) NSString *tauserid;

@property (nonatomic,strong) NSString *username;
@property (strong, nonatomic) NSString *Ta_endTime;//到期时间

@property (strong, nonatomic) NSString *xiaoqueChuli;//消缺处理情况

@property (strong, nonatomic) NSString *xiaoquesghouliTime;//消缺受理时间
@property (strong, nonatomic) NSString *xiaoqueChuliTime;//消缺处理时间


@property (strong, nonatomic) NSString *weiHuPersonSign;//维护人员签字

@property (strong, nonatomic) NSString *PersonSign;//用户签字
@property (strong, nonatomic) NSString *manyidu;//满意度
@property (strong, nonatomic) NSString *remark;//备注

//@property (strong, nonatomic) NSString *Tadescription;//任务描述
@property (strong, nonatomic) NSString *Ta_IsEvaluate;//
@property (strong, nonatomic) NSString *Ta_Satisfied;//
@property (strong, nonatomic) NSString *Ta_SatisfiedDes;




-(id)initWithJson:(NSDictionary *)json;


@end
