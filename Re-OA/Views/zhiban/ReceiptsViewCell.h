//
//  ReceiptsViewCell.h
//  Re-OA
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptsViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_Abbreviation;
@property (weak, nonatomic) IBOutlet UILabel *lab_BusinessMan;
@property (weak, nonatomic) IBOutlet UILabel *lab_IsStop;
@property (weak, nonatomic) IBOutlet UILabel *lab_Code ;


@property (weak, nonatomic) IBOutlet UILabel *lab_CustomCode ;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReceiptsDate ;

@property (weak, nonatomic) IBOutlet UILabel *lab_Money  ;

@property (weak, nonatomic) IBOutlet UILabel *lab_SetDate;

@property (weak, nonatomic) IBOutlet UILabel *lab_SetMan;
@property (weak, nonatomic) IBOutlet UILabel *lab_Remark;

@property (weak, nonatomic) IBOutlet UILabel *lab_Type;

@property (weak, nonatomic) IBOutlet UILabel *lab_State;
@property (weak, nonatomic) IBOutlet UILabel *lab_ConfirmDate;

@property (weak, nonatomic) IBOutlet UILabel *lab_ConfirmMan;
@property (weak, nonatomic) IBOutlet UILabel *lab_BillCode ;
@property (weak, nonatomic) IBOutlet UILabel *lab_SID  ;
@property (weak, nonatomic) IBOutlet UILabel *lab_num;

@end
