//
//  JsqViewController.m
//  Re-OA
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JsqViewController.h"
#import "SelectPIckView.h"
#import "ShangBaoWebAPI.h"
#import "AlertHelper.h"
@interface JsqViewController ()<okButtonDelegate>
{
    SelectPIckView *select;
    SelectPIckView *select1;
    SelectPIckView *select2;
    SelectPIckView *select3;
    SelectPIckView *select4;
    SelectPIckView *select5;
    SelectPIckView *select6;
    SelectPIckView *select7;
    NSDictionary * cengData;
    NSArray *zaizhiData;
    double num1;
    double num2;
    double num3;
    double num4;
    double num5;
    double num6;
    double num7;
    BOOL isEdit;
    double leng1;
    double leng2;
    double leng3;
    double leng4;
    double leng5;
    double leng6;
    double leng7;
    NSString *pmid1;
    NSString *pmid2;
    NSString *pmid3;
    NSString *pmid4;
    NSString *pmid5;
    NSString *pmid6;
    NSString *pmid7;
    
    NSArray *mainData;
    NSArray *xinData;
    NSArray *lengData;
    NSArray *liData;
    
    NSArray *data;
    
    NSString *jiagong;
    int num;
    NSString *clfc;//计算方法
}

@property (weak, nonatomic) IBOutlet UITextField *tf_banxing;
@property (weak, nonatomic) IBOutlet UILabel *lab_1;
@property (weak, nonatomic) IBOutlet UILabel *lab_2;
@property (weak, nonatomic) IBOutlet UILabel *lab_3;
@property (weak, nonatomic) IBOutlet UILabel *lab_4;
@property (weak, nonatomic) IBOutlet UILabel *lab_5;
@property (weak, nonatomic) IBOutlet UILabel *lab_6;
@property (weak, nonatomic) IBOutlet UILabel *lab_7;
@property (weak, nonatomic) IBOutlet UITextField *tf_1;
@property (weak, nonatomic) IBOutlet UITextField *tf_2;
@property (weak, nonatomic) IBOutlet UITextField *tf_3;
@property (weak, nonatomic) IBOutlet UITextField *tf_4;
@property (weak, nonatomic) IBOutlet UITextField *tf_5;
@property (weak, nonatomic) IBOutlet UITextField *tf_6;
@property (weak, nonatomic) IBOutlet UITextField *tf_7;
@property (weak, nonatomic) IBOutlet UILabel *lab_ref;

@property (strong, nonatomic) NSString *sunhaoLV;

@property (weak, nonatomic) IBOutlet UIImageView *imaV_1;
@property (weak, nonatomic) IBOutlet UIImageView *imaV_2;
@property (weak, nonatomic) IBOutlet UIImageView *imaV_3;
@property (weak, nonatomic) IBOutlet UIImageView *imaV_4;
@property (weak, nonatomic) IBOutlet UIImageView *imaV_5;
@property (weak, nonatomic) IBOutlet UIImageView *imaV_6;
@property (weak, nonatomic) IBOutlet UIImageView *imaV_7;

@property (weak, nonatomic) IBOutlet UIView *view_1;
@property (weak, nonatomic) IBOutlet UIView *view_2;
@property (weak, nonatomic) IBOutlet UIView *view_3;
@property (weak, nonatomic) IBOutlet UIView *view_4;
@property (weak, nonatomic) IBOutlet UIView *view_5;
@property (weak, nonatomic) IBOutlet UIView *view_6;
@property (weak, nonatomic) IBOutlet UIView *view_7;


@property (weak, nonatomic) IBOutlet UILabel *lab_re1;
@property (weak, nonatomic) IBOutlet UILabel *lab_re2;
@property (weak, nonatomic) IBOutlet UILabel *lab_re3;
@property (weak, nonatomic) IBOutlet UILabel *lab_re4;
@property (weak, nonatomic) IBOutlet UILabel *lab_re5;
@property (weak, nonatomic) IBOutlet UILabel *lab_re6;
@property (weak, nonatomic) IBOutlet UILabel *lab_re7;
@end

@implementation JsqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    jiagong=@"0";
    _sunhaoLV=[NSString string];
