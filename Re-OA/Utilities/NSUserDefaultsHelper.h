

#import <Foundation/Foundation.h>

@interface NSUserDefaultsHelper : NSObject
+(BOOL)saveTheFavoriteMenu:(NSMutableArray*)selectedMenuIDArr;
+(NSMutableArray*)menuIDFromTheFavorite;

@end
