#import "WeiShenHeViewController.h"
#import "AlertHelper.h"
#import "ShenHeWebAPI.h"
#import "ShenHeListCell.h"
#import "ShenHeListModel.h"
#import "UserPermission.h"

#import "ScreenHelper.h"
#import "ShenHeChooseModelBtnView.h"
#import "JSONHelper.h"
#import "WeiShenHeDetailViewController.h"
#import "CharacterHelper.h"
#import "MJRefresh.h"

@interface WeiShenHeViewController (){
    NSMutableArray *dataArr;
    UIView *bgView ; //遮罩层
   // int selectedTag;
    BOOL isChooseMode;
    NSString *typeidStr;
    ShenHeChooseView1 *choseview;
    
   // NSString *typeid;
    NSString *perid;
    NSString *stim;
    NSString *etim;
    NSString *Stitt;
    
    
    
}

@end

@implementation WeiShenHeViewController

- (void)viewDidLoad {
    typeidStr=@"1,2,3,4,5";
    isChooseMode=NO;
   // selectedTag=0;
    [super viewDidLoad];
    dataArr=[NSMutableArray new];
    UISwipeGestureRecognizer *leftgesture=  [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showTheChooseView:)];
    leftgesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftgesture];
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
-(void)refreshingDataList{
    [self.tableView headerBeginRefreshing];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [ShenHeWebAPI requestListByUID:[UserPermission standartUserInfo].ID
                           AndType:typeidStr
                        AndAdstate:@"0"
                              pkey:@""
                              rnum:@"0"
                                st:stim
                                et:etim
                             ouser:perid
                               titkey:Stitt
                           success:^(NSArray *renwulist){
                               
                            //   NSLog(@"ZZAZZZZZ %@",renwulist);
                               
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
                            AndAdstate:@"0"
                                  pkey:fpiid
                                  rnum:rnum
                                    st:stim
                                    et:etim
                                 ouser:perid
                                titkey:Stitt
                               success:^(NSArray *renwulist){
                                  // NSLog(@"+++ %@",renwulist);
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

//批量操作
-(void)actionSheetBtnHandle:(int)btnIndex{
    switch (btnIndex) {
        case 0:
            [self piliangYES];
            break;
        case 1:
            [self piliangNO];
            break;
        case 2:
            [self piliangUndo];
            break;
    }
}
//批量同意
-(void)piliangYES{
    [self piliangHandleByTypeID:@"1"];
}
//批量驳回
-(void)piliangNO{
    [self piliangHandleByTypeID:@"2"];
}
//批量不同意
-(void)piliangUndo{
    [self piliangHandleByTypeID:@"3"];
}
//批量处理
-(void)piliangHandleByTypeID:(NSString*)typid{
    NSMutableArray *selectedModelArr=[[NSMutableArray alloc]init];
    NSMutableArray *paramArr=[[NSMutableArray alloc]init];
    if ([self hasSelectSomeFPID:selectedModelArr]) {
        for (ShenHeListModel *shenheModel in selectedModelArr) {
            NSDictionary *dict=@{@"ftyp":shenheModel.ftyp,@"fpiid":shenheModel.fpiId};
            [paramArr addObject:dict];
        }
          [AlertHelper MBHUDShow:@"提交中---" ForView:self.view AndDelayHid:30];
        [ShenHeWebAPI requestApproveAnyByUID:[UserPermission standartUserInfo].ID
                                    AndadTyp:typid
                                      Andacl:[JSONHelper toJSONData:paramArr]
                                     success:^(NSArray *resArr){
                                           [AlertHelper hideAllHUDsForView:self.view];
                                         if ([resArr[0][@"rzt"] intValue ]==1 ) {
                                              [AlertHelper singleMBHUDShow:@"提交成功" ForView:self.view AndDelayHid:2];
                                         }
                                         else
                                         {
                                            [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
                                         }
                                        
                                           [self alertView:nil clickedButtonAtIndex:1];
                                           [self.tableView headerBeginRefreshing];
                                     }
                                        fail:^{
                                            [AlertHelper hideAllHUDsForView:self.view];
                                            [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
                                        }];
    }else{
        
        [AlertHelper singleMBHUDShow:@"至少选择一条审批信息" ForView:self.view AndDelayHid:2];
    }
    
}


-(BOOL)hasSelectSomeFPID:(NSMutableArray*)selectedModelArr{
    
    for (ShenHeListModel *shenheModel in dataArr) {
        if (shenheModel.isSeleted) {
            [selectedModelArr addObject:shenheModel];
        }
    }
    if (selectedModelArr.count>0) {
        return YES;
    }
    return NO;
}

//开启全选模式view
-(void)selectTheChooseBtn{
    isChooseMode=YES;
    [self hidThebgview];

        [UIView animateWithDuration:0.3 animations:^(){
            NSArray *cellArr=[self.tableView visibleCells];
            for (UITableViewCell *cell in cellArr) {
                cell.accessoryType= UITableViewCellAccessoryNone;
                cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
            }
            
            ShenHeChooseModelBtnView *view =[[ShenHeChooseModelBtnView alloc]  instanceChooseView];
            [self.view.window addSubview:view];
            self.closingChooseModeNotification= view;
            view.chooseAllDelegate=self;
        }];

}
//全选
-(void)chooseAll{
    for (ShenHeListModel *shenheModel in dataArr) {
        shenheModel.isSeleted=YES;
    }
    NSArray *cellArr=[self.tableView visibleCells];
    for (UITableViewCell *cell in cellArr) {
        cell.accessoryType= UITableViewCellAccessoryCheckmark;
    }
}
//取消全选
-(void)clearAll{
    for (ShenHeListModel *shenheModel in dataArr) {
        shenheModel.isSeleted=NO;
    }
    NSArray *cellArr=[self.tableView visibleCells];
    for (UITableViewCell *cell in cellArr) {
        cell.accessoryType= UITableViewCellAccessoryNone;
    }
}
//取消 选择模式
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1==buttonIndex) {
        isChooseMode=NO;
        for (ShenHeListModel *shenheModel in dataArr) {
            shenheModel.isSeleted=NO;
        }
        [UIView animateWithDuration:0.3 animations:^(){
            
            NSArray *cellArr=[self.tableView visibleCells];
            for (UITableViewCell *cell in cellArr) {
                cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
                cell.backgroundColor=[UIColor whiteColor];
            }
        }completion:^(BOOL finished){
            NSObject<ShenHeNotification> *tmpDele=self.closingChooseModeNotification;
            [tmpDele closingTheChooseMode];
        } ];
        
    }
}


//选择一个上报类别 通知controller 刷新数据
-(void)selectTheTypeID:(int)tid{
    [self hidThebgview];

        switch (tid) {
            case 1:
                self.navigationItem.title=@"未审核-财务";
                break;
            case 2:
                self.navigationItem.title=@"未审核-人事";
                break;
            case 3:
                self.navigationItem.title=@"未审核-行政";
                break;
            case 4:
                self.navigationItem.title=@"未审核-业务";
                break;
            case 5:
                self.navigationItem.title=@"未审核-生产";
                break;
            case 6:
                self.navigationItem.title=@"未审核-全部";
                break;
        }
        
        if (tid!=6) {
            typeidStr=[[NSString alloc] initWithFormat:@"%i",tid];
        }else{
            typeidStr=@"1,2,3,4,5";
        }

        [self.tableView headerBeginRefreshing];

    
}

//加载查询菜单view
- (IBAction)showTheChooseView:(id)sender {
    
    if (!isChooseMode) {
        [self showThebgview];
        int y=20;
        
        if ( self.view.frame.size.height==812)
        {
            y=64;
        }
     choseview =[[ShenHeChooseView1 alloc] initWithFrame:CGRectMake(120, y, self.view.frame.size.width-120, self.view.frame.size.height-y*2) andMode:YES ];
      choseview.dDelegate=self;

        [self.view.window addSubview:choseview];
        
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"放弃此次选择？" delegate:self cancelButtonTitle:@"继续" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
-(void)selectSheHeWithSt:(NSString *)st andName:(NSString *)name et:(NSString *)et type:(NSString *)type tittle:(NSString *)titt

{
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
    
    if (name.length==0||[name isEqualToString:@"k"]) {
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
-(void)selecPiliang
{
    isChooseMode=YES;
    [self hidThebgview];
         [UIView animateWithDuration:0.3 animations:^(){
            NSArray *cellArr=[self.tableView visibleCells];
            for (UITableViewCell *cell in cellArr) {
                cell.accessoryType= UITableViewCellAccessoryNone;
                cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
            }
            
            ShenHeChooseModelBtnView *view =[[ShenHeChooseModelBtnView alloc]  instanceChooseView];
            [self.view.window addSubview:view];
            self.closingChooseModeNotification= view;
            view.chooseAllDelegate=self;
        }];
}
//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    [choseview removeFromSuperview];

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
    ShenHeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shenhelistcell" forIndexPath:indexPath];
    cell.backgroundColor= (isChooseMode )?[UIColor groupTableViewBackgroundColor]:[UIColor whiteColor];
    cell.accessoryType= (isChooseMode)?UITableViewCellAccessoryNone:UITableViewCellAccessoryDisclosureIndicator;
    if (model.isSeleted) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    cell.labDate.text=model.ctm;
    cell.labDesc.text=[CharacterHelper replacingTheBRToEmpty:model.con] ;
    cell.labTitle.text=model.tit;
    cell.labNowfs.text=model.fnm;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isChooseMode) {
        ShenHeListModel *model = [dataArr objectAtIndex:indexPath.row];
        model.isSeleted=(model.isSeleted)?NO:YES;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType =(model.isSeleted)?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ShenHe" bundle:[NSBundle mainBundle]];
        WeiShenHeDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"weishenhedetail"];
        ShenHeListModel *model = [dataArr objectAtIndex:indexPath.row];
        controller.fpiId= model.fpiId;
        controller.ftyp= model.ftyp;
        controller.toFsArr= model.toFs;
        controller.cmtp=model.cmTp;
        controller.fmTp=model.fmTp;
        controller.x=model.x;
        controller.y=model.y;
        controller.okbak=model.okbak;
        controller.refreshNotification=self;
        [self.navigationController pushViewController:controller animated:YES ];    }
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

//返回主菜单
- (IBAction)redirectToManScene:(id)sender {
    if (isChooseMode) {
        [UIView animateWithDuration:0.3 animations:^(){
            NSObject<ShenHeNotification> *tmpDele=self.closingChooseModeNotification;
            [tmpDele closingTheChooseMode];
        }completion:^(BOOL finished){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end













