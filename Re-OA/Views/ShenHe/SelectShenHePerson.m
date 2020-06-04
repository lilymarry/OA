//
//  SelectShenHePerson.m
//  Re-OA
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 姜任鹏. All rights reserved.
//

#import "SelectShenHePerson.h"
#import "ShenHeWebAPI.h"
#import "AlertHelper.h"
@implementation SelectShenHePerson

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
        
    {
        UILabel *lab=[[UILabel alloc ] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        lab.textAlignment=NSTextAlignmentLeft;
        lab.textColor=[UIColor lightGrayColor];
        lab.font =  [UIFont fontWithName:@"Arial" size:12.0f];
        lab.text=@" 选择要查询的人员";
        [self addSubview:lab];
        
        _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 45, self.frame.size.width, self.frame.size.height-45)];
        _table.delegate=self;
        _table.dataSource=self;
        [self addSubview:_table];
        personData =[NSMutableArray array];
     //   NSLog(@"WWW %@",_type);
     //   self.backgroundColor=[UIColor redColor];
         UIButton *bt_quxiao=[UIButton buttonWithType:UIButtonTypeRoundedRect];
         bt_quxiao.frame=CGRectMake(frame.size.width-50, 0,50, 44);
        [bt_quxiao setTitle:@"取消" forState:UIControlStateNormal];
        [bt_quxiao addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        //bt_piliang.tag=1004;
        bt_quxiao.titleLabel .font =[UIFont systemFontOfSize:12];
        [self addSubview:bt_quxiao];
        
    }
    return self;
    
}
-(void)setType:(NSString *)type
{
    // personData =[NSMutableArray array];

    [self getData:type];

}
-(void)getData:(NSString *)typ
{
    [AlertHelper singleMBHUDShow:@"加载中..." ForView:self];
    [ShenHeWebAPI requestShenHePersonWithFtyp:typ success:^(NSArray *arr){
        [AlertHelper hidMBHUDFromView:self];

        [personData removeAllObjects];
        @try {
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"unm",@"k",@"uid", nil];
            NSArray *data=arr[0][@"ulist"];
            if (data.count!=0 ) {
                personData =[NSMutableArray arrayWithArray:arr[0][@"ulist"]];
                
                [personData insertObject:dic atIndex:0];
               [self.table reloadData];
            }
          
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
    
        }
        
    } fail:^(){
      

       [AlertHelper singleMBHUDShow:@"网络错误，稍后再试" ForView:self AndDelayHid:3];
    
    }];
  

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return personData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identfier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
        
    }
    cell.textLabel.text=[personData[indexPath.row]objectForKey:@"unm"];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.datDelegate respondsToSelector:@selector(selectPresonWithNum:andName:)])
    {
        [self.datDelegate selectPresonWithNum:[personData[indexPath.row]objectForKey:@"uid"] andName:[personData[indexPath.row]objectForKey:@"unm"]];
        [self removeFromSuperview];
    }
    
    
}
-(void)cancel
{
    [self removeFromSuperview];

}
//-(void)closingTheLittleMenu:(void (^)())closeMenuHandle{
//    [self removeTheView:closeMenuHandle];
//}
//-(void)removeTheView:(void (^)())closeMenuHandle{
//    
//    [UIView animateWithDuration:0.2 animations:^(){
//        [self setFrame:CGRectMake([ScreenHelper SCREEN_WIDTH], 0, [ScreenHelper SCREEN_WIDTH], [ScreenHelper SCREEN_HEIGHT])];
//    } completion:^(BOOL finished){
//        [self removeFromSuperview];
//        if (closeMenuHandle) {
//            closeMenuHandle();
//        }
//    }];
//}
@end
