//
//  AllRenWuHotDetailViewController.h
//  Re-OA
//
//  Created by imac-1 on 2016/11/7.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllRenWuHotDetailViewController : UIViewController
@property (strong,nonatomic) NSString *ta_id;
@property (strong, nonatomic)  NSString *Taop_ISRelease   ;   //  是否发布 0没有发布 1已经发布
@property (strong, nonatomic)  NSString *Taop_ISFAudit     ;   // 是否审核 0没有审核 1已经审核

@property (strong ,nonatomic)NSString *tyteName;

@end
