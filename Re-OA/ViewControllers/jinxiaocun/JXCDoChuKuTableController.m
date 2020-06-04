

#import "JXCDoChuKuTableController.h"
#import "JinXiaoCunWebAPI.h"
#import "AlertHelper.h"
#import "JXCDoRuKuDocModel.h"
#import "JXCChuKuDocCell.h"
#import "JXCCommonAddCell.h"
#import "JXCDelegate.h"
#import "BackgroudView.h"
#import "JXCAddChuKuChooseView.h"
#import "JXCCommonChooseDataView.h"
#import "JXCChuKuDetailCell.h"
#import "JXCDoRuKuMXModel.h"
#import "JSONHelper.h"
#import "UserPermission.h"
#import "MJExtension.h"
#import "ZBarSDK.h"
#import "ZbarOverlayView.h"

@interface JXCDoChuKuTableController ()<JXCAddCellDelegate,JXCCommonChooseViewDelegate,JXCAddChooseViewDelegate,JXCRuKuDetailCellDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ZBarReaderViewDelegate>{
    
    NSString *dengjiid;
    
    NSMutableArray *sectionArr;     //分组数据
    
    NSMutableArray *docrowArr;      //磅单数据
    NSMutableArray *mxrowArr;       //明细信息
    
    NSMutableArray *dengjiArr;          //等级数据
    NSMutableArray *cangkuArr;          //仓库数据
    NSMutableDictionary *duoweiDict;    //剁位数据
    
    JXCAddChuKuChooseView *chooseView; //明细选取视图
    
    JXCCommonChooseDataView *dengjiChooseView; //等级选取视图
    JXCCommonChooseDataView *cangkuChooseView; //仓库选取视图
    JXCCommonChooseDataView *duoweiChooseView; //剁位选取视图
    ZBarReaderView * reader;
    ZbarOverlayView *_overLayView;
    
    
}

@end

@implementation JXCDoChuKuTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"成品出库";
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(submitRuKu)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    dengjiid=@"";
    
    docrowArr=[NSMutableArray new];
    mxrowArr=[NSMutableArray new];
    [mxrowArr addObject:@"add"];
    sectionArr=[NSMutableArray new];
    
    dengjiArr = [NSMutableArray new];
    cangkuArr = [NSMutableArray new];
    duoweiDict = [NSMutableDictionary new];
    
    NSDictionary *dict1=@{@"name":@"磅单详情",@"child":docrowArr};
    NSDictionary *dict2=@{@"name":@"明细信息",@"child":mxrowArr};
    
    [sectionArr addObject:dict1];
    [sectionArr addObject:dict2];
    
    dengjiChooseView = [JXCCommonChooseDataView initJXCCommonChooseDataViewAndTarget:self];
    dengjiChooseView.pickview.tag=888;
    cangkuChooseView = [JXCCommonChooseDataView initJXCCommonChooseDataViewAndTarget:self];
    cangkuChooseView.pickview.tag=999;
    duoweiChooseView = [JXCCommonChooseDataView initJXCCommonChooseDataViewAndTarget:self];
    duoweiChooseView.pickview.tag=1000;
    
    [self loadData];
}


//加载磅单数据
-(void)loadData{
    [AlertHelper singleMBHUDShow:@"获取中..." ForView:self.tableView];
    [JinXiaoCunWebAPI requestBangdanDetailForChuKuBybdid:self.bdid  success:^(NSArray *arr){
        
        [AlertHelper hideAllHUDsForView:self.tableView];
        
        NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
        NSArray *dictArr= [dict objectForKey:@"bd"];
        
        for (NSDictionary *dict1 in dictArr) {
            JXCDoRuKuDocModel *model=[[JXCDoRuKuDocModel alloc]initWithJson:dict1];
            [docrowArr addObject:model];
        }
        //  kfid    kfnm
        [cangkuArr addObjectsFromArray:[dict objectForKey:@"kf"]];
        [dengjiArr addObjectsFromArray:[dict objectForKey:@"hwlv"]];
        [self.tableView reloadData];
        
    } fail:^(){
        [AlertHelper hideAllHUDsForView:self.tableView];
        [AlertHelper singleMBHUDShow:@"网络请求失败!" ForView:self.tableView AndDelayHid:2];
    }];
}

