//
//  TimeJiaGeHuiZongQuYuViewController.m
//  Re-OA
//
//  Created by admin on 15/4/21.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "TimeJiaGeHuiZongQuYuViewController.h"
#import "TimeQuYuhuizongView.h"
#import "ScreenHelper.h"
#import "JinXiaoCunWebAPI.h"
#import "JxcZongJiaCell.h"
#import "JxcZhuZhuangCell.h"
#import "AlertHelper.h"

#define timeLabWide 69
#define numLabWide  55
@interface TimeJiaGeHuiZongQuYuViewController ()<getTimeQuYuhuizongViewDataDelegate>
{
    UIView *bgView ; //遮罩层
    BOOL isChooseMode;
    TimeQuYuhuizongView *view;
    NSMutableArray *allData;
    NSMutableDictionary *dic;
    double maxwide;
    NSArray *rcArr;
    NSArray *ccArr;

}
@end

@implementation TimeJiaGeHuiZongQuYuViewController
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

- (IBAction)chaxunPress:(id)sender {
    [self showThebgview];
    
    view =[[TimeQuYuhuizongView alloc]  instanceJiageChaXun];
    view.dataDelegate=self;
    [self.view.window addSubview:view];
}
//改变列表
//- (IBAction)changeList:(id)sender {
//    
//    if (self.segmentControl.selectedSegmentIndex==0)
//    {
//        
//        [self reloadTheRuChangList];
//        
//    }
//    else
//    {
//        [self reloadTheChuChangList];
//    }
//}

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
//-(void)reloadTheChuChangList{
//    if (allData.count!=0)
//    {
//        if ([allData[0][@"tjdata"][1] count]>0)
//        {
//             ccArr=allData[0][@"tjdata"][1][@"data"];
//        }
//        else
//        {
//            ccArr=nil;
//        }
//    }
//   if (ccArr.count!=0)
//    {
//        maxwide =[self selectMaxMum:ccArr ];
//    }
//    [self.tableView reloadData];
//    
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rcArr =[NSArray array];
    ccArr=[NSArray array];
    dic=[[NSMutableDictionary alloc]init];
    allData=[[NSMutableArray alloc]init];
    
   // self.segmentControl.selectedSegmentIndex=0;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getTimeQuYuhuizongViewData:(NSString *)st dengji:(NSDictionary *)dengjiDic zhonglei:(NSDictionary *)zhongleiDic leiXing:(NSDictionary *)leixing

{
    dic = [NSMutableDictionary dictionaryWithDictionary:leixing];
    
    [dic setObject:st forKey:@"st"];
    [dic setObject:leixing[@"lxnm"] forKey:@"leixing"];
    [dic setObject:zhongleiDic[@"zlnm"] forKey:@"zhonglei"];
     [AlertHelper singleMBHUDShow:@"获取中..." ForView:self.view];
    [JinXiaoCunWebAPI getTimeQuYuhuizongDataWithHwzl:zhongleiDic[@"zlid"] hwlv:dengjiDic[@"lvid"] hwlx:leixing[@"lxid"] kstm:st success:^(NSArray *arr){
        [AlertHelper hidMBHUDFromView:self.view];
        [allData removeAllObjects];
        allData=[NSMutableArray arrayWithArray:arr];
      //  if (self.segmentControl.selectedSegmentIndex==0)
      //  {
            [self reloadTheRuChangList];
      //  }
      //  else
      //  {
      //      [self reloadTheChuChangList];
      //  }

     


} fail:^(){
    [AlertHelper hideAllHUDsForView:self.view];
    [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];

}];
    
    [self hidThebgview];
    [view closingTheLittleMenu:nil];

}
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
   // {  if(self.segmentControl.selectedSegmentIndex==0)
  //  {
        return rcArr.count;
  //  }
  //  else
   // {
        return ccArr.count;
  //  }
 //   }
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
      //  if (self.segmentControl.selectedSegmentIndex==0)
      //  {
            cell.la_time.text=rcArr[indexPath.row][@"dq"];
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
//      //  else{
//            
//            cell.la_time.text=ccArr[indexPath.row][@"dq"];
//            NSString *str=[NSString stringWithFormat:@"%0.4f",[ccArr[indexPath.row][@"jg"]doubleValue]];
//            cell.la_price.text=str;
//            
//            double temp=[str doubleValue];
//            if (temp>0)
//            {
//                cell.vie_backView.frame=CGRectMake(timeLabWide, 0,timeLabWide+ [self setcellBackViewWide:temp], 41);
//                cell.la_price.frame=CGRectMake(CGRectGetMaxX(cell.vie_backView.frame), 0, numLabWide, 41);
//            }
//            else
//            {
//                cell.vie_backView.frame=CGRectMake(timeLabWide, 0, 0, 41);
//                cell.la_price.frame=CGRectMake(CGRectGetMaxX(cell.vie_backView.frame), 0, numLabWide, 41);
//            }
//            
//            
//            
//        }
    
        
 //   }
    
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
