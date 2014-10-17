//
//  SelectStartPointViewController.h
//  PC
//
//  Created by MacBook Pro on 14-9-13.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface SelectStartPointViewController : CFBaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView          * _mapView;
    BMKLocationService  * _locService;//百度定位服务
    
}

@property (nonatomic, strong) NSMutableArray *nearPointArr;//定位附近的地点
@end
