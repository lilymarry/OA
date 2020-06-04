

#import <Foundation/Foundation.h>


@interface ShenHeDetailModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *fstate;
@property (nonatomic,strong) NSString *tit;
@property (nonatomic,strong) NSString *ctm;
@property (nonatomic,strong) NSString *pric;
@property (nonatomic,strong) NSString *doPNm;
@property (nonatomic,strong) NSString *pic;
@property (nonatomic,strong) NSString *fnm;
@property (nonatomic,strong) NSString *fmTp;
@property (nonatomic,strong) NSString *con;
@property (nonatomic,strong) NSString *voi;
@property (nonatomic,strong) NSString *u_id;
@property (nonatomic,strong) NSString *fonm;
@property (nonatomic,strong) NSString *nowfs;

-(id)initWithJson:(NSDictionary *)json;

@end
