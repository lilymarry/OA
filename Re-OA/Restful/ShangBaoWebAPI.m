#import "ShangBaoWebAPI.h"
#import "URL.h"
#import "NetRequestTool.h"


#define shangBao [NSString stringWithFormat:@"%@/Wap/WapFlowHandler.ashx",kDomain]
#define getZhixinxi [NSString stringWithFormat:@"%@/Wap/WapPapeHandler.ashx?",kDomain]
@implementation ShangBaoWebAPI


//获取上报权限流
+(void)getShangBaoFlowWithType:(NSString *)type Andu_id:(NSString *)u_id success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"fNowP",@"ftyp":type,@"u_id":u_id};
    [[NetRequestTool sharedRequest]request :dic URL:shangBao success:success fail:fail];
}
//上报审核提交
+(void)approveShangBaoWithUSerID:(NSString *)usId flowId :(NSString *) flowId ftyp:(NSString *)ftyp tittle:(NSString *)tit cont:(NSString *)cont pric:(NSString *)pric pic:(NSData *)pic voi:(NSData *)voi   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"fStart",@"u_id":usId,@"fpId":flowId ,@"ftyp":ftyp,@"tit":tit ,@"con":cont ,@"pric":pric };
    [[NetRequestTool sharedRequest]request:dic URL:shangBao imageData:pic soundData:voi success:success fail:fail];
}
//上报审核提交(GPS)
+(void)approveShangBaoWithUSerID:(NSString *)usId flowId :(NSString *) flowId ftyp:(NSString *)ftyp tittle:(NSString *)tit cont:(NSString *)cont pric:(NSString *)pric pic:(NSData *)pic voi:(NSData *)voi  AndX:(NSString*)x AndY:(NSString*)y   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"fStart",@"u_id":usId,@"fpId":flowId ,@"ftyp":ftyp,@"tit":tit ,@"con":cont ,@"pric":pric,@"x":x,@"y":y};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao imageData:pic soundData:voi success:success fail:fail];
}
//上报列表
+(void)getshangBaoListWithUserID:(NSString *)_id ftype:(NSString *)typeId  fstate :(NSString *)fstate fpId:(NSString *)fpId success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"rtList",@"u_id":_id,@"fstate":fstate ,@"ftyp":typeId ,@"fpId":fpId};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}
//上报列表刷新
+(void)getshangBaoListWithUserID:(NSString *)_id ftype:(NSString *)typeId  fstate :(NSString *)fstate fpId:(NSString *)fpId
                            pkey:(NSString *)fpiid
                            rnum:(NSString *)rNum
        success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"rtList",@"u_id":_id,@"fstate":fstate ,@"ftyp":typeId ,@"fpId":fpId,@"pkey":fpiid,@"rNum":rNum};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}
////流程轨迹
+(void)getshangBaoListFlowfpId:(NSString *)fpId success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"fLocus",@"fpiId":fpId};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}
+(NSString *)smallImgUrlPathWithUid:(NSString*)uid picName :(NSString *)pic
{
    return [NSString stringWithFormat:@"%@/Upload/%@/FLow/pic/small/%@",kDomain,uid,pic];
}
+(NSString *)largeImgUrlPathWithUid:(NSString*)uid picName :(NSString *)pic{
    return  [NSString stringWithFormat:@"%@/Upload/%@/FLow/pic/%@",kDomain,uid,pic];
}
+(NSString *)soundUrlPathWithUid:(NSString*)uid voiName :(NSString *)voi{
    return  [NSString stringWithFormat:@"%@/Upload/%@/FLow/voi/%@",kDomain,uid,voi];
}
//付款上报
+(void)ShangBaoCaiwuFuKuanWithUid:(NSString *)uid  cont :(NSString *)cont extr :(NSString *)estr proj :(NSString *)proj prop :(NSString *)prop fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype
                          success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"cont":cont,@"extr":estr,@"proj":proj,@"prop":prop,@"fpId":fpId,@"met":met,@"u_id":uid,@"method":@"fmSPay",@"num":num,@"ftyp":ftype};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}
//借款上报
+(void)ShangBaoCaiwujiekuanWithUid:(NSString *)uid  way :(NSString *)way extr :(NSString *)estr pers :(NSString *)pers  fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype
                          success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"way":way,@"extr":estr,@"pers":pers,@"fpId":fpId,@"met":met,@"u_id":uid,@"method":@"fmSLoan",@"num":num,@"ftyp":ftype};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}