//添加cell  被点击
-(void)clickingAddCellHandle{
    [BackgroudView  showTheBackgroudViewToView:self.view.window
                                  showedHandle:^(){
                                      chooseView=nil;
                                      chooseView = [[JXCAddChuKuChooseView alloc]
                                                    initJXCAddChuKuChooseViewForView:self.view.window
                                                    taget:self
                                                    closedHanld:^(){
                                                        [BackgroudView hidTheBackgroudviewFromParentView:self.view.window  hiddenHandle:nil];
                                                    }];
                                      chooseView.tf_KuFang.inputView= cangkuChooseView;
                                      chooseView.tf_DuoWei.inputView=duoweiChooseView;
                                  }
                                  hiddenHandle:^(){
                                      [chooseView didClosingTheView:^(){}];
                                  }];
}
-(void)scanTiaoMaPress
{
    
    [self init_camera];
    
}

//仓库，垛位视图选取
-(void)confirmChooseView:(UIPickerView *)pickview AtIndex:(NSInteger)index{
    if (pickview.tag==999) {
        if (cangkuArr.count>0) {
            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary:[cangkuArr objectAtIndex:index]];
            [chooseView.tf_KuFang resignFirstResponder];
            
            duoweiChooseView=nil;
            chooseView.tf_DuoWei.inputView=nil;
            duoweiChooseView=[JXCCommonChooseDataView initJXCCommonChooseDataViewAndTarget:self];
            duoweiChooseView.pickview. tag=1000;
            chooseView.tf_DuoWei.inputView=duoweiChooseView;
            
            if (index!=-1  &&  index != [chooseView.cangkuIndex integerValue]) {
                chooseView.tf_KuFang.text = [dict objectForKey:@"kfnm"];
                chooseView.cangkuIndex= [NSNumber numberWithInteger:index];
                chooseView.tf_DuoWei.text=nil;
                [self loadDuoweiDataByCangkuIndex:index];
            }
        }
        else{
            [AlertHelper singleMBHUDShow:@"无仓库数据" ForView:chooseView AndDelayHid:1];
            [chooseView.tf_KuFang resignFirstResponder];
        }
    }else if (pickview.tag==1000){
        if (cangkuArr.count>0) {
            NSString *kfid = [[cangkuArr objectAtIndex:[chooseView.cangkuIndex intValue]] objectForKey:@"kfid"] ;
            NSArray *arr = [duoweiDict objectForKey:kfid];
            if (arr.count>0) {
                NSDictionary *dict= [arr objectAtIndex:index];
                NSString *str= [dict valueForKey:@"dwnm"];
                chooseView.tf_DuoWei.text=str;
                chooseView.duoweiIndex= [NSNumber numberWithInteger:index];
                [chooseView.tf_DuoWei resignFirstResponder];
            }else{
                [AlertHelper singleMBHUDShow:@"无垛位数据" ForView:chooseView AndDelayHid:1];
                [chooseView.tf_DuoWei resignFirstResponder];
            }
            
        }else{
            [AlertHelper singleMBHUDShow:@"无仓库数据" ForView:chooseView AndDelayHid:1];
            [chooseView.tf_KuFang resignFirstResponder];
            [chooseView.tf_DuoWei resignFirstResponder];
        }
    } else if (pickview.tag==888){
        if (dengjiArr.count>0) {
            NSDictionary *dict= [dengjiArr objectAtIndex:index];
            [docrowArr removeAllObjects];
            [docrowArr addObject:dict];
            dengjiid= [dict valueForKey:@"djid"];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
            JXCChuKuDocCell *cell= (JXCChuKuDocCell*) [self.tableView cellForRowAtIndexPath:indexpath];
            
            [self.tableView beginUpdates];
            cell.tf_dengjitf.text= [dict valueForKey:@"djnm"];;
            [self.tableView endUpdates];
            [cell.tf_dengjitf resignFirstResponder];
        } else{
            [AlertHelper singleMBHUDShow:@"无等级数据" ForView:self.tableView AndDelayHid:1];
            [chooseView.tf_KuFang resignFirstResponder];
            [chooseView.tf_DuoWei resignFirstResponder];
        }
    }
}

