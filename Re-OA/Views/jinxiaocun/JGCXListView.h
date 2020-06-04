//
//  JGCXListView.h
//  Re-OA
//
//  Created by admin on 15/4/22.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  selectButtonTagDelegate <NSObject>
-(void)getButtonTag:(int )tagId  ;
@end
@interface JGCXListView : UIView
@property(nonatomic,strong)JGCXListView *view;
@property(nonatomic,weak) id <selectButtonTagDelegate> delegate;
-(JGCXListView *)instanceJiageChaXun;
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle;
@end
