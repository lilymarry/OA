//
//  JiaGeHuiZongBendiViewController.m
//  Re-OA
//
//  Created by admin on 15/4/20.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "JiaGeHuiZongBendiViewController.h"
#import "JinXiaoCunWebAPI.h"
#import "ScreenHelper.h"
#import "JxcZhuZhuangCell.h"
#import "JxcZongJiaCell.h"
#import "AlertHelper.h"
#import "JGCXBenDiHuiZongView.h"
#define timeLabWide 69
#define numLabWide  55
@interface JiaGeHuiZongBendiViewController ()<getJGCXBenDiHuiZongViewDataDelegate>

@end

@implementation JiaGeHuiZongBendiViewController
{
    UIView *bgView ; //遮罩层
    BOOL isChooseMode;
    JGCXBenDiHuiZongView *view;
    NSArray *rcArr;
    NSArray *ccArr;
    double maxwide;
    NSMutableDictionary *dic;
    NSMutableArray *allData;
    
}
- (IBAction)chaxunPress:(id)sender
{
    if (!isChooseMode) {
        [self showThebgview];
        
        view =[[ JGCXBenDiHuiZongView alloc]  instanceJiageChaXun];
        view.dataDelegate=self;
        [self.view.window addSubview:view];
    }
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
-(void)getJGCXBenDiHuiZongViewViewData:(NSString *)st leixing:(NSDictionary *)dengjiDic zhonglei:(NSDictionary *)zhongleiDic
{
    dic = [NSMutableDictionary dictionaryWithDictionary:dengjiDic];
    [dic setObject:zhongleiDic[@"zlnm"] forKey:@"zhonglei"];
    [dic setObject:st forKey:@"time"];
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [JinXiaoCunWebAPI jiadehuizongDataWithHwzl:zhongleiDic[@"zlid"] hwlx:dengjiDic[@"lxid"] kstm:st success:^(NSArray *arr){
     
        [AlertHelper hideAllHUDsForView:self.view];
        [allData removeAllObjects];
        allData=[NSMutableArray arrayWithArray:arr];
        if (allData.count!=0)
        {
            rcArr= allData[0][@"tjdata"][0][@"data"];
        }
        
        if (rcArr.count!=0)
        {
            maxwide =[self selectMaxMum:rcArr ];
        }
        [self.tableView reloadData];
      

    } fail:^(){[AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];
}];
   
    
    [self hidThebgview];
    [view closingTheLittleMenu:nil];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    allData=[NSMutableArray array];
   // self.segmentControl.selectedSegmentIndex=0;
    rcArr =[NSArray array];
    ccArr=[NSArray array];
    dic=[[NSMutableDictionary alloc]init];
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0)
    {
        return 1;
    }
    else
    {
      
            return rcArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0)
    {
       // NSLog(@"WWW %@",dic);
        static NSString *identfier=@"cell1";
        JxcZongJiaCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier forIndexPath:indexPath ];
        cell.la_denji.text=dic[@"time"];
        cell.la_zhonglei.text=dic[@"zhonglei"];
        cell.la_leixing.text=dic[@"lxnm"];
        
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
        return 144;
    }
    else
    {
        return 75;
        
    }
    
}



@end
