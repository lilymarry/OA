
#import "MyRenWuQiTaRenViewController.h"
#import "RenWuTaopListModel.h"
#import "MyRenWuChengJieRenCell.h"
#import "RenWuWebAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LargeImageView.h"
#import "CharacterHelper.h"

@interface MyRenWuQiTaRenViewController ()

@end

@implementation MyRenWuQiTaRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

/*myrenwuchengjierencell*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [_dataArr objectAtIndex:indexPath.row];
    RenWuTaopListModel *model =[[RenWuTaopListModel alloc] initWithJson:dict];
    NSString *flagStr=@"unarchived.png";
    
    MyRenWuChengJieRenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myrenwuchengjierencell" forIndexPath:indexPath];
    cell.labDate.hidden=NO;
    cell.labDate.text= model.Taop_Date_1;
    cell.labName.text=model.Taop_UserName;
    cell.twDesc.text=[CharacterHelper replacingTheBRToEnter: model.Taop_Description];
    if ([model.Taop_IsSee isEqualToString:@"2"]) {
        cell.labDate.hidden=YES;
    }else if ([model.Taop_Iscomplete isEqualToString:@"1"] && [model.Taop_IsTimeout isEqualToString:@"2"]  ){
        flagStr=@"archived.png";
    }else if ([model.Taop_IsTimeout isEqualToString:@"1"]){
        flagStr=@"archiving.png";
    }
    cell.imgFlag.image=[UIImage imageNamed:flagStr];
    NSString *imgurlstr=[[RenWuWebAPI smallImgUrlPathWithUid:model.Taop_Userid] stringByAppendingString:model.Taop_Img];
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
    NSDictionary *dict = [_dataArr objectAtIndex:index];
    RenWuTaopListModel *model =[[RenWuTaopListModel alloc] initWithJson:dict];
    NSString *imgurlstr=[[RenWuWebAPI largeImgUrlPathWithUid:model.Taop_Userid] stringByAppendingString:model.Taop_Img];
    LargeImageView *view = [[LargeImageView alloc] initLargeImage:nil OrImgUrl:imgurlstr];
    [self.view.window addSubview:view];
}

@end











