//版权所有：凯凯科技有限公司
//系统名称：
//文件名称：GetLatitudeAndLongitude
//作　　者：谢东
//完成日期：2013-7-23
//功能说明：获取经纬度
//-------------------------------

#import "GetLatitudeAndLongitude.h"

@implementation GetLatitudeAndLongitude

@synthesize delegate;

- (void)dealloc
{
    if (delegate) {
        delegate = nil;
    }
}

/**
 @method 初始化
 */
- (id)init{
    self = [super init];
    if (self) {
        //初始化
        if (!_locManager) {
            _locManager =[[CLLocationManager alloc] init];
        }
    }
    return self;
}

/**
 @method 启动定位
 */
- (void)starGetCurlocation
{
    //定位成功
    _locManager.delegate = self;
    _locManager.desiredAccuracy = kCLLocationAccuracyBest;
    //移动100米更新定位
    _locManager.distanceFilter = 1000.0f;
    //启动定位
    [_locManager startUpdatingLocation];
}


/**
 @method 获取经纬度
 @param  manager 定位器
 @param  newLocation 新的经纬度
 @param  oldLocation 定位前的经纬度
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //获取经纬度
    CLLocationCoordinate2D mylocation = newLocation.coordinate;
    //停止定位
    [_locManager stopUpdatingLocation];
    //回调-传出经纬度
    if ([delegate respondsToSelector:@selector(getLatAndLon:)]) {
        [delegate getLatAndLon:mylocation];
    }
    //根据经纬度去获取城市信息
    [self getCityInfo:mylocation];
}

/**
 @method 获取经纬失败
 @param  manager 定位器
 @param  error 错误的信息
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError*)error{
    //获取经纬度失败
    if ([delegate respondsToSelector:@selector(failedGetCurLocation:)]) {
    [delegate failedGetCurLocation:error];
    }
}

/**
 @method 获取城市信息
 @param  aCoord 经纬度信息
 注：适合ios5.0以上
 */
- (void)getCityInfo:(CLLocationCoordinate2D) aCoord{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        
        //NSLog(@"placeconue:%d",place.count);
        for (CLPlacemark *placemark in place) {
            //城市
            NSString *cityStr=[placemark.addressDictionary objectForKey:@"City"];
            //NSLog(@"city:%@",cityStr);
            if (cityStr) [dict setObject:cityStr forKey:@"City"];
            
            //街道
            NSString *Street=[placemark.addressDictionary objectForKey:@"Street"];
            //NSLog(@"Street:%@",Street);
            if (Street) [dict setObject:Street forKey:@"Street"];
            
            //省份
            NSString *State=[placemark.addressDictionary objectForKey:@"State"];
            //NSLog(@"State:%@",State);
            if (State) [dict setObject:State forKey:@"State"];
            
            NSString *ZIP=[placemark.addressDictionary objectForKey:@"ZIP"];
            //NSLog(@"ZIP:%@",ZIP);
            if (ZIP) [dict setObject:ZIP forKey:@"ZIP"];
            
            //国家
            NSString *Country=[placemark.addressDictionary objectForKey:@"Country"];
            //NSLog(@"Country:%@",Country);
            if (Country) [dict setObject:Country forKey:@"Country"];
            
            //国家代码
            NSString *CountryCode=[placemark.addressDictionary objectForKey:@"CountryCode"];
            //NSLog(@"CountryCode:%@",CountryCode);
            if (CountryCode) [dict setObject:CountryCode forKey:@"CountryCode"];
            
            break;
        }
        if (delegate && [delegate respondsToSelector:@selector(getCityInfo:)]) {
            [delegate getCityInfo:dict];
        }
    };
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:aCoord.latitude longitude:aCoord.longitude];
    [geocoder reverseGeocodeLocation:loc completionHandler:handler];
 
}

@end