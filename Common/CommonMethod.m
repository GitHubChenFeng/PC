//
//  CommonMethod.m
//  PC
//
//  Created by MacBook Pro on 14-9-1.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "CommonMethod.h"
#import <MessageUI/MessageUI.h>
#import "Encry.h"

@implementation CommonMethod


// 是否4英寸屏幕
+ (BOOL)is4InchScreen
{
    static BOOL bIs4Inch = NO;
    static BOOL bIsGetValue = NO;
    
    if (!bIsGetValue)
    {
        CGRect rcAppFrame = [UIScreen mainScreen].bounds;
        bIs4Inch = (rcAppFrame.size.height == 568.0f);
        
        bIsGetValue = YES;
    }else{}
    
    return bIs4Inch;
}

//获取当前时间
+ (NSString*)getCurrentTime{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    
	return [dateFormatter stringFromDate:[NSDate date]];
    
}

//拨打电话
+ (void)makeCall:(NSString *)phoneNumber
{
	BOOL canSendSMS = [MFMessageComposeViewController canSendText];
	if (canSendSMS) {
		
		NSString* numberAfterClear = [self cleanPhoneNumber:phoneNumber];
		
		NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", numberAfterClear]];
		NSLog(@"make call, URL=%@", phoneNumberURL);
		
		[[UIApplication sharedApplication] openURL:phoneNumberURL];
	}
	else {
		NSLog(@"系统不支持电话功能");
        
	}
}
+ (NSString*)cleanPhoneNumber:(NSString*)phoneNumber
{
	
    phoneNumber=[phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [phoneNumber length])];
    phoneNumber=[phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [phoneNumber length])];
    phoneNumber=[phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [phoneNumber length])];
    phoneNumber=[phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [phoneNumber length])];
    phoneNumber=[phoneNumber stringByReplacingOccurrencesOfString:@"+86" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [phoneNumber length])];
    return phoneNumber;
	
}

+ (NSString*)getSecureString:(NSString *)keystring
{
	NSString *securekey = [Encry md5:keystring];
	return securekey;
}

//服务器数据请求
+ (NSString *)requestServiceUrl:(NSString *)url{
    //时间戳
    NSString *time = [CommonMethod getCurrentTime];
    //密钥
    NSString *key = [CommonMethod getSecureString:[NSString stringWithFormat:@"%@+%@",serviceSignSecureKey,time]];
    NSString *resultUrl = [NSString stringWithFormat:@"%@&rand=%@&key=%@",url,time,key];
    
    MLOG(@"请求接口:%@",resultUrl);
    
    return resultUrl;
}

// 手机号码正则表达式
+ (BOOL)phoneNumberChecking:(NSString *)phone
{
    //    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phone];
}

@end
