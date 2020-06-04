
#import "ChooseUserViewController.h"
#import "RenWuWebAPI.h"
#import <MBProgressHUD.h>
#import "UserPermission.h"
#import "RenWuUsersModel.h"
#import "RenWuUserGroupModel.h"

@interface ChooseUserViewController (){
    NSMutableArray *dataArr;
    NSMutableArray *groupDataArr;
    UITextField *_search;
    BOOL isSearch;
    NSMutableArray *_searchArr;
    NSMutableDictionary *_nameArr;
    BOOL allSele;
    NSMutableArray *indexArr;
}
@end

@implementation ChooseUserViewController

-(void)viewDidLoad{
    
    dataArr=[[NSMutableArray alloc ] init];
    groupDataArr=[[NSMutableArray alloc ] init];
    [self addsearch];
    _searchArr=[NSMutableArray array];
    _nameArr=[NSMutableDictionary dictionary];
    allSele=NO;
    indexArr=[NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadTheUsers];
}
-(void)addsearch
{
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, self.view.frame.size.width, 40);
    _search=[[UITextField alloc]init];
    _search.frame=CGRectMake(5, 5, view.frame.size.width*0.60-5, view.frame.size.height-10);
    _search.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _search.layer.borderWidth=0.5;
    _search.delegate=self;
    [view addSubview:_search];
    
    UIButton *sure=[UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame=CGRectMake(CGRectGetMaxX(_search.frame)+5, 5, view.frame.size.width*0.15, view.frame.size.height-10);
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setBackgroundImage:[UIImage imageNamed:@"btn11.png"] forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(searchEvent) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sure];
    
    UIButton *allSelect=[UIButton buttonWithType:UIButtonTypeCustom];
    allSelect.frame=CGRectMake(CGRectGetMaxX(sure.frame)+5, 5, view.frame.size.width*0.15, view.frame.size.height-10);
    [allSelect setTitle:@"全选" forState:UIControlStateNormal];
    [allSelect setBackgroundImage:[UIImage imageNamed:@"allSelcet.png"] forState:UIControlStateNormal];
    [allSelect addTarget:self action:@selector(allSelectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:allSelect];
    
    self.tableView.tableHeaderView=view;
}
-(void)allSelectBtnPress:(id)sender
{
    [indexArr removeAllObjects];
    allSele=allSele?NO:YES;
    [self.tableView reloadData];
}
-(void)searchEvent
{
    allSele=NO;
    [indexArr removeAllObjects];
    [groupDataArr removeAllObjects];
    [self.view endEditing:YES];
    isSearch=YES;
    if (_searchArr !=nil)
    {
        [_searchArr removeAllObjects];
    }
    if ([_search.text isEqualToString:@""]) {
        isSearch=NO;
         [groupDataArr addObjectsFromArray:[RenWuUserGroupModel createArrayWithUsersAndPinYin:dataArr]];
        [self.tableView reloadData];
        return;
    }
    
    
    for (int i=0; i<dataArr.count; i++)
    {
        RenWuUsersModel *mo=dataArr[i];
        if ([mo.name rangeOfString:_search.text].location==NSNotFound)
        {}else
        {
            [_searchArr addObject:mo];
            
        }
    }
    
     [groupDataArr addObjectsFromArray:[RenWuUserGroupModel createArrayWithUsersAndPinYin:_searchArr]];
    [self.tableView reloadData];

    if (_searchArr.count==0) {
        // isSearch=NO;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"未找到匹配结果" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)reloadTheUsers{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"获取中...";
    
    [RenWuWebAPI requestUsersByUID:[UserPermission standartUserInfo].ID success:^(NSArray *userlist){
        [hud hide:YES];
        [dataArr removeAllObjects];
        for (NSDictionary *dict in userlist)
        {
            
            RenWuUsersModel *model=[[RenWuUsersModel alloc]initWithJson:dict];
            [dataArr addObject:model];
        }
        
        if (dataArr.count>0) {
            [groupDataArr addObjectsFromArray:[RenWuUserGroupModel createArrayWithUsersAndPinYin:dataArr]];
            [self.tableView reloadData];
        }
        
    } fail:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }];
}

//确定所选用户
- (IBAction)confirmUsers:(id)sender {
    if (allSele &&(!isSearch)) {
        [groupDataArr removeAllObjects];
        for (RenWuUsersModel *model in dataArr) {
            model.isChoosed=YES;
        }
         [groupDataArr addObjectsFromArray:[RenWuUserGroupModel createArrayWithUsersAndPinYin:dataArr]];
    }
    NSObject<RenWuChooseUserNotification> *tmpDele=self.chooseUserDelegate;
    [tmpDele setTheChooseUser: groupDataArr];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (isSearch)
    {
        return 1;
    }
    else
    {
        return groupDataArr.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isSearch) {
        return _searchArr.count;
    }
    else
    {
        RenWuUserGroupModel *group = [groupDataArr objectAtIndex:section];
        return group.users.count;
    }
}
//myrenwucell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"usercell" forIndexPath:indexPath];
    RenWuUsersModel *user;
    if (isSearch) {
        //cell = [tableView dequeueReusableCellWithIdentifier:@"usercell" forIndexPath:indexPath];
        user = [_searchArr objectAtIndex:indexPath.row];
    }
    else
    {
        RenWuUserGroupModel *group =[groupDataArr objectAtIndex:indexPath.section];
        user = [group.users objectAtIndex:indexPath.row];
        // cell = [tableView dequeueReusableCellWithIdentifier:@"usercell" forIndexPath:indexPath];
        
    }
    cell.textLabel.text =user.name;
    
    if (allSele)
    {    user.isChoosed=YES;
        cell.accessoryType=  UITableViewCellAccessoryCheckmark;
    }
    else
    {
        if (user.isChoosed) {
            cell.accessoryType=  UITableViewCellAccessoryCheckmark;
           
        }else{
            cell.accessoryType=  UITableViewCellAccessoryNone;

        }
    }
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray *indexs=[[NSMutableArray alloc]init];
    for(RenWuUserGroupModel *group in groupDataArr){
        [indexs addObject:group.name];
    }
    return indexs;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    RenWuUserGroupModel *group=[groupDataArr objectAtIndex:section];
    return group.name;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (isSearch)
    {
        RenWuUsersModel *user= [_searchArr objectAtIndex:indexPath.row];
        
        if (user.isChoosed==YES){
            user.isChoosed=NO;
            cell.accessoryType=UITableViewCellAccessoryNone;
        }else if(user.isChoosed==NO){
            user.isChoosed=YES;
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        }
        
        
    }
    else
    {
        
        RenWuUserGroupModel *group= [groupDataArr objectAtIndex:indexPath.section];
        RenWuUsersModel *user= [group.users objectAtIndex:indexPath.row];
        
        if (user.isChoosed==YES){
            user.isChoosed=NO;
            cell.accessoryType=UITableViewCellAccessoryNone;
        }else if(user.isChoosed==NO){
            user.isChoosed=YES;
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        }
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end
