
#import <Foundation/Foundation.h>


@interface ShenHeYFKDetailModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *met;
@property (nonatomic,strong) NSString *fstate;
@property (nonatomic,strong) NSString *nowfs;
@property (nonatomic,strong) NSString *ctm;
@property (nonatomic,strong) NSString *tit;
@property (nonatomic,strong) NSString *proj;
@property (nonatomic,strong) NSString *cont;
@property (nonatomic,strong) NSString *doPNm;
@property (nonatomic,strong) NSString *extr;
@property (nonatomic,strong) NSString *fnm;
@property (nonatomic,strong) NSString *fmTp;
@property (nonatomic,strong) NSString *prop;
@property (nonatomic,strong) NSString *num;
@property (nonatomic,strong) NSString *u_id;
@property (nonatomic,strong) NSString *fonm;

-(id)initWithJson:(NSDictionary *)json;

@end
