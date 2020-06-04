#import <Foundation/Foundation.h>

@interface ShangBaoWebAPI : NSObject

+(void)getShangBaoFlowWithType:(NSString *)type Andu_id:(NSString *)u_id success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)approveShangBaoWithUSerID:(NSString *)usId flowId :(NSString *) flowId ftyp:(NSString *)ftyp tittle:(NSString *)tit cont:(NSString *)cont pric:(NSString *)pric pic:(NSData *)pic voi:(NSData *)voi   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)getshangBaoListWithUserID:(NSString *)_id ftype:(NSString *)typeId  fstate :(NSString *)fstate fpId:(NSString *)fpId success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)getshangBaoListFlowfpId:(NSString *)fpId success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(NSString *)largeImgUrlPathWithUid:(NSString*)uid picName :(NSString *)pic;
+(NSString *)smallImgUrlPathWithUid:(NSString*)uid picName :(NSString *)pic;
+(NSString *)soundUrlPathWithUid:(NSString*)uid voiName :(NSString *)voi;
+(void)ShangBaoCaiwuFuKuanWithUid:(NSString *)uid  cont :(NSString *)cont extr :(NSString *)estr proj :(NSString *)proj prop:(NSString *)prop fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype
                          success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)ShangBaoCaiwujiekuanWithUid:(NSString *)uid  way :(NSString *)way extr :(NSString *)estr pers :(NSString *)pers  fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype
                           success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)ShangBaoCaiwuDepartListWithsuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)ShangBaoCaiwuBaoXiaoWithUid:(NSString *)uid  depId :(NSString *)DepID dep :(NSString *)dep  fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype  det:(NSString *)det success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)getshangBaoListWithUserID:(NSString *)_id ftype:(NSString *)typeId  fstate :(NSString *)fstate fpId:(NSString *)fpId
                            pkey:(NSString *)fpiid
                            rnum:(NSString *)rNum

                         success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)deleteSingleShangBao:(NSString *)fpiid success:(void (^)(NSArray *))success fail:(void (^)())fail;


//上报审核提交(GPS)
+(void)approveShangBaoWithUSerID:(NSString *)usId flowId :(NSString *) flowId ftyp:(NSString *)ftyp tittle:(NSString *)tit cont:(NSString *)cont pric:(NSString *)pric pic:(NSData *)pic voi:(NSData *)voi  AndX:(NSString*)x AndY:(NSString*)y   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//报销上报(GPS)
+(void)ShangBaoCaiwuBaoXiaoWithUid:(NSString *)uid  depId :(NSString *)DepID dep :(NSString *)dep  fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype  det:(NSString *)det   AndX:(NSString*)x AndY:(NSString*)y  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//付款上报(GPS)
+(void)ShangBaoCaiwuFuKuanWithUid:(NSString *)uid  cont :(NSString *)cont extr :(NSString *)estr proj :(NSString *)proj prop :(NSString *)prop fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype  AndX:(NSString*)x AndY:(NSString*)y
                          success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//借款上报(GPS)
+(void)ShangBaoCaiwujiekuanWithUid:(NSString *)uid  way :(NSString *)way extr :(NSString *)estr pers :(NSString *)pers  fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype  AndX:(NSString*)x AndY:(NSString*)y success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

+(void)zhiZhangNameWithsuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)getzhizhangDetailWithpbid:(NSString *)pbid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
+(void)SunHaoLvWithsuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//获取纸板材质 信息
+(void)zhibanCaiZhiWithsuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//纸张上报
+(void)zhizhangShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm pbid :(NSString *)pbid
                  pbnm :(NSString *)pbnm pmyi :(NSString *)pmyi pmer :(NSString *)pmer pmsan :(NSString *)pmsan pmsi:(NSString *)pmsi pmwu :(NSString *)pmwu pmliu :(NSString *)pmliu pmqi :(NSString *)pmqi refer :(NSString *) refer report :(NSString *)report  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//xin纸张上报
+(void)newZhizhangShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm pbid :(NSString *)pbid pbnm :(NSString *)pbnm pmyi :(NSString *)pmyi pmer :(NSString *)pmer pmsan :(NSString *)pmsan pmsi:(NSString *)pmsi pmwu :(NSString *)pmwu pmliu :(NSString *)pmliu pmqi :(NSString *)pmqi refer :(NSString *) refer report :(NSString *)report gouzhijianshu1:(NSString *)gouzhijianshu1 xiuqiu1:(NSString *)xiuqiu1 gouzhijianshu2:(NSString *)gouzhijianshu2 xiuqiu2:(NSString *)xiuqiu2 gouzhijianshu3:(NSString *)gouzhijianshu3 xiuqiu3:(NSString *)xiuqiu3    success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

//宁河质量事故审批上报
+(void)ningHeZhiLiangShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm odcode :(NSString *)odcode size :(NSString *)size pm :(NSString *)pm odnum :(NSString *)odnum err :(NSString *)err reason:(NSString *)reason opinion :(NSString *)opinion pic:(NSArray *)pic  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

//宁河质量事故审批上报
+(void)ningHeZhiLiangShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm odcode :(NSString *)odcode size :(NSString *)size pm :(NSString *)pm odnum :(NSString *)odnum err :(NSString *)err reason:(NSString *)reason opinion :(NSString *)opinion   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//宁河特规纸种申请审批上报
+(void)ningHePaperShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm batcha :(NSString *)batcha size :(NSString *)size pm :(NSString *)pm odnum :(NSString *)odnum montha :(NSString *)montha remark:(NSString *)remark   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//新宁河特规纸种申请审批上报
+(void)ningHePaperShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y txtTGZZ :(NSString *)txtTGZZ txtZF:(NSString *)txtZF txtZBGG :(NSString *)txtZBGG txtXQCCL :(NSString *)txtXQCCL txtXWDHRQ :(NSString *)txtXWDHRQ txtDPYL :(NSString *)txtDPYL txtYYL :(NSString *)txtYYL txtSYKH:(NSString *)txtSYKH  txtKHJSFS :(NSString *)txtKHJSFS txtBZ:(NSString *)txtBZ  pic:(NSArray *)pic success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//多图上报
+(void)approveMorePicShangBaoWithUSerID:(NSString *)usId flowId :(NSString *) flowId ftyp:(NSString *)ftyp tittle:(NSString *)tit cont:(NSString *)cont pric:(NSString *)pric pic:(NSArray *)pic voi:(NSData *)voi  AndX:(NSString*)x AndY:(NSString*)y   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;

//宁河申购单表格申请审批上报
+(void)ningHeShenGouShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y txtMingChengXingHao :(NSString *)txtMingChengXingHao txtDanWei:(NSString *)txtDanWei txtShuLiang :(NSString *)txtShuLiang txtBeiZhu :(NSString *)txtBeiZhu  pic:(NSArray *)pic  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
//宁河客户信息单申请审批上报
+(void)ningHeKeHuInformationShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y txtMingCheng :(NSString *)txtMingCheng txtDiZhi:(NSString *)txtDiZhi txtLianXiRen :(NSString *)txtLianXiRen txtDianHua :(NSString *)txtDianHua txtSanZheng :(NSString *)txtSanZheng txtHuanPing:(NSString *)txtHuanPing txtYueDingLiang :(NSString *)txtYueDingLiang txtShengChanZhi :(NSString *)txtShengChanZhi  txtZiChan:(NSString *)txtZiChan txtZhangQi :(NSString *)txtZhangQi txtShuoMing :(NSString *)txtShuoMing    pic:(NSArray *)pic success:(void(^)(NSArray *userArr))success fail:(void(^)())fail;
@end
