  #import "JXCWeiRuKuTableController.h"
#import "MJRefresh.h"
#import "JXCCommonCell.h"
#import "JXCCommonListModel.h"
#import "JinXiaoCunWebAPI.h"
#import "AlertHelper.h"
#import "ScreenHelper.h"
#import "JXCDoRuKuTableController.h"
#import "CommonDelegate.h"

@interface JXCWeiRuKuTableController ()<CommonNotification>{
    NSMutableArray *dataArr;
    BOOL isPull;
}
@end

@implementation JXCWeiRuKuTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.navigationItem.title=@"未入库";
    [self.view setFrame:[ScreenHelper areaToFullScreenDivStateAndTabBars]];
    dataArr = [NSMutableArray new];
    isPull=YES;
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.tableView headerBeginRefreshing];
}

//下拉刷新
-(void)headerRereshing{
    isPull=YES;
    [self requestListDataByrnum:@"0"];
}

//上拉加载
-(void)footerRereshing{
    isPull=NO;
    NSString *rnum=[NSString stringWithFormat:@"%lu",(unsigned long)dataArr.count ];
    [self requestListDataByrnum:rnum];
}

-(void)refreshingDataList{
    [self.tableView headerBeginRefreshing];
}

//获取数据
-(void)requestListDataByrnum:(NSString *)rnum{
    
    [JinXiaoCunWebAPI getBangDanListWithRnum:rnum bdtyp:@"3" success:^(NSArray *arr){
        if ( arr.count>0) {
            
            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
            NSArray *dictArr= [dict objectForKey:@"bd"];
            
            if (isPull) {
                [dataArr removeAllObjects];
            }
            
            for (NSDictionary *dict1 in dictArr) {
                JXCCommonListModel *model=[[JXCCommonListModel alloc]initWithJson:dict1];
                [dataArr addObject:model];
            }
        }
        
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        
    } fail:^(){
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        [AlertHelper singleMBHUDShow:@"网络请求出错!" ForView:self.tableView AndDelayHid:2];
    }];
}

- (IBAction)redirectToManScene:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXCCommonListModel *model = [dataArr objectAtIndex:indexPath.row];
    JXCCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jxccommoncell"];
    if (!cell)
        cell=[JXCCommonCell initWithNib];
    
    cell.lab_Dengji.text=model.lvnm;
    cell.lab_zuofei.text=model.fqbs;
    cell.lab_WuZiMing.text=model.wznm;
    cell.lab_ChePaiHao.text= model.carno;
    cell.lab_BangDanHao.text=model.bdno;
    cell.lab_BangDanRiQi.text= model.tm;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RuKu" bundle:[NSBundle mainBundle]];
    JXCDoRuKuTableController *controller = [storyboard instantiateViewControllerWithIdentifier:@"jxcDoRuku"];
    JXCCommonListModel *model = [dataArr objectAtIndex:indexPath.row];
    controller.bdid= model.bdid;
    controller.commonNotification=self;
    [self.navigationController pushViewController:controller animated:YES ];
    
}





@end
