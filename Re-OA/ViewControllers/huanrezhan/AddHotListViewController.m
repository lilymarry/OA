//
//  AddHotListViewController.m
//  Re-OA
//
//  Created by imac-1 on 2016/12/28.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "AddHotListViewController.h"
#import "ScreenHelper.h"
#import "ChooseDateView.h"
#import "SelectPerViewController.h"
#import "ChangeHostWebAPI.h"
#import "UserPermission.h"
#import "AlertHelper.h"
@interface AddHotListViewController ()<RenWuDateChooseDelegate,UITextFieldDelegate,UIActionSheetDelegate,UITextViewDelegate>
{
  ChooseDateView *ch_deDay;
    NSString*uid;
}
@property (weak, nonatomic) IBOutlet UILabel *personLable;
@property (weak, nonatomic) IBOutlet UITextField *txf_date;
@property (weak, nonatomic) IBOutlet UITextField *tf_area;
@property (weak, nonatomic) IBOutlet UITextField *tf_water;
@property (weak, nonatomic) IBOutlet UITextField *tf_waterBi;
@property (weak, nonatomic) IBOutlet UITextField *tf_elec;
@property (weak, nonatomic) IBOutlet UITextField *tf_elecBi;
@property (weak, nonatomic) IBOutlet UITextField *tf_hot;
@property (weak, nonatomic) IBOutlet UITextField *tf_hotBi;
@property (weak, nonatomic) IBOutlet UITextView *tx_introduce;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *subBut;

@end

