#import "ShangBaoLiuTableViewController.h"
#import "ShangBaoWebAPI.h"
#import "ShangBaoTabViewController.h"
#import "ShangBaoList.h"
#import <MBProgressHUD.h>
#import "ShangBaoFlowCell.h"
#import "ScreenHelper.h"
#import "AlertHelper.h"
#import "UserPermission.h"
@interface ShangBaoLiuTableViewController (){
    NSMutableArray *_allList;
}

@end

@implementation ShangBaoLiuTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"上报流程";
    
    UINavigationController *controller=  self.navigationController;
    if (controller==nil) {
        UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], 64)];
        self.tableView.tableHeaderView = headerView;
        UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], 64)];
        UINavigationItem *NavTitle = [[UINavigationItem alloc] initWithTitle:_tittleStr];
        [navBar pushNavigationItem:NavTitle animated:YES];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"renwuToIndexNavImg"] style:UIBarButtonItemStyleBordered target:self action:@selector(navBackBt)];
        //设置barbutton
        NavTitle.leftBarButtonItem = item;
        [headerView addSubview:navBar];
    }
}
-(void)navBackBt{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSString *)tittleWithTag:(int)tag
{
    switch (tag)
    {
        case 1:
            return @"财务上报";
            break;
        case 2:
            return @"人事上报";
            break;
        case 3:
            return @"行政上报";
            break;
        case 4:
            return @"业务上报";
            break;
        case 5:
            return @"生产上报";
            break;
    }
    return  nil;
}
-(void)viewWillAppear:(BOOL)animated{
    _allList =[NSMutableArray array];
   [AlertHelper MBHUDShow:@"获取中" ForView:self.view AndDelayHid:30];
    [ShangBaoWebAPI getShangBaoFlowWithType:[ NSString stringWithFormat:@"%d" ,_buttag ]
                                    Andu_id:[UserPermission standartUserInfo].ID
                                    success:^(NSArray *arr)
     {
        [AlertHelper hideAllHUDsForView:self.view];
         @try {
             if ([arr[0][@"rzt"]isEqualToString:@"1"])
             {
                 
                 [_allList removeAllObjects];
                 [_allList addObjectsFromArray: arr[0][@"fp"]];
                 [self.tableView reloadData];
             }
             else{}
         }
         @catch (NSException *exception) {}}
        fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"网络错误，稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];}];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier=@"cell";
    ShangBaoFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    cell.labTitle.text= [_allList[indexPath.row]objectForKey:@"fnm"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     ShangBaoFlowCell *cell = (ShangBaoFlowCell*)[tableView cellForRowAtIndexPath:indexPath];
    ShangBaoTabViewController *tab=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ShangBaoTab"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:_allList[indexPath.row]];
    [dic setObject:[ NSString stringWithFormat:@"%d" ,_buttag ] forKey:@"typeId"];
    //NSLog(@"AA______ %@",dic);

    [[ShangBaoList standartUserInfo] setInfoDic:dic];
    tab.title=cell.labTitle.text;
    [self presentViewController:tab animated:YES completion:nil];
}

@end
