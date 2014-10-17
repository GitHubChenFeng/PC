//
//  PreviewPathViewController.h
//  PC
//
//  Created by MacBook Pro on 14-9-21.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReleasePahtModel.h"
#import "BMapKit.h"
#import "SVProgressHUD.h"

@interface PreviewPathViewController : UIViewController<BMKMapViewDelegate, BMKRouteSearchDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView* _mapView;
    BMKRouteSearch* _routesearch;//路径规划
    BMKGeoCodeSearch* _geocodesearch; //地理位置编码
}

@property (nonatomic, strong) ReleasePahtModel *pModel;
@property (nonatomic, strong) ASIFormDataRequest *request;

@end
