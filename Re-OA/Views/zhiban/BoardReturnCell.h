//
//  BoardReturnCell.h
//  Re-OA
//
//  Created by admin on 16/3/14.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardReturnCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab_Code ;
@property (weak, nonatomic) IBOutlet UILabel *lab_Date ;


@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryCode;
@property (weak, nonatomic) IBOutlet UILabel *lab_OrderCode;
@property (weak, nonatomic) IBOutlet UILabel *lab_PbrAmount;



@property (weak, nonatomic) IBOutlet UILabel *lab_Money ;
@property (weak, nonatomic) IBOutlet UILabel *lab_Freight ;

@property (weak, nonatomic) IBOutlet UILabel *lab_FreightSquare  ;

@property (weak, nonatomic) IBOutlet UILabel *lab_MoneyRateOfDiscount ;
@property (weak, nonatomic) IBOutlet UILabel *lab_Reason ;

@property (weak, nonatomic) IBOutlet UILabel *lab_PricePaperBoard;


@property (weak, nonatomic) IBOutlet UILabel *lab_CustomCode ;

@property (weak, nonatomic) IBOutlet UILabel *lab_Abbreviation;
@property (weak, nonatomic) IBOutlet UILabel *lab_CustomName ;

@property (weak, nonatomic) IBOutlet UILabel *lab_PaperBoardCode;
@property (weak, nonatomic) IBOutlet UILabel *lab_RateOfDiscount ;
@property (weak, nonatomic) IBOutlet UILabel *lab_PaperBoardWidth  ;



@property (weak, nonatomic) IBOutlet UILabel *lab_PaperBoardLength ;
@property (weak, nonatomic) IBOutlet UILabel *lab_PerVolumeAmount ;

@property (weak, nonatomic) IBOutlet UILabel *lab_PerSquareMeterAmount  ;



@property (weak, nonatomic) IBOutlet UILabel *lab_PerSquareMeterFiveLayersAmount ;////////////


@property (weak, nonatomic) IBOutlet UILabel *lab_PricSpec ;

@property (weak, nonatomic) IBOutlet UILabel *lab_SpecEx ;
@property (weak, nonatomic) IBOutlet UILabel *lab_MastPerson ;

@property (weak, nonatomic) IBOutlet UILabel *lab_SecondPerson;
@property (weak, nonatomic) IBOutlet UILabel *lab_PlateNumber ;


@property (weak, nonatomic) IBOutlet UILabel *lab_PlateNumberEx;
@property (weak, nonatomic) IBOutlet UILabel *lab_Driver ;
@property (weak, nonatomic) IBOutlet UILabel *lab_State  ;


@property (weak, nonatomic) IBOutlet UILabel *lab_SetDate ;
@property (weak, nonatomic) IBOutlet UILabel *lab_SetMan ;



@property (weak, nonatomic) IBOutlet UILabel *lab_ProcessMode  ;

@property (weak, nonatomic) IBOutlet UILabel *lab_PboAmount ;
@property (weak, nonatomic) IBOutlet UILabel *lab_TimeBeginProduce ;

@property (weak, nonatomic) IBOutlet UILabel *lab_TeamName ;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReturnAmount ;

@property (weak, nonatomic) IBOutlet UILabel *lab_PitCode;
@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryMan ;

@property (weak, nonatomic) IBOutlet UILabel *lab_SID;
@property (weak, nonatomic) IBOutlet UILabel *lab_num;

@end
