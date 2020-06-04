
#import <Foundation/Foundation.h>


@interface RenWuTaopModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *taopname;
@property (nonatomic,strong) NSString *taopid;

-(id)initWithJson:(NSDictionary *)json;

@end