//加载垛位数据，若已经加载过了，就不会联网获取
-(void)loadDuoweiDataByCangkuIndex:(NSInteger)cangkuindex{
    
    NSString *kfid = [[cangkuArr objectAtIndex:cangkuindex] objectForKey:@"kfid"] ;
    
    BOOL hasData=YES;
    if ([duoweiDict allKeys].count>0) {
        for (NSString *key in [duoweiDict allKeys]) {
            if (![kfid isEqualToString:key]) {
                hasData=NO;
                break;
            }
        }
    }else{
        hasData=NO;
    }
    
    
    if (!hasData) {
        chooseView.act_duowei.hidden=NO;
        [chooseView.act_duowei startAnimating];
        
        [JinXiaoCunWebAPI requestDuoWeiByCangKuID:kfid success:^(NSArray *arr){
            
            [chooseView.act_duowei stopAnimating];
            chooseView.act_duowei.hidden=YES;
            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: arr[0]];
            
            for (NSString *key in dict.allKeys) {
                if ([@"dw" isEqualToString:key]) {
                    [duoweiDict setObject:[dict objectForKey:@"dw"] forKey:kfid];
                    break;
                }
            }
            
        } fail:^(){
            [chooseView.act_duowei stopAnimating];
            chooseView.act_duowei.hidden=YES;
            [AlertHelper singleMBHUDShow:@"获取垛位信息失败" ForView:self.view AndDelayHid:2] ;
        }];
    }
    
    
}

//明细选取视图确认
-(void)confirmWithCangkuIndex:(NSNumber *)cangkuIndex AndDuoweiIndex:(NSNumber *)duoweiIndex AndShuliang:(NSString *)shuliang AndZhongliang:(NSString *)zhongliang{
    
    [chooseView didClosingTheView:^(){
        [BackgroudView hidTheBackgroudviewFromParentView:self.view.window  hiddenHandle:^(){
            
            JXCDoRuKuMXModel *mxModel= [[JXCDoRuKuMXModel alloc] init];
            //仓库
            NSDictionary *cangkudict =[[NSDictionary alloc] initWithDictionary:[cangkuArr objectAtIndex:[cangkuIndex integerValue]]];
            mxModel.kfmc=  [cangkudict objectForKey:@"kfnm"];
            mxModel.kfid=  [cangkudict objectForKey:@"kfid"];
            
            NSArray *arr = [duoweiDict objectForKey:mxModel.kfid];
            NSDictionary *dict= [arr objectAtIndex:[duoweiIndex integerValue]];
            
            mxModel.dwnm= [dict valueForKey:@"dwnm"];
            mxModel.dwid= [dict valueForKey:@"dwid"];
            
            mxModel.num=shuliang;
            mxModel.danw=@"";
            mxModel.kg=zhongliang;
            
            [mxrowArr insertObject:mxModel atIndex:mxrowArr.count-1];
            
            NSIndexPath *indexPath=   [NSIndexPath indexPathForRow:mxrowArr.count-2 inSection:1];
            [self.tableView beginUpdates];
            
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            
            [self.tableView endUpdates];
        }];
        
        
    }];
}
//删除明细
-(void)deleteCellHandleByRowIndex:(id)sender{
    
    JXCChuKuDetailCell *cell = (JXCChuKuDetailCell*)sender;
    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
    [mxrowArr removeObjectAtIndex:indexPath.row];
    
    [self.tableView beginUpdates];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.tableView endUpdates];
}