//    //损耗率
//    [ShangBaoWebAPI SunHaoLvWithsuccess:^(NSArray *arr){
//        @try {
//            _sunhaoLV =[NSString stringWithString:arr[0][@"lrate"]];
//        }
//        @catch (NSException *exception) {
//            [AlertHelper singleMBHUDShow:@"无数据" ForView:self.view AndDelayHid:2];
//        }
//        @finally {
//            
//        }
//        
//        
//        
//    } fail:^(){}];
    num1=0;
    num2=0;
    num3=0;
    num4=0;
    num5=0;
    num6=0;
    num7=0;
    leng1=1;
    leng2=1;
    leng3=1;
    leng4=1;
    leng5=1;
    leng6=1;
    leng7=1;
    zaizhiData=[NSArray array];
    cengData=[NSDictionary dictionary];
    
    select=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    select.state=0;
    select.delegate=self;
    self.tf_banxing.inputView=select;
    //板型名称
    [ShangBaoWebAPI zhiZhangNameWithsuccess:^(NSArray *arr){
        @try {
            data=arr[0][@"pb"];
            
            
            
            NSMutableArray *daArr=[NSMutableArray array];
            
            for (int i=0; i<[data count]; i++)
            {
                [daArr addObject:  data[i][@"pbnm"] ];
            }
            select.dataArr=daArr;
            
        }
        @catch (NSException *exception) {
            [AlertHelper singleMBHUDShow:@"无数据！" ForView:self.view AndDelayHid:2];
        }
        @finally {
            
        }
        
        
    } fail:^(){}];
    
    select1=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    select2=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    select3=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    select4=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    select5=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    select6=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    select7=[[SelectPIckView alloc]initWithFrame:CGRectMake(0, 377,   self.view.frame.size.width, 166)];
    
    select1.state=1;
    select1.delegate=self;
    self.tf_1.inputView=select1;
    
    select2.state=2;
    select2.delegate=self;
    self.tf_2.inputView=select2;
    
    select3.state=3;
    select3.delegate=self;
    self.tf_3.inputView=select3;
    
    select4.state=4;
    select4.delegate=self;
    self.tf_4.inputView=select4;
    
    select5.state=5;
    select5.delegate=self;
    self.tf_5.inputView=select5;
    
    select6.state=6;
    select6.delegate=self;
    self.tf_6.inputView=select6;
    
    select7.state=7;
    select7.delegate=self;
    self.tf_7.inputView=select7;
    
    
    
    [ShangBaoWebAPI zhibanCaiZhiWithsuccess:^(NSArray *arr){
        @try {
           // NSLog(@"WWWWW%@",arr);
            xinData=arr[0][@"pmx"];
            mainData=arr[0][@"pmm"];
            lengData=arr[0][@"pml"];
            clfc=arr[0][@"clfc"];
            _sunhaoLV =arr[0][@"lrate"];
        }
        @catch (NSException *exception) {
            [AlertHelper singleMBHUDShow:@"无数据！" ForView:self.view AndDelayHid:2];
        }
        @finally {
            
        }
        
        
    } fail:^(){}];
    
    _tf_1.hidden=YES;
    _tf_2.hidden=YES;
    _tf_3.hidden=YES;
    _tf_4.hidden=YES;
    _tf_5.hidden=YES;
    _tf_6.hidden=YES;
    _tf_7.hidden=YES;
    
    
    //隐藏 光标
    _tf_1.tintColor=[UIColor clearColor];
    _tf_2.tintColor=[UIColor clearColor];
    _tf_3.tintColor=[UIColor clearColor];
    _tf_4.tintColor=[UIColor clearColor];
    _tf_5.tintColor=[UIColor clearColor];
    _tf_6.tintColor=[UIColor clearColor];
    _tf_7.tintColor=[UIColor clearColor];
}

