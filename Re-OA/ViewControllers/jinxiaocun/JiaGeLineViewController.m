//
//  JiaGeLineViewController.m
//  Re-OA
//
//  Created by imac-1 on 2017/9/6.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "JiaGeLineViewController.h"

@interface JiaGeLineViewController ()

@end

@implementation JiaGeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)gotoLastView:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
