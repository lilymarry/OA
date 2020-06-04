
#import <Foundation/Foundation.h>


@interface RenWuTaopListModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *Taop_Iscomplete;
@property (nonatomic,strong) NSString *Taop_Id;
@property (nonatomic,strong) NSString *Taop_IsSee;
@property (nonatomic,strong) NSString *Taop_Comment;
@property (nonatomic,strong) NSString *Taop_Userid;
@property (nonatomic,strong) NSString *Taop_Date_1;
@property (nonatomic,strong) NSString *Taop_Description;
@property (nonatomic,strong) NSString *Taop_UserName;
@property (nonatomic,strong) NSString *Taop_Img;
@property (nonatomic,strong) NSString *Taop_Taid;
@property (nonatomic,strong) NSString *Taop_IsTimeout;
 


-(id)initWithJson:(NSDictionary *)json;

@end
