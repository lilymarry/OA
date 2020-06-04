#import "GongDetailViewController.h"
#import "GongGaoWebAPI.h"
#import "AlertHelper.h"
#import "CharacterHelper.h"

@interface GongDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tittle;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *preson;

@end

@implementation GongDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"公告详情";
    if ( self.view.frame.size.height==812)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    }
-(void)viewWillAppear:(BOOL)animated{
   
    [AlertHelper MBHUDShow:@"获取中" ForView:self.view AndDelayHid:30];
   [GongGaoWebAPI gongGaoDetailedID:_neid success:^(NSArray *arr)
     {
         [AlertHelper hideAllHUDsForView:self.view];
         @try {
             _time.text=[arr[0]objectForKey:@"date"];
             _tittle.text=[arr[0]objectForKey:@"title"];
             _preson.text=[arr[0]objectForKey:@"username"];
             _content.text=[CharacterHelper replacingTheBRToEnter:[arr[0]objectForKey:@"description"]];
         }
         @catch (NSException *exception) {
         }}
    fail:^(){
        [AlertHelper hideAllHUDsForView:self.view];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
@end
