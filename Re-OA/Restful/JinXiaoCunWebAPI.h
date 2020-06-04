

#import <Foundation/Foundation.h>

@interface JinXiaoCunWebAPI : NSObject
+(void)getBangDanListWithRnum:(NSString *)rnum bdtyp:(NSString *)bdtyp  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)getBangDanDataWithbdId:(NSString *)bdid bdtyp:(NSString *)bdtyp  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//检验质检
+(void)sendResultjyzjWithUserID:(NSString *)userId bdtyp:(NSString *)bdtyp bdid:(NSString *)bdid hwlvnm:(NSString *)hwlvnm hwlv:(NSString *)hwlv zawu:(NSString *)zawu zazhi3:(NSString *)zazhi3 zazhe4:(NSString *)zazhi4 shuifen:(NSString *)shuifen maokg:(NSString *)makg jingkg:(NSString *)jingkg zawukg :(NSString *)zawukg zhazhi3kg:(NSString *)zhazhi3kg zhazhi4kg :(NSString *)zhazhi4kg koukg:(NSString *)koukg koupct:(NSString *)koupct jianshu:(NSString *)jianshu images:(NSArray*)imageDataArray success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

+(void)getYiBangDanListWithRnum:(NSString *)rnum bdtyp:(NSString *)bdtyp bm:(NSString *)bm userId:(NSString *)usid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)sendResultFeiqiWithUserID:(NSString *)userId  bdid:(NSString *)bdid hwlvnm:(NSString *)hwlvnm
                            hwlv:(NSString *)hwlv zawu:(NSString *)zawu zazhi3:(NSString *)zazhi3 zazhe4:(NSString *)zazhi4 shuifen:(NSString *)shuifen koukg:(NSString *)koukg koupct:(NSString *)koupct jianshu:(NSString *)jianshu beizhu:(NSString *)beizhu  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)getYcrklistDataWithbdId:(NSString *)bdid userId:(NSString *)userid  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)getKuFanglisTsuccess:(void(^)(NSArray *arr))success fail:(void(^)())fail;
+(void)getKuFanglisTDetalWithdeId:(NSString *)dwid  success:(void(^)(NSArray *arr))success fail:(void(^)())fail;
+(void)getBaseDataWithtype:(NSString *)type  Success:(void(^)(NSArray *arr))success fail:(void(^)())fail;
+(void)getZoneSuccess:(void(^)(NSArray *arr))success fail:(void(^)())fail;
+(void)getZhudetaillistDataWithHwlv:(NSString *)hwlv hwzl:(NSString *)hwzl kstm:(NSString *)kstm jstm:(NSString *)jstm  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)getBangDanDataSuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

//价格汇总柱状图
+(void)jiadehuizongDataWithHwzl:(NSString *)hwzl hwlx:(NSString *)hwlx kstm:(NSString *)kstm  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

//26 时间段区域的平均价格曲线图
+(void)getQuYuhuizongDataWithHwzl:(NSString *)hwzl hwlv:(NSString *)hwlv dq:(NSString *)dq ywlb:(NSString *)ywlb hwlx:(NSString *)hwlx kstm:(NSString *)kstm jstm:(NSString *)jstm success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//27
+(void)getTimeQuYuhuizongDataWithHwzl:(NSString *)hwzl hwlv:(NSString *)hwlv  hwlx:(NSString *)hwlx kstm:(NSString *)kstm  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//28 当个时间段地区价格区域汇总柱状图
+(void)getTimediquhuizongDataWithHwzl:(NSString *)hwzl  dq:(NSString *)dq  hwlx:(NSString *)hwlx kstm:(NSString *)kstm success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//入库
+(void)requestBangdanDetailForRuKuBybdid:(NSString *)bdid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)requestDuoWeiByCangKuID:(NSString*)kfid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)submiteRuKuWithuid:(NSString*)uid
                  AndbdId:(NSString*)bdId
                   Andrkl:(NSString*)rkl
                  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)requestYiRuKuListWithuid:(NSString *)uid Andrnum:(NSString *)rnum  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)requestYiRuKuDetailWithbdid:(NSString *)bdid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

//出库
+(void)getBangDanListWithRnum:(NSString *)rnum bdtyp:(NSString *)bdtyp  ywtyp:(NSString *)ywtyp success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)requestBangdanDetailForChuKuBybdid:(NSString *)bdid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)requestYiChuKuListWithuid:(NSString *)uid Andrnum:(NSString *)rnum  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)submiteChuKuWithuid:(NSString*)uid
                   AndbdId:(NSString*)bdId
                   Andhwlv:(NSString*)hwlv
                    Andrkl:(NSString*)rkl
                   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
@end
