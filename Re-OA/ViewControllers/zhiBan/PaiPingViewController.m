//
//  PaiPingViewController.m
//  Re-OA
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaiPingViewController.h"
@interface PaiPingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_TwoLayersSchedulingSquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_ThreeLayersSchedulingSquar;
@property (weak, nonatomic) IBOutlet UILabel *lab_FourLayersSchedulingSquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_FiveLayersSchedulingSquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_SixLayersSchedulingSquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_SevenLayersSchedulingSquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_TotalLayersSchedulingSquare;
@end

@implementation PaiPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lab_TwoLayersSchedulingSquare.text=_pmodel.TwoLayersSchedulingSquare;
    _lab_ThreeLayersSchedulingSquar.text=_pmodel.ThreeLayersSchedulingSquare;
    _lab_FourLayersSchedulingSquare.text=_pmodel.FourLayersSchedulingSquare;
    _lab_FiveLayersSchedulingSquare.text=_pmodel.FiveLayersSchedulingSquare;
    _lab_SixLayersSchedulingSquare.text=_pmodel.SixLayersSchedulingSquare;
    _lab_SevenLayersSchedulingSquare.text=_pmodel.SevenLayersSchedulingSquare;
    _lab_TotalLayersSchedulingSquare.text=_pmodel.TotalLayersSchedulingSquare;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
