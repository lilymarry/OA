
#import "SecondMenuChooseViewController.h"
#import "MenuListCell.h"

@interface SecondMenuChooseViewController ()
{
    NSMutableArray *data;
}

@end

@implementation SecondMenuChooseViewController

@synthesize parentMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"";
    data = parentMenu.childMenu;
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
    
    if (menu.isChangYong==YES){
        cell.accessoryType= UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuListCell *cell = (MenuListCell*)[tableView cellForRowAtIndexPath:indexPath];
    MenuModel *menu= [data objectAtIndex:indexPath.row];
    
    if (menu.isChangYong==YES){
        menu.isChangYong=NO;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }else if(menu.isChangYong==NO){
        menu.isChangYong=YES;
        cell.accessoryType= UITableViewCellAccessoryCheckmark;
    }
    
}


@end
