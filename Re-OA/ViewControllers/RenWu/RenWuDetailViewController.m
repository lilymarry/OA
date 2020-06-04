
#import "RenWuDetailViewController.h"
#import <MBProgressHUD.h>
#import "RenWuWebAPI.h"
#import "UserPermission.h"
#import "MyReceivedReWuDetailModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RenWuChengJieRenCell.h"
#import "RenWuTaopListModel.h"
#import "LargeImageView.h"
#import "CharacterHelper.h"

@interface RenWuDetailViewController (){
    NSMutableArray *dataArr;
    MyReceivedReWuDetailModel *model;
}

@end

@implementation RenWuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.tableview.dataSource=self;
    self.imgrenwu.userInteractionEnabled=YES;
    UITapGestureRecognizer *imgtapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRenWuLargeImage:)];
    [self.imgrenwu addGestureRecognizer:imgtapGesture];
}

-(void)viewWillAppear:(BOOL)animated{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"获取中...";
    
    [RenWuWebAPI requestReceivedDetailByUID:[UserPermission standartUserInfo].ID
                                    AndType:@"1"
                                    AndTAID:self.ta_id success:^(NSArray *renwulist){
                                        if (renwulist && renwulist.count>0) {
                                            
                                            
                                            NSDictionary *dict =[[NSDictionary alloc] initWithDictionary: renwulist[0]];
                                            
                                            model=[[MyReceivedReWuDetailModel alloc]initWithJson:[dict objectForKey:@"task"][0]];
                                            
                                            self.labUserName.text=model.username;
                                            self.labsdate.text=model.talssueddate;
                                            self.labedate.text=model.tastopdate;
                                            self.twTitle.text=model.taname;
                                            self.twContent.text=[CharacterHelper replacingTheBRToEnter:model.tadescription] ;
                                            
                                            NSString *flagStr=@"unarchived.png";
                                            if ([model.iscomplete isEqualToString:@"1"]) {
                                                flagStr=@"archived.png";
                                            }else if ([model.iscomplete isEqualToString:@"2"]){
                                                flagStr=@"archiving.png";
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
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    
    RenWuChengJieRenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quanbudetailcell" forIndexPath:indexPath];
    
    cell.labDate.text= taopmodel.Taop_Date_1;
    cell.labName.text=taopmodel.Taop_UserName;
    cell.twDesc.text=[CharacterHelper replacingTheBRToEnter:taopmodel.Taop_Description] ;
    cell.twTitle.text=([taopmodel.Taop_Comment isEqualToString:@"" ])?@"无评语":taopmodel.Taop_Comment;
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


