//部门列表
+(void)ShangBaoCaiwuDepartListWithsuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"getD"};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}
//报销上报
+(void)ShangBaoCaiwuBaoXiaoWithUid:(NSString *)uid  depId :(NSString *)DepID dep :(NSString *)dep  fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype  det:(NSString *)det success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"fpId":fpId,@"met":met,@"u_id":uid,@"method":@"fmSGetM",@"depid":DepID, @"dep":dep,@"num":num,@"ftyp":ftype,@"det":det};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}

//报销上报(GPS)
+(void)ShangBaoCaiwuBaoXiaoWithUid:(NSString *)uid  depId :(NSString *)DepID dep :(NSString *)dep  fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype  det:(NSString *)det   AndX:(NSString*)x AndY:(NSString*)y  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"fpId":fpId,@"met":met,@"u_id":uid,@"method":@"fmSGetM",@"depid":DepID, @"dep":dep,@"num":num,@"ftyp":ftype,@"det":det,@"x":x,@"y":y};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}
//付款上报(GPS)
+(void)ShangBaoCaiwuFuKuanWithUid:(NSString *)uid  cont :(NSString *)cont extr :(NSString *)estr proj :(NSString *)proj prop :(NSString *)prop fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype  AndX:(NSString*)x AndY:(NSString*)y
                          success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"cont":cont,@"extr":estr,@"proj":proj,@"prop":prop,@"fpId":fpId,@"met":met,@"u_id":uid,@"method":@"fmSPay",@"num":num,@"ftyp":ftype,@"x":x,@"y":y};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}
//借款上报(GPS)
+(void)ShangBaoCaiwujiekuanWithUid:(NSString *)uid  way :(NSString *)way extr :(NSString *)estr pers :(NSString *)pers  fpid:(NSString *)fpId met:(NSString *)met num:(NSString *)num ftype:(NSString *)ftype  AndX:(NSString*)x AndY:(NSString*)y
                           success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"way":way,@"extr":estr,@"pers":pers,@"fpId":fpId,@"met":met,@"u_id":uid,@"method":@"fmSLoan",@"num":num,@"ftyp":ftype,@"x":x,@"y":y};
    [[NetRequestTool sharedRequest]request:dic URL:shangBao  success:success fail:fail];
}

+(void)deleteSingleShangBao:(NSString *)fpiid success:(void (^)(NSArray *))success fail:(void (^)())fail{
    NSDictionary * param = @{@"fpiid":fpiid,@"method":@"DelFlow"};
    [[NetRequestTool sharedRequest] request:param URL:shangBao success:success fail:fail];
}

//获得纸板名称
+(void)zhiZhangNameWithsuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"pblist"};
    [[NetRequestTool sharedRequest]request:dic URL:getZhixinxi  success:success fail:fail];
}
//纸张详情
+(void)getzhizhangDetailWithpbid:(NSString *)pbid success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"pbfind",@"pbid":pbid};
    [[NetRequestTool sharedRequest]request:dic URL:getZhixinxi  success:success fail:fail];
}
//获得损耗率
+(void)SunHaoLvWithsuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"plr"};
    [[NetRequestTool sharedRequest]request:dic URL:getZhixinxi  success:success fail:fail];
}
//获取纸板材质 信息
+(void)zhibanCaiZhiWithsuccess:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary *dic=@{@"method":@"pmlist"};
    [[NetRequestTool sharedRequest]request:dic URL:getZhixinxi  success:success fail:fail];
}
//纸张上报
+(void)zhizhangShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm pbid :(NSString *)pbid pbnm :(NSString *)pbnm pmyi :(NSString *)pmyi pmer :(NSString *)pmer pmsan :(NSString *)pmsan pmsi:(NSString *)pmsi pmwu :(NSString *)pmwu pmliu :(NSString *)pmliu pmqi :(NSString *)pmqi refer :(NSString *) refer report :(NSString *)report  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary * param = @{@"fpid":fpid,@"method":@"fmspape",@"uid":uid ,@"x":x ,@"y":y ,@"khid":khid,@"khnm":khnm,@"pbid":pbid,@"pbnm":pbnm,@"pmyi":pmyi,@"pmer":pmer,@"pmsan":pmsan ,@"pmsi":pmsi ,@"pmwu":pmwu,@"pmliu":pmliu,@"pmqi":pmqi ,@"refer":refer,@"report": report};
    [[NetRequestTool sharedRequest] request:param URL:shangBao success:success fail:fail];
}
//xin纸张上报
+(void)newZhizhangShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm pbid :(NSString *)pbid pbnm :(NSString *)pbnm pmyi :(NSString *)pmyi pmer :(NSString *)pmer pmsan :(NSString *)pmsan pmsi:(NSString *)pmsi pmwu :(NSString *)pmwu pmliu :(NSString *)pmliu pmqi :(NSString *)pmqi refer :(NSString *) refer report :(NSString *)report gouzhijianshu1:(NSString *)gouzhijianshu1 xiuqiu1:(NSString *)xiuqiu1 gouzhijianshu2:(NSString *)gouzhijianshu2 xiuqiu2:(NSString *)xiuqiu2 gouzhijianshu3:(NSString *)gouzhijianshu3 xiuqiu3:(NSString *)xiuqiu3    success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary * param = @{@"fpid":fpid,@"method":@"fmsnhpape",@"uid":uid ,@"x":x ,@"y":y ,@"khid":khid,@"khnm":khnm,@"pbid":pbid,@"pbnm":pbnm,@"pmyi":pmyi,@"pmer":pmer,@"pmsan":pmsan ,@"pmsi":pmsi ,@"pmwu":pmwu,@"pmliu":pmliu,@"pmqi":pmqi ,@"refer":refer,@"report": report,@"gouzhijianshu1":gouzhijianshu1 ,@"xiuqiu1":xiuqiu1,@"gouzhijianshu2":gouzhijianshu2 ,@"xiuqiu2":xiuqiu2,@"gouzhijianshu3":gouzhijianshu3 ,@"xiuqiu3":xiuqiu3};
    [[NetRequestTool sharedRequest] request:param URL:shangBao success:success fail:fail];
}



