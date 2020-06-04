//
//  ZhiBanItemViewController.m
//  Re-OA
//
//  Created by imac-1 on 2017/2/17.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "ZhiBanItemViewController.h"
#import "UserPermission.h"
#import "OrderSummaryViewController1.h"
@interface ZhiBanItemViewController ()
{   NSArray *storyboardIDArr;
    NSString *quanXianId;
    NSString *quanXianId1;
}
@end

@implementation ZhiBanItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ( self.view.frame.size.height==812)
    {
       self.navigationController.navigationBar.translucent = NO;
    }
    
    storyboardIDArr=[NSArray arrayWithObjects:@"jyhz",@"ywydd",@"skmx",@"thmx",@"lhtj",@"mrxdtj",@"ywymrdd",@"yzcc",nil];
    quanXianId=@"";
    quanXianId1=@"aaaaa";
    
}
- (IBAction)lastPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnpress:(id)sender {
    UIButton *but=(UIButton *)sender;
    switch (but.tag-1000)
    {
        case 1:
        {
            quanXianId=@"jyhz";
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
        }break;
        case 2:
        {
            quanXianId=@"ywydd";
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
            
        }break;
        case 3:
        {
            quanXianId=@"skmx";
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
        }break;
        case 4:
        {
            quanXianId=@"thmx";
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
            
        }break;
        case 5:
        {
            quanXianId=@"lhtj";
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
            
        }break;
        case 6:
        {
            quanXianId=@"mrxdtj";
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
            
        }break;
        case 7:
        {
            quanXianId=@"ywymrdd";
            quanXianId1=@"ywymrddqb";
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
            
        }break;
        case 8:
        {
            quanXianId=@"yzcc";
      
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
            
        }break;
    }
  
    
    
}
-(void)pushShangBaoliuViewControllerWithButtonTag:(int )tag
{
   
    
    NSString *menuKey= [UserPermission standartUserInfo].MenuRole;
    if (tag==7) {
    NSRange range= [ menuKey rangeOfString:@"ywymrddqb"];
  
    if ( range.location == NSNotFound)
    {
        NSRange range1= [ menuKey rangeOfString:@"ywymrdd"];
        if ( range1.location == NSNotFound) {
            [self showAlertView];
        }
        else
        {
             [self gotoOrderSummaryViewController1WithQuanXianId:@"ywymrdd"];
        }
    
    }
    else
    {
        [self gotoOrderSummaryViewController1WithQuanXianId:@"ywymrddqb"];

    }
    
    }
    else
    {
       NSRange range= [ menuKey rangeOfString:quanXianId];
        if ( range.location == NSNotFound)
        {
           
            [self showAlertView];
            
        }
      
        else
        {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"ZhiBan" bundle:[NSBundle mainBundle]];
            UIViewController *changyongController = [story instantiateViewControllerWithIdentifier:storyboardIDArr[tag -1]];
          
            [self.navigationController pushViewController:changyongController animated:YES];
     }

    
 

    }

}
-(void)showAlertView
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提醒"
                                                  message:@"您没有访问该模块的权限"
                                                 delegate:self
                                        cancelButtonTitle:@"知道了"
                                        otherButtonTitles: nil];
    [alert show];

}
-(void)gotoOrderSummaryViewController1WithQuanXianId:(NSString *)quid
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"ZhiBan" bundle:[NSBundle mainBundle]];
    OrderSummaryViewController1 *changyongController = [story instantiateViewControllerWithIdentifier:storyboardIDArr[6]];
    changyongController.quanXianId1=quid;
    [self.navigationController pushViewController:changyongController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
