//
//  Menu.h
//  Re-OA
//fpTyp.Add("1", "财务相关");
//fpTyp.Add("2", "人事管理");
//fpTyp.Add("3", "行政事务");
//fpTyp.Add("4", "业务相关");
//fpTyp.Add("5", "生产相关");
//  Created by imac-1 on 15/1/3.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property (nonatomic) NSString *num;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageName;
@property (nonatomic) NSString *listImageName;
@property (nonatomic) NSString *nibName;
@property (nonatomic) BOOL isChangYong;
@property (nonatomic) NSMutableArray *childMenu;
@property (nonatomic) NSString *storyboardName;
@property (nonatomic) NSString *storyboardID;
@property (nonatomic) NSDictionary *paramsForController;

-(MenuModel*)initWithNum:(NSString*)num
                 AndName:(NSString*)name
            AndImageName:(NSString*)imageName
        AndListImageName:(NSString*)listImageName
          AndIsChangYong:(BOOL)isChangYong
              AndNibName:(NSString*)nibName
              AndStoryboardName:(NSString*)storyboardName
              AndStoryboardID:(NSString*)storyboardID
              AndparamsForController:(NSDictionary*)param;

+(NSMutableArray*)menusOfQuanBu;
+(NSMutableArray*)menusOfChangYong;

+(NSMutableArray*)menuListOfFirstChoose;
+(NSMutableArray*)menuListOfSecondChooseForParentMenu:(MenuModel*)parentMenu;


@end
