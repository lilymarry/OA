//
//  OrderSummaryCell.h
//  Re-OA
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSummaryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lab_SalesMan;
@property (weak, nonatomic) IBOutlet UILabel *lab_ModelsNum;
@property (weak, nonatomic) IBOutlet UILabel *lab_CustomerNum ;
@property (weak, nonatomic) IBOutlet UILabel *lab_BeforeDiscountAmount ;
@property (weak, nonatomic) IBOutlet UILabel *lab_AfterDiscountAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_MeterNum;
@property (weak, nonatomic) IBOutlet UILabel *lab_Square;
@property (weak, nonatomic) IBOutlet UILabel *lab_Cube ;
@property (weak, nonatomic) IBOutlet UILabel *lab_BasePaperAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_GrossProfit  ;
@property (weak, nonatomic) IBOutlet UILabel *lab_BasePaperProportion;
@property (weak, nonatomic) IBOutlet UILabel *lab_num;


@end
