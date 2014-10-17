//
//  CFAppDelegate.h
//  PC
//
//  Created by MacBook Pro on 14-8-31.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "CFViewController.h"
#import "GetLatitudeAndLongitude.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

@protocol APPlicationDelegate <NSObject>
@optional
- (BOOL)tencentHandleCallBack:(NSDictionary*)param;
- (BOOL)sinaHandleCallBack:(NSDictionary*)param;
-(BOOL)qqHandleCallBack:(NSDictionary *)param;
-(BOOL)weixinHandleCallBack:(NSDictionary *)param;
@end

@interface CFAppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    
    BMKMapManager* _mapManager;
    CFViewController *_CfrootViewCtl;
    __unsafe_unretained id <APPlicationDelegate> delegate;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) id <APPlicationDelegate> delegate;
//@property (strong, nonatomic) BMKMapView *mapView;
//@property (strong, nonatomic) GetLatitudeAndLongitude *latAndLon;
@end
