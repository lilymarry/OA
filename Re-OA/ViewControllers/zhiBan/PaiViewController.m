//
//  PaiViewController.m
//  Re-OA
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "PaiViewController.h"

@interface PaiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_SchedulingAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_SchedulingMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_SchedulingWeight;
@property (weak, nonatomic) IBOutlet UILabel *lab_NotSchedulingMeters;

@end

@implementation PaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lab_NotSchedulingMeters.text=_model.NotSchedulingMeters;
    _lab_SchedulingAmount.text=_model.SchedulingAmount;
    _lab_SchedulingMeters.text=_model.SchedulingMeters;
    _lab_SchedulingWeight.text=_model.SchedulingWeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
