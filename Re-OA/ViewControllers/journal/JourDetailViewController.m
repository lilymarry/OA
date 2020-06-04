#import "JourDetailViewController.h"
#import "UserPermission.h"
#import "RizhiWebAPI.h"
#import "NullValueHelper.h"
#import  "PingLunViewController.h"
#import "ScreenHelper.h"
#import "CharacterHelper.h"
#import "AlertHelper.h"
#import "RizhiTableViewCell.h"
@interface JourDetailViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CGRect rect;
}
@property (weak, nonatomic) IBOutlet UITextView *contentVIew;
@property (weak, nonatomic) IBOutlet UITextView *tittleText;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIView *talkView;
@property (weak, nonatomic) IBOutlet UITextField *talkText;
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@property(strong ,nonatomic)NSMutableArray * PingLunArr;
@end

@implementation JourDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _PingLunArr =[NSMutableArray array];
    CGRect rect1=CGRectMake(0, [ScreenHelper SCREEN_HEIGHT]-49-48, [ScreenHelper SCREEN_WIDTH], 48);
    [self.talkView setFrame:rect1];
    rect=  self.talkView.frame;
    self.title=@"日志详情";
   
    //日志详情
    [RizhiWebAPI scanJournalDetail:[self.detail objectForKey:@"Jo_Id"] type:_flag success:^(NSArray *arr)
     {
         [AlertHelper hideAllHUDsForView:self.view];
         _nameLable.text=arr[0][@"username"];
         _contentVIew.text=[CharacterHelper replacingTheBRToEnter:[arr[0] objectForKey:@"description"]];
         _tittleText.text=[arr[0] objectForKey:@"title"];
    
    } fail:^(){
        
    }];
    //1 我的 2 全部
    if ([_flag isEqualToString:@"1"]){} 
    else{
        UIBarButtonItem *item= [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStyleBordered target:self action:@selector(dopingLun)];
        self.navigationItem.rightBarButtonItem=item;
    
    }
    [self getpinglunData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self getpinglunData];
}
-(void)getpinglunData
{

    //评论列表
    [AlertHelper MBHUDShow:@"获取中..." ForView:self.view AndDelayHid:30];
    [RizhiWebAPI AddCommentJournal:[self.detail objectForKey:@"Jo_Id"] success:^(NSArray *arr)
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

-(void)dopingLun

{
    NSString *tittlStr=[NSString stringWithFormat:@"点评%@的日志", _nameLable.text];
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle: tittlStr
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"点评",nil];
    theAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
  
    [theAlert show];

 }
- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *pingyuStr=@"";
    if (theAlert.alertViewStyle == UIAlertViewStylePlainTextInput) {
        pingyuStr = [theAlert textFieldAtIndex:0].text;
    }
    if ([@"点评" isEqualToString:[theAlert buttonTitleAtIndex:buttonIndex]]) {
    
        {
            [AlertHelper MBHUDShow:@"提交中..." ForView:self.view AndDelayHid:30];
            [RizhiWebAPI AddCommentJournal:[self.detail objectForKey:@"Jo_Id"] context:pingyuStr  username:[UserPermission standartUserInfo].name userId:[UserPermission standartUserInfo].ID success:^(NSArray *arr)
             {
                 [AlertHelper hideAllHUDsForView:self.view];
                 if ([[arr[0]objectForKey:@"bool"]isEqualToString:@"1"])
                 {
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"评论成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                    [self getpinglunData];
                     
                 }
                 else {
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误,请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                 }
             } fail:^(){
                 [AlertHelper hideAllHUDsForView:self.view];
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误,请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 [alert show];
             }];
        }
    
    }
    
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

@end
