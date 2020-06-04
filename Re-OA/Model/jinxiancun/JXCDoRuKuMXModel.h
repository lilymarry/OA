


#import <Foundation/Foundation.h>


 //danw：货品单位，num：数量，kfid：库房ID，kfmc：库房名称，dwid：垛位ID，dwnm：垛位名称，kg：出入库重量
@interface JXCDoRuKuMXModel : NSObject

@property (nonatomic,strong) NSString *danw;
@property (nonatomic,strong) NSString *num;
@property (nonatomic,strong) NSString *kfid;
@property (nonatomic,strong) NSString *kfmc;
@property (nonatomic,strong) NSString *dwid;
@property (nonatomic,strong) NSString *dwnm;
@property (nonatomic,strong) NSString *kg;
 @property (nonatomic,strong) NSString *index;


-(id)initWithJson:(NSDictionary *)json;

@end
