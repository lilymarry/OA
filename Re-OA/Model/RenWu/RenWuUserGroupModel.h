
#import <Foundation/Foundation.h>

@interface RenWuUserGroupModel : NSObject

@property (nonatomic,copy) NSString *name;//
@property (nonatomic,strong) NSMutableArray *users;
-(RenWuUserGroupModel *)initWithName:(NSString *)name andUsers:(NSMutableArray *)users;
+(NSMutableArray *)createArrayWithUsers:(NSMutableArray *)userArr;
+(NSArray *)createArrayWithUsersAndPinYin:(NSMutableArray *)arr;
@end