//提交出库
-(void)submitRuKu{
    [mxrowArr removeObjectAtIndex:mxrowArr.count-1];
    NSArray *mxDataArr= [[NSArray alloc] initWithArray:mxrowArr];
    
    if (mxDataArr.count>0) {
        NSArray *dictArray = [JXCDoRuKuMXModel keyValuesArrayWithObjectArray:mxDataArr];
        
        NSString *rkl=[JSONHelper toJSONData:dictArray];
        [AlertHelper singleMBHUDShow:@"提交中..." ForView:self.tableView];
        [JinXiaoCunWebAPI submiteChuKuWithuid:[UserPermission standartUserInfo].ID
                                      AndbdId:self.bdid
                                      Andhwlv:dengjiid
                                       Andrkl:rkl
                                      success:^(NSArray *arr){
                                          
                                          [AlertHelper hideAllHUDsForView:self.tableView];
                                          [AlertHelper singleAlertShow:@"提交成功"];
                                          if (self.commonNotification!=nil) {
                                              [self.commonNotification refreshingDataList];
                                          }
                                          [self.navigationController popViewControllerAnimated:YES];
                                      } fail:^(){
                                          [AlertHelper hideAllHUDsForView:self.tableView];
                                          [AlertHelper singleMBHUDShow:@"网络请求失败!" ForView:self.tableView AndDelayHid:2];
                                      }];
        
    }else{
        [AlertHelper singleMBHUDShow:@"至少要有一条明细！" ForView:self.tableView AndDelayHid:2];
    }
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
        
        NSInteger rowIndex=indexPath.row;
        if (rowIndex == mxrowArr.count-1) {
            return 50;
        }else{
            return 128;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0==indexPath.section) {         //详情
        NSDictionary *dict= [sectionArr objectAtIndex:indexPath.section];
        JXCDoRuKuDocModel *docModel =(JXCDoRuKuDocModel*)[ (NSMutableArray*)[dict valueForKey:@"child"] lastObject];
        JXCChuKuDocCell *cell = (JXCChuKuDocCell*)[tableView dequeueReusableCellWithIdentifier:@"jxcchukudoccell"];
        if (!cell)
            cell=[JXCChuKuDocCell initWithNib];
        
        cell.tf_dengjitf.inputView= dengjiChooseView;
        cell.lab_chepaihao.text=docModel.carno;
        cell.lab_bangdanhao.text=docModel.bdno;
        cell.lab_tihuodanwei.text=docModel.ghcmp;
        cell.lab_wuzimingcheng.text=docModel.wznm;
        
        return cell;
        
    }else{
        NSInteger rowIndex=indexPath.row;
        if (rowIndex == mxrowArr.count-1) {
            JXCCommonAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jxcaddcell"];
            if (!cell){
                cell=[[JXCCommonAddCell alloc] initWithNibWithModle:YES];
                cell.addCellDelegate=self;
            }
            return cell;
        }else{
            JXCDoRuKuMXModel *mxModel = [mxrowArr objectAtIndex:indexPath.row];
            JXCChuKuDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jxcchukudetailcell"];
            if (!cell){
                cell=[JXCChuKuDetailCell initJXCChuKuDetailCellForTarget:self];
            }
            cell.lab_num.hidden=YES;
            cell.lab_shuliang.text=mxModel.num;
            cell.lab_duoweihao.text= mxModel.dwnm;
            cell.lab_kufanghao.text=mxModel.kfmc;
            cell.lab_zhongliang.text=mxModel.kg;
            return cell;
        }
    }
    return nil;
}


