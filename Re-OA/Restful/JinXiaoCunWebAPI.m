
#import "JinXiaoCunWebAPI.h"
#import "URL.h"
#import "NetRequestTool.h"

//网络接口
#define shRequestList [NSString stringWithFormat:@"%@/Wap/WapJXCHandler.ashx",kDomain]


@implementation JinXiaoCunWebAPI


//磅单类型（1过磅待初检，2初检待二检，3检完待入库，4入库待空车出厂，6出厂过磅后置完成，7完成待结算）
+(void)getBangDanListWithRnum:(NSString *)rnum bdtyp:(NSString *)bdtyp  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"bdlist",@"rnum":rnum,@"bdtyp":bdtyp};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//已检列表
+(void)getYiBangDanListWithRnum:(NSString *)rnum bdtyp:(NSString *)bdtyp bm:(NSString *)bm userId:(NSString *)usid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"yjylist",@"rnum":rnum,@"zjtyp":bdtyp ,@"bm":bm ,@"uid":usid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//磅单详细数据
+(void)getBangDanDataWithbdId:(NSString *)bdid bdtyp:(NSString *)bdtyp  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"bddata",@"bdid":bdid,@"bdtyp":bdtyp};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//检验质检
+(void)sendResultjyzjWithUserID:(NSString *)userId bdtyp:(NSString *)bdtyp bdid:(NSString *)bdid
   hwlvnm:(NSString *)hwlvnm
                           hwlv:(NSString *)hwlv zawu:(NSString *)zawu zazhi3:(NSString *)zazhi3 zazhe4:(NSString *)zazhi4 shuifen:(NSString *)shuifen maokg:(NSString *)makg jingkg:(NSString *)jingkg zawukg :(NSString *)zawukg zhazhi3kg:(NSString *)zhazhi3kg zhazhi4kg :(NSString *)zhazhi4kg koukg:(NSString *)koukg koupct:(NSString *)koupct jianshu:(NSString *)jianshu images:(NSArray*)imageDataArray success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    
    NSDictionary *dic=@{@"method":@"jyzj",@"uid":userId,@"bdid":bdid,@"bdtyp":bdtyp , @"hwlvnm": hwlvnm, 
                        @"hwlv":hwlv, @"zawu":zawu,@"zazhi3":zazhi3,@"zazhi4":zazhi4,@"shuifen":shuifen,@"maokg":makg,@"jingkg":jingkg,@"zawukg":zawukg,@"zazhi3kg":zhazhi3kg,@"zazhi4kg" :zhazhi4kg,@"koukg":koukg,@"koupct":koupct,@"jianshu":jianshu};
    [[NetRequestTool sharedRequest]requestMorePics:dic URL:shRequestList images:imageDataArray success:success fail:fail];
    
  //  [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}
//检验废弃
+(void)sendResultFeiqiWithUserID:(NSString *)userId  bdid:(NSString *)bdid hwlvnm:(NSString *)hwlvnm hwlv:(NSString *)hwlv zawu:(NSString *)zawu zazhi3:(NSString *)zazhi3 zazhe4:(NSString *)zazhi4 shuifen:(NSString *)shuifen koukg:(NSString *)koukg koupct:(NSString *)koupct jianshu:(NSString *)jianshu beizhu:(NSString *)beizhu  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    
    NSDictionary *dic=@{@"method":@"jyfq",@"uid":userId,@"bdid":bdid,@"hwlvnm": hwlvnm,@"hwlv":hwlv,@"fqbak":beizhu,@"zawu":zawu,@"zazhi3":zazhi3,@"zazhi4":zazhi4,@"shuifen":shuifen,@"koukg":koukg,@"koupct":koupct,@"jianshu":jianshu };
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}
//已质检详情
+(void)getYcrklistDataWithbdId:(NSString *)bdid userId:(NSString *)userid  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"yjydata",@"bdid":bdid,@"uid":userid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}

