

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject
+(NSString *)toJSONData:(id)theData;

+ (id)toArrayOrNSDictionary:(NSString *)jsonStr;
@end;
