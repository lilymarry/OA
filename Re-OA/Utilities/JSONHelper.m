

#import "JSONHelper.h"

@implementation JSONHelper

// 将字典或者数组转化为JSON串
+(NSString *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}


// 将JSON串转化为字典或者数组
+ (id)toArrayOrNSDictionary:(NSString *)jsonStr{
    NSError *error = nil;
   NSData *jsonData= [jsonStr dataUsingEncoding:NSASCIIStringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}

@end
