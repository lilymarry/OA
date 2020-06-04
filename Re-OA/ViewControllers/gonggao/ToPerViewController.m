#import "ToPerViewController.h"
#import "PersonCell.h"
#import "GongGaoWebAPI.h"
#import "UserPermission.h"
#import "ScreenHelper.h"
#import "AlertHelper.h"
#import "Pinyin.h"
@interface ToPerViewController ()
{
    NSMutableArray *_allPer;
    NSMutableArray *_selectedPer;
    NSMutableArray *_selectedUid;
    UITextField *_search;
    BOOL isSearch;
    NSMutableDictionary *_nameArr;
    NSMutableArray *_searchArr;
    NSMutableArray *_idxZimu;
    BOOL allSele;
    NSMutableArray *indexArr;
}
@end

@implementation ToPerViewController

-(id)initWithBlock:(finishBlock)ablock
{
    if (self=[super init]) {
        
        
        _block=[ablock copy];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection=YES;
    
    _allPer=[NSMutableArray array];
    _selectedPer=[NSMutableArray array];
    _selectedUid=[NSMutableArray array];
    indexArr = [NSMutableArray new];
    allSele=NO;
    _idxZimu=[NSMutableArray array];
    [self addsearch];
    UIBarButtonItem *com=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishSelected)];
    com.tintColor=[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem =com;
    [self getData];
    _nameArr =[NSMutableDictionary dictionary];
    _searchArr =[NSMutableArray array];
   NSLog(@"gonggao ");
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(void)getData
{
    [AlertHelper MBHUDShow:@"获取中" ForView:self.view AndDelayHid:30];
    [GongGaoWebAPI gongGaoPresonRequestlistID:[UserPermission standartUserInfo].ID success:^(NSArray *userList)
     {
         [AlertHelper hideAllHUDsForView:self.view];
         
         [_allPer removeAllObjects];
         [_allPer addObjectsFromArray:userList];
         _idxZimu=[NSMutableArray arrayWithArray:[self sort:userList]];
         [self.tableView reloadData];
     }
        fail:^(){[AlertHelper hideAllHUDsForView:self.view];
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];}];
}
-(void)allSelectBtnPress:(id)sender
{
    [indexArr removeAllObjects];
     allSele=allSele?NO:YES;
    [self.tableView reloadData];
}

-(NSArray *)sort:(NSArray *)arr
{
    NSMutableSet *zimu=[NSMutableSet set];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        char c=pinyinFirstLetter([obj[@"name"] characterAtIndex:0]);
        [zimu addObject:[NSString stringWithFormat:@"%c",c-32]];
    }];
    [_nameArr removeAllObjects];
    [[zimu allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section=[NSMutableArray array];
        for (int i=0; i<arr.count; i++) {
            char c=pinyinFirstLetter([arr[i][@"name"] characterAtIndex:0]);
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
    [indexArr removeAllObjects];
    [self.view endEditing:YES];
    isSearch=YES;
    if (_searchArr !=nil)
    {
        [_searchArr removeAllObjects];
        
    }
    if ([_search.text isEqualToString:@""]) {
        isSearch=NO;
        [self.tableView reloadData];
        return;
    }
    [_nameArr enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *uname=obj[@"name"];
            if ([uname rangeOfString:_search.text].location==NSNotFound) {
            }else
            {
                [_searchArr addObject:obj];
            }
        }];
        [self.tableView reloadData];
    }];
    if (_searchArr.count==0) {
        isSearch=NO;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"未找到匹配结果" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)finishSelected
{
    if (allSele) {
        if (isSearch)
        {
            for (id search in _searchArr) {
                [_selectedPer addObject:search[@"name"]];
                [_selectedUid addObject:search[@"id"]];
            }
        }
        else
        {
            for (id person in _allPer) {
                [_selectedPer addObject:person[@"name"]];
                [_selectedUid addObject:person[@"id"]];
            }
        }
    }else{
        if (isSearch)
        {
            for (NSIndexPath *indexPath in indexArr) {
                [_selectedPer addObject:_searchArr[indexPath.row][@"name"]];
                [_selectedUid addObject:_searchArr[indexPath.row][@"id"]];
            }
        }
        else
        {
            for (NSIndexPath *indexPath in indexArr) {
                [_selectedPer addObject:_nameArr[_idxZimu[indexPath.section]][indexPath.row][@"name"]];
                [_selectedUid addObject:_nameArr[_idxZimu[indexPath.section]][indexPath.row][@"id"]];
            }
        }
    }
    
    if (_block)
    {
        _block(_selectedPer,_selectedUid);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    static NSString *ident=@"PersonCell";
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    cell.selectState.hidden=YES;
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"PersonCell" owner:self options:nil] lastObject];
    }
    if (isSearch) {
        cell.textLabel.text=_searchArr[indexPath.row][@"name"];
    }else
    {   cell.textLabel.text=_nameArr[_idxZimu[indexPath.section]][indexPath.row][@"name"];
        
    }
    if (allSele)
    {
        cell.accessoryType=  UITableViewCellAccessoryCheckmark;
    }
    else
    {
        if ([indexArr containsObject:indexPath]) {
            cell.accessoryType=  UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType=  UITableViewCellAccessoryNone;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCell *cell = (PersonCell*)[tableView cellForRowAtIndexPath:indexPath];

    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    [indexArr addObject:indexPath];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCell *cell = (PersonCell*)[tableView cellForRowAtIndexPath:indexPath];

    cell.accessoryType=UITableViewCellAccessoryNone;
    [indexArr removeObject:indexPath];
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
