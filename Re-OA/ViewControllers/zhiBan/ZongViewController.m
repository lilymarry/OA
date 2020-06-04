//
//  ZongViewController.m
//  Re-OA
//
//  Created by admin on 16/3/21.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "ZongViewController.h"
#import "DetailView.h"
#import "ScreenHelper.h"
@interface ZongViewController ()
{
    UIView *bgView ; //遮罩层
    DetailView *choseview;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *lab_TotalPitMeters;
@property (weak, nonatomic) IBOutlet UILabel *lab_TotalPitAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_TotalPitSquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReducedPitSquare;
@property (weak, nonatomic) IBOutlet UILabel *lab_CustomerNum;
@property (weak, nonatomic) IBOutlet UILabel *lab_OrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lab_DeliveryAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReturnAmount;
@property (weak, nonatomic) IBOutlet UILabel *lab_ReturnDifference ;
@property (weak, nonatomic) IBOutlet UILabel *lab_BasePaperWeight;
@property (weak, nonatomic) IBOutlet UILabel *lab_BasePaperAmount ;
@end

@implementation ZongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scrollview.contentSize=CGSizeMake(self.view.frame.size.width, 700);
    _lab_TotalPitMeters.text=_model.TotalPitMeters;
    _lab_TotalPitAmount.text=_model.TotalPitAmount;
    _lab_TotalPitSquare.text=_model.TotalPitSquare;
    _lab_ReducedPitSquare.text=_model.ReducedPitSquare;
    _lab_CustomerNum.text=_model.CustomerNum;
    _lab_OrderNum.text=_model.OrderNum;
    _lab_DeliveryAmount.text=_model.DeliveryAmount;
    _lab_ReturnAmount.text=_model.ReturnAmount;
    _lab_ReturnDifference.text=_model.ReturnDifference;
    _lab_BasePaperAmount.text=_model.BasePaperAmount;
    _lab_BasePaperWeight.text=_model.BasePaperWeight;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)detailPress:(id)sender {
    UIButton *but =(UIButton *)sender;
    switch (but.tag) {
        case 1001:
            [self showDetailViewTittle1:@"单坑米数" tittle2:@"双坑米数" tittle3:@"三坑米数" c1:_model.SinglePitMeters c2:_model.DoublePitMeters c3:_model.ThreePitMeters];
            break;
        case 1002:
            [self showDetailViewTittle1:@"单坑金额" tittle2:@"双坑金额" tittle3:@"三坑金额" c1:_model.SinglePitAmount c2:_model.DoublePitAmount c3:_model.ThreePitAmount];
            break;
        case 1003:
            [self showDetailViewTittle1:@"单坑平方" tittle2:@"双坑平方" tittle3:@"三坑平方" c1:_model.SinglePitSquare c2:_model.DoublePitSquare c3:_model.ThreePitSquare];
            break;
        default:
            break;
    }
    
}
-(void)showDetailViewTittle1:(NSString *)tittle1 tittle2:(NSString *)tittle2 tittle3:(NSString *)tittle3 c1:(NSString *)c1 c2:(NSString *)c2 c3:(NSString *)c3
{
    
    [self showThebgview];
    choseview =[[DetailView alloc]instanceChooseView];
    choseview.c1=c1;
    choseview.c2=c2;
    choseview.c3=c3;
    choseview.tittle1=tittle1;
    choseview.tittle2=tittle2;
    choseview.tittle3=tittle3;
    [choseview refresh];
    [self.view.window addSubview:choseview];

}
-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
    tapGesture.numberOfTapsRequired=1;
    [bgView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.8;
    }completion:^(BOOL finished){
        
    } ];
}
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];

    [choseview removeFromSuperview];
}
//撤销背景蒙板
-(void)hidThebgview{
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}



@end
