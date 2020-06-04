//
//  BangdanViewController.m
//  Re-OA
//
//  Created by admin on 15/4/17.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "BangdanViewController.h"
#import  "JinXiaoCunWebAPI.h"
#import "BangDanViewCell.h"
#import "BangDanViewTittle.h"
@interface BangdanViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *dataArr;
    UIScrollView *leftScrollView;
    UIScrollView *rightScrollView;
    
    UITableView *leftTableView;
    UITableView *rightTableView;
    
    NSArray *titleArray;
    
    UIView *view2;
    
}

@end

@implementation BangdanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray = [[NSArray alloc] initWithObjects:@"磅单ID",@"磅单号", @"磅单状态", @"车牌号",
                  @" 垛位名称 ",
                  @"货物品种",
                  @" 结算重量",@" 净重 "
                  ,@" 检验件数 ", @"库房名称",@" 扣水重量 ",@" 毛重 ",@" 毛重时间 ", @"  皮重 ",@"皮重时间 ",
                  @" 入库件数 ",
                  
                  @"收货单位",@"货物名称"  ,
                  
                  
                  
                  @" 业务类别",@" 杂物重量",@"  杂纸重量",@" 总件数 ",nil];
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 80, 50)];
    view1.backgroundColor = [UIColor grayColor];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"编号";
    [view1 addSubview:nameLabel];
    
    [self.view addSubview:view1];
    
   
    
    view2 = [[UIView alloc] initWithFrame:CGRectMake(80, 70, 960, 50)];
    view2.backgroundColor = [UIColor grayColor];
    for(int i=0;i<[titleArray count];i++)
    {
        UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(80*i, 10, 80, 30)];
        tmpLabel.backgroundColor = [UIColor clearColor];
        tmpLabel.font = [UIFont systemFontOfSize:15];
        tmpLabel.text = [titleArray objectAtIndex:i];
        
        [view2 addSubview:tmpLabel];
        
    }
    [self.view addSubview:view2];
    
    leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-120)];
    leftScrollView.backgroundColor = [UIColor whiteColor];
    leftScrollView.bounces = NO;
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(80, 0, self.view.frame.size.width-80, 1040)];
    rightScrollView.backgroundColor = [UIColor grayColor];
    rightScrollView.alwaysBounceHorizontal = FALSE;
    rightScrollView.bounces = NO;
    rightScrollView.delegate = self;
    
    [self.view addSubview:leftScrollView];
    [leftScrollView addSubview:rightScrollView];
    
    rightScrollView.directionalLockEnabled = YES;
    
    
    //	leftScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*10);
    //	rightScrollView.contentSize = CGSizeMake(self.view.frame.size.width*10, self.view.frame.size.height *10);
    leftScrollView.contentSize = CGSizeMake(320, 1040);
    rightScrollView.contentSize = CGSizeMake(640, 1040);
    rightScrollView.directionalLockEnabled = YES;
    
    
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, 1040)];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.rowHeight = 50;
    leftTableView.scrollEnabled = NO;
    leftTableView.alwaysBounceHorizontal = FALSE;
    leftTableView.bounces = NO;
    [leftScrollView addSubview:leftTableView];
    //leftTableView.backgroundColor = [UIColor blackColor];
    //leftTableView.separatorColor=	[[UIColor alloc] initWithRed:0.337 green:0.337 blue:0.337 alpha:1];
    
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 880, 1040)];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.rowHeight = 50;
    rightTableView.scrollEnabled = NO;
    rightTableView.bounces = NO;
    rightTableView.alwaysBounceHorizontal = FALSE;
    [rightScrollView addSubview:rightTableView];

    
       [JinXiaoCunWebAPI getBangDanDataSuccess:^(NSArray *userArr) {
        
    
        [dataArr removeAllObjects];
        dataArr =[NSMutableArray arrayWithArray:userArr];
        
        [rightTableView reloadData];
        
        
    } fail:^{
        
    }];
    

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //重新布下局
    view2.frame = CGRectMake(80, 70, 640, 50);
    view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, 640, 50);
    view2.clipsToBounds = YES;
    view2.backgroundColor = [UIColor grayColor];
    //view2.frame = CGRectMake(0, 0 , 960 , contentHeight);
    [self.view addSubview:view2];
    rightScrollView.frame =CGRectMake(80, 0, self.view.frame.size.width - 80, 1040);
    [leftScrollView addSubview:rightScrollView];
    
    
    rightTableView.frame = CGRectMake(0, 0, 640,1040);
    [rightScrollView addSubview:rightTableView];
    leftTableView.frame = CGRectMake(0, 0, 80, 1040);
    [leftScrollView addSubview:leftTableView];
    
    [rightTableView reloadData];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.0];
    view2.frame = CGRectMake(80, 70, 640, 50);
    view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, 640, 50);
    view2.clipsToBounds = YES;
    [self.view addSubview:view2];
    [UIView commitAnimations];
    
}



//这里应用另一个思路，就是左右滑动的时候，view2不必要加到ScrollView上面，用一个动画改变它的位置即可
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
 
    if(scrollView.contentOffset.x)
        
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.0];
    view2.frame = CGRectMake(80, 70, 640, 50);
    view2.bounds = CGRectMake(scrollView.contentOffset.x, 0, 640, 50);
    view2.clipsToBounds = YES;
    [self.view addSubview:view2];
    [UIView commitAnimations];
    
}

//防止滑动过程中锁定方向不让滑动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate)
        [self scrollViewDidEndDecelerating:scrollView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArr[0][@"bdr"] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == leftTableView)
    {
        static NSString *cellIdetify = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
        if(!cell)
        {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.textLabel.textColor = [UIColor redColor];
        cell.backgroundColor=[UIColor redColor];
        return cell;
   }
   
    else {
        
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
        //
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
    }
    

   
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
