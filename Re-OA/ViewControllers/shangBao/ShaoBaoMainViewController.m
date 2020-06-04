#import "ShaoBaoMainViewController.h"

#import "ShangBaoLiuTableViewController.h"
@interface ShaoBaoMainViewController ()

@end

@implementation ShaoBaoMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"renwuToIndexNavImg"] style:UIBarButtonItemStyleBordered                                                                       target:self    action:@selector(lastBtnPress:)];
    leftButton.enabled = YES;
    [self.navigationItem setLeftBarButtonItem:leftButton];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)lastBtnPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)selectBtnPress:(id)sender
{
    UIButton *but=(UIButton *)sender;
    switch (but.tag-1000)
    {
        case 1:
        {
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
        }break;
        case 2:
        {
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
            
        }break;
        case 3:
        {
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
        }break;
        case 4:
        {
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
            
        }break;
        case 5:
        {
            [self pushShangBaoliuViewControllerWithButtonTag:(int)but.tag-1000];
            
        }break;
    }
}
-(void)pushShangBaoliuViewControllerWithButtonTag:(int )tag
{
    ShangBaoLiuTableViewController *liu=[[UIStoryboard storyboardWithName:@"ShangBao" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ShangBaoliutable"];
    liu.buttag=tag;
    [self.navigationController pushViewController:liu animated:YES];
    
}
@end
