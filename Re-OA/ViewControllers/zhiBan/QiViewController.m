//
//  QiViewController.m
//  Re-OA
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "QiViewController.h"

@interface QiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_RecieveAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_OtherSales;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReturnGoodsAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_DebitAmount ;
@property (weak, nonatomic) IBOutlet UILabel *lab_GrossProfit ;
@property (weak, nonatomic) IBOutlet UILabel *lab_GrossProfitTwo;
@property (weak, nonatomic) IBOutlet UILabel *lab_GrossProfitThree;
@property (weak, nonatomic) IBOutlet UILabel *lab_ActualSales;
@property (weak, nonatomic) IBOutlet UILabel *lab_EstimatedProfit;
@property (weak, nonatomic) IBOutlet UILabel *lab_EstimatedProfitTwo;
@property (weak, nonatomic) IBOutlet UILabel *lab_Freight;
@property (weak, nonatomic) IBOutlet UILabel *lab_ShareAmount ;
@property (weak, nonatomic) IBOutlet UILabel *lab_AuxiliaryAmount;
@end

@implementation QiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lab_RecieveAmount.text=_model.RecieveAmount;
    _lab_OtherSales.text=_model.OtherSales;
    _lab_ReturnGoodsAmount.text=_model.ReturnGoodsAmount;
    _lab_DebitAmount.text=_model.DebitAmount;
    _lab_GrossProfit.text=_model.GrossProfit;
    _lab_GrossProfitTwo.text=_model.GrossProfitTwo;
    _lab_GrossProfitThree.text=_model.GrossProfitThree;
    
    _lab_ActualSales.text=_model.ActualSales;
    _lab_EstimatedProfit.text=_model.EstimatedProfit;
    _lab_EstimatedProfitTwo.text=_model.EstimatedProfitTwo;
    _lab_Freight.text=_model.Freight;
    _lab_ShareAmount.text=_model.ShareAmount;
    _lab_AuxiliaryAmount.text=_model.AuxiliaryAmount;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
