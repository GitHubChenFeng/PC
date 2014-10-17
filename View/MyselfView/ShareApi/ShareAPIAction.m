//
//  ShareAPIAction.m
//  ShareDemo
//
//  Created by yunlai on 13-7-11.
//  Copyright (c) 2013年 ios. All rights reserved.
//

#import "ShareAPIAction.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "SendMsgToWeChat.h"
#import "CallInfoApp.h"
#import "UIImageScale.h"
//#import "shareToWeiboViewController.h"

#import <TencentOpenAPI/QQApiInterface.h>
#import "QQSendMessage.h"
//#import "Global.h"

#define WXDownAddress @"http://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8"
#define WXShareImageSize CGSizeMake(57,57)

@implementation ShareAPIAction

@synthesize delegate;
@synthesize shareDict;
@synthesize callApp;
@synthesize navController = _navController;

// QQ分享
- (void)QQShareDict:(NSDictionary *)shareDic
{
    if (![QQApi isQQInstalled]) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:nil
                                  message:@"使用QQ可以方便、免费的与好友分享图片、新闻"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  otherButtonTitles:@"下载QQ",nil];
        alertView.tag = 1;
        [alertView show];
        [alertView release];
    } else {
        if (![QQApi isQQSupportApi]) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:nil
                                      message:@"您的QQ版本不支持分享，请下载最新的QQ版本"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      otherButtonTitles:@"下载QQ",nil];
            alertView.tag = 2;
            [alertView show];
            [alertView release];
        } else {
            // 发送数据实例创建
            QQSendMessage *sendQQMsg = [[QQSendMessage alloc] init];
            // 得到标题
            NSString *title = [shareDic objectForKey:ShareTitle];
            // 得到所有内容
            NSString *content = [shareDic objectForKey:ShareContent];
            // 得到URL链接
            NSString *url = [shareDic objectForKey:ShareUrl];
            // 得到图片
            UIImage *image = [shareDic objectForKey:ShareImage];
            
            // 图片缩小到WX接受的范围内
            UIImage *imagesss = nil;
            if (url.length == 0) {
                if (image) {
                    imagesss = image;
                } else {
                    imagesss = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"yun_plus_download_share" ofType:@"jpg"]];
                }
                // 只分享图片
                [sendQQMsg sendImageMessageForQQ:imagesss ThumbImage:[imagesss fillSize:CGSizeMake(57, 57)] title:title description:content];
            } else {
                if (image) {
                    imagesss = [image scaleToSize:CGSizeMake(57, 57)];
                } else {
                    imagesss = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"yun_plus_download_share" ofType:@"jpg"]];
                }
                // 分享数据到微信好友
                [sendQQMsg sendUrlMessageForQQ:imagesss url:url title:title description:content];
            }
            [sendQQMsg release];
        }
    }
}

// 微信 分享
- (void)WXShareInt:(int)intWX dict:(NSDictionary *)shareDic
{
    // 是否安装微信
    if(![WXApi isWXAppInstalled]) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:nil
                                  message:@"使用微信可以方便、免费的与好友分享图片、新闻"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  otherButtonTitles:@"下载微信",nil];
        alertView.tag = 0;
        [alertView show];
        [alertView release];
    }else {
        // 发送数据实例创建
        SendMsgToWeChat *sendMsg = [[SendMsgToWeChat alloc] init];
        // 得到标题
        NSString *title = [shareDic objectForKey:ShareTitle];
        // 得到所有内容
        NSString *content = [shareDic objectForKey:ShareContent];
        // 得到URL链接
        NSString *url = [shareDic objectForKey:ShareUrl];
        // 得到图片
        UIImage *image = [shareDic objectForKey:ShareImage];

        // 图片缩小到WX接受的范围内
        UIImage *imagesss = nil;
        if (url.length == 0) {
            if (image) {
                imagesss = image;
            } else {
                imagesss = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"yun_plus_download_share" ofType:@"jpg"]];
            }
            // 只分享图片
            [sendMsg sendImageContent:imagesss ThumbImage:[image fillSize:WXShareImageSize] type:intWX];
        } else {
            if (image) {
                imagesss = [image fillSize:WXShareImageSize];
            } else {
                imagesss = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"yun_plus_download_share" ofType:@"jpg"]];
            }
            // 分享数据到微信好友
            [sendMsg sendNewsContent:title newsDescription:content newsImage:imagesss newUrl:url shareType:intWX];
        }
        [sendMsg release];
    }
}

