//
//  PaperBoardOrderExModel.m
//  Re-OA
//
//  Created by admin on 16/3/29.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaperBoardOrderExModel.h"

@implementation PaperBoardOrderExModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.ItemTotal=dict[@"ItemTotal"];
        self.SID= dict[@"SID"] ;
        self.OrderCode= dict[@"OrderCode"] ;
        self.Anxious=dict[@"Anxious"];
        
        self.CustomCode= dict[@"CustomCode"];
        self.CustomName=dict[@"CustomName"];
        self.Abbreviation=dict[@"Abbreviation"];
        self.Area= dict[@"Area"];
        self.BusinessMan= dict[@"BusinessMan"] ;
        self.DistcountCash=dict[@"DistcountCash"];
        
        self.Address=dict[@"Address"];
        self.RateFreight=dict[@"RateFreight"];
        
        self.Mileage=dict[@"Mileage"];
        self.PinYin= dict[@"PinYin"];
        self.StorageArea= dict[@"StorageArea"] ;
        self.RateOfDistinct= dict[@"RateOfDistinct"] ;
        
        self.PaperBoardCode=dict[@"PaperBoardCode"];
        self.CodePaperEquip= dict[@"CodePaperEquip"];
        
        
        self.PaperBoardCodeProduce= dict[@"PaperBoardCodeProduce"] ;
        self.CodePaperEquipProduce=dict[@"CodePaperEquipProduce"];
        self.PitCode=dict[@"PitCode"];
        self.Layer= dict[@"Layer"];
        self.SchedulingClass= dict[@"SchedulingClass"] ;
        self.Height=dict[@"Height"];
        self.BaseWeight=dict[@"BaseWeight"];
        self.Spec=dict[@"Spec"];
        self.SpecEx= dict[@"SpecEx"] ;
        self.PricSpec=dict[@"PricSpec"];
        self.ProduceSpec= dict[@"ProduceSpec"];
        
        
        self.PaperKai=dict[@"PaperKai"];
        self.Degree= dict[@"Degree"] ;
        self.SetMan= dict[@"SetMan"] ;
        self.SetDate=dict[@"SetDate"];
        
        self.UpdateDate= dict[@"UpdateDate"];
        self.UpdateMan=dict[@"UpdateMan"];
        self.DeliveryDate=dict[@"DeliveryDate"];
        self.PaperBoardWidth= dict[@"PaperBoardWidth"];
        self.PaperBoardLength= dict[@"PaperBoardLength"] ;
        self.PaperBoardWidthPrice=dict[@"PaperBoardWidthPrice"];
        
        self.PaperWidth=dict[@"PaperWidth"];
        self.TheEdge=dict[@"TheEdge"];
        
        self.PlusMm=dict[@"PlusMm"];
        self.Amount= dict[@"Amount"];
        self.MaterialAmount= dict[@"MaterialAmount"] ;
        self.LargeAmount= dict[@"LargeAmount"] ;
        self.SendNum=dict[@"SendNum"];
        self.AmountToProduce= dict[@"AmountToProduce"];
        
        //self.PlanWeight=dict[@"PlanWeight"];
        self.PricePaperBoard= dict[@"PricePaperBoard"] ;
        self.PriceSquare=dict[@"PriceSquare"];
        self.CostOfPaper=dict[@"CostOfPaper"];
        self.NetEdgeSize= dict[@"NetEdgeSize"];
        self.PriceNetEdge= dict[@"PriceNetEdge"] ;
        self.CantDiscount=dict[@"CantDiscount"];
        
        self.CustomCode=dict[@"CustomCode"];
        self.Abbreviation= dict[@"Abbreviation"] ;
        self.ChangePrice=dict[@"ChangePrice"];
        self.StockCode= dict[@"StockCode"];
        self.OrderType= dict[@"OrderType"] ;
        
        self.ProduceRemark=dict[@"ProduceRemark"];
        self.ShippingRemark= dict[@"ShippingRemark"] ;
        self.PressLine=dict[@"PressLine"];
        self.PressLine1= dict[@"PressLine1"];
        self.PressLine2= dict[@"PressLine2"] ;
            self.PressLine3=dict[@"PressLine3"];
            self.PressLine4=dict[@"PressLine4"];
            self.PressLine5=dict[@"PressLine5"];
            self.PressLine6=dict[@"PressLine6"];
            self.PressLine7=dict[@"PressLine7"];
            self.PressLine8=dict[@"PressLine8"];
        
        
        self.PressureType=dict[@"PressureType"];
        self.Attention= dict[@"Attention"] ;
        self.ApproveMan= dict[@"ApproveMan"] ;
        self.PerSquareMeterPrice=dict[@"PerSquareMeterPrice"];
        
        self.PerVolume= dict[@"PerVolume"];
        self.PerSquareMeter=dict[@"PerSquareMeter"];
        self.PaperBoardLength=dict[@"PaperBoardLength"];
        self.perWeight= dict[@"perWeight"];
        self.PerSquareMeterFiveLayers= dict[@"PerSquareMeterFiveLayers"] ;
        self.PaperSquare=dict[@"PaperSquare"];
        
        self.BillSquare=dict[@"BillSquare"];
        self.BillVolume=dict[@"BillVolume"];
        
        self.BillWeight=dict[@"BillWeight"];
        self.BillPaperLength= dict[@"BillPaperLength"];
        self.PlanSquare= dict[@"PlanSquare"] ;
        self.PlanVolume= dict[@"PlanVolume"] ;
        self.PlanWeight=dict[@"PlanWeigh"];
        self.PlanPaperLength= dict[@"PlanPaperLength"];
        
        
        self.ReturnAmount= dict[@"ReturnAmount"] ;
        self.HasChecked=dict[@"HasChecked"];
        self.PriceProcess=dict[@"PriceProcess"];
        self.InAmount= dict[@"InAmount"];
        self.TallyAmount= dict[@"TallyAmount"] ;
        self.TallyFlag=dict[@"TallyFlag"];
        
        self.CustomCode=dict[@"CustomCode"];
        self.Abbreviation= dict[@"Abbreviation"] ;
        self.PriceGroupCode=dict[@"PriceGroupCode"];
        self.PriceOffer= dict[@"PriceOffer"];
        self.DeductionAmount= dict[@"DeductionAmount"] ;
        
        self.InsertOrder=dict[@"InsertOrder"];
        self.ProduceSequence= dict[@"ProduceSequence"] ;
        self.ProducePlanCode=dict[@"ProducePlanCode"];
        self.DeviceCode= dict[@"DeviceCode"];
        self.TeamName= dict[@"TeamName"] ;
        self.TimeBeginProduce=dict[@"TimeBeginProduce"];
        self.ProduceState= dict[@"ProduceState"] ;
        self.ProducePlanDate=dict[@"ProducePlanDate"];
        self.PitCodeGroup= dict[@"PitCodeGroup"];

    }
    return self;
}

@end
