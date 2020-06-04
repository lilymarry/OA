//
//  ShenHeChooseView1.h
//  Re-OA
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectShenHePerson.h"
#import "ShenHeDelegate.h"
#import "RenWuDelegate.h"
@protocol shenHeDataDelegate <NSObject>
@optional
-(void)selectSheHeWithSt:(NSString *)st andName:(NSString *)name et:(NSString *)et type:(NSString *)type
                  tittle:(NSString *)titt;


//-(void)selecAll;
-(void)selecPiliang;
@end
@interface ShenHeChooseView1 : UIView<shenHePerDelegate,ShenHeNotification,UITextFieldDelegate,RenWuDateChooseDelegate>
@property(weak,nonatomic) id <shenHeDataDelegate>dDelegate;
//@property (weak,nonatomic) id<ShenHeSelectDelegate> shenHeSelectDelegate;
- (id)initWithFrame:(CGRect)frame andMode:( BOOL) pilaing;
@end
