//
//  RenWuDetailHotModel.h
//  Re-OA
//
//  Created by imac-1 on 2016/11/7.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RenWuDetailHotModel : NSObject
@property (nonatomic,strong) NSString *Taop_Comment;
@property (nonatomic,strong) NSString *Taop_Date;
@property (nonatomic,strong) NSString *Taop_Date_1;
@property (nonatomic,strong) NSString *Taop_Description;
@property (nonatomic,strong) NSString *Taop_Id;

@property (nonatomic,strong) NSString *Taop_Img1;
@property (nonatomic,strong) NSString *Taop_Img2;

@property (nonatomic,strong) NSString *Taop_Img3;

@property (nonatomic,strong) NSString *Taop_ImgDate1;
@property (nonatomic,strong) NSString *Taop_ImgDate2;
@property (nonatomic,strong) NSString *Taop_ImgDate3;

@property (nonatomic,strong) NSString *Taop_IsSee;
@property (nonatomic,strong) NSString *Taop_IsTimeout;

@property (nonatomic,strong) NSString *Taop_Iscomplete;
@property (strong, nonatomic) NSString *Taop_Latitude1;

@property (strong, nonatomic) NSString *Taop_Latitude2;

@property (strong, nonatomic) NSString *Taop_Latitude3;
@property (strong, nonatomic) NSString *Taop_Longitude1;


@property (strong, nonatomic) NSString *Taop_Longitude2;

@property (strong, nonatomic) NSString *Taop_Longitude3;
@property (strong, nonatomic) NSString *Taop_Taid;
@property (strong, nonatomic) NSString *Taop_UserName;

@property (strong, nonatomic) NSString *Taop_Userid;

@property (strong, nonatomic) NSString *Taop_Describe1;
@property (strong, nonatomic) NSString *Taop_Describe2;

@property (strong, nonatomic) NSString *Taop_Describe3;




-(id)initWithJson:(NSDictionary *)json;
@end
