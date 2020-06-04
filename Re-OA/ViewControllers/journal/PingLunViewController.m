#import "PingLunViewController.h"
#import "RizhiWebAPI.h"
#import "RizhiTableViewCell.h"
#import "AlertHelper.h"
@interface PingLunViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property(strong ,nonatomic)NSMutableArray * PingLunArr;
@end

@implementation PingLunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _PingLunArr =[NSMutableArray array];
    [AlertHelper MBHUDShow:@"获取中..." ForView:self.view AndDelayHid:30];
    [RizhiWebAPI AddCommentJournal:self.J_Id success:^(NSArray *arr)
    {
        [AlertHelper hideAllHUDsForView:self.view];
        [_PingLunArr removeAllObjects];
        [_PingLunArr addObjectsFromArray:arr];
        [_tabView reloadData];
        
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误,请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _PingLunArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier=@"rizhicell";
    RizhiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RizhiTableViewCell" owner:self options:nil] lastObject];
    }
    cell.tittleLable.text=_PingLunArr[indexPath.row][@"Jr_UserName"];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.contentLable.text=_PingLunArr[indexPath.row][@"Jr_Description"];
    cell.timeLable.text=[self substringWithAstring: _PingLunArr[indexPath.row][@"Jr_Date"] ];
    return cell;
}
-(NSString *)substringWithAstring:(NSString *)str
{
    NSString *str1=@" ";
    NSRange range = [str rangeOfString:str1] ;
    NSString *time=[str substringToIndex:range.location];
    return time;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
