
#import <Foundation/Foundation.h>

@interface ShenHeListModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *fstate;
@property (nonatomic,strong) NSString *tit;
@property (nonatomic,strong) NSString *fpiId;
@property (nonatomic,strong) NSString *ctm;
@property (nonatomic,strong) NSString *fpiAd;
@property (nonatomic,strong) NSString *Nowfs;
@property (nonatomic,strong) NSString *fnm;
@property (nonatomic,strong) NSString *opPNm;
@property (nonatomic,strong) NSString *fpId;
@property (nonatomic,strong) NSString *con;
@property (nonatomic,strong) NSString *fo;
@property (nonatomic,strong) NSString *ftyp;
@property (nonatomic) BOOL isSeleted;
@property (nonatomic,strong) NSMutableArray *toFs;
@property (nonatomic,strong) NSString *fmTp;
@property (nonatomic,strong) NSString *cmTp;
@property (nonatomic,strong) NSString *x;
@property (nonatomic,strong) NSString *y;
@property (nonatomic,strong) NSString *rNum;
@property (nonatomic,strong) NSString *okbak;

-(id)initWithJson:(NSDictionary *)json;

@end
