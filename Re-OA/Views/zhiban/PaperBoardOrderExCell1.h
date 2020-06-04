//
//  PaperBoardOrderExCell1.h
//  Re-OA
//
//  Created by imac-1 on 2016/12/16.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaperBoardOrderExCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *  OrderCode;//订单编号


@property (weak, nonatomic) IBOutlet UILabel *  CustomName;//客户名称

@property (weak, nonatomic) IBOutlet UILabel *  BusinessMan ;//业务员
@property (weak, nonatomic) IBOutlet UILabel *  yuanzhiBi ;//原纸占比

@property (weak, nonatomic) IBOutlet UILabel * PaperBoardCode ;//纸质
@property (weak, nonatomic) IBOutlet UILabel*  PaperBoardWidth;//纸宽
@property (weak, nonatomic) IBOutlet UILabel *  PaperBoardLength ;//纸长

@property (weak, nonatomic) IBOutlet UILabel *  Amount ;//数量
@property (weak, nonatomic) IBOutlet UILabel*   PriceSquare;//	平方单价
@property (weak, nonatomic) IBOutlet UILabel*   CostOfPaper ;//原纸平方单价

@property (weak, nonatomic) IBOutlet UILabel *  PitCodeGroup ;//机位楞型
@property (weak, nonatomic) IBOutlet UILabel *  num ;//机位楞型
@end
