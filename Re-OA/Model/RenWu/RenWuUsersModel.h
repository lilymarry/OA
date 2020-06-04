

#import <Foundation/Foundation.h>


@interface RenWuUsersModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic) BOOL isChoosed;
 


-(id)initWithJson:(NSDictionary *)json;

@end
