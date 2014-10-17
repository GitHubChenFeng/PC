//
//  ManageCenter.h
//  PC
//
//  Created by MacBook Pro on 14-9-2.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManageCenter : NSObject

+ (ManageCenter *)shareManager;

@property(nonatomic, assign)BOOL             isFirstLogin;           // 第一次登陆标记
@property(nonatomic, assign)double           klongtitude;            // 经度
@property(nonatomic, assign)double           klatitude;              // 纬度
@property(nonatomic, strong)NSString         *city;                  // 城市信息
@property(nonatomic, strong)NSString         *zone;                  // 城市区
@property(nonatomic, strong)NSString         *locatCity;             // 定位城市


@property(nonatomic, strong)NSString         *URLSTR;                  //url请求


@end