//宁河质量事故审批上报
+(void)ningHeZhiLiangShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm odcode :(NSString *)odcode size :(NSString *)size pm :(NSString *)pm odnum :(NSString *)odnum err :(NSString *)err reason:(NSString *)reason opinion :(NSString *)opinion  pic:(NSArray *)pic  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary * param = @{@"fpid":fpid,@"method":@"fmsnherr",@"u_id":uid,@"uid":uid,@"x":x ,@"y":y ,@"khid":khid,@"khnm":khnm,@"odcode":odcode,@"size":size,@"pm":pm,@"odnum":odnum,@"err":err ,@"opinion":opinion,@"reason":reason};
 //   [[NetRequestTool sharedRequest] request:param URL:shangBao success:success fail:fail];
    [[NetRequestTool sharedRequest]requestMorePics:param URL:shangBao images:pic  success:success fail:fail];

}
//宁河质量事故审批上报
+(void)ningHeZhiLiangShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm odcode :(NSString *)odcode size :(NSString *)size pm :(NSString *)pm odnum :(NSString *)odnum err :(NSString *)err reason:(NSString *)reason opinion :(NSString *)opinion   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary * param = @{@"fpid":fpid,@"method":@"fmsnherr",@"u_id":uid,@"uid":uid,@"x":x ,@"y":y ,@"khid":khid,@"khnm":khnm,@"odcode":odcode,@"size":size,@"pm":pm,@"odnum":odnum,@"err":err ,@"opinion":opinion,@"reason":reason};
       [[NetRequestTool sharedRequest] request:param URL:shangBao success:success fail:fail];
//    [[NetRequestTool sharedRequest]requestMorePics:param URL:shangBao images:pic  success:success fail:fail];
    
}

//宁河特规纸种申请审批上报
+(void)ningHePaperShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y khid :(NSString *)khid khnm:(NSString *)khnm batcha :(NSString *)batcha size :(NSString *)size pm :(NSString *)pm odnum :(NSString *)odnum montha :(NSString *)montha remark:(NSString *)remark   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary * param = @{@"fpid":fpid,@"method":@"fmsnhspape",@"uid":uid ,@"x":x ,@"y":y ,@"khid":khid,@"khnm":khnm,@"size":size,@"pm":pm,@"odnum":odnum,@"batcha":batcha ,@"montha":montha,@"remark":remark};
    [[NetRequestTool sharedRequest] request:param URL:shangBao success:success fail:fail];
}

