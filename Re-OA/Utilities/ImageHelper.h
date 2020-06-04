

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageHelper : NSObject
+(UIImage*)hotZipAndStoreTheChoosedImageWithController:(UIImagePickerController *)picker AndInfo:(NSDictionary *)info;
+(UIImage*)zipAndStoreTheChoosedImageWithController:(UIImagePickerController *)picker AndInfo:(NSDictionary *)info;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
//缩列图
+(UIImage*)hotImageWithImage:(UIImage*)image;
+(UIImage *)hotLargImagWithImage:(UIImage *)image;
@end
