//
//  HotRewWuWebAPI.h
//  Re-OA
//
//  Created by imac-1 on 2016/12/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotRewWuWebAPI : NSObject
#pragma mark -----热力任务
//热力
+(void)requestHostListByUID:(NSString *)userid AndType:(NSString *)type  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail;

//发布任务接口
+(void)requestReleaseTaskByUID:(NSString *)userid AndType:(NSString *)type  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail;

///我的任务
+(void)requestTaskByUID:(NSString *)userid method:(NSString *)method  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail;


//全部任务接口
+(void)requestAllTaskByUID:(NSString *)userid AndType:(NSString *)type  taid:(NSString *)taid page:(NSString *)page success:(void (^)(NSArray *))success fail:(void (^)())fail;
//任务派发人员
+(void)requestHotUsersByUID:(NSString *)uid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//分配人员任务
+(void)sendPersonListTaid:(NSString *)taid arraycjuserid:(NSString *)arraycjuserid arraycjusername:(NSString *)arraycjusername  success:(void (^)(NSArray *))success fail:(void (^)())fail;
//工头审核
+(void)AddAuditWithTaid:(NSString *)taid Taop_Describe:(NSString *)Taop_Describe   success:(void (^)(NSArray *))success fail:(void (^)())fail;
//热力任务 详情
+(void)requestHotReceivedDetailByUID:(NSString *)userid AndType:(NSString *)type AndTAID:(NSString *)taid success:(void (^)(NSArray *))success fail:(void (^)())fail;
//热力图片上传
+(void)requestHotPicByUID:(NSString *)userid AndType:(NSString *)type AndTkonid:(NSString *)tkonid Taop_Longitude:(NSString *)Taop_Longitude Taop_Latitude:(NSString *)Taop_Latitude  Taop_Describe:(NSString *)Taop_Describe imaArr:(NSArray *)imaArr success:(void (^)(NSArray *))success fail:(void (^)())fail progress:(void (^)(float))progress;

+(NSString *)HotImgUrlPathWithUid:(NSString*)uid type:(NSString *)type pcName:(NSString *)picNam;
//上传任务描述
+(void)requestHotDiscriptionByUID:(NSString *)userid AndTodescription:(NSString *)todescription AndTAID:(NSString *)taid success:(void (^)(NSArray *))success fail:(void (^)())fail;
//任务完成
+(void)requestFinishHotTaop_Id:(NSString *)Taop_Id AndTaop_Taid:(NSString *)Taop_Taid   success:(void (^)(NSArray *))success fail:(void (^)())fail;

//评价
+(void)requestTaskFinishHotTaop_Id:(NSString *)Taop_Id Ta_Satisfied:(NSString *)Ta_Satisfied Ta_SatisfiedDes:(NSString *)Ta_SatisfiedDes   success:(void (^)(NSArray *))success fail:(void (^)())fail;


@end
