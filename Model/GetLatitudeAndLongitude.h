//版权所有：凯凯科技有限公司
//系统名称：
//文件名称：GetLatitudeAndLongitude
//作　　者：谢东
//完成日期：2013-7-23
//功能说明：获取经纬度
//-------------------------------

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LatAndLonDelegate <NSObject>

@optional
/**
 @brief 获取经纬度
 @param latAndLon保存经纬度
 */
- (void) getLatAndLon:(CLLocationCoordinate2D)aLatAndLon;

/**
 @brief 获取城市信息
 @param aDiCityInfo保存城市信息
 */
- (void) getCityInfo:(NSDictionary*)aDiCityInfo;

/**
 @brief 获取经纬度失败回调
 @param aError提示信息
 */
- (void) failedGetCurLocation:(NSError*)aError;

@end

@interface GetLatitudeAndLongitude : NSObject<CLLocationManagerDelegate>{
    
    CLLocationManager    *_locManager;  //定位器
}

@property(nonatomic,assign)id<LatAndLonDelegate> delegate;

/**
 @brief 启动定位
 */
- (void)starGetCurlocation;

/**
 @brief 获取城市信息
 @param aCoord 经纬度信息
 注：适合ios5.0以上
 */
- (void)getCityInfo:(CLLocationCoordinate2D) aCoord;

@end
