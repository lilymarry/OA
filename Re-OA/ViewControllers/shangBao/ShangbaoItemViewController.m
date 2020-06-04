//
//  ShangbaoItemViewController.m
//  Re-OA
//
//  Created by imac-1 on 2017/9/14.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "ShangbaoItemViewController.h"
#import "MenuModel.h"
#import "JXCItemCell.h"
#import "UserPermission.h"
#import "ShangBaoLiuTableViewController.h"
@interface ShangbaoItemViewController ()
{
    NSMutableArray *menuData;
}
@end

@implementation ShangbaoItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuData =[NSMutableArray new];
    
//    MenuModel *m1= [[MenuModel alloc ] initWithNum:@"cwsb" AndName:@"费用报销" AndImageName:@"baoxiao1.png" AndListImageName:@"baoxiao_1.png" AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [menuData addObject:m1];
//    
//    m1= [[MenuModel alloc ] initWithNum:@"rssb" AndName:@"财务上报" AndImageName:@"caiwu.png" AndListImageName:@"caiwu_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [menuData addObject:m1];
//    
//    m1= [[MenuModel alloc ] initWithNum:@"scsb" AndName:@"费用申请" AndImageName:@"shenqing.png"  AndListImageName:@"shenqing_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [menuData addObject:m1];
//    
//    m1= [[MenuModel alloc ] initWithNum:@"xzsb" AndName:@"行政上报" AndImageName:@"xingzheng.png" AndListImageName:@"xingzheng_1.png"    AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [menuData addObject:m1];
//    
//    m1= [[MenuModel alloc ] initWithNum:@"ywsb" AndName:@"业务上报" AndImageName:@"yewu.png"  AndListImageName:@"yewu_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
//    [menuData addObject:m1];
    
    
    
// #pragma ------old 上报列表
        MenuModel *m1= [[MenuModel alloc ] initWithNum:@"cwsb" AndName:@"财务上报" AndImageName:@"caiwu.png" AndListImageName:@"caiwu_1.png" AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
        [menuData addObject:m1];
    
        m1= [[MenuModel alloc ] initWithNum:@"rssb" AndName:@"人事上报" AndImageName:@"renshi.png" AndListImageName:@"renshi_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
        [menuData addObject:m1];
    
        m1= [[MenuModel alloc ] initWithNum:@"scsb" AndName:@"生产上报" AndImageName:@"shengchan.png"  AndListImageName:@"shengchan_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
        [menuData addObject:m1];
    
        m1= [[MenuModel alloc ] initWithNum:@"xzsb" AndName:@"行政上报" AndImageName:@"xingzheng.png" AndListImageName:@"xingzheng_1.png"    AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
        [menuData addObject:m1];
    
        m1= [[MenuModel alloc ] initWithNum:@"ywsb" AndName:@"业务上报" AndImageName:@"yewu.png"  AndListImageName:@"yewu_1.png"   AndIsChangYong:NO AndNibName:@"" AndStoryboardName:@"" AndStoryboardID:@"" AndparamsForController:nil ];
        [menuData addObject:m1];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)lastBtnPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
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
    
    NSString *menuKey= [UserPermission standartUserInfo].MenuRole;
    
    NSString *shangbaoKey= @"rssb,scsb,xzsb,ywsb,cwsb";
    NSDictionary *dict=@{@"rssb":@"2",@"scsb":@"5",@"xzsb":@"3",@"ywsb":@"4",@"cwsb":@"1"};

    MenuModel *menu= [menuData objectAtIndex:indexPath.row];
    
    NSRange range = [menuKey rangeOfString:menu.num];
    if ( range.location != NSNotFound)
    {
        NSRange range1 = [shangbaoKey rangeOfString:menu.num];
        if (range1.location != NSNotFound) {
            
            int tag =[[dict valueForKey:menu.num] intValue];
            
            ShangBaoLiuTableViewController *liu=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ShangBaoliutable"];
            liu.tittleStr=menu.name;
            liu.buttag=tag;
            [self presentViewController:liu animated:YES completion:nil];
            
        }
    
//    UIStoryboard *story = [UIStoryboard storyboardWithName:menu.storyboardName bundle:[NSBundle mainBundle]];
//    UINavigationController *changyongController = [story instantiateViewControllerWithIdentifier:menu.storyboardID];
//    [self presentViewController:changyongController animated:YES completion:nil];
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

@end
