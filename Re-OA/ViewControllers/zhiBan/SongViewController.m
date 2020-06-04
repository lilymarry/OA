//
//  SongViewController.m
//  Re-OA
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "SongViewController.h"

@interface SongViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryWeight;
@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReturnAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReturnDifference ;

@property (weak, nonatomic) IBOutlet UILabel *lab_DeliverySquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_DeliverySaleSquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryVolume ;



@end

@implementation SongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lab_DeliveryAmount.text=_model.DeliveryAmount;
    _lab_DeliveryWeight.text=_model.DeliveryWeight;
    _lab_ReturnAmount.text=_model.ReturnAmount;
    _lab_ReturnDifference.text=_model.ReturnDifference;
    _lab_DeliverySquare.text=_model.DeliverySquare;
    _lab_DeliverySaleSquare.text=_model.DeliverySaleSquare;
    _lab_DeliveryVolume.text=_model.DeliveryVolume;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
