//
//  RenWuHotDetailViewCell.h
//  Re-OA
//
//  Created by imac-1 on 2016/11/7.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol RenWuHotDetailDelegate <NSObject>
//-(void)getRenWuHotDetail;
//@end

@interface RenWuHotDetailViewCell : UITableViewCell
//@property (weak,nonatomic) id<RenWuHotDetailDelegate> ddelegate;
@property (weak, nonatomic) IBOutlet UILabel *Ta_Number;// 编号

@property (weak, nonatomic) IBOutlet UILabel *Ta_Address;

@property (weak, nonatomic) IBOutlet UILabel *Ta_Area;//小区

@property (weak, nonatomic) IBOutlet UILabel *Ta_Phone;//联系电话
@property (weak, nonatomic) IBOutlet UILabel *Ta_Source;// 业务来源
@property (weak, nonatomic) IBOutlet UILabel *Ta_Type;//业务类型

@property (weak, nonatomic) IBOutlet UILabel *Ta_endTime;//到期时间
@property (weak, nonatomic) IBOutlet UILabel *lab_endTime;//到期时间


@property (weak, nonatomic) IBOutlet UILabel *xiaoqueChuli;//消缺处理情况

@property (weak, nonatomic) IBOutlet UILabel *xiaoquesghouliTime;//消缺受理时间
@property (weak, nonatomic) IBOutlet UILabel *xiaoqueChuliTime;//消缺处理时间

@property (weak, nonatomic) IBOutlet UILabel *Ta_TimeLimit;//时限
@property (weak, nonatomic) IBOutlet UILabel *weiHuPersonSign;//维护人员签字

@property (weak, nonatomic) IBOutlet UILabel *PersonSign;//用户签字
@property (weak, nonatomic) IBOutlet UILabel *manyidu;//满意度
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UILabel *remark;//备注



@property (weak, nonatomic) IBOutlet UILabel *talssueddate;
@property (weak, nonatomic) IBOutlet UILabel *tastopdate;

@property (weak, nonatomic) IBOutlet UIImageView *imaFlag;

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *fabutime;
@property (weak, nonatomic) IBOutlet UILabel *biaoti;
@property (weak, nonatomic) IBOutlet UILabel *Tadescription;//任务描述

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UIButton *btn_satis;
- (IBAction)btnPress:(id)sender;


@end
