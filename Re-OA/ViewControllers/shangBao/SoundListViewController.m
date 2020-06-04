#import "SoundListViewController.h"
@interface SoundListViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationBarDelegate>
{
    NSMutableArray *arr;
    NSMutableArray *arrMp3;
}
@property (nonatomic, strong)UINavigationBar * navibar;
@end
@implementation SoundListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"本地录音";
    arr =[NSMutableArray array];
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES);
    NSString * getUserDocumentDirectoryPath = [array objectAtIndex: 0];
    NSString *s=[NSString stringWithFormat:@"%@/%@",getUserDocumentDirectoryPath,@"record"];
    NSBundle *songBundle=[NSBundle bundleWithPath:s];
    NSString *bundlePath=[songBundle resourcePath];

    arrMp3=[NSMutableArray arrayWithArray: [NSBundle pathsForResourcesOfType:@"wmv" inDirectory:bundlePath]];
    NSString *str=@"record/";
    for (NSString *filePath in arrMp3)
    {
        NSRange range = [filePath rangeOfString:str];//匹配得到的下标
        NSString *   string = [filePath substringFromIndex:range.length+range.location];//截取范围类的字符串
        [arr addObject: string];
    }
    arrMp3=(NSMutableArray *)  [[arrMp3 reverseObjectEnumerator]allObjects];
    arr=(NSMutableArray *)  [[arr reverseObjectEnumerator]allObjects];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident=@"cel";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    cell.textLabel.text=arr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"soundName" object:arr[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {   [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSError *err;
        if( [fileMgr removeItemAtPath:[arrMp3 objectAtIndex:indexPath.row]  error:&err])
        {
            [arrMp3 removeObjectAtIndex:[indexPath row]];
            [arr removeObjectAtIndex:[indexPath row]];
        }
        
        [tableView endUpdates];
      
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
