


#import <Foundation/Foundation.h>


@interface JXCCommonListModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *tm;
@property (nonatomic,strong) NSString *wznm;
@property (nonatomic,strong) NSString *bdno;
@property (nonatomic,strong) NSString *carno;
@property (nonatomic,strong) NSString *fqbs;
@property (nonatomic,strong) NSString *bdid;
@property (nonatomic,strong) NSString *lvnm;

@property (nonatomic,strong) NSString *shouhdw;
@property (nonatomic,strong) NSString *songhdw;


-(id)initWithJson:(NSDictionary *)json;

@end
