
#import "JKQuYuViewController.h"
#import "PGCategoryView.h"
#import "AlertHelper.h"
#import "JianKongWebAPI.h"
#import "JianKongTableController.h"
@interface JKQuYuViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_leftTbale;
    UITableView *_rightTbale;
    UIView *_contentView;
    UILabel *label;
    NSMutableArray *dataArr;
    NSMutableArray *detailArr;
    NSString *gci;
    
}
@property (strong, nonatomic) PGCategoryView *categoryView;

@end

@implementation JKQuYuViewController
- (IBAction)gotoLast:(id)sender {
    
    [self dismissViewControllerAnimated: YES completion:nil];
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
    [JianKongWebAPI gongChangQuYuSuecss:^(NSArray *arr){
       
        [AlertHelper hideAllHUDsForView:self.view];
        [dataArr removeAllObjects];
         dataArr =[NSMutableArray arrayWithArray:arr[0][@"dqgc"]];
      
        [_leftTbale reloadData];
    } fail:^(){
        [AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];

    
    }];

    
}
-(void)addSubView
{
    int y=0;
  // && [[[UIDevice currentDevice] systemVersion]intValue]<9.0
    int  item=[[[UIDevice currentDevice] systemVersion]intValue];
    if(item==10||item==8 )
    {
        y=0;
    }
    else
    {
        y=64;
    }
  
    _contentView = [[UIView alloc] init];
    _contentView.frame = CGRectMake(self.view.bounds.size.width, 0,self.view.bounds.size.width, self.view.bounds.size.height);
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _contentView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_contentView];
    
   // UIView *view=[[UIView alloc]init];
    
//    view.frame=CGRectMake(0, 66, _contentView.frame.size.width, 60);
//    //view.layer.cornerRadius=10;
//    view.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    [_contentView addSubview:view];
//    
//   UILabel *  label=[[UILabel alloc] initWithFrame:CGRectMake(1, 1, view.frame.size.width, 20)];
//    label.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    label.text=@"选择厂区";
//
//    
//    label.font=[UIFont systemFontOfSize:10];
//    [view addSubview:label];
    
 
    _leftTbale = [[UITableView alloc] init];
    
    _leftTbale.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-y);
    
    _leftTbale.dataSource = self;
    _leftTbale.delegate = self;
    _leftTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _leftTbale.showsVerticalScrollIndicator = NO;
    [self.view insertSubview:_leftTbale belowSubview:_contentView];
    
    _rightTbale = [[UITableView alloc] init];
    _rightTbale.frame = CGRectMake(0,64, _contentView.bounds.size.width, _contentView.bounds.size.height-64);
    _rightTbale.dataSource = self;
    _rightTbale.delegate = self;
    _rightTbale.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _rightTbale.showsVerticalScrollIndicator = NO;
    //_rightTbale.tableFooterView = [[UIView alloc] init];
    [_contentView addSubview:_rightTbale];
    
    
    CGRect frame = _contentView.frame;
    frame.origin.x -= 30;
    frame.size.width = 30;
    _categoryView = [PGCategoryView categoryRightView:_contentView];
    _categoryView.frame = frame;
    [self.view addSubview:_categoryView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _leftTbale) {
      
        return dataArr.count;
    }else{
        return 1;
    }


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTbale) {
        NSDictionary *dic=dataArr[section];
   
        NSArray *arr=dic[@"gcxx"];

        return arr.count;
    }else{
        return detailArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTbale) {
        static NSString *identfier=@"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
            cell.backgroundColor=[UIColor clearColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
      
        NSDictionary *dic=dataArr[indexPath.section];
        NSArray *arr=dic[@"gcxx"];
        cell.textLabel.text=arr[indexPath.row][@"gcnm"];
        gci=arr[indexPath.row][@"gcid"];
        
        return  cell;
         }else{
             static NSString *identfier=@"cell1";
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
             if (!cell) {
                 cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
                 cell.backgroundColor=[UIColor clearColor];
                cell.accessoryType=UITableViewAutomaticDimension;
             }
             cell.textLabel.text=detailArr[indexPath.row][@"lxname"];
          
             return cell;
    }
}
#pragma mark - tableView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTbale) {
       
        NSDictionary *dic=dataArr[indexPath.section];
        NSArray *arr=dic[@"gcxx"];
        [self gongchangData:arr[indexPath.row][@"gcid"]];
        [_categoryView show];
    }
    else{
      JianKongTableController *tab=[[UIStoryboard storyboardWithName:@"JianKong" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"JK"];
        tab.lxid= detailArr[indexPath .row][@"lxid"];
        tab.gcid=gci;
        [self.navigationController pushViewController:tab animated:YES];
    }
    
}
-(void)gongchangData:(NSString *)gcid
{
     [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [JianKongWebAPI GongChangHuaFen:gcid Suecss:^(NSArray *arr){
        [AlertHelper hideAllHUDsForView:self.view];
        [detailArr removeAllObjects];
        detailArr =[NSMutableArray arrayWithArray:arr[0][@"lx"]];
        [_rightTbale reloadData];
    } fail:^(){
    [AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];
    }];

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView ==_leftTbale) {
        NSDictionary *dic=dataArr[section];
        if (dic.count >0) {
              return dic[@"dqnm"];
        }
        
       
    }
   
    return nil;
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
