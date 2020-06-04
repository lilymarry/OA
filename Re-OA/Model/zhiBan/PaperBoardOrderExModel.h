//
//  PaperBoardOrderExModel.h
//  Re-OA
//
//  Created by admin on 16/3/29.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaperBoardOrderExModel : NSObject
@property (nonatomic,copy) NSString * ItemTotal	;//全部条数
@property (nonatomic,copy) NSString *  SID ;//SID
@property (nonatomic,copy) NSString *  OrderCode;//订单编号
@property (nonatomic,copy) NSString *  Anxious ;//急
@property (nonatomic,copy) NSString *  CustomCode ;//客户代号
@property (nonatomic,copy) NSString *  CustomName;//客户名称
@property (nonatomic,copy) NSString *  Abbreviation ;//客户简称
@property (nonatomic,copy) NSString *  Area ;//地区

@property (nonatomic,copy) NSString *  BusinessMan ;//业务员
@property (nonatomic,copy) NSString *  DistcountCash ;//收款折扣率
@property (nonatomic,copy) NSString *  Address ;//送货地点
@property (nonatomic,copy) NSString *  RateFreight ;//运费率
@property (nonatomic,copy) NSString *  Mileage ;//公里数
@property (nonatomic,copy) NSString *  PinYin ;//拼音
@property (nonatomic,copy) NSString *  StorageArea ;//
@property (nonatomic,copy) NSString *  RateOfDistinct ;//	折扣率
@property (nonatomic,copy) NSString * PaperBoardCode ;//纸质
@property (nonatomic,copy) NSString * CodePaperEquip ;//配纸
@property (nonatomic,copy) NSString *  PaperBoardCodeProduce ;//	生产纸质
@property (nonatomic,copy) NSString * CodePaperEquipProduce;//配纸代号
@property (nonatomic,copy) NSString *  PitCode ;//坑类
@property (nonatomic,copy) NSString *  Layer;//层数
@property (nonatomic,copy) NSString *  SchedulingClass ;//排产分类
@property (nonatomic,copy) NSString *  Height ;//高度
@property (nonatomic,copy) NSString *  BaseWeight ;//基重
@property (nonatomic,copy) NSString *  Spec ;//投产尺寸
@property (nonatomic,copy) NSString *  SpecEx ;//投产比例
@property (nonatomic,copy) NSString * PricSpec ;//投产尺寸
@property (nonatomic,copy) NSString *  ProduceSpec ;//生产尺寸


@property (nonatomic,copy) NSString *  PaperKai ;//开数
@property (nonatomic,copy) NSString *  Degree;//等级
@property (nonatomic,copy) NSString * SetMan ;//下单人
@property (nonatomic,copy) NSString *  SetDate;//下单日期
@property (nonatomic,copy) NSString * UpdateDate;//修改时间
@property (nonatomic,copy) NSString * UpdateMan ;//修改人
@property (nonatomic,copy) NSString *  DeliveryDate;//交期
@property (nonatomic,copy) NSString *  PaperBoardWidth;//纸宽
@property (nonatomic,copy) NSString *  PaperBoardLength ;//纸长
@property (nonatomic,copy) NSString *  PaperBoardWidthPrice ;//计价纸宽
@property (nonatomic,copy) NSString *  PaperWidth ;//纸度
@property (nonatomic,copy) NSString *  TheEdge;//纸板宽度
@property (nonatomic,copy) NSString *  PlusMm;//跳mm
@property (nonatomic,copy) NSString *  Amount ;//数量
@property (nonatomic,copy) NSString *  MaterialAmount;//套料数
@property (nonatomic,copy) NSString *  LargeAmount;//	大张数量
@property (nonatomic,copy) NSString *  SendNum;//送
@property (nonatomic,copy) NSString *  AmountToProduce ;//待生产数量

