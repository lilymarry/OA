#import "YzjDetailViewController.h"
#import "JinXiaoCunWebAPI.h"
#import "UserPermission.h"
#import "AlertHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface YzjDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab_bdnum;
@property (weak, nonatomic) IBOutlet UILabel *lab_carNum;
@property (weak, nonatomic) IBOutlet UILabel *tf_zaWuWeight;
@property (weak, nonatomic) IBOutlet UILabel *tf_zazhiWeight;
@property (weak, nonatomic) IBOutlet UILabel *tf_zaPapperweiht;
@property (weak, nonatomic) IBOutlet UILabel *tf_jinZhongWeight;
@property (weak, nonatomic) IBOutlet UILabel *tf_maoWeight;
@property (weak, nonatomic) IBOutlet UILabel *tf_zaWuWeightBi;
@property (weak, nonatomic) IBOutlet UILabel*tf_zazhiWeightBi;
@property (weak, nonatomic) IBOutlet UILabel *tf_zaPapperweihtBi;
@property (weak, nonatomic) IBOutlet UILabel *tf_dengji;
@property (weak, nonatomic) IBOutlet UILabel *tf_kg;
@property (weak, nonatomic) IBOutlet UILabel *tf_baifenbi;
@property (weak, nonatomic) IBOutlet UILabel *tf_shuifen;
@property (weak, nonatomic) IBOutlet UILabel *tf_num;
@property (weak, nonatomic) IBOutlet UILabel *tf_Person;
@property (weak, nonatomic) IBOutlet UITextView *tv_beizhu;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation YzjDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [AlertHelper singleMBHUDShow:@"获取中--" ForView:self.view];
    [JinXiaoCunWebAPI getYcrklistDataWithbdId:_model.bdid userId:[UserPermission standartUserInfo].ID success:^(NSArray *arr){
       [AlertHelper hideAllHUDsForView:self.view];
        NSLog(@"WWW %@",arr);
        NSArray *zhijArr=[arr[0]objectForKey:@"zjd"];
        _lab_bdnum.text=[zhijArr[0]objectForKey:@"bdno"];
        _lab_carNum.text=[zhijArr[0]objectForKey:@"carno"];
        _tf_zaWuWeightBi.text=[zhijArr[0]objectForKey:@"zawu"];
        _tf_zazhiWeightBi.text=[zhijArr[0]objectForKey:@"zazhi4"];
        _tf_zaPapperweihtBi.text=[zhijArr[0]objectForKey:@"zazhi3"];
        _tf_dengji.text=[zhijArr[0]objectForKey:@"hwlv"];
        _tf_kg.text=[zhijArr[0]objectForKey:@"koukg"];
        _tf_baifenbi.text=[zhijArr[0]objectForKey:@"koupct"];
        _tf_shuifen.text=[zhijArr[0]objectForKey:@"shuifen"];
        _tf_num.text=[zhijArr[0]objectForKey:@"jianshu"];
        _tf_Person.text=[zhijArr[0]objectForKey:@"ren"];
        _tv_beizhu.text=[zhijArr[0]objectForKey:@"beizhu"];
          NSArray *baoArr=[arr[0]objectForKey:@"cb"];
        _tf_zaWuWeight.text=[baoArr[0]objectForKey:@"zawukg"];
        _tf_zazhiWeight.text=[baoArr[0]objectForKey:@"zazhi4kg"];
        _tf_zaPapperweiht.text=[baoArr[0]objectForKey:@"zazhi3kg"];
        _tf_jinZhongWeight.text=[baoArr[0]objectForKey:@"jingkg"];
        _tf_maoWeight.text=[baoArr[0]objectForKey:@"maokg"];
        } fail:^(){
          [AlertHelper singleAlertShowAndMBHUDHid:@"网络错误" ForView:self.view];
        }];
}
//- (void)refresPictureView:(NSArray *)lists  withUid:(NSString *)uid
//{
//    userid=uid;
//    self.imageArrs = (NSMutableArray *)lists;
//
//
//    int imgNum =(int) self.imageArrs.count;
//
//    CGFloat  viewWidth =60;
//    CGFloat  viewHeight =60;
//    _scrollView.contentSize = CGSizeMake((viewWidth+5) *(imgNum+1), 0);
//
//
//    for (int i = 0 ; i < imgNum; i ++) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(5+viewWidth)*i, 5, viewWidth, viewHeight)];
//        NSString *imgurlstr=[[ShenHeWebAPI smallImgUrlPathWithUid:uid] stringByAppendingString:_imageArrs[i]];
//
//        NSURL *url=[NSURL URLWithString:imgurlstr];
//
//        [imageView   sd_setImageWithURL:url                                placeholderImage:[UIImage imageNamed:@"nopicture"]
//                                options:0
//                              completed:^(UIImage *image,
//                                          NSError *error,
//                                          SDImageCacheType cacheType,
//                                          NSURL *imageURL){
//                                  imageView.image=[ImageHelper hotImageWithImage:image];
//
//                              }];
//
//        [imageView setUserInteractionEnabled:YES];
//        imageView.tag =i;
//        [_scrollView addSubview:imageView];
//        imageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *singleTap =
//        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage:)];
//        [imageView addGestureRecognizer:singleTap];
//
//    }
//
//
//}
//
//-(void)whenClickImage:(UITapGestureRecognizer *)gestureRecognizer
//{
//
//    UIImageView *imgView=(UIImageView *)[gestureRecognizer view];
//
//    if ([self.delegate respondsToSelector:@selector(showShenGouZhiLiangDisPlayImageView: andUserId:)]) {
//        [self.delegate showShenGouZhiLiangDisPlayImageView: self.imageArrs[imgView.tag ] andUserId:userid];
//
//    }
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
