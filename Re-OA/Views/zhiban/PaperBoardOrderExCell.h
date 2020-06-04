//
//  PaperBoardOrderExCell.h
//  Re-OA
//
//  Created by admin on 16/3/29.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaperBoardOrderExCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UILabel * ItemTotal	;//全部条数
@property (weak, nonatomic) IBOutlet UILabel *  SID ;//SID
@property (weak, nonatomic) IBOutlet UILabel *  OrderCode;//订单编号
@property (weak, nonatomic) IBOutlet UILabel*  Anxious ;//急
@property (weak, nonatomic) IBOutlet UILabel *  CustomCode ;//客户代号
@property (weak, nonatomic) IBOutlet UILabel *  CustomName;//客户名称
@property (weak, nonatomic) IBOutlet UILabel *  Abbreviation ;//客户简称
@property (weak, nonatomic) IBOutlet UILabel *  Area ;//地区

@property (weak, nonatomic) IBOutlet UILabel *  BusinessMan ;//业务员
@property (weak, nonatomic) IBOutlet UILabel *  DistcountCash ;//收款折扣率
@property (weak, nonatomic) IBOutlet UILabel *  Address ;//送货地点
@property (weak, nonatomic) IBOutlet UILabel *  RateFreight ;//运费率
@property (weak, nonatomic) IBOutlet UILabel *  Mileage ;//公里数
@property (weak, nonatomic) IBOutlet UILabel *  PinYin ;//拼音
@property (weak, nonatomic) IBOutlet UILabel *  StorageArea ;//
@property (weak, nonatomic) IBOutlet UILabel *  RateOfDistinct ;//	折扣率
@property (weak, nonatomic) IBOutlet UILabel * PaperBoardCode ;//纸质
@property (weak, nonatomic) IBOutlet UILabel * CodePaperEquip ;//配纸
@property (weak, nonatomic) IBOutlet UILabel *  PaperBoardCodeProduce ;//	生产纸质
@property (weak, nonatomic) IBOutlet UILabel * CodePaperEquipProduce;//配纸代号
@property (weak, nonatomic) IBOutlet UILabel *  PitCode ;//坑类
@property (weak, nonatomic) IBOutlet UILabel *  Layer;//层数
@property (weak, nonatomic) IBOutlet UILabel *  SchedulingClass ;//排产分类
@property (weak, nonatomic) IBOutlet UILabel *  Height ;//高度
@property (weak, nonatomic) IBOutlet UILabel *  BaseWeight ;//基重
@property (weak, nonatomic) IBOutlet UILabel*  Spec ;//投产尺寸
@property (weak, nonatomic) IBOutlet UILabel *  SpecEx ;//投产比例
@property (weak, nonatomic) IBOutlet UILabel * PricSpec ;//投产尺寸
@property (weak, nonatomic) IBOutlet UILabel*  ProduceSpec ;//生产尺寸


@property (weak, nonatomic) IBOutlet UILabel *  PaperKai ;//开数
@property (weak, nonatomic) IBOutlet UILabel *  Degree;//等级
@property (weak, nonatomic) IBOutlet UILabel * SetMan ;//下单人
@property (weak, nonatomic) IBOutlet UILabel *  SetDate;//下单日期
@property (weak, nonatomic) IBOutlet UILabel * UpdateDate;//修改时间
@property (weak, nonatomic) IBOutlet UILabel * UpdateMan ;//修改人
@property (weak, nonatomic) IBOutlet UILabel *  DeliveryDate;//交期
@property (weak, nonatomic) IBOutlet UILabel*  PaperBoardWidth;//纸宽
@property (weak, nonatomic) IBOutlet UILabel *  PaperBoardLength ;//纸长
@property (weak, nonatomic) IBOutlet UILabel *  PaperBoardWidthPrice ;//计价纸宽

@property (weak, nonatomic) IBOutlet UILabel *  PaperWidth ;//纸度
@property (weak, nonatomic) IBOutlet UILabel*  TheEdge;//纸板宽度
@property (weak, nonatomic) IBOutlet UILabel *  PlusMm;//跳mm
@property (weak, nonatomic) IBOutlet UILabel *  Amount ;//数量
@property (weak, nonatomic) IBOutlet UILabel *  MaterialAmount;//套料数
@property (weak, nonatomic) IBOutlet UILabel*  LargeAmount;//	大张数量

@property (weak, nonatomic) IBOutlet UILabel *  SendNum;//送
@property (weak, nonatomic) IBOutlet UILabel *  AmountToProduce ;//待生产数量

@property (weak, nonatomic) IBOutlet UILabel*  PricePaperBoard ;//单价
@property (weak, nonatomic) IBOutlet UILabel*   PriceSquare;//	平方单价
@property (weak, nonatomic) IBOutlet UILabel*   CostOfPaper ;//原纸平方单价
@property (weak, nonatomic) IBOutlet UILabel*  NetEdgeSize ;//净边尺寸
@property (weak, nonatomic) IBOutlet UILabel*   PriceNetEdge ;//净边计价
@property (weak, nonatomic) IBOutlet UILabel*   CantDiscount ;;//	不可折

