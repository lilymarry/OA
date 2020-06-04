//
//  paBoOrPaCoQuCustom_detailCell.h
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface paBoOrPaCoQuCustom_detailCell1 : UITableViewCell
@property (nonatomic,copy)NSString * ItemTotal ;
@property (weak, nonatomic) IBOutlet UILabel *lab_OrderCode ;//订单号
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperBoardName ; //下单纸质
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperBoardCodeProduce; //生产纸质
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperKai; //开数
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperWidth;//纸度
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperBoardLength;//纸板长度

@property (weak, nonatomic) IBOutlet UILabel *lab_OrderNum;//订单数量
@property (weak, nonatomic) IBOutlet UILabel *lab_SaleAmount ;//折后金额
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperBoardSpecifications ;//下单规格
@property (weak, nonatomic) IBOutlet UILabel *lab_ValuationSpecifications   ;//计价规格

@property (weak, nonatomic) IBOutlet UILabel *lab_PproducteExplain  ;//生产说明
@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryExplain ;//送货说明
@property (weak, nonatomic) IBOutlet UILabel *lab_BasePaperSquarePrice ;//原纸平方价

@property (weak, nonatomic) IBOutlet UILabel *lab_SquarePrice ;//平方单价
@property (weak, nonatomic) IBOutlet UILabel *lab_BasePaperAmount;//原纸金额
@property (weak, nonatomic) IBOutlet UILabel *lab_ProcessingCost ;//加工费

@property (weak, nonatomic) IBOutlet UILabel *lab_BasePaperPercent;//原纸比例
@property (weak, nonatomic) IBOutlet UILabel *lab_Cube ;//立方
@property (weak, nonatomic) IBOutlet UILabel *lab_Square  ;//平方
@property (weak, nonatomic) IBOutlet UILabel *lab_OrderDateTime ;//下单时间
@property (weak, nonatomic) IBOutlet UILabel *lab_ScheduleNum ;//排程单号

@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryDateTime   ;//交期
@property (weak, nonatomic) IBOutlet UILabel *lab_CustomPurchaseNum ;//客户采购号
@property (weak, nonatomic) IBOutlet UILabel *lab_CustomCode ;//客户代号
@property (weak, nonatomic) IBOutlet UILabel *lab_Abbreviation ;//客户简称
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperPrice ;//纸板单价
@property (weak, nonatomic) IBOutlet UILabel *lab_Trimming ;//修边
@property (weak, nonatomic) IBOutlet UILabel *lab_TrimmingRatio ;//修边率
@property (weak, nonatomic) IBOutlet UILabel *lab_Salesman;//业务员

@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryNum ;//送货单号
@property (weak, nonatomic) IBOutlet UILabel *lab_TallyNum ;//理货单号
@property (weak, nonatomic) IBOutlet UILabel *lab_CarNum ;//车牌号
@property (weak, nonatomic) IBOutlet UILabel *lab_PrintDateTime;//打单时间
@property (weak, nonatomic) IBOutlet UILabel *lab_num;//打单时间
@end
