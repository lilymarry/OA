//
//  HotLineViewController.m
//  Re-OA
//
//  Created by imac-1 on 2017/1/4.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "HotLineViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SelectPerViewController.h"
#import "ChooseDateView.h"
#import "ChangeHostWebAPI.h"
#import "ScreenHelper.h"
#import "AlertHelper.h"
@interface HotLineViewController ()<UIWebViewDelegate,RenWuDateChooseDelegate>
{
    ChooseDateView *date1;
    ChooseDateView *date2;
    NSString *method;
    NSString *tittle;
    NSString *danWei;
    
    NSString *biaoZhunLine;
    NSString *shijiLine;
    NSString *timestr;
    
    //  NSURLRequest *request;
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITextField *tf_st;
@property (weak, nonatomic) IBOutlet UITextField *tf_et;
@property (strong, nonatomic)  UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (strong, nonatomic) JSContext *context;
@end

@implementation HotLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    date1 = [ChooseDateView instanceChooseDateView];
    date1.chooseDateDelegate=self;
    date1.dateId=@"1";
    _tf_st.inputView=date1;
    
    date2 = [ChooseDateView instanceChooseDateView];
    date2.chooseDateDelegate=self;
    date2.dateId=@"2";
    _tf_et.inputView=date2;
    
    NSDate *dates= [NSDate dateWithTimeInterval:-24*60*60*30 sinceDate:[NSDate date]];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
     NSDate *date=[NSDate date];
     _tf_st.text= [formatter stringFromDate:dates];
     _tf_et.text= [formatter stringFromDate:date];
    
    method=@"Running_Chart_Water";
    tittle=@"水耗";
    danWei=@"kg/㎡";
}
- (IBAction)selectNamePress:(id)sender {
    
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
                                         //   uid= [uidstr substringToIndex:uidstr.length-1];
                                         _lab_name.text= [namestr substringToIndex:namestr.length-1];
                                     }
                                 }];
    [self.navigationController pushViewController:to animated:YES];
    
}
-(void)chooseTheDate:(NSString *)dateStr withId:(NSString *)dateid
{
    if ([dateid isEqualToString:@"1"]) {
        _tf_st.text= dateStr;
        
        [_tf_st resignFirstResponder];
        
    }
    else
    {
        _tf_et.text= dateStr;
        
        [_tf_et resignFirstResponder];
        
    }
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)surePress:(id)sender {
    
    if ([_lab_name.text isEqualToString:@"选择站点"]) {
        [AlertHelper singleMBHUDShow:@"请选择站点" ForView:self.view  AndDelayHid:1];

    }
    else
    {
    [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [ChangeHostWebAPI requestlineWithMethod:method getSiteName:_lab_name.text getStartDate:_tf_st.text getEndDate:_tf_et.text success:^(NSArray * arr) {
         [AlertHelper hideAllHUDsForView:self.view];
        [self.webView removeFromSuperview];
        
        if ([arr[0][@"bool"] integerValue]==1) {
  
        NSString * str=  arr[0][@"content"];
        if (str.length>0) {
                
         
        NSArray *array = [str componentsSeparatedByString:@"|"];
        
        timestr=array[0];
        biaoZhunLine=array[1];
        shijiLine=array[2];
        
        self. webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,220, [ScreenHelper SCREEN_WIDTH], 200)];
        self.webView.delegate=self;
        [self.view addSubview:self.webView];
        
        NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"hotyunxingtu.html"];
        NSURLRequest *     request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
        [self.webView loadRequest:request];
            }}
        else
        {
           [AlertHelper singleMBHUDShow:@"无数据" ForView:self.view  AndDelayHid:1];
        
        }
        
        
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];

    }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segPress:(id)sender {
    switch ([self.segment selectedSegmentIndex]) {
        case 0:
            method=@"Running_Chart_Water";
            tittle=@"水耗";
            danWei=@"kg/㎡";
            [self.webView removeFromSuperview];
            break;
        case 1:
            method=@"Running_Chart_Power";
            tittle=@"电耗";
            danWei=@"kw.h/㎡";
            [self.webView removeFromSuperview];
            break;
        case 2:
            method=@"Running_Chart_Heat";
            tittle=@"热耗";
            danWei=@"GL/㎡";
            [self.webView removeFromSuperview];
            break;
            
        default:
            break;
    }
    
    
    
}
- (IBAction)lastPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    
    // 装载数据
    [self loadChartsData];
}


#pragma mark - Load Charts Data

- (void)loadChartsData
{
    
    
    JSValue * Yheight = [JSValue valueWithInt32:200 inContext:_context];
    _context[@"$Yheight"] = Yheight;
    _context[@"$series1"] = timestr;
    _context[@"$series2"] = biaoZhunLine;
    _context[@"$series3"] = shijiLine;
    _context[@"$charttitle"] = tittle;
    _context[@"$danwei"] = danWei;
    [AlertHelper hideAllHUDsForView:self.view];
    
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
