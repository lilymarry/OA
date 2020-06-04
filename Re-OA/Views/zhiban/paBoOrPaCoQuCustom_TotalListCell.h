//
//  paBoOrPaCoQuCustom_TotalListCell.h
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface paBoOrPaCoQuCustom_TotalListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_CustomCode ; // 客户代号
@property (weak, nonatomic) IBOutlet UILabel *lab_Abbreviation ;//客户简称
@property (weak, nonatomic) IBOutlet UILabel *lab_Region ; //区域,
@property (weak, nonatomic) IBOutlet UILabel *lab_BusinessMan; //业务员,
@property (weak, nonatomic) IBOutlet UILabel *lab_ReducedSquare; //折合平方
@property (weak, nonatomic) IBOutlet UILabel *lab_Cube;//立方
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperSize;//纸度
@property (weak, nonatomic) IBOutlet UILabel *lab_Num;//款数
@property (weak, nonatomic) IBOutlet UILabel *lab_TrimmingLoss ;//修边损耗量
@property (weak, nonatomic) IBOutlet UILabel *lab_Meters ;//米数
@property (weak, nonatomic) IBOutlet UILabel *lab_TwoLayersMeters   ;//二层米数
@property (weak, nonatomic) IBOutlet UILabel *lab_SinglePitMeters  ;//单坑米数
@property (weak, nonatomic) IBOutlet UILabel *lab_DoublePitMeters ;//双坑米数
@property (weak, nonatomic) IBOutlet UILabel *lab_ThreePitMeters ;//三坑米数
@property (weak, nonatomic) IBOutlet UILabel *lab_Square ;//平方
@property (weak, nonatomic) IBOutlet UILabel *lab_TwoLayersSquare;//二层平方
@property (weak, nonatomic) IBOutlet UILabel *lab_SinglePitSquare ;//单坑平方
@property (weak, nonatomic) IBOutlet UILabel *lab_DoublePitSquare;//双坑平方
@property (weak, nonatomic) IBOutlet UILabel *lab_ThreePitSquare ;//三坑平方
@property (weak, nonatomic) IBOutlet UILabel *lab_Amount  ;//原纸金额
@property (weak, nonatomic) IBOutlet UILabel *lab_TwoLayersAmount ;//二层原纸金额
@property (weak, nonatomic) IBOutlet UILabel *lab_SinglePitAmount ;//单坑原纸金额
@property (weak, nonatomic) IBOutlet UILabel *lab_DoublePitAmount   ;//双坑原纸金额
@property (weak, nonatomic) IBOutlet UILabel *lab_ThreePitAmount ;//三坑原纸金额
@property (weak, nonatomic) IBOutlet UILabel *lab_SaleAmount ;//折后金额
@property (weak, nonatomic) IBOutlet UILabel *lab_SaleTwoLayersAmount ;//二层折后金额
@property (weak, nonatomic) IBOutlet UILabel *lab_SaleSinglePitAmount ;//单坑折后金额
@property (weak, nonatomic) IBOutlet UILabel *lab_SaleDoublePitAmount ;//双坑折后金额
@property (weak, nonatomic) IBOutlet UILabel *lab_SaleThreePitAmount ;//三坑折后金额
@property (weak, nonatomic) IBOutlet UILabel *lab_WariningNum;//预警款数
@property (weak, nonatomic) IBOutlet UILabel *lab_num;//预警款数
@end