@property (nonatomic,copy) NSString *  PricePaperBoard ;//单价
@property (nonatomic,copy) NSString *  PriceSquare;//	平方单价
@property (nonatomic,copy) NSString *  CostOfPaper ;//原纸平方单价
@property (nonatomic,copy) NSString *  NetEdgeSize ;//净边尺寸
@property (nonatomic,copy) NSString *  PriceNetEdge ;//净边计价
@property (nonatomic,copy) NSString *  CantDiscount ;;//	不可折
@property (nonatomic,copy) NSString *  ChangePrice ;//	改价
@property (nonatomic,copy) NSString * StockCode ;//采购号
@property (nonatomic,copy) NSString *  OrderType;//订单类型
@property (nonatomic,copy) NSString *  ProduceRemark;//生产说明
@property (nonatomic,copy) NSString *  ShippingRemark ;//送货说明

@property (nonatomic,copy) NSString *  PressLine ;//压线
@property (nonatomic,copy) NSString *  PressLine1 ;//	压线1
@property (nonatomic,copy) NSString * PressLine2 ;// 压线2
@property (nonatomic,copy) NSString *  PressLine3 ;// 压线3
@property (nonatomic,copy) NSString *  PressLine4 ;// 压线4
@property (nonatomic,copy) NSString *  PressLine5;//	压线5
@property (nonatomic,copy) NSString *  PressLine6 ;//	压线6
@property (nonatomic,copy) NSString *  PressLine7 ;//	压线7
@property (nonatomic,copy) NSString * PressLine8 ;//	压线8

@property (nonatomic,copy) NSString *  PressureType ;//压型
@property (nonatomic,copy) NSString *  Attention;//注意事项
@property (nonatomic,copy) NSString * ApproveMan ;//审核人
@property (nonatomic,copy) NSString *  PerSquareMeterPrice ;//	小片计价体积
@property (nonatomic,copy) NSString *  PerVolume ;//小片平方
@property (nonatomic,copy) NSString *  PerSquareMeter;//小片体积
@property (nonatomic,copy) NSString *  perWeight ;//小片重量
@property (nonatomic,copy) NSString *  PerSquareMeterFiveLayers ;//小片折五层平方
@property (nonatomic,copy) NSString *  PaperSquare ;//单平方
@property (nonatomic,copy) NSString *  BillSquare;//单体积
@property (nonatomic,copy) NSString *  BillVolume ;//单长度
@property (nonatomic,copy) NSString *  BillWeight ;//单重量
@property (nonatomic,copy) NSString *  BillPaperLength ;//单长度
@property (nonatomic,copy) NSString *  PlanSquare ;//排产平方
@property (nonatomic,copy) NSString *  PlanVolume ;//排产立方
@property (nonatomic,copy) NSString *  PlanWeight ;//理论重量
@property (nonatomic,copy) NSString *  PlanPaperLength ;//排产长度

@property (nonatomic,copy) NSString *  ReturnAmount ;//回签数
@property (nonatomic,copy) NSString *  HasChecked ;//已核单
@property (nonatomic,copy) NSString *  PriceProcess ;//加工费
@property (nonatomic,copy) NSString *  InAmount;//入库数
@property (nonatomic,copy) NSString *  TallyAmount ;//理货数
@property (nonatomic,copy) NSString *  TallyFlag ;//理货中
@property (nonatomic,copy) NSString *  PriceGroupCode ;//组报价编号
@property (nonatomic,copy) NSString *  PriceOffer ;//	平方报价
@property (nonatomic,copy) NSString *  DeductionAmount;//扣销数量
@property (nonatomic,copy) NSString *  InsertOrder ;//插单
@property (nonatomic,copy) NSString *  ProduceSequence ;//	生产次序
@property (nonatomic,copy) NSString *  ProducePlanCode ;//排产单号
@property (nonatomic,copy) NSString *  DeviceCode ;//设备编号
@property (nonatomic,copy) NSString *  TeamName ;//生产班组
@property (nonatomic,copy) NSString *  TimeBeginProduce ;//投产时间
@property (nonatomic,copy) NSString *  ProduceState ;//生产状态
@property (nonatomic,copy) NSString *  ProducePlanDate ;//排程时间
@property (nonatomic,copy) NSString *  PitCodeGroup ;//机位楞型
-(instancetype)initWithDic:(NSDictionary *)dict;
@end
