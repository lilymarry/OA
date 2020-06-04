 
#import "JXCDetailChuKuTableController.h"
#import "JinXiaoCunWebAPI.h"
#import "AlertHelper.h"

#import "JXCChuKuDocCell.h"
//#import "JXCCommonAddCell.h"

#import "JXCChuKuDetailCell.h"
#import "JXCDoRuKuMXModel.h"
#import "UserPermission.h"
#import "MJExtension.h"
#import "JXCDoRuKuDocModel.h"

@interface JXCDetailChuKuTableController (){
    NSMutableArray *sectionArr;             //分组数据
    
    NSMutableArray *docrowArr;              //磅单数据
    NSMutableArray *mxrowArr;               //明细信息
    
    NSMutableArray *cangkuArr;              //仓库数据
    NSMutableDictionary *duoweiDict;        //剁位数据
}

@end

@implementation JXCDetailChuKuTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"出库详情";
 
    docrowArr=[NSMutableArray new];
    
    JXCDoRuKuDocModel *dModel= [[JXCDoRuKuDocModel alloc] init];
    dModel.carno= self.docModel.carno;
    dModel.bdno= self.docModel.bdno;
    dModel.lvnm= self.docModel.lvnm;
    dModel.wznm= self.docModel.wznm;
    dModel.ghcmp=self.docModel.songhdw;
  
    
    [docrowArr addObject:dModel];
    mxrowArr=[NSMutableArray new];
   
    sectionArr=[NSMutableArray new];
    
    NSDictionary *dict1=@{@"name":@"磅单详情",@"child":docrowArr};
    NSDictionary *dict2=@{@"name":@"明细信息",@"child":mxrowArr};
    
    [sectionArr addObject:dict1];
    [sectionArr addObject:dict2];
    
    [self loadData];
}


//加载数据
-(void)loadData{
    [AlertHelper singleMBHUDShow:@"获取中..." ForView:self.tableView];
    
    [JinXiaoCunWebAPI requestYiRuKuDetailWithbdid:self.docModel.bdid
                                       success:^(NSArray *arr){
        
        [AlertHelper hideAllHUDsForView:self.tableView];
        
        NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
        NSArray *dictArr= [dict objectForKey:@"crk"];
        
                                           int xuhao=1;
        for (NSDictionary *dict1 in dictArr) {
            JXCDoRuKuMXModel *model=[[JXCDoRuKuMXModel alloc]initWithJson:dict1];
            model.index=[NSString stringWithFormat:@"%d",xuhao];
            xuhao++;
            [mxrowArr addObject:model];
        }

        [self.tableView reloadData];
        
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.tableView];
        [AlertHelper singleMBHUDShow:@"网络请求失败!" ForView:self.tableView AndDelayHid:2];
    }];
}



#pragma mark - Table view data source
#pragma mark - section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dict= [sectionArr objectAtIndex:section];
    NSArray *dataArr= [dict valueForKey:@"child"];
    return dataArr.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dict= [sectionArr objectAtIndex:section];
    return  [dict valueForKey:@"name"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


#pragma mark - row
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0==indexPath.section) {
        return 215;
    }else{
            return 128;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0==indexPath.section) {         //详情
        NSDictionary *dict= [sectionArr objectAtIndex:indexPath.section];
        JXCDoRuKuDocModel *docModel =(JXCDoRuKuDocModel*)[ (NSMutableArray*)[dict valueForKey:@"child"] lastObject];
        JXCChuKuDocCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jxcchukudoccell"];
        if (!cell)
            cell=[JXCChuKuDocCell initWithNib];
        
        cell.tf_dengjitf.text= docModel.lvnm;
        cell.tf_dengjitf.userInteractionEnabled=NO;
        cell.lab_chepaihao.text=docModel.carno;
        cell.lab_bangdanhao.text=docModel.bdno;
        cell.lab_tihuodanwei.text=docModel.ghcmp;
        cell.lab_wuzimingcheng.text=docModel.wznm;
        
        return cell;
        
    }else{
 
            JXCDoRuKuMXModel *mxModel = [mxrowArr objectAtIndex:indexPath.row];
            JXCChuKuDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jxcchukudetailcell"];
            if (!cell){
                cell=[JXCChuKuDetailCell initJXCChuKuDetailCellForTarget:self];
            }
        
            cell.lab_shuliang.text=mxModel.num;
            cell.lab_duoweihao.text= mxModel.dwnm;
            cell.lab_kufanghao.text=mxModel.kfmc;
        cell.lab_zhongliang.text=mxModel.kg;
        cell.lab_num.text= mxModel.index;
        cell.btn_div.hidden=YES;
            return cell;
        }
       return nil;
}

@end
