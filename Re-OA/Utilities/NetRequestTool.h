
#import <Foundation/Foundation.h>

@interface NetRequestTool : NSObject
+(NetRequestTool*)sharedRequest;

-(void)request:(NSDictionary *)parm URL:(NSString *)url success:(void (^)(id))success fail:(void (^)())fail;
-(void)requestCommon:(NSDictionary *)parm URL:(NSString *)url success:(void (^)(id))success fail:(void (^)())fail;

-(void)request:(NSDictionary *)parm URL:(NSString *)url imageData:(NSData*)imgData  success:(void (^)(id))success fail:(void (^)())fail;
//带有进度上传一张图片的请求
-(void)requestl:(NSDictionary *)parm URL:(NSString *)url imageData:(NSData*)imgData  success:(void (^)(id))success fail:(void (^)())fail   progress:(void (^)(float))progress;

-(void)requestMorePic:(NSDictionary *)parm URL:(NSString *)url images:(NSArray*)imageDataArray  success:(void (^)(id))success fail:(void (^)())fail  progress:(void (^)(float))progress;
// 登录
-(void)requestLogin:(NSString *)username andPassword:(NSString *)password success:(void(^)(NSArray *userInfo))success fail:(void(^)())fail;

// 修改密
-(void)requestUpdataPw:(NSString *)uName newPw:(NSString *)aNewPw success:(void (^)(NSArray*))success fail:(void (^)())fail;

-(void)request:(NSDictionary *)parm URL:(NSString *)url imageData:(NSData*)imgData  soundData :(NSData *)voi success:(void (^)(id))success fail:(void (^)())fail;

//退出
-(void)requestsignout:(NSString *)uid success:(void (^)(NSArray*))success fail:(void (^)())fail;

////检测版本 fir
//-(void)requestVersionFromFIRsuccess:(void (^)(NSDictionary*))success fail:(void (^)())fail;
-(void)requestVersionFromURLsuccess:(void (^)(NSArray*))success fail:(void (^)())fail;

-(void)requestLineState:(NSString *)uid success:(void (^)(NSArray*))success fail:(void (^)())fail;

//论坛 获取天气
-(void)getWeatherSuccess:(void(^)(NSDictionary *userInfo))success fail:(void(^)())fail;


-(void)requestMorePics:(NSDictionary *)parm URL:(NSString *)url images:(NSArray*)imageDataArray  soundData :(NSData *)voi success:(void (^)(id))success fail:(void (^)())fail;

-(void)requestMorePics:(NSDictionary *)parm URL:(NSString *)url images:(NSArray*)imageDataArray  success:(void (^)(id))success fail:(void (^)())fail;
@end
