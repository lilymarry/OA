//
//  TJDisPlayPictureView.h
//  Re-OA
//
//  Created by imac-1 on 2016/11/4.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TJPictureDisPlayViewDelegate <NSObject>

@optional
- (void)showDisPlayImageView:(NSString *)imaName andType:(NSString *) type ;

-(void)getImag:(NSString *)lo andla:(NSString *)la;


@end
@interface TJDisPlayPictureView : UIView
@property (nonatomic, weak) id<TJPictureDisPlayViewDelegate> delegate;

@property (nonatomic, strong) NSString *typeStr;//图片类型
@property (nonatomic, strong) NSString *time;//图片标题

@property (nonatomic, strong) NSString *lo;//图片类型
@property (nonatomic, strong) NSString *la;//图片标题
- (void)refresPictureView:(NSArray *)lists withType:(NSString *)type andUsid:(NSString *)uid andDecri:(NSString *)decri;
@end
