#import "CarPerController.h"
#import "CarLocationWebAPI.h"
#import "Pinyin.h"
#import "AlertHelper.h"
#define  kHeaderViewH 40

@interface CarPerController ()<UITextFieldDelegate>
{
    NSMutableArray *_personArr;
    NSMutableArray *_idxZimu;
    NSMutableDictionary *_nameArr;
    UITextField *_search;
    BOOL isSearch;
    NSMutableArray *_searchArr;
}
@end

@implementation CarPerController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _personArr=[NSMutableArray array];
    _nameArr =[NSMutableDictionary dictionary];
    _searchArr=[NSMutableArray array];
    if (!_isHideSearch) {
        [self addsearch];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self getData];
}
-(void)addsearch
{
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, self.view.frame.size.width, kHeaderViewH);
    _search=[[UITextField alloc]init];
    _search.frame=CGRectMake(5, 5, view.frame.size.width*0.65-5, view.frame.size.height-10);
    _search.autocapitalizationType=UITextAutocapitalizationTypeNone;
    _search.layer.borderWidth=0.5;
    _search.delegate=self;
    UIButton *sure=[UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame=CGRectMake(view.frame.size.width*0.65+10, 5, view.frame.size.width*0.15, view.frame.size.height-10);
    [sure setTitle:@"查找" forState:UIControlStateNormal];
    [sure setBackgroundImage:[UIImage imageNamed:@"btn11.png"] forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(searchEvent) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sure];
    [view addSubview:_search];
    self.tableView.tableHeaderView=view;
    self.tableView.bounces=NO;

}
-(void)getData
{
      [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.tableView];
      [CarLocationWebAPI getCarlistWithSuccess:^(NSArray *userList) {
      [AlertHelper hideAllHUDsForView:self.tableView];
        if (userList.count>0) {
            [_personArr removeAllObjects];
            [_personArr addObjectsFromArray:userList];
            _idxZimu=[NSMutableArray arrayWithArray:[self sort:userList]];
            [self.tableView reloadData];
        }
       } fail:^{
        [AlertHelper hideAllHUDsForView:self.tableView];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
}
-(NSArray *)sort:(NSArray *)arr
{
    NSMutableSet *zimu=[NSMutableSet set];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      char c=pinyinFirstLetter([obj[@"car_Nm"] characterAtIndex:0]);
      [zimu addObject:[NSString stringWithFormat:@"%c",c-32]];
    }];
    [_nameArr removeAllObjects];
    [[zimu allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section=[NSMutableArray array];
        for (int i=0; i<arr.count; i++) {
            char c=pinyinFirstLetter([arr[i][@"car_Nm"] characterAtIndex:0]);
            if ([obj isEqualToString:[NSString stringWithFormat:@"%c",c-32]]) {
                [section addObject:arr[i]];
            }
        }
        [_nameArr setObject:section forKey:obj];
        
    }];
    return [[zimu allObjects] sortedArrayUsingSelector:@selector(compare:)];
}
-(void)searchEvent
{
    [self.view endEditing:YES];
    isSearch=YES;
    if ([_search.text isEqualToString:@""]) {
        isSearch=NO;
        [self.tableView reloadData];
        return;
    }
    [_nameArr enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *uname=obj[@"car_Nm"];
            if ([uname rangeOfString:_search.text].location==NSNotFound) {
            }else
            {
                [_searchArr removeAllObjects];
                [_searchArr addObject:obj];
                [self.tableView reloadData];
            }
        }];
    }];
    if (_searchArr.count==0) {
        isSearch=NO;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"未找到匹配结果" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isSearch) {
        return 1;
    }else
        return _nameArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if (isSearch) {
        return _searchArr.count;
    }else
    {
        NSArray *arr=_nameArr[_idxZimu[section]];
        return arr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
        cell.backgroundColor=[UIColor clearColor];
    }
    if (isSearch) {
        cell.textLabel.text=_searchArr[indexPath.row][@"car_Nm"];
    }else
        cell.textLabel.text=_nameArr[_idxZimu[indexPath.section]][indexPath.row][@"car_Nm"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSearch) {
        _selectedBlock(_searchArr[indexPath.row][@"car_Nm"],_searchArr[indexPath.row][@"car_Id"]);
    }else
        _selectedBlock(_nameArr[_idxZimu[indexPath.section]][indexPath.row][@"car_Nm"],_nameArr[_idxZimu[indexPath.section]][indexPath.row][@"car_Id"]);
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (isSearch) {
        return nil;
    }else
        return _idxZimu;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (isSearch) {
        return nil;
    }else
        return _idxZimu[section];
}

@end