-(NSString *)exchangeCaizhiName :(NSString *)oldName
{
    if ([oldName isEqualToString:@"MIAN"])
    {
        return @"面";
        
    }
    else   if ([oldName isEqualToString:@"XIN"])
    {
        return @"芯";
        
    }
    else if ([oldName isEqualToString:@"LENG"])
    {
        return @"楞";
    }
    else if ([oldName isEqualToString:@"LI"])
    {
        return @"里";
    }
    else
    {
        return  @"未设置";
        
    }
}
-(NSArray *)setleiXingdata:(NSString *)str
{
    NSMutableArray *name=[NSMutableArray array];
    
    [name removeAllObjects];
    if ([str isEqualToString:@"面"]) {
        
        
        
        for (int i=0; i<mainData .count; i ++)
        {
            [ name addObject:mainData[i][@"code"] ];
            
        }
        return  name;
        
        
    }
    
    else if([str isEqualToString:@"芯"])
        
    {   [name removeAllObjects];
        
        for (int i=0; i<xinData .count; i ++)
        {
            [ name addObject:xinData[i][@"code"] ];
            
        }
        return  name;
        
        
    }
    
    else if([str isEqualToString:@"里"])
        
    {
        [name removeAllObjects];
        
        for (int i=0; i<mainData .count; i ++)
        {
            [ name addObject:mainData[i][@"code"] ];
            
        }
        return  name;
        
    }
    else  if([str isEqualToString:@"楞"])
    {
        
        [name removeAllObjects];
        
        for (int i=0; i<lengData .count; i ++)
        {
            [ name addObject:lengData[i][@"code"] ];
            
        }
        return  name;
    }
    else
    {
        return nil;
        
    }
    
}
-(NSArray *)dataWithCode:(NSString *)str
{
    if ([str isEqualToString:@"面"]) {
        
        return  mainData;
        
        
    }
    
    else if([str isEqualToString:@"芯"])
    {
        
        return  xinData;
        
        
    }
    
    else if([str isEqualToString:@"里"])
    {
        
        return mainData;
        
    }
    else{
        
        return  lengData;
    }
    
    
}

-(NSString *)setviewImage:(NSString *)str
{
    if ([str isEqualToString:@"面"]) {
        
        return  @"ic_mian.png";
        
        
    }
    
    else if([str isEqualToString:@"芯"])
    {
        
        return  @"ic_xin.png";
        
        
    }
    
    else if([str isEqualToString:@"里"])
    {
        
        return @"ic_li.png" ;
        
    }
    else if ([str isEqualToString:@"楞"])
    {
        
        return  @"ic_leng.png";
    }
    else
    {
        return nil;
    }
    
    
    
}
-(int)getviewnum:(NSDictionary *)dic
{
    int i=0;
    
    if ([[self exchangeCaizhiName:dic[@"yiway"]]isEqualToString:@"未设置"]) {
        ;
    }
    else
    {
        i++;
    }
    
    if ([[self exchangeCaizhiName:dic[@"erway"]]isEqualToString:@"未设置"]) {
        ;
    }
    else
    {
        i++;
    }
    
    if ([[self exchangeCaizhiName:dic[@"sanway"]]isEqualToString:@"未设置"]) {
        ;
    }
    else
    {
        i++;
    }
    
    if ([[self exchangeCaizhiName:dic[@"siway"]]isEqualToString:@"未设置"]) {
        ;
    }
    else
    {
        i++;
    }
    if ([[self exchangeCaizhiName:dic[@"wuway"]]isEqualToString:@"未设置"]) {
        ;
    }
    else
    {
        i++;
    }
    if ([[self exchangeCaizhiName:dic[@"liuway"]]isEqualToString:@"未设置"]) {
        ;
    }
    else
    {
        i++;
    }
    if ([[self exchangeCaizhiName:dic[@"qiway"]]isEqualToString:@"未设置"]) {
        ;
    }
    else
    {
        i++;
    }
    
    
    
    
    return i;
    
}
-(BOOL)searchLeng:(NSString *)str
{
    if ([str isEqualToString:@"楞"]) {
        return YES;
    }
    else
    {
        return NO;
    }
    
    
}

