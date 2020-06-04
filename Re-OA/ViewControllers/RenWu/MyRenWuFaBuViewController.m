
#import "MyRenWuFaBuViewController.h"
#import "MyReceivedReWuDetailModel.h"
#import <MBProgressHUD.h>
#import "RenWuWebAPI.h"
#import "UserPermission.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RenWuTaopListModel.h"
#import "FabuRenWuChengJieRenCell.h"
#import "LargeImageView.h"
#import "CharacterHelper.h"

@interface MyRenWuFaBuViewController (){
    NSMutableArray *dataArr;
    MyReceivedReWuDetailModel *model;
}

@end

@implementation MyRenWuFaBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"派发任务详情";
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.imgrenwu.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRenWuLargeImage:)];
    [self.imgrenwu addGestureRecognizer:imgtapGesture];
}

//评语
- (IBAction)writeThePingYu:(id)sender {
    
    NSInteger tag= ((UIButton*)sender).tag;
    NSDictionary *dict = [dataArr objectAtIndex:tag-1000000000];
    RenWuTaopListModel *taopmodel =[[RenWuTaopListModel alloc] initWithJson:dict];
    
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle: [[NSString alloc] initWithFormat:@"点评 %@ 的任务",taopmodel.Taop_UserName ]
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"点评",nil];
    theAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
    theAlert.tag=tag-1000000000;
    [theAlert show];
    
}
- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *pingyuStr=@"";
    if (theAlert.alertViewStyle == UIAlertViewStylePlainTextInput) {
        pingyuStr = [theAlert textFieldAtIndex:0].text;
    }
    if ([@"点评" isEqualToString:[theAlert buttonTitleAtIndex:buttonIndex]]) {
        
        NSInteger tag =theAlert.tag;
        NSDictionary *dict = [dataArr objectAtIndex:tag];
        RenWuTaopListModel *taopmodel =[[RenWuTaopListModel alloc] initWithJson:dict];
        
        
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"提交中...";
        
        
        [RenWuWebAPI sendADianpingByTaopid:taopmodel.Taop_Id
                            Anddescription:pingyuStr
                                   success:^(NSArray *resArr) {
                                       
                                       [dict setValue:pingyuStr forKey:@"Taop_Comment"];
                                       
                                       
                                       NSIndexPath *indexpath=[NSIndexPath indexPathForItem:tag inSection:0];
                                       FabuRenWuChengJieRenCell *cell =(FabuRenWuChengJieRenCell*)[self.tableview cellForRowAtIndexPath:indexpath];
                                       
                                       cell.twTitle.text=pingyuStr;
                                       cell.btnPingyu.hidden=YES;
                                       cell.twTitle.hidden=NO;
                                       
                                       [self.tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                       hud.labelText=@"已提交...";
                                       [hud hide:YES afterDelay:0.5];
                                       
                                   } fail:^{
                                       hud.labelText=@"提交失败...";
                                       [hud hide:YES afterDelay:0.5];
                                   }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"获取中...";
    
    [RenWuWebAPI requestReceivedDetailByUID:[UserPermission standartUserInfo].ID
                                    AndType:@"1"
                                    AndTAID:self.ta_id success:^(NSArray *renwulist){
                                        
                                        [hud hide:YES];
                                        
                                        if (renwulist && renwulist.count>0) {
                                            
                                            
                                            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: renwulist[0]];
                                            
                                            model=[[MyReceivedReWuDetailModel alloc]initWithJson:[dict objectForKey:@"task"][0]];
                                            
                                            self.labUserName.text=model.username;
                                            self.labsdate.text=model.talssueddate;
                                            self.labedate.text=model.tastopdate;
                                            self.twTitle.text=model.taname;
                                            self.twContent.text=[CharacterHelper replacingTheBRToEnter:model.tadescription] ;
                                            
                                            NSString *flagStr=@"archived.png";
                                            if ([model.iscomplete isEqualToString:@"1"]) {
                                                flagStr=@"archived.png";
                                            }else if ([model.iscomplete isEqualToString:@"2"]){
                                                flagStr=@"archiving.png";
                                            }else if ([model.iscomplete isEqualToString:@"3"]){
                                                flagStr=@"unarchived.png";
                                            }
                                            self.imgFlag.image=[UIImage imageNamed:flagStr];
                                            
                                            NSString *imgurlstr=[[RenWuWebAPI smallImgUrlPathWithUid:model.tauserid] stringByAppendingString:model.taimg];
                                            NSURL *url=[NSURL URLWithString:imgurlstr];
                                            [self.imgrenwu sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"nopicture"]];
                                            
                                            dataArr=[dict objectForKey:@"list"];
                                            [self.tableview reloadData];
                                            
                                        }
                                        [hud hide:YES];
                                    }  fail:^{
                                        [hud hide:YES];
                                        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                        [alert show];
                                    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
}
//quanbudetailcell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [dataArr objectAtIndex:indexPath.row];
    RenWuTaopListModel *taopmodel =[[RenWuTaopListModel alloc] initWithJson:dict];
    NSString *flagStr=@"unarchived.png";
    
    FabuRenWuChengJieRenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fabudetailcell" forIndexPath:indexPath];
    
    cell.btnPingyu.tag=indexPath.row+1000000000;
    cell.labDate.text= taopmodel.Taop_Date_1;
    cell.labName.text=taopmodel.Taop_UserName;
    cell.twDesc.text=[CharacterHelper replacingTheBRToEnter:taopmodel.Taop_Description] ;
    cell.twTitle.text=([taopmodel.Taop_Comment isEqualToString:@"" ])?@"无评语":taopmodel.Taop_Comment;
    
    if ([taopmodel.Taop_Comment isEqualToString:@""]) {
        cell.twTitle.hidden=YES;
        cell.btnPingyu.hidden=NO;
    }else{
        cell.twTitle.hidden=NO ;
        cell.btnPingyu.hidden=YES;
    }
    
    if ([taopmodel.Taop_IsSee isEqual:@2]) {
        cell.labDate.hidden=YES;
        cell.imgFlag.hidden=YES;
    }else if ([taopmodel.Taop_Iscomplete isEqualToString:@"1"] && [taopmodel.Taop_IsTimeout isEqualToString:@"2"]  ){
        flagStr=@"archived.png";
    }else if ([taopmodel.Taop_IsTimeout isEqualToString:@"1"]){
        flagStr=@"archiving.png";
    }
    cell.imgFlag.image=[UIImage imageNamed:flagStr];
    NSString *imgurlstr=[[RenWuWebAPI smallImgUrlPathWithUid:taopmodel.Taop_Userid] stringByAppendingString:taopmodel.Taop_Img];
    NSURL *url=[NSURL URLWithString:imgurlstr];
    [cell.imgview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"nopicture"]];
    cell.imgview.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLargeImage:)];
    cell.imgview.tag=100+indexPath.row;
    [cell.imgview addGestureRecognizer:imgtapGesture];
    return cell;
}

//查看图片
-(void)showLargeImage:(UITapGestureRecognizer*)gesture{
    
    int index= (int)gesture.view.tag-100;
    
    NSDictionary *dict = [dataArr objectAtIndex:index];
    RenWuTaopListModel *taopmodel =[[RenWuTaopListModel alloc] initWithJson:dict];
    
    NSString *imgurlstr=[[RenWuWebAPI largeImgUrlPathWithUid:taopmodel.Taop_Userid] stringByAppendingString:taopmodel.Taop_Img];
    
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:nil OrImgUrl:imgurlstr];
    [self.view.window addSubview:view];
}

//查看任务图片
-(void)showRenWuLargeImage:(UITapGestureRecognizer*)gesture{
    NSString *imgurlstr=[[RenWuWebAPI largeImgUrlPathWithUid:model.tauserid] stringByAppendingString:model.taimg];
    
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:nil OrImgUrl:imgurlstr];
    [self.view.window addSubview:view];
}


@end
