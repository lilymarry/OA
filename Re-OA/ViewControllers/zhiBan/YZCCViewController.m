//
//  YZCCViewController.m
//  Re-OA
//
//  Created by imac-1 on 2017/4/7.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "YZCCViewController.h"
#import "AlertHelper.h"
#import "ZhiBanWebAPI.h"
#import "YZCCModel.h"
#import "YZCCViewCell.h"
@interface YZCCViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
    NSDictionary *dic;
}
@property (weak, nonatomic) IBOutlet UITableView *tabView;


@end

@implementation YZCCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // if ( self.view.frame.size.height==812)
  //  {
        self.navigationController.navigationBar.translucent = NO;
   // }
    dataArr=[NSMutableArray array];
    [AlertHelper MBHUDShow:@"加载中..." ForView:self.view AndDelayHid:30];
    [ZhiBanWebAPI getyZcWithsuccess:^(NSArray * arr) {
      //  NSLog(@"111 %@",arr[0])   ;
      //  NSLog(@"111 %@",arr[0][@"huizong"])   ;
        //  NSLog(@"22 %@",arr[0][@"dange"][0])   ;
        
        [AlertHelper hideAllHUDsForView:self.view];
        if ([arr[0][@"dange"] count]>0) {
            for (NSDictionary *dict in arr[0][@"dange"][0]) {
                YZCCModel *model=[[YZCCModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                
                [dataArr addObject:model];
            }
            dic=arr[0][@"huizong"][0];
            [_tabView reloadData];

        }
        else
        {
            [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
            
        }

     //   NSLog(@"DDDD %@",dataArr);
    } fail:^{
        [AlertHelper hideAllHUDsForView:self.view];
        
        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];

    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    @try {
        return dataArr.count+1;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}
//quanbudetailcell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CustomCellIdentifier = @"Cell1";
   
    YZCCViewCell  *cell = (YZCCViewCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (!cell) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"YZCCViewCell" owner:nil options:nil];
        cell= [nibView lastObject];
    }
    if (indexPath.row==dataArr.count) {
           cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
        cell.zhilei.text=[NSString stringWithFormat:@"总计 %@", dic[@"zgs"]];
         cell.zongliang.text=[NSString stringWithFormat:@"%@", dic[@"zzl"]];;
        cell.suliang.text=[NSString stringWithFormat:@"%@", dic[@"zsl"]];;
        
        cell.zongjiage.text=[NSString stringWithFormat:@"%@", dic[@"zjg"]];
       
    }
    else
    {
 
    YZCCModel *model=[dataArr objectAtIndex:indexPath.row];
    cell.suliang.text=[NSString stringWithFormat:@"%@", model.suliang];;
    cell.zhilei.text=[NSString stringWithFormat:@"%@", model.zhilei];;
    cell.zongjiage.text=[NSString stringWithFormat:@"%@", model.zongjiage];
    cell.zongliang.text=model.zongliang;
    }
    return cell;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
    
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
