//
//  TallyViewCell.h
//  Re-OA
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TallyViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_State ;
@property (weak, nonatomic) IBOutlet UILabel *lab_StateApprove ;
@property (weak, nonatomic) IBOutlet UILabel *lab_SetMan;
@property (weak, nonatomic) IBOutlet UILabel *lab_TallyMan;
@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryMan;
@property (weak, nonatomic) IBOutlet UILabel *lab_PrintMan ;
@property (weak, nonatomic) IBOutlet UILabel *lab_Stevedore ;
@property (weak, nonatomic) IBOutlet UILabel *lab_Code   ;

@property (weak, nonatomic) IBOutlet UILabel *lab_SetDate  ;
@property (weak, nonatomic) IBOutlet UILabel *lab_PrintTime ;

@property (weak, nonatomic) IBOutlet UILabel *lab_VehicleCode ;
@property (weak, nonatomic) IBOutlet UILabel *lab_Driver ;

@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryDate;
@property (weak, nonatomic) IBOutlet UILabel *lab_RateFreight ;

@property (weak, nonatomic) IBOutlet UILabel *lab_Freight;
@property (weak, nonatomic) IBOutlet UILabel *lab_TheoryFreight ;
@property (weak, nonatomic) IBOutlet UILabel *lab_PlateNumber  ;



@property (weak, nonatomic) IBOutlet UILabel *lab_CustomAmount ;
@property (weak, nonatomic) IBOutlet UILabel *lab_Mileage ;

@property (weak, nonatomic) IBOutlet UILabel *lab_MoneyDelivery   ;

@property (weak, nonatomic) IBOutlet UILabel *lab_Volume ;
@property (weak, nonatomic) IBOutlet UILabel *lab_VolumePrice ;

@property (weak, nonatomic) IBOutlet UILabel *lab_Weight ;
@property (weak, nonatomic) IBOutlet UILabel *lab_fnGetTallyCustomName ;

@property (weak, nonatomic) IBOutlet UILabel *lab_Mobile ;
@property (weak, nonatomic) IBOutlet UILabel *lab_OrderAmount ;

@property (weak, nonatomic) IBOutlet UILabel *lab_ReturnAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReturnTime;


@property (weak, nonatomic) IBOutlet UILabel *lab_HasDelivery ;
@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryHasPrinted  ;


@property (weak, nonatomic) IBOutlet UILabel *lab_HasFreight ;
@property (weak, nonatomic) IBOutlet UILabel *lab_SquareAmount ;

@property (weak, nonatomic) IBOutlet UILabel *lab_SquareFiveLayers  ;

@property (weak, nonatomic) IBOutlet UILabel *lab_SquareFiveLayersPrice ;

@property (weak, nonatomic) IBOutlet UILabel *lab_FreightSquare ;


@property (weak, nonatomic) IBOutlet UILabel *lab_TheoryFreightSquare ;

@property (weak, nonatomic) IBOutlet UILabel *lab_CustomSubsidy ;
@property (weak, nonatomic) IBOutlet UILabel *lab_OrderSubsidy ;

@property (weak, nonatomic) IBOutlet UILabel *lab_Remark;
@property (weak, nonatomic) IBOutlet UILabel *lab_Sequence ;

@property (weak, nonatomic) IBOutlet UILabel *lab_BillAmount ;

@property (weak, nonatomic) IBOutlet UILabel *lab_FreightByCustomOnly;
@property (weak, nonatomic) IBOutlet UILabel *lab_RateByCustomOnly ;

@property (weak, nonatomic) IBOutlet UILabel *lab_SID;
@property (weak, nonatomic) IBOutlet UILabel *lab_num;

@end
