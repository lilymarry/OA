//
//  BoardReturnModel.m
//  Re-OA
//
//  Created by 123 on 16/3/13.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "BoardReturnModel.h"

@implementation BoardReturnModel
-(instancetype)initWithDic:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.Code=dict[@"Code"];
        self.Date=dict[@"Date"];
        self.DeliveryCode= dict[@"DeliveryCode"];
        self.OrderCode= dict[@"OrderCode"] ;
        self.PbrAmount=dict[@"PbrAmount"];
        self.Money=dict[@"Money"];
        self.Freight=dict[@"Freight"];
        self.FreightSquare= dict[@"FreightSquare"] ;
        self.MoneyRateOfDiscount=dict[@"MoneyRateOfDiscount"];
        self.Reason= dict[@"Reason"];
        self.PricePaperBoard= dict[@"PricePaperBoard"] ;
        self.CustomCode= dict[@"CustomCode"] ;
        self.Abbreviation=dict[@"Abbreviation"];
        self.CustomName= dict[@"CustomName"];
        self.PaperBoardCode= dict[@"PaperBoardCode"] ;
        
        
        
        self.RateOfDiscount=dict[@"RateOfDiscount"];
        self.PaperBoardWidth=dict[@"PaperBoardWidth"];
        self.PaperBoardLength= dict[@"PaperBoardLength"];
        self.PerVolumeAmount= dict[@"PerVolumeAmount"] ;
        self.PerSquareMeterAmount=dict[@"PerSquareMeterAmount"];
   self.PerSquareMeterFiveLayersAmount=dict[@"PerSquareMeterFiveLayersAmount"];
        self.PricSpec=dict[@"PricSpec"];
        
        self.SpecEx= dict[@"SpecEx"] ;
        self.MastPerson=dict[@"MastPerson"];
        self.SecondPerson= dict[@"SecondPerson"];
        self.PlateNumber= dict[@"PlateNumber"] ;
        self.PlateNumberEx= dict[@"PlateNumberEx"] ;
        self.Driver=dict[@"Driver"];
        self.State= dict[@"State"];
        self.SetDate= dict[@"SetDate"] ;
        
        
        self.SetMan=dict[@"SetMan"];
        self.ProcessMode=dict[@"ProcessMode"];
        self.PboAmount= dict[@"PboAmount"];
        self.TimeBeginProduce= dict[@"TimeBeginProduce"] ;
        self.TeamName=dict[@"TeamName"];
        self.ReturnAmount=dict[@"ReturnAmount"];
        self.PitCode=dict[@"PitCode"];
        self.DeliveryMan= dict[@"DeliveryMan"] ;
        
        self.SID= dict[@"SID"] ;
                self.ItemTotal=dict[@"ItemTotal"];
    }
    return self;
}
@end