@implementation AddHotListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScroll)];
    [self.scrollView addGestureRecognizer:tap];
       [self.navigationItem setTitle:@"新增记录"];
    _scrollView.contentSize = CGSizeMake([ScreenHelper SCREEN_WIDTH],850);
    
    ch_deDay = [ChooseDateView instanceChooseDateView];
    ch_deDay.chooseDateDelegate=self;
    ch_deDay.dateId=@"1";
    _txf_date.inputView=ch_deDay;
    
    uid=@"";
    NSDate *dates= [NSDate dateWithTimeInterval:+48*60*60+8 sinceDate:[NSDate date]];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
   
     _txf_date.text= [formatter stringFromDate:dates];
    
    if ([_state isEqualToString:@"0"]) {
        _subBut.hidden=YES;
        _personLable.text=__mode.HTR_SiteName;
        _tf_area.text=__mode.HTR_M;
        _tf_water.text=__mode.HTR_Mark1;
        _tf_waterBi.text=__mode.HTR_Consumption1;
        _tf_elec.text=__mode.HTR_Mark2;
        _tf_elecBi.text=__mode.HTR_Consumption2;
        _tf_hot.text=__mode.HTR_Mark3;
        _tf_hotBi.text=__mode.HTR_Consumption3;
        _tx_introduce.text=__mode.HTR_Fault;
        _txf_date.text=__mode.HTR_Date;
        
        
           [_tf_area setEnabled:NO];
          [_tf_water setEnabled:NO];
        [_tf_waterBi setEnabled:NO];
        [_tf_elec setEnabled:NO];
        [_tf_elecBi setEnabled:NO];
        
        [_tf_hot setEnabled:NO];
        [_tf_hotBi setEnabled:NO];
        
        [_txf_date setEnabled:NO];
        
        [self.navigationItem setTitle:@"记录详情"];
        
    }

}
- (IBAction)subpress:(id)sender {
    
    if (_personLable.text.length==0) {
         [AlertHelper singleMBHUDShow:@"站名不能为空" ForView:self.view AndDelayHid:1];
    }
    else if(_txf_date.text.length==0)
    {
         [AlertHelper singleMBHUDShow:@"时间不能为空" ForView:self.view AndDelayHid:1];
    }
    else
    {
         [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
        [ChangeHostWebAPI addHotChangeHTR_Userid:[UserPermission standartUserInfo].name HTR_Username:[UserPermission standartUserInfo].name HTR_SiteName:_personLable.text HTR_M:_tf_area.text HTR_Mark1:_tf_water.text HTR_Consumption1:_tf_waterBi.text  HTR_Mark2:_tf_elec.text HTR_Consumption2:_tf_elecBi.text HTR_Mark3:_tf_hot.text HTR_Consumption3:_tf_hotBi.text HTR_Fault:_tx_introduce.text HTR_Date:_txf_date.text  HTR_Id:@"0"
 success:^(NSArray * arr) {
         [AlertHelper hideAllHUDsForView:self.view];
        if ([arr[0][@"bool"] integerValue]==1) {
            [AlertHelper singleMBHUDShow:@"提交成功" ForView:self.view  AndDelayHid:1];
            
            NSObject<CommonNotification> *tmpDele=self.refreshNotification;
            [tmpDele refreshingDataList];
            [self.navigationController popViewControllerAnimated: YES];
          
        }
        if ([arr[0][@"bool"] integerValue]==2) {
            [AlertHelper singleMBHUDShow:@"当前站点今日已存在记录" ForView:self.view  AndDelayHid:1];
            
           
        }

        else
        {
            [AlertHelper singleMBHUDShow:@"提交失败" ForView:self.view  AndDelayHid:1];
        }

    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
    }];
    }
}
- (IBAction)addPerPress:(id)sender {
    SelectPerViewController *to=[[SelectPerViewController alloc]initWithBlock:^(NSArray *names,NSArray *uids)
                             {
                                 NSMutableString *namestr=[NSMutableString string];
                                 NSMutableString *uidstr=[NSMutableString string];
                                 [names enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                                  {
                                      [namestr appendString:[NSString stringWithFormat:@"%@,",obj]];
                                  }];
                                 [uids enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                     [uidstr appendString:[NSString stringWithFormat:@"%@,",obj]];
                                 }];
                                 if (uidstr.length!=0&&namestr.length!=0)
                                 {
                                      uid= [uidstr substringToIndex:uidstr.length-1];
                                    _personLable.text= [namestr substringToIndex:namestr.length-1];
                                 }
                             }];
    [self.navigationController pushViewController:to animated:YES];
}
-(void)tapScroll
{
    
    
    [_txf_date resignFirstResponder];
    [_tf_area resignFirstResponder];
    [_tf_water resignFirstResponder];
    [_tf_waterBi resignFirstResponder];
    [_tf_elec resignFirstResponder];
    [_tf_elecBi resignFirstResponder];
    [_tf_hot resignFirstResponder];
    [_tf_hotBi resignFirstResponder];
    [_tx_introduce resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    //设定动画持续时间
    [UIView setAnimationDuration:0.3];
    // _scrollView.frame = CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT]+200);
    _scrollView.contentSize = CGSizeMake([ScreenHelper SCREEN_WIDTH],850);
    [_scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
    
    //动画结束
    [UIView commitAnimations];
    
    
    
    
}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid
       {
        _txf_date.text= dateStr;
        
        [_txf_date resignFirstResponder];
        [self  tapScroll];
  
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    // foucsTextField = textField;
    _scrollView.contentSize = CGSizeMake([ScreenHelper SCREEN_WIDTH],850 +216);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:_scrollView];//把当前的textField的坐标映射到scrollview上
    if(_scrollView.contentOffset.y-pt.y+64<=0)//判断最上面不要去滚动
        [_scrollView setContentOffset:CGPointMake(0, pt.y-64) animated:YES];//华东
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _scrollView.contentSize = CGSizeMake([ScreenHelper SCREEN_WIDTH],850 +216);//原始滑动距离增加键盘高度
    CGPoint pt = [textView convertPoint:CGPointMake(0, 0) toView:_scrollView];//把当前的textField的坐标映射到scrollview上
    if(_scrollView.contentOffset.y-pt.y+64<=0)//判断最上面不要去滚动
        [_scrollView setContentOffset:CGPointMake(0, pt.y-64) animated:YES];//华东
    
    
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
