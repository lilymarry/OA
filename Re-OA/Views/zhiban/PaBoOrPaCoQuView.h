//
//  PaBoOrPaCoQuView.h
//  Re-OA
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaBoOrPaCoQuView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lab_tittle1;
@property (weak, nonatomic) IBOutlet UILabel *lab_tittle2;
@property (weak, nonatomic) IBOutlet UILabel *lab_tittle3;
@property (weak, nonatomic) IBOutlet UILabel *lab_tittle4;
@property (weak, nonatomic) IBOutlet UILabel *lab_c1;
@property (weak, nonatomic) IBOutlet UILabel *lab_c2;
@property (weak, nonatomic) IBOutlet UILabel *lab_c3;
@property (weak, nonatomic) IBOutlet UILabel *lab_c4;
@property (strong, nonatomic)NSString *c1;
@property (strong, nonatomic)NSString  *c2;
@property (strong, nonatomic) NSString  *c3;
@property (strong, nonatomic) NSString  *c4;
@property (strong, nonatomic)NSString *tittle1;
@property (strong, nonatomic)NSString  *tittle2;
@property (strong, nonatomic) NSString  *tittle3;
@property (strong, nonatomic) NSString  *tittle4;

-(void)refresh;
-(PaBoOrPaCoQuView  *)instanceChooseView;
@end
