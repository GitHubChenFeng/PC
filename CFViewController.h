//
//  CFViewController.h
//  PC
//
//  Created by MacBook Pro on 14-8-31.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "GetLatitudeAndLongitude.h"
#import "HomePageBottomView.h"
#import "MapAnnotation.h"
#import "CurrentLocationAnnotation.h"
#import "PopoverView.h"
#import "CMSCoinView.h"
#import "CheckDriverOrPassengerView.h"
#import "CFMessageViewController.h"
#import "CustomNaviBarSearchController.h"
#import "CustomViewController.h"
#import "NYSearchDoctorViewController.h"
#import "CFReleaseDirverRouteController.h"
#import "ReleasePassengerViewController.h"
#import "MyInfoViewController.h"
#import "LoginViewController.h"

@interface CFViewController : CustomViewController<BMKMapViewDelegate,LatAndLonDelegate,BMKPoiSearchDelegate,UITextFieldDelegate,HomePageBottomViewDelegate,BMKLocationServiceDelegate,PopoverViewDelegate,CheckDriverOrPassengerViewDelegate,CMSCoinViewDelegate,CustomNaviBarSearchControllerDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView          * _mapView;
    BMKPoiSearch        * _search;
    BMKGeoCodeSearch    * _geocodesearch;
    BMKLocationService  * _locService;//百度定位服务
    
    UIImageView         *bgView;
    UIImageView         *imgHeadView;
    CheckDriverOrPassengerView *_transitionDirverButton;
    CheckDriverOrPassengerView *_transitionPassengerButton;
    
    UIImageView         *_releasePathBgView;
    NSMutableArray      *_nearPointArry;
}

@property (nonatomic, strong) BMKPoiSearch* _search;
@property (nonatomic, strong) HomePageBottomView *bottomView;
@property (nonatomic, strong) UITextField *searchFeild;
@property (nonatomic, strong) NSMutableArray *driverArray;
@property (nonatomic, strong) BMKAnnotationView *annotationForRemove;

@property (nonatomic) int selectIndex;

@property (strong, nonatomic) PopoverView   *popverView;
@property (strong, nonatomic) CMSCoinView   *coinView;
@property (strong, nonatomic) GetLatitudeAndLongitude *latAndLon;
@property (nonatomic, readonly) CustomNaviBarSearchController *ctrlSearchBar;
@end
