//
//  TimeJiaGeHuidanQuYuViewController.m
//  Re-OA
//
//  Created by admin on 15/4/21.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "TimeJiaGeHuidanQuYuViewController.h"
#import "TimeJiaGeHuidanQuYuView.h"
#import "ScreenHelper.h"
#import "JinXiaoCunWebAPI.h"
#import "JxcZongJiaCell.h"
#import "JxcZhuZhuangCell.h"
#import "AlertHelper.h"
#define timeLabWide 69
#define numLabWide  55
@interface TimeJiaGeHuidanQuYuViewController ()<getTimeJiaGeHuidanQuYuViewDelegate>
{
    UIView *bgView ; //遮罩层
    BOOL isChooseMode;
    TimeJiaGeHuidanQuYuView *view;
    NSMutableArray *allData;
    NSMutableDictionary *dic;
    double maxwide;
    NSArray *rcArr;
    NSArray *ccArr;
}
@end

@implementation TimeJiaGeHuidanQuYuViewController
- (IBAction)chaxunPress:(id)sender {
    [self showThebgview];
    
    view =[[TimeJiaGeHuidanQuYuView alloc]  instanceJiageChaXun];
    view.dataDelegate=self;
    [self.view.window addSubview:view];
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
//撤销背景蒙板
-(void)hidThebgview{
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}
//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    [view closingTheLittleMenu:nil];
    
}
-(double )selectMaxMum:(NSArray *)arr
{
    double  max =[arr[0][@"jg"] doubleValue];;
    
    for (int i=0; i <arr.count; i++)
        
    {
        
        if ([arr[i][@"jg"] doubleValue]>max)
        {
            max =[arr[i][@"jg"] doubleValue];
        }
    }
    
    return max;
    
}
-(CGFloat)setcellBackViewWide:(double)num
{
    
    num= num/maxwide;
    double wide=self.view.frame.size.width-70-timeLabWide-numLabWide;
    return  num *wide;
    
    
}

-(void)reloadTheRuChangList
{
    if (allData.count!=0)
    {
        if ([allData[0][@"tjdata"][0] count]>0)
        {
            rcArr=allData[0][@"tjdata"][0][@"data"];
        }
        else
        {
            rcArr=nil;
        }
    }
    if (rcArr.count!=0)
    {
        maxwide =[self selectMaxMum:rcArr ];
    }
    
    [self.tableView reloadData];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getTimeQuYuhuizongViewData:(NSString *)st quyu:(NSDictionary *)quyuDic zhonglei:(NSDictionary *)zhongleiDic leiXing:(NSDictionary *)leixing
{
    [AlertHelper singleMBHUDShow:@"获取中..." ForView:self.view];

    [ JinXiaoCunWebAPI getTimediquhuizongDataWithHwzl:zhongleiDic[@"zlid"] dq:quyuDic[@"dqid"] hwlx:leixing[@"lxid"] kstm:st success:^(NSArray *arr){
        
        [AlertHelper hidMBHUDFromView:self.view];
        dic = [NSMutableDictionary dictionaryWithDictionary:leixing];
        
        [dic setObject:st forKey:@"st"];
        [dic setObject:leixing[@"lxnm"] forKey:@"leixing"];
        [dic setObject:zhongleiDic[@"zlnm"] forKey:@"zhonglei"];
        
        [allData removeAllObjects];
        allData=[NSMutableArray arrayWithArray:arr];
   
            [self reloadTheRuChangList];
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
    
    }];
    [self hidThebgview];
    [view closingTheLittleMenu:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    rcArr =[NSArray array];
    ccArr=[NSArray array];
    dic=[[NSMutableDictionary alloc]init];
    allData=[[NSMutableArray alloc]init];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (section==0)
    {
        return 1;
    }
    else
      
        return rcArr.count;

  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0)
    {
        static NSString *identfier=@"cell1";
        JxcZongJiaCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
        
        cell.la_denji.text=dic[@"st"];
        cell.la_zhonglei.text=dic[@"zhonglei"];
        cell.la_leixing.text=dic[@"leixing"];
        return cell;
    }
    else
    {     static NSString *identfier=@"cell2";
        JxcZhuZhuangCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"JxcZhuZhuangCell" owner:self options:nil] lastObject];
        }
   
            cell.la_time.text=rcArr[indexPath.row][@"lvnm"];
            NSString *str=[NSString stringWithFormat:@"%0.4f",[rcArr[indexPath.row][@"jg"]doubleValue]];
            cell.la_price.text=str;
            
            double temp=[str doubleValue];
            
            if (temp>0)
            {
                cell.vie_backView.frame=CGRectMake(timeLabWide, 0,timeLabWide+ [self setcellBackViewWide:temp], 41);
                cell.la_price.frame=CGRectMake(CGRectGetMaxX(cell.vie_backView.frame), 0, numLabWide, 41);
            }
            else
            {
                cell.vie_backView.frame=CGRectMake(timeLabWide, 0, 0, 41);
                cell.la_price.frame=CGRectMake(CGRectGetMaxX(cell.vie_backView.frame), 0, numLabWide, 41);
            }
            return cell;
        }
    
      
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return 142;
    }
    else
    {
        return 57;
        
    }
    
}

@end
