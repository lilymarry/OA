


#import <Foundation/Foundation.h>


@interface MyReceivedReWuDetailModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *taname;
@property (nonatomic,strong) NSString *tadescription;
@property (nonatomic,strong) NSString *iscomplete;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *tauserid;
@property (nonatomic,strong) NSString *tastopdate;
@property (nonatomic,strong) NSString *taimg;
@property (nonatomic,strong) NSString *talssueddate;
 


-(id)initWithJson:(NSDictionary *)json;

@end
