#import "ExchangeXYzuobiao.h"
#import "CSqlite.h"


@implementation ExchangeXYzuobiao
#pragma mark 火星坐标转换
const CGFloat x_pi = 3.14159265358979324 * 3000.0 / 180.0;
+(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    CSqlite *m_sqlite;
    m_sqlite = [[CSqlite alloc]init];
    [m_sqlite openSqlite];
    int TenLat=0;
    int TenLog=0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    sqlite3_stmt* stmtL = [m_sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step(stmtL)==SQLITE_ROW)
    {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
    }
    yGps.latitude = yGps.latitude+offLat*0.0001;
    yGps.longitude = yGps.longitude + offLog*0.0001;
    return yGps;
}
// 谷歌坐标转百度坐标
//+ (CLLocationCoordinate2D)getBaiduLocFromGoogleLocLat:(CGFloat)fGoogleLat lng:(CGFloat)fGoogleLng
//{
//    CLLocationCoordinate2D objLoc;
//    
//    CGFloat x = fGoogleLng, y = fGoogleLat;
//    CGFloat z = sqrt(x * x + y * y) + 0.00002f * sin(y * x_pi);
//    CGFloat theta = atan2(y, x) + 0.000003f * cos(x * x_pi);
//    objLoc.longitude = z * cos(theta) + 0.0065;
//    objLoc.latitude = z * sin(theta) + 0.006;
//    
//    return objLoc;
//}
//+ (CLLocationCoordinate2D)GPSLocToGoogleLoc:(CLLocationCoordinate2D)objGPSLoc
//{
//    CLLocationCoordinate2D objLoc;
//    
//    CGFloat x = fGoogleLng, y = fGoogleLat;
//    CGFloat z = sqrt(x * x + y * y) + 0.00002f * sin(y * x_pi);
//    CGFloat theta = atan2(y, x) + 0.000003f * cos(x * x_pi);
//    objLoc.longitude = z * cos(theta) + 0.0065;
//    objLoc.latitude = z * sin(theta) + 0.006;
//    
//    return objLoc;

//}
+ (CLLocationCoordinate2D)getBaiduLocFromGoogleLocLat:(CGFloat)fGoogleLat lng:(CGFloat)fGoogleLng
{
    CLLocationCoordinate2D objLoc;
    
    CGFloat x = fGoogleLng, y = fGoogleLat;
    CGFloat z = sqrt(x * x + y * y) + 0.00002f * sin(y * x_pi);
    CGFloat theta = atan2(y, x) + 0.000003f * cos(x * x_pi);
    objLoc.longitude = z * cos(theta) + 0.0065;
    objLoc.latitude = z * sin(theta) + 0.006;
    
    return objLoc;
}
@end
