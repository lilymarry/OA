//
//  SelectShenHePerson.h
//  Re-OA
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol shenHePerDelegate <NSObject>
-(void)selectPresonWithNum:(NSString *)num andName:(NSString *)name;

@end
@interface SelectShenHePerson : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *personData;
    
}
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSString  *type;
@property(weak,nonatomic) id <shenHePerDelegate>datDelegate;
-(void)setType:(NSString *)type;

@end