// 微博 分享
- (void)weiboShareWeiboEnum:(WEIBOENUM)WeiboEnum dict:(NSDictionary *)shareDic
{
    UIImage *shareImage = [shareDict objectForKey:ShareImage];
    NSString *content = [shareDict objectForKey:ShareContent];
    
    weiboView = [[WeiboViewController alloc]init];
    weiboView.weiboText = content;
    weiboView.weiboImage = shareImage;
    weiboView.type = WeiboEnum;
//    UINavigationController *navPushView = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    [self.navController pushViewController:weiboView animated:YES];
}
// 手机短信 分享
- (void)phoneShareDict:(NSDictionary *)shareDic
{
    NSString *url = [shareDict objectForKey:ShareUrl];
    NSString *content = [shareDict objectForKey:ShareContent];
    
    NSString *sendContent = [NSString stringWithFormat:@"%@,url:%@",content,url];
    
    CallInfoApp *callAppc = [[CallInfoApp alloc]init];
    self.callApp = callAppc;
    [callAppc release];
    
    [self.callApp sendMessageTo:@"" withContent:sendContent withNav:_navController];
}

// 开始分享
- (void)startShare:(id <ShareAPIActionDelegate>)adelegate shareEnum:(SHAREENUM)share
{
    CFAppDelegate *appdelegate = (CFAppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.delegate = self;
    self.delegate = adelegate;
    
    if ([delegate respondsToSelector:@selector(shareApiActionReturnValue)])
    {
        self.shareDict = [delegate shareApiActionReturnValue];
    }
    NSLog(@"self.shareDict = %@",self.shareDict);
    
    if (self.shareDict)
    {
        switch (share)
        {
            case ShareWXFriendCircle:   // 朋友圈
                [self WXShareInt:0 dict:self.shareDict];
                break;
            case ShareWXFriend:         // 朋友
                [self WXShareInt:1 dict:self.shareDict];
                break;
            case ShareSina:             // 新浪
                [self weiboShareWeiboEnum:WeiboEnumSina dict:shareDict];
                break;
            case ShareTencent:          // 腾讯
                [self weiboShareWeiboEnum:WeiboEnumTencent dict:shareDict];
                break;
            case SharePhone:            // 手机短信
                [self phoneShareDict:shareDict];
                break;
            case ShareQQ:               // QQ分享
                NSLog(@"ShareQQ");
                [self QQShareDict:self.shareDict];
                break;
                
            default:
                break;
        }
    }
    
    self.shareDict = nil;
    self.delegate = nil;
}

-(BOOL)weixinHandleCallBack:(NSDictionary *)param
{
    NSURL *url = [param objectForKey:@"url"];
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)onReq:(BaseReq *)req
{}

//分享成功后请求积分接口更新用户积分
-(void)onResp:(BaseResp *)resp
{
//    if(resp.errStr == nil || resp.errStr.length == 0)
//    {
//        int userId = [[Global sharedGlobal].user_id intValue];
//        if(userId > 0)
//        {
//            NSMutableDictionary *requestDic = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:userId] forKey:@"userId"];
//            [[NetManager sharedManager] accessService:requestDic data:nil command:SHARE_CONTENT_COMMAND_ID accessAdress:@"share.do?param=" delegate:nil withParam:nil];
//        }
//    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0) {
        if(buttonIndex != alertView.cancelButtonIndex)
        {
            // 微信如果没有安装，从此处跳到安装目录
            NSURL *url = [NSURL URLWithString:WXDownAddress];
            [[UIApplication sharedApplication] openURL:url];
        }
    } else if (alertView.tag == 1) {
        if(buttonIndex != alertView.cancelButtonIndex)
        {
            // QQ如果没有安装，从此处跳到安装目录
            NSURL *url = [NSURL URLWithString:[QQApi getQQInstallURL]];
            [[UIApplication sharedApplication] openURL:url];
        }
    } else if(alertView.tag == 2) {
        if(buttonIndex != alertView.cancelButtonIndex)
        {
            // QQ API不支持，从此处跳到下载目录
            NSURL *url = [NSURL URLWithString:[QQApi getQQInstallURL]];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)dealloc
{
    self.shareDict = nil;
    self.callApp = nil;
    [_navController release];
    [super dealloc];
}
@end
