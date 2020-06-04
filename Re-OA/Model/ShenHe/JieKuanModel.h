
#import <Foundation/Foundation.h>

@interface JieKuanModel : NSObject


@property (nonatomic,strong) NSString *ctm;
@property (nonatomic,strong) NSString *doPNm;
@property (nonatomic,strong) NSString *extr;
@property (nonatomic,strong) NSString *fmTp;
@property (nonatomic,strong) NSString *fnm;
@property (nonatomic,strong) NSString *fonm;
@property (nonatomic,strong) NSString *fstate;
@property (nonatomic,strong) NSString *met;
@property (nonatomic,strong) NSString *nowfs;
@property (nonatomic,strong) NSString *num;
@property (nonatomic,strong) NSString *pers;
@property (nonatomic,strong) NSString *tit;
@property (nonatomic,strong) NSString *u_id;
@property (nonatomic,strong) NSString *way;

-(id)initWithJson:(NSDictionary *)json;

@end
