
#import "WeiShenHeDetailViewController.h"
#import "AlertHelper.h"
#import "ShenHeWebAPI.h"
#import "ShenHeDetailModel.h"
#import "ShenHeDetailCell.h"
//#import "ShenHeProcessCell.h"
#import "ShenHeProcessCell_1.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LargeImageView.h"
#import "UserPermission.h"
#import "JSONHelper.h"
#import "ScreenHelper.h"
#import "ShenHeBuTongYiChooseView.h"
#import "JieKuanCell.h"
#import "JieKuanModel.h"
#import "FukuanCell.h"
#import "FukuanModel.h"
#import "BaoXiaoCell.h"
#import "BaoXiaoModel.h"
#import "CharacterHelper.h"
//#import "ShangBaoMapViewController.h"
#import "ZhiZhangModel.h"
#import "ZhiZhangDetailViewCell.h"
#import "ShangBMapViewController.h"
#import "NingHeCell.h"
#import "NingHeModel.h"
#import "NingHePaperModel.h"
#import "NingHeCell2.h"
#import "NingHeKeHuInfoModel.h"
#import "NingHeKeHuInfoCell.h"
#import "NingHeShenGouShenHeModel.h"
#import "NingHeShenGouShenHeCell.h"
#import "NingHeCell2_1.h"
#import "NingHeShenGouModel.h"
#import "NewZhiZhangDetailViewCell.h"
@interface WeiShenHeDetailViewController ()<ShenHePicDelegate,NingHeCellPicDelegate,NingHeKeHuCellPicDelegate,NingHeShenGouShenHeCellPicDelegate>{
    NSMutableArray *sectionData;
    NSInteger handleIndex;
    UIView *bgView ; //遮罩层
}

@end

