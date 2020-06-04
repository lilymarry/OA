//
//  YuanViewController.m
//  Re-OA
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "YuanViewController.h"

@interface YuanViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_WorkBackWeight;
@property (weak, nonatomic) IBOutlet UILabel *lab_WorkBackAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_InventoryLossWeight;
@property (weak, nonatomic) IBOutlet UILabel *lab_InventoryLossAmount ;
@property (weak, nonatomic) IBOutlet UILabel *lab_BasePaperWeight;
@property (weak, nonatomic) IBOutlet UILabel *lab_BasePaperAmount ;
@end

@implementation YuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lab_BasePaperAmount.text=_model.BasePaperAmount;
    _lab_BasePaperWeight.text=_model.BasePaperWeight;
    
    _lab_WorkBackAmount.text=_model.WorkBackAmount;
    _lab_WorkBackWeight.text=_model.WorkBackWeight;
    
    _lab_InventoryLossAmount.text=_model.InventoryLossAmount;
    _lab_InventoryLossWeight.text=_model.InventoryLossWeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
