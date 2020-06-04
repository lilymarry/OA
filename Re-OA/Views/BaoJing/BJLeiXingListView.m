//
//  BJLeiXingListView.m
//  Re-OA
//
//  Created by admin on 15/5/28.
//  Copyright (c) 2015年 姜任鹏. All rights reserved.
//

#import "BJLeiXingListView.h"
#import "BaoJingWebAPI.h"
#import "ScreenHelper.h"
#import "BJLeiXingCell.h"
#import "Exchange16Color.h"

@implementation BJLeiXingListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _leiXingArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identfier=@"cell";
    BJLeiXingCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BJLeiXingCell" owner:self options:nil] lastObject];
        
    }
    cell.lab_name.text=[_leiXingArr[indexPath.row]objectForKey:@"jblxnm"];
    // i=  rand()%20;
    cell.vie_flag.backgroundColor=[Exchange16Color colorWithHexString:_colorArr[indexPath.row]];
  
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataDelegate respondsToSelector:@selector(selectLeiXingWithNum:)])
    {
      [self.dataDelegate selectLeiXingWithNum:[NSString stringWithFormat: @"%ld",(long)indexPath.row]];
      //  [self.dataDelegate selectLeiXingWithNum:[NSString stringWithFormat: @"%d",i]];
        [self closingTheLittleMenu:nil];
    }


}
-(void)getdata
{
    _leiXingArr=[NSMutableArray array];
    [BaoJingWebAPI requestBaoJIngLeiXingSuccess:^(NSArray *arr){
     _leiXingArr =[NSMutableArray arrayWithArray:arr];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"jblxnm", @"0",@"jblxid",nil];
        [_leiXingArr insertObject:dic atIndex:0];
        [_table reloadData];
    } fail:^(){}];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Color" ofType:@"plist"];
    _colorArr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    
}
-(void)closingTheLittleMenu:(void (^)())closeMenuHandle{
    [self removeTheView:closeMenuHandle];
}
-(void)removeTheView:(void (^)())closeMenuHandle{
    
    [UIView animateWithDuration:0.2 animations:^(){
        [self setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH], 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
        if (closeMenuHandle) {
            closeMenuHandle();
        }
    }];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
  
    if (self)
    {
        UILabel *lab=[[UILabel alloc ] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        lab.textAlignment=NSTextAlignmentLeft;
        lab.textColor=[UIColor lightGrayColor];
        lab.font =  [UIFont fontWithName:@"Arial" size:12.0f];
        lab.text=@" 选择要查询的报警类型";
        [self addSubview:lab];
   
    
     _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, frame.size.width, frame.size.height-44)];
     _table.delegate=self;
    _table.dataSource=self;
    [self addSubview:_table];
        
        [self getdata];
    }
    
    return self;
}

@end
