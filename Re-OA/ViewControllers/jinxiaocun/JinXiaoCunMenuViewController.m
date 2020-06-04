//
//  JinXiaoCunMenuViewController.m
//  Re-OA
//
//  Created by imac-1 on 2017/9/6.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "JinXiaoCunMenuViewController.h"
#import "MenuModel.h"
#import "JXCItemCell.h"
@interface JinXiaoCunMenuViewController ()
{
   NSMutableArray *menuData;
}
@end

@implementation JinXiaoCunMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib*nib = [UINib nibWithNibName:@"MenuListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"menuListCell"];

    
    menuData =[NSMutableArray new];
    MenuModel *m1= [[MenuModel alloc ] initWithNum:@"ylzj" AndName:@"原料质检" AndImageName:@"zhijian-412@3x.png" AndListImageName:@"zhijian-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"ZhiJian" AndStoryboardID:@"ZhiJian" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"ylrk" AndName:@"原料入库" AndImageName:@"yuanliaoruku-412@3x.png" AndListImageName:@"yuanliaoruku-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"RuKu" AndStoryboardID:@"RuKu" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"ylck" AndName:@"成品出库" AndImageName:@"chengpinchuku-412@3x.png" AndListImageName:@"chengpinchuku-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"ChuKu" AndStoryboardID:@"ChuKu" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"cccx" AndName:@"仓存查询" AndImageName:@"cangcun-412@3x.png" AndListImageName:@"cangcun-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"CangCun" AndStoryboardID:@"CangCun" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    
    
    
//    m1= [[MenuModel alloc ] initWithNum:@"ssbd" AndName:@"实时磅单" AndImageName:@"shishi-412@3x.png" AndListImageName:@"shishi-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"BangDan" AndStoryboardID:@"BangDan" AndparamsForController:nil ];
//    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"jgcx" AndName:@"价格查询" AndImageName:@"jiage-412@3x.png" AndListImageName:@"jiage-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"jiaGe" AndStoryboardID:@"Jiage" AndparamsForController:nil ];
    [menuData addObject:m1];
    
    m1= [[MenuModel alloc ] initWithNum:@"bjcx" AndName:@"报警" AndImageName:@"baojing-412@3x.png" AndListImageName:@"baojing-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"BaoJing" AndStoryboardID:@"baojing" AndparamsForController:nil ];
    
    [menuData addObject:m1];
    
    
    
    
    m1= [[MenuModel alloc ] initWithNum:@"sxt" AndName:@"监控视频" AndImageName:@"jiankongshipin-412@3x.png" AndListImageName:@"jiankongshipin-150@3x.png"   AndIsChangYong:NO   AndNibName:@"" AndStoryboardName:@"JianKong" AndStoryboardID:@"jiankong" AndparamsForController:nil];
    [menuData addObject:m1];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoLast:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuModel *menu= [menuData objectAtIndex:indexPath.row];     
    static NSString *identfier=@"JXCItemCell";
    JXCItemCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JXCItemCell" owner:self options:nil] lastObject];
    }
    cell.ima_imageView.image=[UIImage imageNamed:menu.listImageName];
    cell.lab_name.text=menu.name;
    return cell;
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    MenuModel *menu= [menuData objectAtIndex:indexPath.row];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:menu.storyboardName bundle:[NSBundle mainBundle]];
    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:menu.storyboardID];
    [self presentViewController:changyongController animated:YES completion:nil];

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;

}

@end