@implementation WeiShenHeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    handleIndex=100;
    UIBarButtonItem *rightItem= [[UIBarButtonItem alloc] initWithTitle:@"操作" style:UIBarButtonItemStylePlain target:self action:@selector(shenheHandle)];

    self.navigationItem.rightBarButtonItem=rightItem;
    
    sectionData=[NSMutableArray new];
    NSMutableArray *shangbaoOneArr=[NSMutableArray new];
    NSMutableArray *liuchengArr=[NSMutableArray new];
    NSDictionary *dict1=@{@"name":@"上报详情",@"process":shangbaoOneArr};
    NSDictionary *dict2=@{@"name":@"审核进度",@"process":liuchengArr};
    
    [sectionData addObject:dict1];
    [sectionData addObject:dict2];
    
    UINib*nib = [UINib nibWithNibName:@"ZhiZhangDetailViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"zhicell"];
    
    UINib*nib1 = [UINib nibWithNibName:@"NingHeCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"ningheCell"];
    
    UINib*nib2 = [UINib nibWithNibName:@"NingHeCell2" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"ningheCell2"];
    UINib*nib3 = [UINib nibWithNibName:@"NingHeKeHuInfoCell" bundle:nil];
    [self.tableView registerNib:nib3 forCellReuseIdentifier:@"ningheKeHuCell"];
    UINib*nib4 = [UINib nibWithNibName:@"NewZhiZhangDetailViewCell" bundle:nil];
    [self.tableView registerNib:nib4 forCellReuseIdentifier:@"newzhicell"];
}

//审核
-(void)shenheHandle{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"审核操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"同意" otherButtonTitles:@"驳回",@"不同意", nil];
    sheet.tag=10000;
    [sheet showInView:self.view.window];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            handleIndex=0;
            [self shenheYES];
            break;
        case 1:
            handleIndex=1;
            [self shenheNO];
            break;
        case 2:
            handleIndex=2;
            [self shenheUndo];
            break;
        default:  handleIndex=100;
            break;
    }
}
//同意
-(void)shenheYES{
    
    if ([_okbak isEqualToString:@"1"]) {
         [self dissAlert:@"同意"];
    }
     else
     {
        [self shenheHandleByTypeID:@"1" AndCon:@"" AndToFid:@""];
     }
}
//不同意
-(void)shenheNO{
    [self showThebgview];
    
    ShenHeBuTongYiChooseView *view =[[ShenHeBuTongYiChooseView alloc]  instanceChooseViewWithArrayData:self.toFsArr];
    self.closingPickViewNotification=view;
    view.submitDelegate= self;
    [self.view.window addSubview:view];
    
  
}
//驳回
-(void)shenheUndo{
    [self dissAlert:@"不同意"];
    
}
-(void)dissAlert:(NSString *)cont
{
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:cont
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定",nil];
    theAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [theAlert show];

}
-(void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (1==buttonIndex) {
        NSString *pingyuStr=@"";
        if (theAlert.alertViewStyle == UIAlertViewStylePlainTextInput) {
            pingyuStr = [theAlert textFieldAtIndex:0].text;
            NSString * encodingString = [pingyuStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if ([theAlert.title isEqualToString:@"不同意"]) {
                  [self shenheHandleByTypeID:@"3" AndCon:encodingString AndToFid:@""];
            }
            else {
                [self shenheHandleByTypeID:@"1" AndCon:encodingString AndToFid:@""];
            }
          
        }
    }
}
-(void)hasReadyForSubmitWithcon:(NSString *)con Andfsid:(NSString *)fsid{
    [self shenheHandleByTypeID:@"2" AndCon:con AndToFid:fsid];
    [self hidThebgview];
}
//审核处理
-(void)shenheHandleByTypeID:(NSString*)typid AndCon:(NSString*)con AndToFid:(NSString*)toFsId{
    [ShenHeWebAPI requestShenHeHandleByu_id:[UserPermission standartUserInfo].ID
                                   Andfpiid:self.fpiId
                                   AndadTyp:typid
                                    Andftyp:self.ftyp
                                  AndtoFsId:toFsId
                                     Andvoi:@""
                                     Andpic:@""
                                     Andcon:con
                                     Andtit:@""
                                    Andpric:@""
                                    success:^(NSArray *resArr) {
                                        NSDictionary *dict = [resArr lastObject];
                                        NSString *res= [dict valueForKey:@"rzt"];
                                        
                                        
                                        //0保存失败，1文件保存成功，2数据不全，3无权限，4流程已结束
                                        if ([@"0" isEqualToString:res]) {
                                            [AlertHelper singleMBHUDShow:@"审批失败" ForView:self.view AndDelayHid:2];
                                        }else if ([@"1" isEqualToString:res]){
                                            [AlertHelper singleAlertShow:@"审批成功"];
                                            NSObject<CommonNotification> *tmpDele=self.refreshNotification;
                                            [tmpDele refreshingDataList];
                                            [self.navigationController popViewControllerAnimated:YES];
                                        }else if ([@"2" isEqualToString:res]){
                                            [AlertHelper singleMBHUDShow:@"审批失败,数据不全" ForView:self.view AndDelayHid:2];
                                        }else if ([@"3" isEqualToString:res]){
                                            [AlertHelper singleMBHUDShow:@"无审批权限" ForView:self.view AndDelayHid:2];
                                        }else if ([@"4" isEqualToString:res]){
                                            [AlertHelper singleMBHUDShow:@"流程已结束" ForView:self.view AndDelayHid:2];
                                        }
                                        
                                    } fail:^{
                                        [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:2];
                                    }];
}

-(void)viewWillAppear:(BOOL)animated{
    @try {
        [AlertHelper singleMBHUDShow:@"获取中..." ForView:self.view];
        
        [ShenHeWebAPI requestListByfpiId:self.fpiId success:^(NSMutableArray *resArr){
            
            NSLog(@"WWWWWWWW %@",resArr);
            
            [AlertHelper hidMBHUDFromView:self.view];
            
            if (resArr && resArr.count>0) {
                
                NSDictionary *d= [resArr lastObject];
                NSMutableArray *rArr = [d valueForKey:@"fol"];
                
                if ([@"1" isEqualToString:self.cmtp]) {            //付
                    FuKuanModel *detailModel= [[FuKuanModel alloc] initWithJson:[rArr lastObject]];
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                }else if ([@"2" isEqualToString:self.cmtp]) {       //借
                    JieKuanModel *detailModel= [[JieKuanModel alloc] initWithJson:[rArr lastObject]];
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                }else if ([@"3" isEqualToString:self.cmtp]) {       //报
                    BaoXiaoModel *detailModel= [[BaoXiaoModel alloc] initWithJson:[rArr lastObject]];
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                }
                else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormPapePrice"])
                {
                    
                    ZhiZhangModel *detailModel= [[ZhiZhangModel alloc] initWithJson:[rArr lastObject]];
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                    
                }
                else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHPapePrice"])
                {
                    ZhiZhangModel *detailModel= [[ZhiZhangModel alloc] initWithJson:[rArr lastObject]];
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                    
                    
                }

                else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHMassErr"])
                {
                    
                    NingHeModel *detailModel= [[NingHeModel alloc] initWithJson:[rArr lastObject]];
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                    
                }
                else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNewNHSpPaper"])
                {
                    
                    NingHePaperModel *detailModel= [[NingHePaperModel alloc] initWithJson:[rArr lastObject]];
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                    
                }

                else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHSpPaper"])
                {
                    
                    NingHePaperModel *detailModel= [[NingHePaperModel alloc] initWithJson:[rArr lastObject]];
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                    
                }
                else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHCustomerInfo"])
                {
                    
                    NingHeKeHuInfoModel    *detailModel= [[NingHeKeHuInfoModel alloc] init];
                    [detailModel setValuesForKeysWithDictionary:[rArr lastObject]];
                    
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                    
                }
                else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHPurchase"])
                {
                    NingHeShenGouShenHeModel    *detailModel= [[NingHeShenGouShenHeModel alloc] init];
                    [detailModel setValuesForKeysWithDictionary:[rArr lastObject]];
                    
                    NSArray *array1 = [detailModel.txtMingChengXingHao componentsSeparatedByString:@"[&]"];
                    NSArray *array2 = [detailModel.txtDanWei componentsSeparatedByString:@"[&]"];
                    NSArray *array3 = [detailModel.txtBeiZhu componentsSeparatedByString:@"[&]"];
                    NSArray *array4 = [detailModel.txtShuLiang componentsSeparatedByString:@"[&]"];
                    NSMutableArray *arr=[NSMutableArray array];
                    for (int i=0; i<array1.count; i++) {
                        NingHeShenGouModel *model=[[NingHeShenGouModel alloc]init];
                        model.name=array1[i];
                        model.shuliang=array4[i];
                        model.dawei=array2[i];
                        model.beizhu=array3[i];
                        [arr addObject:model];
                        
                    }
                    detailModel.data=arr;
                    
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                }
                

                else{
                    ShenHeDetailModel *detailModel= [[ShenHeDetailModel alloc] initWithJson:[rArr lastObject]];
                    NSDictionary *dict1 = [sectionData objectAtIndex:0];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] removeAllObjects];
                    [(NSMutableArray*)[dict1 valueForKey:@"process"] addObject:detailModel];
                }
                NSDictionary *dict2 = [sectionData objectAtIndex:1];
                [(NSMutableArray*)[dict2 valueForKey:@"process"] removeAllObjects];
                for (NSDictionary *dic in rArr) {
                    ShenHeDetailModel *model= [[ShenHeDetailModel alloc] initWithJson:dic];
                    [(NSMutableArray*)[dict2 valueForKey:@"process"] addObject:model];
                }
                [self.tableView reloadData];
            }
            
        } fail:^{
            [AlertHelper hideAllHUDsForView:self.view];
            [AlertHelper singleMBHUDShow:@"网络请求数据失败" ForView:self.view AndDelayHid:1];
        }];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    }
