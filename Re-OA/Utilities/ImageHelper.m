

#import "ImageHelper.h"

#import "ScreenHelper.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation ImageHelper

//imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
+(UIImage*)zipAndStoreTheChoosedImageWithController:(UIImagePickerController *)picker AndInfo:(NSDictionary *)info{

    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *) kUTTypeImage])
    {
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //设置image的尺寸
        CGSize imagesize = image.size;
        
        //iphone5
        CGFloat a=(imagesize.height>imagesize.width)?320.0:568;
        
        //iphone6
        if ([ScreenHelper checkWhichIphoneScreen] == iphone6) {
            a=(imagesize.height>imagesize.width)?375:667;
        }else if ([ScreenHelper checkWhichIphoneScreen] == iphone6plus){
             a=(imagesize.height>imagesize.width)?414:736;
        }
  
        float XX=imagesize.width/a;//宽度比
        float VY=imagesize.height/XX;//在屏幕上的高度
        
        imagesize.width = a*5;//放大倍数100
        imagesize.height =VY*5;

         UIImage *ima = [ImageHelper imageWithImage:image scaledToSize:imagesize];

        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            UIImageWriteToSavedPhotosAlbum(ima, nil, nil, nil);
        }
        return ima;
    }
    return nil;
}

+(UIImage*)hotZipAndStoreTheChoosedImageWithController:(UIImagePickerController *)picker AndInfo:(NSDictionary *)info{
    
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *) kUTTypeImage])
    {
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
       
        //设置image的尺寸
        CGSize imagesize = image.size;
        
        //iphone5
        CGFloat a=(imagesize.height>imagesize.width)?320.0:568;
        
        //iphone6
        if ([ScreenHelper checkWhichIphoneScreen] == iphone6) {
            a=(imagesize.height>imagesize.width)?375:667;
        }else if ([ScreenHelper checkWhichIphoneScreen] == iphone6plus){
            a=(imagesize.height>imagesize.width)?414:736;
        }
        
        float XX=imagesize.width/a;//宽度比
        float VY=imagesize.height/XX;//在屏幕上的高度
        
        imagesize.width = a*10;//放大倍数100
        imagesize.height =VY*10;
        
        UIImage *ima = [ImageHelper imageWithImage:image scaledToSize:imagesize];
        
        return ima;
    }
    return nil;
}

///对图片尺寸进行压缩--
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//缩列图
+(UIImage*)hotImageWithImage:(UIImage*)image {

        
        //设置image的尺寸
        CGSize imagesize = image.size;
        
        //iphone5
        CGFloat a=(imagesize.height>imagesize.width)?320.0:568;
        
        //iphone6
        if ([ScreenHelper checkWhichIphoneScreen] == iphone6) {
            a=(imagesize.height>imagesize.width)?375:667;
        }else if ([ScreenHelper checkWhichIphoneScreen] == iphone6plus){
            a=(imagesize.height>imagesize.width)?414:736;
        }
        
        float XX=imagesize.width/a;//宽度比
        float VY=imagesize.height/XX;//在屏幕上的高度
        
        imagesize.width = a/4;//放大倍数100
        imagesize.height =VY/4;
        
        UIImage *ima = [ImageHelper imageWithImage:image scaledToSize:imagesize];
        
        return ima;


}
+(UIImage *)hotLargImagWithImage:(UIImage *)image
{
    //设置image的尺寸
    CGSize imagesize = image.size;
    
    //iphone5
    CGFloat a=(imagesize.height>imagesize.width)?320.0:568;
    
    //iphone6
    if ([ScreenHelper checkWhichIphoneScreen] == iphone6) {
        a=(imagesize.height>imagesize.width)?375:667;
    }else if ([ScreenHelper checkWhichIphoneScreen] == iphone6plus){
        a=(imagesize.height>imagesize.width)?414:736;
    }
    
    float XX=imagesize.width/a;//宽度比
    float VY=imagesize.height/XX;//在屏幕上的高度
    
    imagesize.width = a*10;//放大倍数100
    imagesize.height =VY*10;
    
    UIImage *ima = [ImageHelper imageWithImage:image scaledToSize:imagesize];
    
    return ima;


}
@end
