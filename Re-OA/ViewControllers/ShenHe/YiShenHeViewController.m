
#import "YiShenHeViewController.h"
#import "AlertHelper.h"
#import "ShenHeWebAPI.h"
#import "YiShenHeListCell.h"
#import "ShenHeListModel.h"
#import "UserPermission.h"
#import "ShenHeChooseView1.h"
#import "ScreenHelper.h"
#import "YiShenHeDetailViewController.h"
#import "MJRefresh.h"
#import "CharacterHelper.h"
#import "TimePicker.h"

@interface YiShenHeViewController (){
    NSMutableArray *dataArr;
    int selectedTag;
    UIView *bgView ; //遮罩层
    NSString *typeidStr;
    ShenHeChooseView1 *choseview;
    
    NSString *perid;
    NSString *stim;
    NSString *etim;
    
    NSString *Stitt;
}

@end

@implementation YiShenHeViewController

- (void)viewDidLoad {
    typeidStr=@"1,2,3,4,5";
    selectedTag=0;
    [super viewDidLoad];
    dataArr=[NSMutableArray new];
    perid=@"";
    stim=@"";
    etim=@"";
    Stitt=@"";
    [self setupRefresh];
}
-(void)viewWillAppear:(BOOL)animated{
}
- (void)setupRefresh
{
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [ShenHeWebAPI requestListByUID:[UserPermission standartUserInfo].ID
                           AndType:typeidStr
                        AndAdstate:@"1"
                              pkey:@""
                              rnum:@"0"
                                st:stim
                                et:etim
                             ouser:perid
                              titkey:Stitt
                           success:^(NSArray *renwulist){
                               
                               [dataArr removeAllObjects];
                               
                               if (renwulist && renwulist.count>0) {
                                   NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: renwulist[0]];
                                   NSArray *dictArr= [dict objectForKey:@"fpi"];
                                   for (NSDictionary *dict1 in dictArr) {
                                       ShenHeListModel *model=[[ShenHeListModel alloc]initWithJson:dict1];
                                       [dataArr addObject:model];
                                   }
                               }
                               [self.tableView reloadData];
                               //结束刷新状态
                               [self.tableView headerEndRefreshing];
                           } fail:^{
                               [self.tableView headerEndRefreshing];
                               
                               [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
                           }];
}

- (void)footerRereshing
{
    if (dataArr.count==0)
    {
        self.tableView.footerRefreshingText = @"无更新数据";
        [self.tableView footerEndRefreshing];
        return ;
    }
    else
    {
        ShenHeListModel *model=dataArr[0];
        NSString *fpiid=model.fpiId;
        ShenHeListModel *mode2=[dataArr lastObject];
        NSString *rnum=mode2.rNum;
        
        [ShenHeWebAPI requestListByUID:[UserPermission standartUserInfo].ID
                               AndType:typeidStr
                            AndAdstate:@"1"
                                  pkey:fpiid
                                  rnum:rnum
                                    st:stim
                                    et:etim
                                 ouser:perid
                                titkey:Stitt
                               success:^(NSArray *renwulist){
                                   
                                   // [dataArr removeAllObjects];
                                 //  NSLog(@"+++ %@",renwulist);
                                   if (renwulist && renwulist.count>0) {
                                       NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: renwulist[0]];
                                       NSArray *dictArr= [dict objectForKey:@"fpi"];
                                       for (NSDictionary *dict1 in dictArr) {
                                           ShenHeListModel *model=[[ShenHeListModel alloc]initWithJson:dict1];
                                           [dataArr addObject:model];
                                       }
                                   }
                                   [self.tableView reloadData];
                                   //结束刷新状态
                                   [self.tableView footerEndRefreshing];
                               } fail:^{
                                   [self.tableView footerEndRefreshing];
                                   
                                   [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
                               }];
    }
}


//加载查询菜单view
- (IBAction)showTheChooseView:(id)sender {
    [self showThebgview];
    int y=20;
    
    if ( self.view.frame.size.height==812)
    {
        y=64;
    }
    choseview =[[ShenHeChooseView1 alloc] initWithFrame:CGRectMake(120, y, self.view.frame.size.width-120, self.view.frame.size.height-y*2) andMode:NO ];
    choseview.dDelegate=self;

    [self.view.window addSubview:choseview];

  }
-(void)selectSheHeWithSt:(NSString *)st andName:(NSString *)name et:(NSString *)et type:(NSString *)type tittle:(NSString *)titt

{
    // NSLog(@"AAA %@ %@ %@  %@",st ,name,et ,type );
    
    int typ=[type intValue];
    
    if ([st isEqualToString:@"选择时间"]) {
        stim=@"";
    }
    else
    {
        stim=st;
    }
    if ([et isEqualToString:@"选择时间"]) {
        etim=@"";
    }
    else
    {
        etim=et;
    }
    //etim=et;
    
    if (name.length==0) {
        perid=@"";
    }
    else
    {
        perid=name;
    }
    if (titt.length==0) {
        Stitt=@"";
    }
    else
    {
        Stitt=titt;
    }
    [self selectTheTypeID:typ];
    
    [self removeTheView:nil];
    
}

//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
   [choseview removeFromSuperview];
}

//加载背景蒙板
-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
    tapGesture.numberOfTapsRequired=1;
    [bgView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.8;
    }completion:^(BOOL finished){
        
    } ];
}
//撤销背景蒙板
-(void)hidThebgview{
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}

//选择一个上报类别 通知controller 刷新数据
-(void)selectTheTypeID:(int)tid{
    [self hidThebgview];

        selectedTag=tid;
        
        switch (tid) {
            case 1:
                self.navigationItem.title=@"已审核-财务";
                break;
            case 2:
                self.navigationItem.title=@"已审核-人事";
                break;
            case 3:
                self.navigationItem.title=@"已审核-行政";
                break;
            case 4:
                self.navigationItem.title=@"已审核-业务";
                break;
            case 5:
                self.navigationItem.title=@"已审核-生产";
                break;
            case 6:
                self.navigationItem.title=@"已审核-全部";
                break;
        }
        
        if (tid!=6) {
            typeidStr=[[NSString alloc] initWithFormat:@"%i",tid];
        }else{
            typeidStr=@"1,2,3,4,5";
        }
 
         [self.tableView headerBeginRefreshing];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShenHeListModel *model = [dataArr objectAtIndex:indexPath.row];
    YiShenHeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yishenhelistcell" forIndexPath:indexPath];
    
    cell.labDate.text=model.ctm;
    cell.labDesc.text=[CharacterHelper replacingTheBRToEmpty:model.con] ;
    cell.labTitle.text=model.tit;
    cell.labfnm.text=model.fnm;
    cell.imgFlag.hidden = NO;
    if (![model.fstate isEqualToString:@"审核中"]) {
        cell.imgFlag.hidden = YES;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ShenHe" bundle:[NSBundle mainBundle]];
    YiShenHeDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"yishenhedetail"];
    ShenHeListModel *model = [dataArr objectAtIndex:indexPath.row];
    controller.fpiId= model.fpiId;
    controller.ftyp= model.ftyp;
    controller.fmTp=model.fmTp;
    controller.cmtp=model.cmTp;
    controller.x=model.x;
    controller.y=model.y;
    [self.navigationController pushViewController:controller animated:YES ];
    
}

- (IBAction)redirectToManScene:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end