@property (weak, nonatomic) IBOutlet UILabel*   ChangePrice ;//	改价
@property (weak, nonatomic) IBOutlet UILabel*  StockCode ;//采购号
@property (weak, nonatomic) IBOutlet UILabel*  OrderType;//订单类型
@property (weak, nonatomic) IBOutlet UILabel*   ProduceRemark;//生产说明
@property (weak, nonatomic) IBOutlet UILabel*   ShippingRemark ;//送货说明

@property (weak, nonatomic) IBOutlet UILabel  *  PressLine ;//压线
@property (weak, nonatomic) IBOutlet UILabel *  PressLine1 ;//	压线1
@property (weak, nonatomic) IBOutlet UILabel * PressLine2 ;// 压线2
@property (weak, nonatomic) IBOutlet UILabel *  PressLine3 ;// 压线3
@property (weak, nonatomic) IBOutlet UILabel*  PressLine4 ;// 压线4
@property (weak, nonatomic) IBOutlet UILabel *  PressLine5;//	压线5
@property (weak, nonatomic) IBOutlet UILabel *  PressLine6 ;//	压线6
@property (weak, nonatomic) IBOutlet UILabel *  PressLine7 ;//	压线7
@property (weak, nonatomic) IBOutlet UILabel * PressLine8 ;//	压线8

@property (weak, nonatomic) IBOutlet UILabel*  PressureType ;//压型
@property (weak, nonatomic) IBOutlet UILabel *  Attention;//注意事项
@property (weak, nonatomic) IBOutlet UILabel * ApproveMan ;//审核人
@property (weak, nonatomic) IBOutlet UILabel *  PerSquareMeterPrice ;//	小片计价体积
@property (weak, nonatomic) IBOutlet UILabel *  PerVolume ;//小片平方
@property (weak, nonatomic) IBOutlet UILabel *  PerSquareMeter;//小片体积
@property (weak, nonatomic) IBOutlet UILabel *  perWeight ;//小片重量
@property (weak, nonatomic) IBOutlet UILabel *  PerSquareMeterFiveLayers ;//小片折五层平方
@property (weak, nonatomic) IBOutlet UILabel *  PaperSquare ;//单平方
@property (weak, nonatomic) IBOutlet UILabel *  BillSquare;//单体积
@property (weak, nonatomic) IBOutlet UILabel *  BillVolume ;//单长度
@property (weak, nonatomic) IBOutlet UILabel *  BillWeight ;//单重量
@property (weak, nonatomic) IBOutlet UILabel *  BillPaperLength ;//单长度
@property (weak, nonatomic) IBOutlet UILabel *  PlanSquare ;//排产平方
@property (weak, nonatomic) IBOutlet UILabel *  PlanVolume ;//排产立方
@property (weak, nonatomic) IBOutlet UILabel *  PlanWeight ;//理论重量
@property (weak, nonatomic) IBOutlet UILabel *  PlanPaperLength ;//排产长度

@property (weak, nonatomic) IBOutlet UILabel *  ReturnAmount ;//回签数
@property (weak, nonatomic) IBOutlet UILabel *  HasChecked ;//已核单
@property (weak, nonatomic) IBOutlet UILabel *  PriceProcess ;//加工费
@property (weak, nonatomic) IBOutlet UILabel *  InAmount;//入库数
@property (weak, nonatomic) IBOutlet UILabel *  TallyAmount ;//理货数
@property (weak, nonatomic) IBOutlet UILabel *  TallyFlag ;//理货中
@property (weak, nonatomic) IBOutlet UILabel *  PriceGroupCode ;//组报价编号
@property (weak, nonatomic) IBOutlet UILabel *  PriceOffer ;//	平方报价
@property (weak, nonatomic) IBOutlet UILabel *  DeductionAmount;//扣销数量
@property (weak, nonatomic) IBOutlet UILabel *  InsertOrder ;//插单
@property (weak, nonatomic) IBOutlet UILabel *  ProduceSequence ;//	生产次序
@property (weak, nonatomic) IBOutlet UILabel *  ProducePlanCode ;//排产单号
@property (weak, nonatomic) IBOutlet UILabel *  DeviceCode ;//设备编号
@property (weak, nonatomic) IBOutlet UILabel *  TeamName ;//生产班组
@property (weak, nonatomic) IBOutlet UILabel *  TimeBeginProduce ;//投产时间
@property (weak, nonatomic) IBOutlet UILabel *  ProduceState ;//生产状态
@property (weak, nonatomic) IBOutlet UILabel *  ProducePlanDate ;//排程时间
@property (weak, nonatomic) IBOutlet UILabel *  PitCodeGroup ;//机位楞型
@property (weak, nonatomic) IBOutlet UILabel *  num ;//行数
@end