-(void)doButtonWithSelectRow:(NSString *)row state:(int)state selectRow:(int)selectrow
{
    
    switch (state)
    {
        case 0:
        {
            
            self.tf_banxing.text=row;
            [self.tf_banxing resignFirstResponder];
            @try {
                jiagong=data[selectrow][@"pbwkp"];
                
                [AlertHelper singleMBHUDShow:@"获取数据中..." ForView:self.view];
                [ShangBaoWebAPI getzhizhangDetailWithpbid:data[selectrow][@"pbid"] success:^(NSArray *arr){
                    [AlertHelper hideAllHUDsForView:self.view];
                    NSDictionary *dic=  arr[0][@"pb"][0];
                    
                    num=[self getviewnum:dic];
                    float with = 45;
                    if (num >=5) {
                        with =self.view.frame.size.width/num;
                    }
                    
                    
                    _view_1.frame=CGRectMake(2, 162, with, 93);
                    
                    _view_2.frame=CGRectMake(CGRectGetMaxX(_view_1.frame), 162, with, 93);
                    _view_3.frame=CGRectMake(CGRectGetMaxX(_view_2.frame), 162, with, 93);
                    _view_4.frame=CGRectMake(CGRectGetMaxX(_view_3.frame),162, with, 93);
                    _view_5.frame=CGRectMake(CGRectGetMaxX(_view_4.frame),162, with, 93);
                    _view_6.frame=CGRectMake(CGRectGetMaxX(_view_5.frame), 162, with, 93);
                    _view_7.frame=CGRectMake(CGRectGetMaxX(_view_6.frame), 162, with, 93);
                    select1.dataArr=nil;
                    select2.dataArr=nil;
                    select3.dataArr=nil;
                    select4.dataArr=nil;
                    select5.dataArr=nil;
                    select6.dataArr=nil;
                    select7.dataArr=nil;
                    
                    cengData =dic;
                    NSString *str1=[self exchangeCaizhiName:dic[@"yiway"]];
                    NSString *str2=[self exchangeCaizhiName:dic[@"erway"]];
                    NSString *str3=[self exchangeCaizhiName:dic[@"sanway"]];
                    NSString *str4=[self exchangeCaizhiName:dic[@"siway"]];
                    NSString *str5=[self exchangeCaizhiName:dic[@"wuway"]];
                    NSString *str6=[self exchangeCaizhiName:dic[@"liuway"]];
                    NSString *str7=[self exchangeCaizhiName:dic[@"qiway"]];
                    
                    
                    
                    _imaV_1.image=[UIImage imageNamed:[self setviewImage:str1]];
                    _imaV_2.image=[UIImage imageNamed:[self setviewImage:str2]];
                    _imaV_3.image=[UIImage imageNamed:[self setviewImage:str3]];
                    _imaV_4.image=[UIImage imageNamed:[self setviewImage:str4]];
                    _imaV_5.image=[UIImage imageNamed:[self setviewImage:str5]];
                    _imaV_6.image=[UIImage imageNamed:[self setviewImage:str6]];
                    _imaV_7.image=[UIImage imageNamed:[self setviewImage:str7]];
                    
                    _tf_1.hidden=[self settextFeildHidden:str1];
                    _tf_2.hidden=[self settextFeildHidden:str2];
                    _tf_3.hidden=[self settextFeildHidden:str3];
                    _tf_4.hidden=[self settextFeildHidden:str4];
                    _tf_5.hidden=[self settextFeildHidden:str5];
                    _tf_6.hidden=[self settextFeildHidden:str6];
                    _tf_7.hidden=[self settextFeildHidden:str7];
                    
                    _lab_re1.hidden=[self settextFeildHidden:str1];
                    _lab_re2.hidden=[self settextFeildHidden:str2];
                    _lab_re3.hidden=[self settextFeildHidden:str3];
                    _lab_re4.hidden=[self settextFeildHidden:str4];
                    _lab_re5.hidden=[self settextFeildHidden:str5];
                    _lab_re6.hidden=[self settextFeildHidden:str6];
                    _lab_re7.hidden=[self settextFeildHidden:str7];
                    
                    
                    _lab_1.hidden=[self settextFeildHidden:str1];
                    _lab_2.hidden=[self settextFeildHidden:str2];
                    _lab_3.hidden=[self settextFeildHidden:str3];
                    _lab_4.hidden=[self settextFeildHidden:str4];
                    _lab_5.hidden=[self settextFeildHidden:str5];
                    _lab_6.hidden=[self settextFeildHidden:str6];
                    _lab_7.hidden=[self settextFeildHidden:str7];
                    leng1=[dic[@"yirate"] doubleValue];
                    leng2=[dic[@"errate"] doubleValue];
                    leng3=[dic[@"sanrate"] doubleValue];
                    leng4=[dic[@"sirate"] doubleValue];
                    leng5=[dic[@"wurate"] doubleValue];
                    leng6=[dic[@"liurate"] doubleValue];
                    leng7=[dic[@"qirate"] doubleValue];
                    _tf_1.text=@"";
                    _tf_2.text=@"";
                    _tf_3.text=@"";
                    _tf_4.text=@"";
                    _tf_5.text=@"";
                    _tf_6.text=@"";
                    _tf_7.text=@"";
                    
                    _lab_re1.text=@"材质";
                    _lab_re2.text=@"材质";
                    _lab_re3.text=@"材质";
                    _lab_re4.text=@"材质";
                    _lab_re5.text=@"材质";
                    _lab_re6.text=@"材质";
                    _lab_re7.text=@"材质";
                    
                    pmid1=nil;
                    num1=0;
                    pmid2=nil;
                    num2=0;
                    pmid3=nil;
                    num3=0;
                    pmid4=nil;
                    num4=0;
                    pmid5=nil;
                    num5=0;
                    pmid6=nil;
                    num6=0;
                    pmid7=nil;
                    num7=0;
                    _lab_ref.text=@"0.000";
                    
                    if ( [self searchLeng:str1]) {
                        _lab_1.text=dic[@"yinm"];
                    }
                    else
                    {
                        _lab_1.text=str1;
                    }
                    select1.dataArr=[self setleiXingdata:str1];
                    [select1 reloaPickView];
                    
                    if ( [self searchLeng:str2]) {
                        _lab_2.text=dic[@"ernm"];
                    }
                    else
                    {
                        _lab_2.text=str2;
                    }
                    select2.dataArr=[self setleiXingdata:str2];
                    [select2 reloaPickView];
                    
                    if ( [self searchLeng:str3]) {
                        _lab_3.text=dic[@"sannm"];
                    }
                    else
                    {
                        _lab_3.text=str3;
                    }
                    select3.dataArr=[self setleiXingdata:str3];
                    [select3 reloaPickView];
                    
                    if ( [self searchLeng:str4]) {
                        _lab_4.text=dic[@"sinm"];
                    }
                    else
                    {
                        _lab_4.text=str4;
                    }
                    select4.dataArr=[self setleiXingdata:str4];
                    [select4 reloaPickView];
                    
                    if ( [self searchLeng:str5]) {
                        _lab_5.text=dic[@"wunm"];
                    }
                    else
                    {
                        _lab_5.text=str5;
                    }
                    select5.dataArr=[self setleiXingdata:str5];
                    [select5 reloaPickView];
                    
                    if ( [self searchLeng:str6]) {
                        _lab_6.text=dic[@"liunm"];
                    }
                    else
                    {
                        _lab_6.text=str6;
                    }
                    select6.dataArr=[self setleiXingdata:str6];
                    [select6 reloaPickView];
                    
                    if ( [self searchLeng:str7]) {
                        _lab_7.text=dic[@"qinm"];
                    }
                    else
                    {
                        _lab_7.text=str7;
                    }
                    select7.dataArr=[self setleiXingdata:str7];
                    [select7 reloaPickView];
                    
                } fail:^(){
                    [AlertHelper hideAllHUDsForView:self.view];
                    [AlertHelper singleMBHUDShow:@"网络错误！" ForView:self.view AndDelayHid:2];
                    
                    
                }];
                
            }
            @catch (NSException *exception) {
                [AlertHelper singleMBHUDShow:@"无数据！" ForView:self.view AndDelayHid:2];
            }
            @finally {
                
            }
            
        }
            break;
        case 1:
        {
            self.lab_re1.text=[NSString stringWithFormat:@"材质%@",row];
            [self.tf_1 resignFirstResponder];
            
            NSString *str=[self exchangeCaizhiName:cengData[@"yiway"]];
            
            NSDictionary *dic=[[self dataWithCode:str] objectAtIndex:selectrow];
            
            NSString *str1=dic[@"price"];
            NSString *str2=dic[@"gwet"];
            
            pmid1=dic[@"pmid"];
            num1=  [self num:str1 num2:str2];
            
        }
            break;
        case 2:
        {
            self.lab_re2.text=[NSString stringWithFormat:@"材质%@",row];
            [self.tf_2 resignFirstResponder];
            NSString *str=[self exchangeCaizhiName:cengData[@"erway"]];
            
            NSDictionary *dic=[[self dataWithCode:str] objectAtIndex:selectrow];
            NSString *str1=dic[@"price"];
            NSString *str2=dic[@"gwet"];
            
            pmid2=dic[@"pmid"];
            num2=  [self num:str1 num2:str2];
        }
            break;
        case 3:
        {
            self.lab_re3.text=[NSString stringWithFormat:@"材质%@",row];
            [self.tf_3 resignFirstResponder];
            NSString *str=[self exchangeCaizhiName:cengData[@"sanway"]];
            
            NSDictionary *dic=[[self dataWithCode:str] objectAtIndex:selectrow];
            NSString *str1=dic[@"price"];
            NSString *str2=dic[@"gwet"];
            pmid3=dic[@"pmid"];
            num3=  [self num:str1 num2:str2];
            
            
        }
            break;
        case 4:
        {
            self.lab_re4.text=[NSString stringWithFormat:@"材质%@",row];
            [self.tf_4 resignFirstResponder];
            NSString *str=[self exchangeCaizhiName:cengData[@"siway"]];
            
            NSDictionary *dic=[[self dataWithCode:str] objectAtIndex:selectrow];
            NSString *str1=dic[@"price"];
            NSString *str2=dic[@"gwet"];
            pmid4=dic[@"pmid"];
            num4=  [self num:str1 num2:str2];
            
        }
            break;
        case 5:
        {
            self.lab_re5.text=[NSString stringWithFormat:@"材质%@",row];
            [self.tf_5 resignFirstResponder];
            NSString *str=[self exchangeCaizhiName:cengData[@"wuway"]];
            
            NSDictionary *dic=[[self dataWithCode:str] objectAtIndex:selectrow];
            NSString *str1=dic[@"price"];
            NSString *str2=dic[@"gwet"];
            pmid5=dic[@"pmid"];
            num5=  [self num:str1 num2:str2];
            
            
        }
            break;
        case 6:
        {
            self.lab_re6.text=[NSString stringWithFormat:@"材质%@",row];
            [self.tf_6 resignFirstResponder];
            NSString *str=[self exchangeCaizhiName:cengData[@"liuway"]];
            
            NSDictionary *dic=[[self dataWithCode:str] objectAtIndex:selectrow];
            NSString *str1=dic[@"price"];
            NSString *str2=dic[@"gwet"];
            pmid6=dic[@"pmid"];
            num6=  [self num:str1 num2:str2];
        }
            break;
        case 7:
        {
            self.lab_re7.text=[NSString stringWithFormat:@"材质%@",row];
            [self.tf_7 resignFirstResponder];
            NSString *str=[self exchangeCaizhiName:cengData[@"qiway"]];
            
            NSDictionary *dic=[[self dataWithCode:str] objectAtIndex:selectrow];
            NSString *str1=dic[@"price"];
            NSString *str2=dic[@"gwet"];
            pmid7=dic[@"pmid"];
            num7=  [self num:str1 num2:str2];
            
        }
            break;
        default:
            break;
    }
    
    
}
-(BOOL)settextFeildHidden:(NSString *)str
{
    if (![str isEqualToString:@"未设置"])
    {
        return NO;
    }
    else
    {
        return  YES;
    }
    
    
}

