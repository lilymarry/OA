

#import <Foundation/Foundation.h>


@interface MyRenwuListModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *Ta_Lssueddate;
@property (nonatomic,strong) NSString *Ta_Iscomplete;
@property (nonatomic,strong) NSString *Ta_Id;
@property (nonatomic,strong) NSString *Ta_Username;
@property (nonatomic,strong) NSString *Ta_Name;
@property (nonatomic,strong) NSString *Ta_Description;


-(id)initWithJson:(NSDictionary *)json;

@end
