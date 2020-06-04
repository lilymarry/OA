

#import <Foundation/Foundation.h>

@interface UserPermission : NSObject
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *companyId;
@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic) NSString *MenuRole;
@property (strong, nonatomic) NSString *jNum;
@property (strong, nonatomic) NSString *x;
@property (strong, nonatomic) NSString *y;
@property (strong, nonatomic) NSString *time;//更新提醒时间

@property (strong, nonatomic) NSArray *infoArr;


+ (UserPermission *) standartUserInfo;
@end