//新宁河特规纸种申请审批上报
+(void)ningHePaperShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y txtTGZZ :(NSString *)txtTGZZ txtZF:(NSString *)txtZF txtZBGG :(NSString *)txtZBGG txtXQCCL :(NSString *)txtXQCCL txtXWDHRQ :(NSString *)txtXWDHRQ txtDPYL :(NSString *)txtDPYL txtYYL :(NSString *)txtYYL txtSYKH:(NSString *)txtSYKH  txtKHJSFS :(NSString *)txtKHJSFS txtBZ:(NSString *)txtBZ  pic:(NSArray *)pic  success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary * param = @{@"fpid":fpid,@"method":@"fmsnewnhspape",@"uid":uid ,@"x":x ,@"y":y ,@"txtTGZZ":txtTGZZ,@"txtZF":txtZF,@"txtZBGG":txtZBGG,@"txtXQCCL":txtXQCCL,@"txtXWDHRQ":txtXWDHRQ,@"txtDPYL":txtDPYL ,@"txtYYL":txtYYL,@"txtSYKH":txtSYKH,@"txtKHJSFS":txtKHJSFS,@"txtBZ":txtBZ};
    [[NetRequestTool sharedRequest] request:param URL:shangBao success:success fail:fail];
      //   [[NetRequestTool sharedRequest]requestMorePics:param URL:shangBao images:pic  success:success fail:fail];
}




//多图上报
+(void)approveMorePicShangBaoWithUSerID:(NSString *)usId flowId :(NSString *) flowId ftyp:(NSString *)ftyp tittle:(NSString *)tit cont:(NSString *)cont pric:(NSString *)pric pic:(NSArray *)pic voi:(NSData *)voi  AndX:(NSString*)x AndY:(NSString*)y   success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{

  
        NSDictionary *dic=@{@"method":@"fStart",@"u_id":usId,@"fpId":flowId ,@"ftyp":ftyp,@"tit":tit ,@"con":cont ,@"pric":pric,@"x":x,@"y":y};
       // [[NetRequestTool sharedRequest]request:dic URL:shangBao imageData:pic soundData:voi success:success fail:fail];
        [[NetRequestTool sharedRequest]requestMorePics:dic URL:shangBao images:pic soundData:voi success:success fail:fail];
    


}
//宁河申购单表格申请审批上报
+(void)ningHeShenGouShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y txtMingChengXingHao :(NSString *)txtMingChengXingHao txtDanWei:(NSString *)txtDanWei txtShuLiang :(NSString *)txtShuLiang txtBeiZhu :(NSString *)txtBeiZhu pic:(NSArray *)pic success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary * param = @{@"fpid":fpid,@"method":@"formnhpurchase",@"uid":uid,@"u_id":uid,@"x":x ,@"y":y ,@"txtMingChengXingHao":txtMingChengXingHao,@"txtDanWei":txtDanWei,@"txtShuLiang":txtShuLiang,@"txtBeiZhu":txtBeiZhu};
    
     [[NetRequestTool sharedRequest]requestMorePics:param URL:shangBao images:pic  success:success fail:fail];
  
}

//宁河客户信息单申请审批上报
+(void)ningHeKeHuInformationShangbao:(NSString *)uid andfpid:(NSString *)fpid  x:(NSString *)x y:(NSString *)y txtMingCheng :(NSString *)txtMingCheng txtDiZhi:(NSString *)txtDiZhi txtLianXiRen :(NSString *)txtLianXiRen txtDianHua :(NSString *)txtDianHua txtSanZheng :(NSString *)txtSanZheng txtHuanPing:(NSString *)txtHuanPing txtYueDingLiang :(NSString *)txtYueDingLiang txtShengChanZhi :(NSString *)txtShengChanZhi  txtZiChan:(NSString *)txtZiChan txtZhangQi :(NSString *)txtZhangQi txtShuoMing :(NSString *)txtShuoMing    pic:(NSArray *)pic success:(void(^)(NSArray *userArr))success fail:(void(^)())fail
{
    NSDictionary * param = @{@"fpid":fpid,@"method":@"formnhcustomerinfo",@"uid":uid,@"u_id":uid,@"x":x ,@"y":y ,@"txtMingCheng":txtMingCheng,@"txtDiZhi":txtDiZhi,@"txtLianXiRen":txtLianXiRen,@"txtDianHua":txtDianHua,@"txtSanZheng":txtSanZheng,@"txtHuanPing":txtHuanPing,@"txtYueDingLiang":txtYueDingLiang,@"txtShengChanZhi":txtShengChanZhi,@"txtZiChan":txtZiChan,@"txtZhangQi":txtZhangQi,@"txtShuoMing":txtShuoMing};
     
    [[NetRequestTool sharedRequest]requestMorePics:param URL:shangBao images:pic  success:success fail:fail];
    
}


@end
