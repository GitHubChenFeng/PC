//
//  CommonMethod.h
//  PC
//
//  Created by MacBook Pro on 14-9-1.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonMethod : NSObject


// 是否4英寸屏幕
+ (BOOL)is4InchScreen;

//获取当前时间
+ (NSString*)getCurrentTime;

//拨打电话
+ (void)makeCall:(NSString *)phoneNumber;

//获取加密key
+ (NSString*)getSecureString:(NSString *)keystring;

//服务器数据请求
+ (NSString *)requestServiceUrl:(NSString *)url;

// 手机号码正则表达式
+ (BOOL)phoneNumberChecking:(NSString *)phone;

@end
