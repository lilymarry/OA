//
//  BJLeiXingListView.h
//  Re-OA
//
//  Created by admin on 15/5/28.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol selectLeiXingDelegate <NSObject>
-(void)selectLeiXingWithNum:(NSString *)row;
@end
@interface BJLeiXingListView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(strong ,nonatomic)NSMutableArray *leiXingArr;
@property(strong ,nonatomic)NSMutableArray *colorArr;
@property(weak,nonatomic) id <selectLeiXingDelegate>dataDelegate;

-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;
@end