-(NSString *)seachImageName:(NSString *)str
{
    
    if (str.length==0) {
        return nil;
    }
    else
    {
        NSString *st=@"楞";
        NSRange range = [str rangeOfString:st];//匹配得到的下标
        if (range.location !=NSNotFound)
        {
            str = [str substringFromIndex:range.length+range.location-1];//截取范围类的字符串
        }
        NSString *temp=str;
        
        if ( [temp hasPrefix:@"面"] )
        {
            return  @"ic_mian.png";
        }
        else if( [temp hasPrefix:@"芯"] )
        {
            return  @"ic_xin.png";
        }
        else if ([temp hasPrefix:@"里"])
        {
            return @"ic_li.png" ;
            
        }
        else
        {
            
            return  @"ic_leng.png";
        }
    }
}
-(NSString *)subString:(NSString *)str
{
    if (str.length==0)
    {
        return @"";
    }
    else
    {
        NSString *string=@" |材质：";
        NSRange range = [str  rangeOfString:string];//匹配得到的下标
        NSString *   temp = [str substringFromIndex:range.length+range.location];//截取范围类的字符串
        
        NSString *tem=[str substringToIndex:range.location];
        
        return [NSString stringWithFormat: @"%@%@",tem,temp];
    }
}
-(int)getviewnum:(ZhiZhangModel *)model
{
    int i=0;
    
    if (model.yi.length==0) {
        ;
    }
    else
    {
        i++;
    }
    
    if (model.er.length==0) {
        ;
    }
    else
    {
        i++;
    }
    
    if (model.san.length==0) {
        ;
    }
    else
    {
        i++;
    }
    
    if (model.si.length==0) {
        ;
    }
    else
    {
        i++;
    }
    if (model.wu.length==0) {
        ;
    }
    else
    {
        i++;
    }
    if (model.liu.length==0) {
        ;
    }
    else
    {
        i++;
    }
    if (model.qi.length==0) {
        ;
    }
    else
    {
        i++;
    }
    
    
    
    
    return i;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dict= [sectionData objectAtIndex:section];
    NSArray *dataArr= [dict valueForKey:@"process"];
    return dataArr.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dict= [sectionData objectAtIndex:section];
    return  [dict valueForKey:@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0==indexPath.section) {         //详情
        NSDictionary *dict= [sectionData objectAtIndex:indexPath.section];
        //付
        if ([self.cmtp isEqualToString:@"1"]) {
            FuKuanModel *model= [(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            FuKuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fukuancell"];
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PanJinCaiWu_fukuan" owner:nil options:nil];
                cell= [nibView lastObject];
            }
            
            cell.labctm.text=model.ctm;
            cell.labdoPNm.text=model.doPNm;
            cell.labfstate.text=model.fstate;
            
            cell.labBianHao.text=model.cont;
            cell.labFangShi.text=model.met;
            cell.labXiangMu.text=model.proj;
            cell.labJinE.text=model.num;
            cell.labYuE.text=model.extr;
            cell.labXingZhi.text=model.prop;
            cell.labFangShi.text=model.met;
            return cell;
            
        }else if ([self.cmtp isEqualToString:@"2"]){        //借
            
            JieKuanModel *model= [(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            JieKuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jiekuancell"];
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PanJinCaiWu_jiekuan" owner:nil options:nil];
                cell= [nibView lastObject];
            }
            
            cell.labctm.text=model.ctm;
            cell.labdoPNm.text=model.doPNm;
            cell.labfstate.text=model.fstate;
            
            cell.labJiekuanRen.text=model.pers;
            cell.labFangShi.text=model.met;
            cell.labGuaZhang.text=model.extr;
            cell.labBenCi.text=model.num;
            cell.LabYongTu.text=[CharacterHelper replacingTheBRToEnter: model.way];
            return cell;
            
        }else if ([self.cmtp isEqualToString:@"3"]){        //报
            BaoXiaoModel *model= [(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            BaoXiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baoxiaocell"];
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PanJinCaiWu_baoxiao" owner:nil options:nil];
                cell= [nibView lastObject];
            }
            
            cell.labctm.text=model.ctm;
            cell.labdoPNm.text=model.doPNm;
            cell.labfstate.text=model.fstate;
            
            cell.labBuMen.text=model.dep;
            cell.labFangShi.text=model.met;
            cell.labMingXi.text=[CharacterHelper replacingTheBRToEnter: model.det];
            cell.labJinE.text=model.num;
            cell.labFangShi.text=model.met;
            return cell;
            
        }
        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormPapePrice"])
        {
            ZhiZhangModel *model=[(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            
            
            ZhiZhangDetailViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"zhicell"];
            
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ZhiZhangDetailViewCel" owner:nil options:nil];
                cell= [nibView lastObject];
            }
            int num=[self getviewnum:model];
            float with = 45;
            if (num >=5) {
                with =self.view.frame.size.width/num;
            }
            
            
            cell. view_1.frame=CGRectMake(0, 89, with, 93);
            
            cell.view_2.frame=CGRectMake(CGRectGetMaxX( cell.view_1.frame), 89, with, 93);
            cell.view_3.frame=CGRectMake(CGRectGetMaxX( cell.view_2.frame), 89, with, 93);
            cell.view_4.frame=CGRectMake(CGRectGetMaxX( cell.view_3.frame),89, with, 93);
            cell.view_5.frame=CGRectMake(CGRectGetMaxX( cell.view_4.frame),89, with, 93);
            cell.view_6.frame=CGRectMake(CGRectGetMaxX( cell.view_5.frame), 89, with, 93);
            cell.view_7.frame=CGRectMake(CGRectGetMaxX( cell.view_6.frame), 89, with, 93);
            
            cell.lab_tit.text=model.khnm;
            cell.lab_zhiBanName.text=model.pbnm;
            cell.lab_1.text=[self subString:model.yi];
            cell.lab_2.text=[self subString:model.er];
            cell.lab_3.text=[self subString:model.san];
            cell.lab_4.text=[self subString:model.si];
            cell.lab_5.text=[self subString:model.wu];
            cell.lab_6.text=[self subString:model.liu];
            cell.lab_7.text=[self subString:model.qi];
            cell.lab_shangbaoRen.text=model.doPNm;
            cell.lab_state.text=model.fstate;
            
            cell.lab_time.text=model.ct;
            cell.lab_ref.text=[NSString stringWithFormat:@"%@ 元/m²",model.ref];;
            cell.lab_infer.text=[NSString stringWithFormat:@"%@ 元/m²", model.inrefer];;
            cell.lab_workp.text=[NSString stringWithFormat:@"%0.3f 元/m²", [self jisuanResult:model.report  andStr:model.inrefer ]];
            cell.lab_report.text=[NSString stringWithFormat:@"%@ 元/m²", model.report];;
            

            cell.imaV_1.image=[UIImage imageNamed:[self seachImageName:model.yi ] ];
            cell.imaV_2.image=[UIImage imageNamed:[self seachImageName:model.er ]];
            cell.imaV_3.image=[UIImage imageNamed:[self seachImageName:model.san ]];
            cell.imaV_4.image=[UIImage imageNamed:[self seachImageName:model.si ]];
            cell.imaV_5.image=[UIImage imageNamed:[self seachImageName:model.wu]];
            cell.imaV_6.image=[UIImage imageNamed:[self seachImageName:model.liu ]];
            cell.imaV_7.image=[UIImage imageNamed:[self seachImageName:model.qi ]];
            return  cell;
       
            
            
        }
        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHPapePrice"])
        {
            
            ZhiZhangModel *model=[(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            
            
            NewZhiZhangDetailViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"newzhicell"];
            
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NewZhiZhangDetailViewCel" owner:nil options:nil];
                cell= [nibView lastObject];
            }
            
            int num=[self getviewnum:model];
            float with = 45;
            if (num >=5) {
                with =self.view.frame.size.width/num;
            }
            
            
            cell. view_1.frame=CGRectMake(0, 89, with, 93);
            
            cell.view_2.frame=CGRectMake(CGRectGetMaxX( cell.view_1.frame), 89, with, 93);
            cell.view_3.frame=CGRectMake(CGRectGetMaxX( cell.view_2.frame), 89, with, 93);
            cell.view_4.frame=CGRectMake(CGRectGetMaxX( cell.view_3.frame),89, with, 93);
            cell.view_5.frame=CGRectMake(CGRectGetMaxX( cell.view_4.frame),89, with, 93);
            cell.view_6.frame=CGRectMake(CGRectGetMaxX( cell.view_5.frame), 89, with, 93);
            cell.view_7.frame=CGRectMake(CGRectGetMaxX( cell.view_6.frame), 89, with, 93);
            
            cell.lab_tit.text=model.khnm;
            cell.lab_zhiBanName.text=model.pbnm;
            cell.lab_1.text=[self subString:model.yi];
            cell.lab_2.text=[self subString:model.er];
            cell.lab_3.text=[self subString:model.san];
            cell.lab_4.text=[self subString:model.si];
            cell.lab_5.text=[self subString:model.wu];
            cell.lab_6.text=[self subString:model.liu];
            cell.lab_7.text=[self subString:model.qi];
            cell.lab_shangbaoRen.text=model.doPNm;
            cell.lab_state.text=model.fstate;
            
            cell.lab_time.text=model.ct;
            cell.lab_ref.text=[NSString stringWithFormat:@"%@ 元/m²",model.ref];;
            cell.lab_infer.text=[NSString stringWithFormat:@"%@ 元/m²", model.inrefer];;
            cell.lab_workp.text=[NSString stringWithFormat:@"%0.3f 元/m²", [self jisuanResult:model.report  andStr:model.inrefer ]];
            cell.lab_report.text=[NSString stringWithFormat:@"%@ 元/m²", model.report];;
            
            
            cell.imaV_1.image=[UIImage imageNamed:[self seachImageName:model.yi ] ];
            cell.imaV_2.image=[UIImage imageNamed:[self seachImageName:model.er ]];
            cell.imaV_3.image=[UIImage imageNamed:[self seachImageName:model.san ]];
            cell.imaV_4.image=[UIImage imageNamed:[self seachImageName:model.si ]];
            cell.imaV_5.image=[UIImage imageNamed:[self seachImageName:model.wu]];
            cell.imaV_6.image=[UIImage imageNamed:[self seachImageName:model.liu ]];
            cell.imaV_7.image=[UIImage imageNamed:[self seachImageName:model.qi ]];
     

            cell.la_1yao.text=model.xiuqiu1;
            cell.la_2yao.text=model.xiuqiu2;
            cell.la_3yao.text=model.xiuqiu3;
            cell.la_1jian.text=model.gouzhijianshu1;
            cell.la_2jian.text=model.gouzhijianshu2;
            cell.la_3jian.text=model.gouzhijianshu3;
            
            return  cell;
            
            
        }

        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHMassErr"])
        {
            
            NingHeModel *model=[(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            
            
            NingHeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ningheCell"];
            
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NingHeCell" owner:nil options:nil];
                cell= [nibView lastObject];
            }
            cell.delegate=self;
            
            if(model.pic)
            {
                NSArray *array = [model.pic componentsSeparatedByString:@"|"];
                [cell refresPictureView:array withUid:model.u_id            ];
            }
            cell.lab_khnm.text=model.khnm;
            cell.lab_odcode.text=model.odcode;
            cell.lab_size.text=model.size;
            cell.lab_pm.text=model.pm;
            cell.lab_odnum.text=model.odnum;
            cell.lab_err.text=model.err;
            cell.lab_reason.text=model.reason;
            cell.lab_opinion.text=model.opinion;
            cell.lab_time.text=model.ctm;
            
            cell.lab_shangbaoRen.text=model.doPNm;
            cell.lab_state.text=model.fstate;
            
            return  cell;
            
            
        }
        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHSpPaper"])
        {
            NingHePaperModel *model=[(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            NingHeCell2_1 *cell=[tableView dequeueReusableCellWithIdentifier:@"ningheCell2_1"];
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NingHeCell2_1" owner:nil options:nil];
                cell= [nibView lastObject];
            }
            cell.lab_khnm.text=model.khnm;
            cell.lab_pm.text=model.pm;
            cell.lab_size.text=model.size;
            cell.lab_odnum.text=model.odnum;
            cell.lab_batcha.text=model.batcha;
            cell.lab_montha.text=model.montha;
            cell.lab_remark.text=model.remark;
            cell.lab_time.text=model.ctm;
            cell.lab_shangbaoRen.text=model.doPNm;
            cell.lab_state.text=model.fstate;
            return  cell;
            
        }

        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNewNHSpPaper"])
        {
            
            NingHePaperModel *model=[(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            
            
            NingHeCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"ningheCell2"];
            
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NingHeCell2" owner:nil options:nil];
                cell= [nibView lastObject];
            }
            cell.lab_txtTGZZ.text=model.txtTGZZ;
            cell.lab_txtZF.text=model.txtZF;
            cell.lab_txtZBGG.text=model.txtZBGG;
            cell.lab_txtXQCCL.text=model.txtXQCCL;
            cell.lab_txtXWDHRQ.text=model.txtXWDHRQ;
            cell.lab_txtDPYL.text=model.txtDPYL;
            
            cell.lab_txtYYL.text=model.txtYYL;
            cell.lab_txtSYKH.text=model.txtSYKH;
            cell.lab_txtKHJSFS.text=model.txtKHJSFS;
            cell.lab_txtBZ.text=model.txtBZ;
            
            cell.lab_remark.text=model.remark;
            cell.lab_time.text=model.ctm;
            cell.lab_shangbaoRen.text=model.doPNm;
            cell.lab_state.text=model.fstate;
            
            
//            cell.delegate=self;
//            if(model.pic)
//            {
//                NSArray *array = [model.pic componentsSeparatedByString:@"|"];
//                [cell refresPictureView:array withUid:model.u_id];
//            }

            return  cell;
            
        }
        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHCustomerInfo"])
        {
            NingHeKeHuInfoModel *model=[(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            NingHeKeHuInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ningheKeHuCell"];
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NingHeKeHuInfoCell" owner:nil options:nil];
                cell= [nibView lastObject];
                
            }
            cell.delegate=self;
            
            if(model.pic)
            {
                NSArray *array = [model.pic componentsSeparatedByString:@"|"];
                [cell refresPictureView:array withUid:model.u_id            ];
            }
            
            cell.txtMingCheng.text=model.txtMingCheng;
            cell.txtDiZhi.text=model.txtDiZhi;
            cell.txtLianXiRen.text=model.txtLianXiRen;
            cell.txtDianHua.text=model.txtDianHua;
            cell.txtSanZheng.text=model.txtSanZheng;
            cell.txtHuanPing.text=model.txtHuanPing;
            cell.txtYueDingLiang.text=model.txtYueDingLiang;
            cell.txtShengChanZhi.text=model.txtShengChanZhi;
            
            cell.txtZiChan.text=model.txtZiChan;
            cell.txtZhangQi.text=model.txtZhangQi;
            cell.txtShuoMing.text=model.txtShuoMing;
            
            
            cell.lab_time.text=model.ctm;
            
            cell.lab_shangbaoRen.text=model.doPNm;
            cell.lab_state.text=model.fstate;
            
            
            return cell;
            
        }
        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHPurchase"])
        {
            NingHeShenGouShenHeModel *model= [(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            NingHeShenGouShenHeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShenHeDetailCell"];
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NingHeShenGouShenHeCell" owner:nil options:nil];
                cell= [nibView lastObject];
            }
//            cell.name.text=model.txtMingChengXingHao;
//            cell.danwei.text=model.txtDanWei;
//            cell.beizhu.text=model.txtBeiZhu;
//            cell.shuling.text=model.txtShuLiang;
            cell.lab_time.text=model.ctm;
             cell.data=model.data;
            cell.lab_shangbaoRen.text=model.doPNm;
            cell.lab_state.text=model.fstate;
             cell.delegate=self;
            if(model.pic)
            {
                NSArray *array = [model.pic componentsSeparatedByString:@"|"];
                [cell refresPictureView:array withUid:model.u_id            ];
            }
            return cell;
            
        }
        else{
            
            ShenHeDetailModel *model= [(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
            
            ShenHeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShenHeDetailCell"];
            if (!cell) {
                NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShenHeDetailCell" owner:nil options:nil];
                cell= [nibView lastObject];
            }
            cell.labcon.text=[NSString stringWithFormat:@"审核意见:%@",[CharacterHelper replacingTheBRToEnter: model.con]];
            cell.labctm.text=model.ctm;
            cell.labfnm.text=model.fnm;
            cell.labtit.text=model.tit;
            cell.labdoPNm.text=model.doPNm;
            cell.labpric.text=model.pric;
            cell.labfstate.text=model.fstate;
            
            cell.delegate=self;
            if(model.pic)
            {
                NSArray *array = [model.pic componentsSeparatedByString:@"|"];
                [cell refresPictureView:array withUid:model.u_id];
            }

            
            if (model.voi) {
                cell.imgvoi.userInteractionEnabled=YES;
                UITapGestureRecognizer *voitapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTheweiVoice:)];
                cell.imgvoi.tag=100+indexPath.section;
                [cell.imgvoi addGestureRecognizer:voitapGesture];
            }

            
            return cell;
        }
    }else{
        NSDictionary *dict= [sectionData objectAtIndex:indexPath.section];
        NSMutableArray *modelArr= [dict valueForKey:@"process"];
        ShenHeProcessCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ShenHeProcessCell_1"];
        if (!cell) {
            NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ShenHeProcessCell_1" owner:nil options:nil];
            cell= [nibView lastObject];
            
        }
        ShenHeDetailModel *model = [modelArr objectAtIndex:indexPath.row];
        cell.labcon.text= [CharacterHelper replacingTheBRToEnter:model.con];
        cell.labctm.text=model.ctm;
        cell.labfonm.text=model.fonm;
        cell.labtit.text=model.nowfs;
        cell.labdoPNm.text=model.doPNm;
        
        NSString *imgStr=@"ingcircle.png";
        if (0==indexPath.row && modelArr.count>1) {
            imgStr=@"endcircle.png";
            cell.labTop.hidden=YES;
        }else{
            cell.labTop.hidden=NO;
        }
        cell.imgCircle.image=[UIImage imageNamed:imgStr];
        
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0==indexPath.section) {
        if (([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormPapePrice"])||([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHSpPaper"]))
            
        {
            return 321;
        }
        else if (([@"" isEqualToString:self.cmtp]&& [_fmTp isEqualToString:@"FormNewNHSpPaper"])||([@"" isEqualToString:self.cmtp]&&[_fmTp isEqualToString:@"FormNHMassErr"]))
        {
            return 370;
        }
        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHCustomerInfo"])
        {
            return 492;
            
        }
        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHPurchase"])
        {
            return 335;
        }
        else if ([@"" isEqualToString:self.cmtp] && [_fmTp isEqualToString:@"FormNHPapePrice"])
        {
            return 524;
            
        }
        else
        {
            return 290;}
    }else{
        return 116;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        CGRect frame= CGRectMake(0, 0, 100, 40);
        UIView *view = [[UIView alloc] initWithFrame:frame ];
        view.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        CGRect labframe= CGRectMake(8, 16, 60, 16);
        UILabel *label = [[UILabel alloc] initWithFrame:labframe];
        label.font= [UIFont fontWithName:@"Helvetica" size:14];
        label.text=@"上报详情";
        label.textColor=[UIColor grayColor];
        [view addSubview:label];
        
        
        CGRect imgframe= CGRectMake([ScreenHelper SCREEN_WIDTH]-8-25, 10, 25, 25);
        UIImageView *img = [[UIImageView alloc] initWithFrame:imgframe];
        img.image= [UIImage imageNamed:@"location"];
        img.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMap:)];
        [img addGestureRecognizer:tapGesture];
        [view addSubview:img];
        
        
        
        return view;
    }
    return  nil;
}
-(double)jisuanResult:(NSString *)str1 andStr:(NSString *)str2
{
  
        return [str1 doubleValue]-[str2 doubleValue];

}
//查看上报地点
-(void)showMap:(UITapGestureRecognizer*)gesture{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]];

    ShangBMapViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"shangbMap"];
    controller.x=self.x;
    controller.y=self.y;
    [self.navigationController pushViewController:controller animated:YES];
}

//查看上报图片
-(void)showLargeImage:(UITapGestureRecognizer*)gesture{
    int index= (int)gesture.view.tag-100;
    
    NSDictionary *dict= [sectionData objectAtIndex:index];
    ShenHeDetailModel *model= [(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
    if (model.pic) {
          NSString *imgurlstr=[[ShenHeWebAPI largeImgUrlPathWithUid:model.u_id] stringByAppendingString:model.pic];
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:nil OrImgUrl:imgurlstr];
    [self.view.window addSubview:view];
    }
  
}
//播放音频
-(void)showTheweiVoice:(UITapGestureRecognizer*)gesture{
    int index= (int)gesture.view.tag-100;
    
    NSDictionary *dict= [sectionData objectAtIndex:index];
    ShenHeDetailModel *model= [(NSMutableArray*)[dict valueForKey:@"process"] lastObject];
    if (model.voi) {
            NSString *soundUrl=[[ShenHeWebAPI voiceUrlPathWithUid:model.u_id] stringByAppendingString:model.voi];
    
    NSURL *url=[NSURL URLWithString:soundUrl];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         AVAudioPlayer *player=[[AVAudioPlayer alloc]initWithData:data error:nil];
         self.avPlay = player;
         [self.avPlay play];
         
     }];
    }

}

//加载背景蒙板
-(void)showThebgview{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidThebgview)];
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
        NSObject<ShenHeNotification> *tmpDele=self.closingPickViewNotification;
        [tmpDele closingThePickViewChooseMode:^(){
            
        }];
    } ];
}
- (void)showDisPlayImageView:(NSString *)imaName andUserId:(NSString *)uid
{
  [self displayLargePic:imaName anduserId:uid];
    
}
-(void)showZhiLiangDisPlayImageView:(NSString *)imaName andUserId:(NSString *)uid
{
   [self displayLargePic:imaName anduserId:uid];
}
-(void)showKehuZhiLiangDisPlayImageView:(NSString *)imaName andUserId:(NSString *)uid
{
  [self displayLargePic:imaName anduserId:uid];
    
}
- (void)showShenGouZhiLiangDisPlayImageView:(NSString *)imaName andUserId:(NSString *)uid
{
    [self displayLargePic:imaName anduserId:uid];
}

-(void)displayLargePic:(NSString *)imaName anduserId:(NSString *)uid
{


    NSString *imgurlstr=[[ShenHeWebAPI largeImgUrlPathWithUid:uid] stringByAppendingString:imaName];
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:nil OrImgUrl:imgurlstr];
    [self.view.window addSubview:view];

}


@end
