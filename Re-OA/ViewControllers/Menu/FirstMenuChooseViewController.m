
#import "FirstMenuChooseViewController.h"
#import "SecondMenuChooseViewController.h"
#import "MenuModel.h"
#import "MenuListCell.h"
#import "NSUserDefaultsHelper.h"
@interface FirstMenuChooseViewController ()
{
    NSMutableArray *data;
}

@end

@implementation FirstMenuChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data=[MenuModel menuListOfFirstChoose];
}

//回退到主界面
- (IBAction)goBackViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
  
}

//保存常用菜单
- (IBAction)saveTheFavoriteMenuIDs:(id)sender {
    NSMutableArray *menuIDsArr=[NSMutableArray new];
    for (MenuModel *m in data) {
        if (m.isChangYong) {
            [menuIDsArr addObject:m.num];
        }
        if (m.childMenu&&m.childMenu.count>0) {
            for (MenuModel *m1 in m.childMenu) {
                if (m1.isChangYong) {
                    [menuIDsArr addObject:m1.num];
                }
            }
            
        }
    }
    [NSUserDefaultsHelper saveTheFavoriteMenu:menuIDsArr];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.refreshMenudelegate refreshingTheFavoriteMenus];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuListCell" forIndexPath:indexPath];
    
    MenuModel *menu= [data objectAtIndex:indexPath.row];
    
    
    cell.menuName.text=menu.name;
    cell.thumimage.image=[UIImage imageNamed:menu.listImageName];
    
    if (menu.childMenu!=nil && menu.childMenu.count>0) {
        cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    }else if (menu.isChangYong==YES&&menu.childMenu==nil){
        cell.accessoryType= UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuListCell *cell = (MenuListCell*)[tableView cellForRowAtIndexPath:indexPath];
    MenuModel *menu= [data objectAtIndex:indexPath.row];
    
    if (menu.childMenu!=nil && menu.childMenu.count>0) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SecondMenuChooseViewController *secondChooseController = [story instantiateViewControllerWithIdentifier:@"secondChooseController"];
        secondChooseController.parentMenu=menu;
        [self.navigationController pushViewController:secondChooseController animated:YES ];
    }
    
    if (menu.isChangYong==YES&&menu.childMenu==nil){
        menu.isChangYong=NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }else if(menu.isChangYong==NO&&menu.childMenu==nil){
        menu.isChangYong=YES;
        cell.accessoryType= UITableViewCellAccessoryCheckmark;
    }
}


@end
















