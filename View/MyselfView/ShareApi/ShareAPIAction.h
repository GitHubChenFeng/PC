//
//  ShareAPIAction.h
//  ShareDemo
//
//  Created by yunlai on 13-7-11.
//  Copyright (c) 2013年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFAppDelegate.h"
#import "WeiboViewController.h"
//#import "HttpRequest.h"

#define ShareImage          @"shareImage"       // 分享的图片
#define ShareContent        @"shareContent"     // 分享的内容
#define ShareTitle          @"shareTitle"       // 分享的标题
#define ShareUrl            @"shareurl"         // 分享的链接

// 分享
typedef enum
{
    ShareSina,              // 新浪微博
    ShareWXFriend,          // 微信好友
    ShareWXFriendCircle,    // 微信朋友圈
    ShareTencent,           // 腾讯微博
    SharePhone,             // 手机用户
    ShareQQ,                // QQ分享
    ShareMax
} SHAREENUM;

@class CallInfoApp;
@class WeiboView;

@protocol ShareAPIActionDelegate <NSObject>
@required
// 分享返回值回调
- (NSDictionary *)shareApiActionReturnValue;

@end

@interface ShareAPIAction : NSObject <UIAlertViewDelegate,APPlicationDelegate,WXApiDelegate>
{
    id <ShareAPIActionDelegate> delegate;
    NSDictionary *shareDict;
    CallInfoApp *callApp;
    
    WeiboViewController *weiboView;
}

@property (assign, nonatomic) id <ShareAPIActionDelegate> delegate;
@property (retain, nonatomic) NSDictionary *shareDict;
@property (retain, nonatomic) CallInfoApp *callApp;
@property (retain, nonatomic) UINavigationController *navController;

// 开始分享
- (void)startShare:(id <ShareAPIActionDelegate>)adelegate shareEnum:(SHAREENUM)share;

@end