#pragma mark 库存查询
//库房列表
+(void)getKuFanglisTsuccess:(void(^)(NSArray *arr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"kflist"};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//库房列表 详情
+(void)getKuFanglisTDetalWithdeId:(NSString *)dwid  success:(void(^)(NSArray *arr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"kfdata",@"dwid":dwid};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
#pragma mark 价格查询
//统计基础设置
+(void)getBaseDataWithtype:(NSString *)type  Success:(void(^)(NSArray *arr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"tjbset", @"type":type};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//统计区域设置
+(void)getZoneSuccess:(void(^)(NSArray *arr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"tjaset"};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
// jiage1
+(void)getZhudetaillistDataWithHwlv:(NSString *)hwlv hwzl:(NSString *)hwzl kstm:(NSString *)kstm jstm:(NSString *)jstm  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"tjjgqx",@"hwlv":hwlv,@"hwzl":hwzl,@"kstm":kstm,@"jstm":jstm};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}

//  价格汇总柱状图
+(void)jiadehuizongDataWithHwzl:(NSString *)hwzl hwlx:(NSString *)hwlx kstm:(NSString *)kstm  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"tjjgzz",@"hwzl":hwzl,@"hwlx":hwlx,@"kstm":kstm};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}
//价格汇总曲线图
+(void)getQuYuhuizongDataWithHwzl:(NSString *)hwzl hwlv:(NSString *)hwlv dq:(NSString *)dq ywlb:(NSString *)ywlb hwlx:(NSString *)hwlx kstm:(NSString *)kstm jstm:(NSString *)jstm success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    NSDictionary *dic=@{@"method":@"tjqyqx",@"hwzl":hwzl,@"hwlx":hwlx,@"kstm":kstm ,@"hwlv":hwlv,@"ywlb":ywlb,@"dq":dq ,@"jstm":jstm};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];

}
//27 当个时间段价格区域汇总柱状图
+(void)getTimeQuYuhuizongDataWithHwzl:(NSString *)hwzl hwlv:(NSString *)hwlv  hwlx:(NSString *)hwlx kstm:(NSString *)kstm  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    NSDictionary *dic=@{@"method":@"tjqyzz",@"hwzl":hwzl,@"hwlx":hwlx,@"kstm":kstm ,@"hwlv":hwlv};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}
//28 价格区域汇总曲线图
+(void)getTimediquhuizongDataWithHwzl:(NSString *)hwzl  dq:(NSString *)dq  hwlx:(NSString *)hwlx kstm:(NSString *)kstm success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"tjdqyzz",@"hwzl":hwzl,@"hwlx":hwlx,@"kstm":kstm ,@"dq":dq};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}

 #pragma mark 实时磅单

+(void)getBangDanDataSuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"bdroall"};
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
}





//---------------------------  入库 ----------------------

//获取要制作的入库单的信息

+(void)requestBangdanDetailForRuKuBybdid:(NSString *)bdid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    
    NSDictionary *dic=@{@"method":@"bddata",@"bdid":bdid,@"bdtyp":@"4"};
    
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}

//获取仓库下的 剁位

+(void)requestDuoWeiByCangKuID:(NSString*)kfid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    
    NSDictionary *dic=@{@"method":@"kfduo",@"kfid":kfid};
    
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}

//提交入库

+(void)submiteRuKuWithuid:(NSString*)uid

                  AndbdId:(NSString*)bdId

                   Andrkl:(NSString*)rkl

                  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    
    NSDictionary *dic=@{@"method":@"hpcrk",@"uid":uid,@"bdId":bdId,@"hwlv":@"",@"crtyp":@"1",@"bm":@"",@"rkl":rkl};
    
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}



//已入库列表

+(void)requestYiRuKuListWithuid:(NSString *)uid Andrnum:(NSString *)rnum  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    
    NSDictionary *dic=@{@"method":@"ycrklist",@"crtyp":@"1",@"uid":uid,@"rnum":rnum};
    
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}

//已入库列表详情

+(void)requestYiRuKuDetailWithbdid:(NSString *)bdid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    
    NSDictionary *dic=@{@"method":@"ycrkdata",@"crtyp":@"1",@"bdid":bdid};
    
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}



//---------------------------  出库 ----------------------

//未出库列表bdtyp＝1   ywtyp＝2

+(void)getBangDanListWithRnum:(NSString *)rnum bdtyp:(NSString *)bdtyp  ywtyp:(NSString *)ywtyp success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    
    NSDictionary *dic=@{@"method":@"bdlist",@"rnum":rnum,@"bdtyp":bdtyp,@"ywtyp":ywtyp};
    
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}



//获取要制作的出库单的信息

+(void)requestBangdanDetailForChuKuBybdid:(NSString *)bdid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    
    NSDictionary *dic=@{@"method":@"bddata",@"bdid":bdid,@"bdtyp":@"2" ,@"ywtyp":@"2"};
    
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}

//提交出库

+(void)submiteChuKuWithuid:(NSString*)uid

                   AndbdId:(NSString*)bdId

                   Andhwlv:(NSString*)hwlv

                    Andrkl:(NSString*)rkl

                   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    
    NSDictionary *dic=@{@"method":@"hpcrk",@"uid":uid,@"bdId":bdId,@"hwlv":hwlv,@"crtyp":@"2",@"bm":@"",@"rkl":rkl};
    
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}

//已出库列表

+(void)requestYiChuKuListWithuid:(NSString *)uid Andrnum:(NSString *)rnum  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail

{
    
    NSDictionary *dic=@{@"method":@"ycrklist",@"crtyp":@"2",@"uid":uid,@"rnum":rnum};
    
    [[NetRequestTool sharedRequest]request:dic URL:shRequestList success:success fail:fail];
    
}


@end