#pragma mark - tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - pickview delegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==999) {
        return cangkuArr.count;
    }else  if (pickerView.tag==1000){
        if ([chooseView.cangkuIndex intValue]!=-1) {
            NSString *kfid = [[cangkuArr objectAtIndex:[chooseView.cangkuIndex intValue]] objectForKey:@"kfid"] ;
            NSArray *arr = [duoweiDict objectForKey:kfid];
            return arr.count;
        }
        return 0;
    }else  if (pickerView.tag==888){
        return dengjiArr.count;
    }
    return 0;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str=nil;
    if (pickerView.tag==999) {
        NSDictionary *dict= [cangkuArr objectAtIndex:row];
        str= [dict valueForKey:@"kfnm"];
    }else if (pickerView.tag==1000){
        if ([chooseView.cangkuIndex intValue]!=-1) {
            
            NSString *kfid = [[cangkuArr objectAtIndex:[chooseView.cangkuIndex intValue]] objectForKey:@"kfid"] ;
            NSArray *arr = [duoweiDict objectForKey:kfid];
            if (arr) {
                NSDictionary *dict= [arr objectAtIndex:row];
                str= [dict valueForKey:@"dwnm"];
            }
        }
        
    }else if (pickerView.tag==888){
        NSDictionary *dict= [dengjiArr objectAtIndex:row];
        str= [dict valueForKey:@"djnm"];
    }
    return str;
}
- (void) readerView:(ZBarReaderView *)readerView didReadSymbols: (ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * s = nil;
    for (s in symbols)
    {
        
        [reader removeFromSuperview];
      //  _txtVie_scan.text=s.data;
     //   NSLog(@"WWWW %@",_txtVie_scan.text);
        break;
    }
    
}


- (void) init_camera
{
    reader = [ZBarReaderView new];
    ZBarImageScanner * scanner = [ZBarImageScanner new];
    [scanner setSymbology:ZBAR_PARTIAL config:0 to:0];
    reader=   [reader initWithImageScanner:scanner];
    // [scanner release];
    reader.torchMode = 0;
    reader.readerDelegate = self;
    
    const float h = [UIScreen mainScreen].bounds.size.height;
    const float w = [UIScreen mainScreen].bounds.size.width;
    const float h_padding = w/4;
    const float v_padding = h / 3.0;
    CGRect reader_rect = CGRectMake(h_padding, v_padding-100,
                                    w * 0.5, h / 3.0);//视图中的一小块,实际使用中最好传居中的区域
    CGRect reader_rect1 = CGRectMake(0,0, w, h);//全屏模式
    reader.frame = reader_rect1;
    //reader.backgroundColor = [UIColor redColor];
    [reader start];
    
    
    [self.view addSubview: reader];
    //[reader release];
    
    _overLayView = [[ZbarOverlayView alloc]initWithFrame:reader.frame];//添加覆盖视图
    [_overLayView startAnimation];
    _overLayView.transparentArea = reader_rect;//设置中间可选框大小
    [reader addSubview:_overLayView];
    reader.scanCrop =[self getScanCrop:reader_rect readerViewBounds:reader_rect1];;// CGRectMake(100 / h,0.5, 1/3.0,0.4);
    
}


//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat fullWidth = readerViewBounds.size.width;
    CGFloat fullHeight = readerViewBounds.size.height;
    CGFloat x,y,width,height;
    x = rect.origin.x;
    y = rect.origin.y;
    width = rect.size.width;
    height = rect.size.height;
    if (x + width > fullWidth) {
        if (width > fullWidth) {
            width = fullWidth;
        }else{
            x = 0;
        }
    }
    if (y + height > fullHeight) {
        if (height > fullHeight) {
            height = fullHeight;
        }else{
            y = 0;
        }
    }
    CGFloat x1,y1,width1,height1;
    x1 = (fullWidth - width - x) / fullWidth;
    y1 = y / fullHeight;
    width1 = width / fullWidth;
    height1 = rect.size.height / readerViewBounds.size.height;
    
    NSLog(@"frame:%@",NSStringFromCGRect(CGRectMake(y1, x1,height1, width1)));
    return CGRectMake(y1, x1,height1, width1);
}


@end
