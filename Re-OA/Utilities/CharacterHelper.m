

#import "CharacterHelper.h"

@implementation CharacterHelper

+(NSString *)replacingTheBRToEmpty:(NSString *)string{
    if (string && (![@"" isEqualToString:string])) {
         return [string stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    }
    return @"";
}


+(NSString *)replacingTheBRToEnter:(NSString *)string{
    if (string && (![@"" isEqualToString:string])) {
        return [string stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\r\n"];
    }
    return @"";
}
@end
