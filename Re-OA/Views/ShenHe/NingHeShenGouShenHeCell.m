//
//  NingHeShenGouShenHeCell.m
//  Re-OA
//
//  Created by imac-1 on 2017/5/16.
//  Copyright © 2017年 姜任鹏. All rights reserved.
//

#import "NingHeShenGouShenHeCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ShenHeWebAPI.h"
#import "UserPermission.h"
#import "ScreenHelper.h"
#import "ImageHelper.h"
#import "NingHeShenGouCell.h"
#import "NingHeShenGouModel.h"
@implementation NingHeShenGouShenHeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _content.delegate=self;
    _content.dataSource=self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)refresPictureView:(NSArray *)lists  withUid:(NSString *)uid
{
    userid=uid;
    self.imageArrs = (NSMutableArray *)lists;
  
    
    int imgNum =(int) self.imageArrs.count;
  
    CGFloat  viewWidth =60;
    CGFloat  viewHeight =60;
    _scrollView.contentSize = CGSizeMake((viewWidth+5) *(imgNum+1), 0);
 
    
    for (int i = 0 ; i < imgNum; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+(5+viewWidth)*i, 5, viewWidth, viewHeight)];
        NSString *imgurlstr=[[ShenHeWebAPI smallImgUrlPathWithUid:uid] stringByAppendingString:_imageArrs[i]];
        
        NSURL *url=[NSURL URLWithString:imgurlstr];
        
        [imageView   sd_setImageWithURL:url                                placeholderImage:[UIImage imageNamed:@"nopicture"]
                                options:0
                              completed:^(UIImage *image,
                                          NSError *error,
                                          SDImageCacheType cacheType,
                                          NSURL *imageURL){
                                  imageView.image=[ImageHelper hotImageWithImage:image];
                                  
                              }];
        
        [imageView setUserInteractionEnabled:YES];
        imageView.tag =i;
        [_scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =
        [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(whenClickImage:)];
        [imageView addGestureRecognizer:singleTap];
        
    }
    
    
}

-(void)whenClickImage:(UITapGestureRecognizer *)gestureRecognizer
{
    
    UIImageView *imgView=(UIImageView *)[gestureRecognizer view];
    
    if ([self.delegate respondsToSelector:@selector(showShenGouZhiLiangDisPlayImageView: andUserId:)]) {
        [self.delegate showShenGouZhiLiangDisPlayImageView: self.imageArrs[imgView.tag ] andUserId:userid];
        
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
    NingHeShenGouCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"NingHeShenGouCell" owner:nil options:nil];
        cell= [nibView lastObject];
        
    }
    NingHeShenGouModel *model=_data[indexPath.row];
    cell.name.text=model.name;
    cell.shuliang.text=model.shuliang;
    cell.beizhu.text=model.beizhu;
    cell.dawei.text=model.dawei;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.content deselectRowAtIndexPath:indexPath animated:YES];
}


@end
