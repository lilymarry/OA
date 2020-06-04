//
//  ShiBangDanViewController.m
//  Re-OA
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "ShiBangDanViewController.h"
#import "JinXiaoCunWebAPI.h"
#import "BangDanViewCell.h"
#import "AlertHelper.h"
#import "BangDanViewTittle.h"
@interface ShiBangDanViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *dataArr;
    UIScrollView *leftScrollView;
    UIScrollView *rightScrollView;
    
    UITableView *leftTableView;
    UITableView *rightTableView;
    
    NSArray *titleArray;
    
    UIView *view2;
    
    int timerCount;
    NSTimer  *timer;
}


@end

@implementation ShiBangDanViewController
- (IBAction)dismissSelfControer:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    timer = [[NSTimer alloc] initWithFireDate:fireDate
                                     interval:1
                                          target:self
                                     selector:@selector(reloadTableViewData:)
                                     userInfo:nil
                                      repeats:YES];
    
    timerCount = 1;
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];

//    titleArray = [[NSArray alloc] initWithObjects:@"磅单ID",@"磅单号", @"磅单状态", @"车牌号",@" 垛位名称 ",@"货物品种",@" 结算重量",@" 净重 ",@" 检验件数 ", @"库房名称",@" 扣水重量 ",@" 毛重 ",@" 毛重时间 ", @"  皮重 ",@"皮重时间 ",@" 入库件数 ",@"收货单位",@"货物名称"  ,@" 业务类别",@" 杂物重量",@"  杂纸重量",@" 总件数 ",nil];
//
//    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 2000, 50)];
//    view2.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    for(int i=0;i<[titleArray count];i++)
//    {
//        UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(80*i, 10, 80, 30)];
//        tmpLabel.backgroundColor = [UIColor clearColor];
//        tmpLabel.font = [UIFont systemFontOfSize:15];
//        tmpLabel.text = [titleArray objectAtIndex:i];
//
//        [view2 addSubview:tmpLabel];
//
//    }
    view2 = [[BangDanViewTittle alloc]instanceChooseView];
    [self.view addSubview:view2];
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width,self.view.frame.size.height-100)];
    rightScrollView.bounces = NO;
    rightScrollView.delegate = self;
    [self.view addSubview:rightScrollView];
    rightScrollView.contentSize = CGSizeMake(2000,self.view.frame.size.height-100);
    
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 2000, CGRectGetHeight(rightScrollView.frame)-50)];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.rowHeight = 50;
    [rightScrollView addSubview:rightTableView];
    


}
-(void)reloadTableViewData:(NSTimer*)theTimer
{
    
    timerCount++;
    if (timerCount==5)
    {
        [AlertHelper singleMBHUDShow:@"获取中..." ForView:self.view];
        [JinXiaoCunWebAPI getBangDanDataSuccess:^(NSArray *userArr) {
            
            // NSLog(@"qq! QQQ %@",userArr);
            [AlertHelper hidMBHUDFromView:self.view];
            
            [dataArr removeAllObjects];
            dataArr =[NSMutableArray arrayWithArray:userArr];
            
            [rightTableView reloadData];
            
            
        } fail:^{
            [AlertHelper hideAllHUDsForView:self.view];
            [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
            
        }];
        timerCount=0;
        
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //重新布下局
    view2.frame = CGRectMake(0, 70, 2000, 50);
    view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, 2000, 50);
    view2.clipsToBounds = YES;
    [self.view addSubview:view2];
    [rightTableView reloadData];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.0];
    view2.frame = CGRectMake(0, 70, 2000,50);
    view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, 2000, 50);
    view2.clipsToBounds = YES;
    [self.view addSubview:view2];
    [UIView commitAnimations];
    
}

////防止滑动过程中锁定方向不让滑动
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if(!decelerate)
//        [self scrollViewDidEndDecelerating:scrollView];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArr[0][@"bdr"] count];
    
  }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//   // NSLog(@"1111 %@",tableView);
//    if(tableView == leftTableView)
//    {
//        static NSString *cellIdetify = @"cell1";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
//        if(!cell)
//        {
//           // cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdetify] ;
//             cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify];
//        }
//
//        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
//        cell.textLabel.textColor = [UIColor redColor];
//
//        return cell;
//    }
//
//    else {
    
        static NSString *identfier=@"cell";
        BangDanViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BangDanViewCell" owner:self options:nil] lastObject];
           
        }
        NSDictionary *dic=  dataArr[0][@"bdr"][indexPath.row];
        cell.bdidLabel.text=dic[@"bdid"];
        cell.bdnoLabel.text=dic[@"bdno"];
        cell.carnoLabel.text=dic[@"carno"];
        cell.bdztnmLabel.text=dic[@"bdztnm"];
        cell.wznmLabel.text=dic[@"wznm"];
        cell.hwpzLabel.text=dic[@"hwpz"];
        cell.shdwLabel.text=dic[@"shdw"];
        cell.dwnmLabel.text=dic[@"dwnm"];
        cell.kfnmLabel.text=dic[@"kfnm"];
        cell.ywlbnmLabel.text=dic[@"ywlbnm"];
        cell.pikgLabel.text=dic[@"pikg"];
        cell.pitmLabel.text=dic[@"pitm"];
        cell.maokgLabel.text=dic[@"maokg"];
        cell.maotmLabel.text=dic[@"maotm"];
        cell.jyjsLabel.text=dic[@"jyjs"];
        cell.rkjsLabel.text=dic[@"rkjs"];
        cell.zjsLabel.text=dic[@"zjs"];
        cell.jingkgLabel.text=dic[@"jingkg"];
        cell.kouskgLabel.text=dic[@"kouskg"];
        cell.zawukgLabel.text=dic[@"zawukg"];
        cell.zazhi3kgLabel.text=dic[@"zazhi3kg"];
        cell.jiesuankgLabel.text=dic[@"jiesuankg"];
        return cell;
 //   }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
