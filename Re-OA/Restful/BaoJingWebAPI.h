
#import <Foundation/Foundation.h>

@interface BaoJingWebAPI : NSObject

+(void)requestBaoJingListWithjblx:(NSString *)jblx
                          Andpkey:(NSString*)pkey
                          Andrnum:(NSString*)rnum
                           Andtop:(NSString*)top
                          Andiszx:(NSString*)iszx
                          success:(void (^)(NSArray *))success fail:(void (^)())fail;
+(void)requestNewBaoJingListWithjblx:(NSString *)jblx
                             Andpkey:(NSString*)pkey
                             Andiszx:(NSString*)iszx
                             success:(void (^)(NSArray *))success fail:(void (^)())fail;
+(void)requestBaoJIngLeiXingSuccess:(void (^)(NSArray *))success fail:(void (^)())fail;
@end
