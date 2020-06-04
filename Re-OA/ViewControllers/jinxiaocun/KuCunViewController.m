
#import "KuCunViewController.h"
#import "PGCategoryView.h"
#import "JinXiaoCunWebAPI.h"
#import "KcListModel.h"
#import "JxcChuCunlistCell.h"
#import "KcDetailListModel.h"
#import "JxcChuCunDetailListCell.h"
#import "AlertHelper.h"
@interface KuCunViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_leftTbale;
    UITableView *_rightTbale;
    UIView *_contentView;
    UILabel *label;
     NSMutableArray *dataArr;
     NSMutableArray *detailArr;
    
}
@property (strong, nonatomic) PGCategoryView *categoryView;


@end

@implementation KuCunViewController
- (IBAction)dismisSelfController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr=[NSMutableArray new];
    detailArr=[NSMutableArray array];
    [self addSubView];

    [ self getData];
}
-(void)getData
{
    [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [JinXiaoCunWebAPI getKuFanglisTsuccess:^(NSArray *arr){
        
        [AlertHelper hideAllHUDsForView:self.view];
        [dataArr removeAllObjects];
        NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
        NSArray *dictArr= [dict objectForKey:@"dw"];
        for (NSDictionary *dict1 in dictArr) {
            KcListModel *model=[[KcListModel alloc]initWithDic:dict1];
            [dataArr addObject:model];
        }
        [_leftTbale reloadData];

    
    } fail:^(){
     [AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];
    }];

}
-(void)addSubView
{
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(self.view.bounds.size.width, 0,self.view.bounds.size.width, self.view.bounds.size.height);
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _contentView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 66, _contentView.frame.size.width, 60);
    //view.layer.cornerRadius=10;
    view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [_contentView addSubview:view];
    
    label=[[UILabel alloc] initWithFrame:CGRectMake(1, 1, view.frame.size.width, 20)];
    label.backgroundColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:10];
    [view addSubview:label];
    
    UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(1, view.frame.size.height-30, 34, 30)];
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.font=[UIFont systemFontOfSize:10];
    lab1.numberOfLines=0;
    lab1.text=@"货物名称";
    [view addSubview:lab1];
    
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(46, view.frame.size.height-27, 34, 14)];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab2.font=[UIFont systemFontOfSize:10];
    
    lab2.text=@"数量";
    [view addSubview:lab2];
    
    UILabel *lab3=[[UILabel alloc] initWithFrame:CGRectMake(98, view.frame.size.height-27, 34, 14)];
    lab3.font=[UIFont systemFontOfSize:10];
    lab3.textAlignment=NSTextAlignmentCenter;
    lab3.text=@"重量";
    [view addSubview:lab3];
    
    UILabel *lab4=[[UILabel alloc] initWithFrame:CGRectMake(151, view.frame.size.height-27, 34, 14)];
    lab4.font=[UIFont systemFontOfSize:10];
    lab4.textAlignment=NSTextAlignmentCenter;
    lab4.text=@"等级";
    [view addSubview:lab4];
    
    UILabel *lab5=[[UILabel alloc] initWithFrame:CGRectMake(200, view.frame.size.height-30, 34, 30)];
    lab5.font=[UIFont systemFontOfSize:10];
    lab5.textAlignment=NSTextAlignmentCenter;
    lab5.numberOfLines=0;
    lab5.text=@"货物类型";
    [view addSubview:lab5];
    
    _leftTbale = [[UITableView alloc] init];
    _leftTbale.frame = CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-110);
    _leftTbale.dataSource = self;
    _leftTbale.delegate = self;
    _leftTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _leftTbale.showsVerticalScrollIndicator = NO;
    _leftTbale.tableFooterView = [[UIView alloc] init];
    [self.view insertSubview:_leftTbale belowSubview:_contentView];
    
    _rightTbale = [[UITableView alloc] init];
    _rightTbale.frame = CGRectMake(0,126, _contentView.bounds.size.width, _contentView.bounds.size.height-126);
    _rightTbale.dataSource = self;
    _rightTbale.delegate = self;
    _rightTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _rightTbale.showsVerticalScrollIndicator = NO;
    _rightTbale.tableFooterView = [[UIView alloc] init];
    [_contentView addSubview:_rightTbale];
    
    
    CGRect frame = _contentView.frame;
    frame.origin.x -= 30;
    frame.size.width = 30;
    _categoryView = [PGCategoryView categoryRightView:_contentView];
    _categoryView.frame = frame;
    [self.view addSubview:_categoryView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTbale) {
        return dataArr.count;
    }else{
        return detailArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTbale) {
        static NSString *CellIdentifier = @"Cell";
       JxcChuCunlistCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
                  cell = [[[NSBundle mainBundle] loadNibNamed:@"JxcChuCunlistCell" owner:self options:nil] lastObject];
        }
        KcListModel *model=dataArr[indexPath.row];
        cell.lab_kName.text=model.kfnm;
        cell.lab_dName.text=model.dwnm;
        cell.lab_num.text=model.jianshu;
        cell.lab_weight.text=model.kg;
       
        return cell;
    }else{
        static NSString *CellIdentifier2 = @"Cell2";
        JxcChuCunDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"JxcChuCunDetailListCell" owner:self options:nil] lastObject];
        }
        KcDetailListModel *model=detailArr[indexPath.row];
        cell.la_wuZiname.text=model.wuZiname;
        cell.la_num.text=model.num;
        cell.la_weight.text=model.weight;
        cell.la_leixing.text=model.leixing;
        cell.la_dengji.text=model.dengji;
        return cell;
    }
}
-(void)getDetalDataWithId:(NSString *)kfid
{
     [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [JinXiaoCunWebAPI getKuFanglisTDetalWithdeId:kfid success:^(NSArray *arr){
        [AlertHelper hideAllHUDsForView:self.view];
       [detailArr removeAllObjects];
        NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
        NSArray *dictArr= [dict objectForKey:@"dwdata"];
        for (NSDictionary *dict1 in dictArr) {
           KcDetailListModel *model=[[KcDetailListModel alloc]initWithDic:dict1];
            [detailArr addObject:model];
        }
        [_rightTbale reloadData];
    } fail:^(){[AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];}];

}
#pragma mark - tableView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       if (tableView == _leftTbale) {
        KcListModel *model=dataArr[indexPath.row];
        [self getDetalDataWithId:model.kfid];
        [_categoryView show];
        label.text=[NSString stringWithFormat:@"当前位置：%@%@",model.kfnm,model.dwnm];
        
    }
    else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        }
    
}
@end
