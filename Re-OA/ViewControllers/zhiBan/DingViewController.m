//
//  DingViewController.m
//  Re-OA
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "DingViewController.h"

@interface DingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_SinglePitMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_SinglePitAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_SinglePitSquare;

@property (weak, nonatomic) IBOutlet UILabel *lab_DoublePitMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_DoublePitAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_DoublePitSquare;

@property (weak, nonatomic) IBOutlet UILabel *lab_ThreePitMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_ThreePitAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_ThreePitSquare;

@property (weak, nonatomic) IBOutlet UILabel *lab_TwoLayersMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_TwoLayersAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_TwoLayersSquare;

@property (weak, nonatomic) IBOutlet UILabel *lab_ThreeLayersMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_ThreeLayersAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_ThreeLayersSquare;

@property (weak, nonatomic) IBOutlet UILabel *lab_FourLayersMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_FourLayersAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_FourLayersSquare;

@property (weak, nonatomic) IBOutlet UILabel *lab_FiveLayersMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_FiveLayersAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_FiveLayersSquare;

@property (weak, nonatomic) IBOutlet UILabel *lab_SevenLayersMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_SevenLayersAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_SevenLayersSquare;


@property (weak, nonatomic) IBOutlet UILabel *lab_TotalPitMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_TotalPitAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_TotalPitSquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReducedPitSquare;


@property (weak, nonatomic) IBOutlet UILabel *lab_CustomerNum;
@property (weak, nonatomic) IBOutlet UILabel *lab_OrderNum;

@end

@implementation DingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lab_SinglePitAmount.text=_model.SinglePitAmount;
    _lab_SinglePitMeters.text=_model.SinglePitMeters;
    _lab_SinglePitSquare.text=_model.SinglePitSquare;
    
    _lab_DoublePitAmount.text=_model.DoublePitAmount;
    _lab_DoublePitMeters.text=_model.DoublePitMeters;
    _lab_DoublePitSquare.text=_model.DoublePitSquare;
    
    _lab_ThreePitAmount.text=_model.ThreePitAmount;
    _lab_ThreePitMeters.text=_model.ThreePitMeters;
    _lab_ThreePitSquare.text=_model.ThreePitSquare;
    
    
    _lab_TwoLayersAmount.text=_model.TwoLayersAmount;
    _lab_TwoLayersMeters.text=_model.TwoLayersMeters;
    _lab_TwoLayersSquare.text=_model.TwoLayersSquare;
    
    
    _lab_ThreeLayersAmount.text=_model.ThreeLayersAmount;
    _lab_ThreeLayersMeters.text=_model.ThreeLayersMeters;
    _lab_ThreeLayersSquare.text=_model.ThreeLayersSquare;
    
    _lab_FourLayersAmount.text=_model.FourLayersAmount;
    _lab_FourLayersMeters.text=_model.FourLayersMeters;
    _lab_FourLayersSquare.text=_model.FourLayersSquare;
    
    _lab_FiveLayersAmount.text=_model.FiveLayersAmount;
    _lab_FiveLayersMeters.text=_model.FiveLayersMeters;
    _lab_FiveLayersSquare.text=_model.FiveLayersSquare;
    
    _lab_SevenLayersAmount.text=_model.SevenLayersAmount;
    _lab_SevenLayersMeters.text=_model.SevenLayersMeters;
    _lab_SevenLayersSquare.text=_model.SevenLayersSquare;
    
    _lab_TotalPitAmount.text=_model.TotalPitAmount;
    _lab_TotalPitMeters.text=_model.TotalPitMeters;
    _lab_TotalPitSquare.text=_model.TotalPitSquare;
    _lab_ReducedPitSquare.text=_model.ReducedPitSquare;
    _lab_CustomerNum.text=_model.CustomerNum;
    _lab_OrderNum.text=_model.OrderNum;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
