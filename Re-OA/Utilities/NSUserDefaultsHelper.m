

#import "NSUserDefaultsHelper.h"

#define udMenuKey @"favoriteMenuID"

@implementation NSUserDefaultsHelper


+(BOOL)saveTheFavoriteMenu:(NSMutableArray *)selectedMenuIDArr
{

    NSString *menuIDStr= [selectedMenuIDArr componentsJoinedByString:@","];
    NSUserDefaults * aUserDefaults = [NSUserDefaults standardUserDefaults];
    [aUserDefaults setObject:menuIDStr forKey:udMenuKey];
    [aUserDefaults synchronize];
    
    return YES;
}

+(NSArray *)menuIDFromTheFavorite
{
    NSUserDefaults * aUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString * aStr = [aUserDefaults objectForKey:udMenuKey];
    return  [aStr componentsSeparatedByString:@","];
}



@end