-(double )num :(NSString *)nu1 num2 :(NSString *)nu2
{
    return [nu1 doubleValue] *[nu2 doubleValue] *[_sunhaoLV doubleValue] *0.000001;
    
}
-(BOOL)caizhiSelectAll
{
    double a[7]={num1,num2,num3,num4,num5,num6,num7};
    for (int i=0;  i<num; i++)
    {
        if (a[i]==0)
        {
            
            return NO;
            break;
            
        }
    }
    return YES;
    
    
}
-(double )exchangStr:(double)doub
{
    double Bum=  round(doub*1000)/1000;
    double Bum1=  round(Bum*100)/100;
    return Bum1;
}

- (IBAction)jisunBtnPress:(id)sender
{
    double jisuan = 0.0;
    
    double bum1= num1 *leng1;
    bum1=[self exchangStr:bum1];
    
    double bum2= num2 *leng2;
    bum2=[self exchangStr:bum2];
    
    double bum3=num3 *leng3;
    bum3=[self exchangStr:bum3];
    
    double bum4= num4 *leng4;
    bum4=[self exchangStr:bum4];
    
    double bum5= num5 *leng5;
    bum5=[self exchangStr:bum5];
    
    double bum6= num6 *leng6;
    bum6=[self exchangStr:bum6];
    
    double bum7= num7 *leng7;
    bum7=[self exchangStr:bum7];
    
 
        if ([clfc isEqualToString:@"XY"]) {
            jisuan=  bum1 +bum2 +bum3 +bum4 +bum5 +bum6 +bum7;
            jisuan=jisuan+[jiagong doubleValue];
            _lab_ref.text =[NSString stringWithFormat: @"%.2f",jisuan];
        }
        else
        {   jisuan=  num1 *leng1 +num2 *leng2 +num3 *leng3 +num4 *leng4 +num5 *leng5 +num6 *leng6 +num7 *leng7;
            jisuan=jisuan+[jiagong doubleValue];
            jisuan=  round(jisuan*1000)/1000;
            _lab_ref.text =[NSString stringWithFormat: @"%.3f",jisuan];
        }
        
        
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    isEdit=NO;
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)gotolastView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
