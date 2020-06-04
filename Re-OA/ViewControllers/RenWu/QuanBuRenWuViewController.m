
#import "QuanBuRenWuViewController.h"
#import "RenWuWebAPI.h"
#import <MBProgressHUD.h>
#import "UserPermission.h"
#import "QuanBuRenWuCell.h"
#import "MyRenwuListModel.h"
#import "RenWuDetailViewController.h"
#import "MJRefresh.h"
#import "CharacterHelper.h"

@interface QuanBuRenWuViewController (){
    
    BOOL isFisrtDispear;
    NSMutableArray *dataArr;
}
@property (weak, nonatomic) IBOutlet UILabel *labshouquan;
@property (weak, nonatomic) IBOutlet UILabel *labkaitong;

@end

@implementation QuanBuRenWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFisrtDispear=YES;
    dataArr=[[NSMutableArray alloc ] init];
    self.navigationItem.title=@"全部任务";
    
    NSString *menuRoleStr= [UserPermission standartUserInfo].MenuRole;
    NSRange range = [menuRoleStr rangeOfString:@"rw_qb"];
    if ( range.location == NSNotFound)
    {
        [self.tableview removeFromSuperview];
        
    }else
    {
        [self.labkaitong removeFromSuperview];
        [self.labshouquan removeFromSuperview];
        [self setupRefresh];
    }
}

-(void)viewWillAppear:(BOOL)animated{
//    [self setupRefresh];
}

-(void)reloadTheList{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"获取中...";
    
    [RenWuWebAPI requestListByUID:[UserPermission standartUserInfo].ID AndType:@"3"
                             taid:@"0" page:@"0"
                          success:^(NSArray *renwulist){
                              [hud hide:YES];
                              [dataArr removeAllObjects];
                              for (NSDictionary *dict in renwulist) {
                                  MyRenwuListModel *model=[[MyRenwuListModel alloc]initWithJson:dict];
                                  [dataArr addObject:model];
                              }
                              [self.tableview reloadData];
                          } fail:^{
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                              [alert show];
                          }];
    
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableview headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableview addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [RenWuWebAPI requestListByUID:[UserPermission standartUserInfo].ID AndType:@"3"
                             taid:@"0" page:@"0"
                          success:^(NSArray *renwulist){
                              
                              [dataArr removeAllObjects];
                              for (NSDictionary *dict in renwulist) {
                                  MyRenwuListModel *model=[[MyRenwuListModel alloc]initWithJson:dict];
                                  [dataArr addObject:model];
                              }
                              
                              [self.tableview reloadData];
                              [self.tableview headerEndRefreshing];
                              
                          } fail:^{
                              [self.tableview headerEndRefreshing];
                              UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                              [alert show];
                          }];
}

- (void)footerRereshing
{
    if (dataArr.count==0)
    {
        self.tableview.footerRefreshingText = @"无更新数据";
        [self.tableview footerEndRefreshing];
        return ;
    }
    else
    {
        MyRenwuListModel *model=dataArr[0];
        NSString *idStr=model.Ta_Id ;
        NSString *pag=[NSString stringWithFormat:@"%lu",(unsigned long) dataArr.count ];
        // 1.添加数据
        [RenWuWebAPI requestListByUID:[UserPermission standartUserInfo].ID AndType:@"3"
                                 taid:idStr page:pag success:^(NSArray *arr){
                                     
                                     
                                     for (NSDictionary *dict in arr) {
                                         MyRenwuListModel *model=[[MyRenwuListModel alloc]initWithJson:dict];
                                         [dataArr addObject:model];
                                     }
                                     
                                     [self.tableview reloadData];
                                     [self.tableview footerEndRefreshing];
                                     
                                 } fail:^{
                                     [self.tableview footerEndRefreshing];
                                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                     [alert show];
                                 }];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
}
//myrenwucell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyRenwuListModel *model = [dataArr objectAtIndex:indexPath.row];
    QuanBuRenwuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quanburenwucell" forIndexPath:indexPath];
    
    NSString *flagStr=@"unarchived.png";
    cell.imgFlag.hidden = NO;
    
    if ([model.Ta_Iscomplete isEqualToString:@"3"]) {
        flagStr=@"unarchived.png";
    }else if ([model.Ta_Iscomplete isEqualToString:@"2"]){
        flagStr=@"archiving.png";
    }else if ([model.Ta_Iscomplete isEqualToString:@"1"]){
        cell.imgFlag.hidden = YES;
    }
    
    cell.imgFlag.image=[UIImage imageNamed:flagStr];
    
    cell.labDate.text= model.Ta_Lssueddate;
    cell.labTitle.text= model.Ta_Name;
    cell.labDesc.text=[CharacterHelper replacingTheBRToEmpty:model.Ta_Description] ;
    cell.labUser.text=model.Ta_Username;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyRenwuListModel *model= [dataArr objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RenWu" bundle:[NSBundle mainBundle]];
    RenWuDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"renwudetail"];
    controller.ta_id= model.Ta_Id;
    [self.navigationController pushViewController:controller animated:YES ];
}
- (IBAction)redirectToManScene:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
