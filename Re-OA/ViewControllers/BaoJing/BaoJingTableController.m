

#import "BaoJingTableController.h"
#import "BaoJingWebAPI.h"
#import "AlertHelper.h"
#import "BaoJingListModel.h"
#import "BaoJingParentCell.h"
#import "BaoJingChildCell.h"
#import "BaoJingDelegate.h"
#import "BackgroudView.h"
//#import "PlayerViewController.h"
#import "PlayerDemoViewController.h"
#import "BJLeiXingListView.h"
#import "ScreenHelper.h"
#import "Exchange16Color.h"
@interface BaoJingTableController ()<BaoJingPlayImageDelegate,selectLeiXingDelegate>{
    NSMutableArray *dataArr;
    int timerCount;
    NSTimer  *timer;
    UIView *bgView ; //遮罩层
    BOOL isChooseMode;
    BJLeiXingListView *view;
    NSString * leiXingStr;
    NSMutableArray *colorArr;
    NSMutableArray *_16ColorArr;
}

@end

@implementation BaoJingTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr= [NSMutableArray new];
    leiXingStr=@"";
   [self loadDataWithLeiXing:@""];
    [self reloadLeixing];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Color" ofType:@"plist"];
    _16ColorArr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    timer = [[NSTimer alloc] initWithFireDate:fireDate
                                     interval:1
                                       target:self
                                     selector:@selector(reloadTableViewData:)
                                     userInfo:nil
                                      repeats:YES];
    
    timerCount = 1;
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
    
}
-(void)reloadLeixing
{
    [BaoJingWebAPI    requestBaoJIngLeiXingSuccess:^(NSArray *arr){
    
        colorArr =[NSMutableArray arrayWithArray:arr];
    
    } fail:^(){}];

}
-(void)reloadTableViewData:(NSTimer*)theTimer
{
    
    timerCount++;
    if (dataArr.count>0)
    {
         BaoJingListModel *model= dataArr[0];
        [self TimeCountWithID:model.bjid];
        
    }
    else
    {
         [self TimeCountWithID:@"0"];
    }
}
-(void)TimeCountWithID:(NSString *)bjId
{   if (timerCount ==5)
    {
        [ self loadNewDataWithLeiXing:leiXingStr andId:bjId];
        timerCount=0;
    }
}
-(void)loadDataWithLeiXing:(NSString *)leiXing
{
    [BaoJingWebAPI requestBaoJingListWithjblx:leiXing Andpkey:@"" Andrnum:@"" Andtop:@"" Andiszx:@"1"  success:^(NSArray *arr){
        if ( arr.count>0) {
            [dataArr removeAllObjects];
            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
            NSArray *dictArr= [dict objectForKey:@"bjxx"];
            
            for (NSDictionary *dict1 in dictArr) {
                BaoJingListModel *model=[[BaoJingListModel alloc]initWithJson:dict1];
                [dataArr addObject:model];
            }
        }
        
        [self.tableView reloadData];
        
        
    } fail:^(){
        [AlertHelper singleMBHUDShow:@"网络请求出错!" ForView:self.tableView AndDelayHid:2];
    }];

}
-(void)viewWillAppear:(BOOL)animated{
   // [self loadDataWithLeiXing:@""];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [timer invalidate];
    
}
-(void)loadNewDataWithLeiXing:(NSString *)leiXing andId:(NSString *)bjid
{
    [BaoJingWebAPI requestNewBaoJingListWithjblx:leiXing Andpkey:bjid Andiszx:@"1" success:^(NSArray *arr){
        
        [UIView animateWithDuration:0.3 animations:^{
            
            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
            NSArray *dictArr= [dict objectForKey:@"bjxx"];
            dictArr=  [[dictArr reverseObjectEnumerator]allObjects];
            for (NSDictionary *dict1 in dictArr) {
               BaoJingListModel *model=[[BaoJingListModel alloc]initWithJson:dict1];
                [dataArr insertObject:model atIndex:0];
                 [self.tableView beginUpdates];
                NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
                [self.tableView endUpdates];
                
            }
            } completion:^(BOOL finished) {
            
            [self.tableView reloadData];
        }];
        
        
    } fail:^(){
        
        
        
    }];

}
- (IBAction)redirectToManScene:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)willAppearPlayViewHandle:(NSIndexPath *)indexPath{
    PlayerDemoViewController *plyerController = [[PlayerDemoViewController alloc] init];
    [self.navigationController pushViewController:plyerController animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaoJingListModel *model = [dataArr objectAtIndex:indexPath.row];
    
    if (model.isChild) {
        return 114;
    }else{
        return 68;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaoJingListModel *model = [dataArr objectAtIndex:indexPath.row];
    
    if (model.isChild) {
        BaoJingChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baojingchildcell"];
        if (!cell)
            cell=[BaoJingChildCell initWithNibAndIndexPath:indexPath AndTarget:self];
        
        cell.lab_bz.text=model.bz;
        cell.lab_cltm.text=model.cltm;
        cell.lab_ygno.text=model.ygno;
        cell.lab_carno.text=model.carno;
        return cell;
        
        
    }else{
        BaoJingParentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baojingparentcell"];
        if (!cell)
            cell=[BaoJingParentCell initWithNib];
        
        cell.lab_dq.text=model.dq;
        cell.lab_bjtm.text=model.bjtm;
        cell.lab_lxmc.text=model.lxmc;
        cell.lab_ssgc.text=model.ssgc;
        cell.contentView.backgroundColor= [self colorWithLeiXing:model.lxmc]; ;
        return cell;
        
    }
    
}
-(UIColor *)colorWithLeiXing:(NSString *)leixing
{
    
    for (int i=0; i<colorArr.count; i++)
    {
        if ([leixing isEqualToString:colorArr[i][@"jblxnm"]])
        {
           
             return  [  Exchange16Color colorWithHexString: _16ColorArr[i+1] ];
            
        }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BaoJingListModel *parentModel= [dataArr objectAtIndex:indexPath.row];
    if (parentModel.isChild==NO) {
        parentModel.isExpended= !parentModel.isExpended? YES:NO;
        
        NSIndexPath *newIndexPath= [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
        
        if (parentModel.isExpended) {
            BaoJingListModel *childModel= [parentModel copy];
            childModel.isChild=YES;
            [dataArr insertObject:childModel atIndex:indexPath.row+1];
            
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            [self.tableView endUpdates];
            
        }else{
            [dataArr removeObjectAtIndex:indexPath.row+1];
            NSIndexPath *newIndexPath= [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
            
            [self.tableView beginUpdates];
            [self.tableView  deleteRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            [self.tableView endUpdates];
        }
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)selectLeiXing:(id)sender
{
    if (!isChooseMode) {
        [self showThebgview];
        view =[[BJLeiXingListView alloc]  initWithFrame:CGRectMake(self.view.frame.size.width-200, 25, 200, self.view.frame.size.height-44)];
        view.dataDelegate=self;
        [self.view.window addSubview:view];
    }

    
}
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
//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    [view closingTheLittleMenu:nil];
    
}
-(void)selectLeiXingWithNum:(NSString *)row
{
    NSString *str=row;
    if([row isEqualToString:@"0"])
   {
       str =@"";
   
   }
    [self  loadDataWithLeiXing:str];
    leiXingStr =str;
    [self hidThebgview];
    [view closingTheLittleMenu:nil];
    
}


@end






















