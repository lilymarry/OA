

#import "RenWuUserGroupModel.h"
#import "RenWuUsersModel.h"
#import "Pinyin.h"

@implementation RenWuUserGroupModel


-(RenWuUserGroupModel *)initWithName:(NSString *)name andUsers:(NSMutableArray *)users{
    if (self=[super init]) {
        self.name=name;
        self.users=users;
    }
    return self;
}


+(NSArray *)createArrayWithUsersAndPinYin:(NSMutableArray *)arr
{
    NSMutableArray *groupArr=[NSMutableArray new];
    NSMutableSet *zimu=[NSMutableSet set];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        char c=pinyinFirstLetter([((RenWuUsersModel*)obj).name characterAtIndex:0]);
        [zimu addObject:[NSString stringWithFormat:@"%c",c-32]];
        
    }];
    
    [[zimu allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        
        NSMutableArray *users=[NSMutableArray array];
        for (int i=0; i<arr.count; i++) {
            char c=pinyinFirstLetter([((RenWuUsersModel*)arr[i]).name characterAtIndex:0]);
            if ([obj isEqualToString:[NSString stringWithFormat:@"%c",c-32]]) {
                [users addObject:arr[i]];
            }
        }
        RenWuUserGroupModel *group= [[RenWuUserGroupModel alloc] initWithName:obj andUsers:users];
        [groupArr addObject:group];
    }];
    return  [groupArr sortedArrayUsingComparator:^NSComparisonResult(RenWuUserGroupModel *obj1,RenWuUserGroupModel *obj2){
        return [obj1.name compare:obj2.name];
    }];
}


+(NSMutableArray *)createArrayWithUsers:(NSMutableArray *)userArr{
    NSMutableArray *groupArr=[NSMutableArray new];
    NSArray *indexCharArr=[NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    
    for (NSString *indexStr in indexCharArr) {
        NSMutableArray *users=[NSMutableArray new];
        [userArr enumerateObjectsUsingBlock:^(id obj,NSUInteger inx, BOOL *stop) {
            
            NSString *firstStr=[((RenWuUsersModel*)obj).name substringToIndex:1];
            NSMutableString *ms = [[NSMutableString alloc] initWithString:firstStr];
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
                // NSLog(@"Pingying: %@", ms);
            }
            NSComparisonResult res=   [[ms substringToIndex:1] localizedCaseInsensitiveCompare:indexStr];
            
            if (res == NSOrderedSame) {
                [users addObject:obj];
            }
        }];
        if (users.count>0) {
            RenWuUserGroupModel *group= [[RenWuUserGroupModel alloc] initWithName:indexStr andUsers:users];
            [groupArr addObject:group];
        }
    }
    
    
    return groupArr;
}


@end
