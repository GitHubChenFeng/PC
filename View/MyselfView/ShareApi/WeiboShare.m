//
//  WeiboShare.m
//  yunPai
//
//  Created by yunlai on 13-7-17.
//
//

#import "WeiboShare.h"
//#import "Common.h"
#import "TCWBEngine.h"
//#import "weibo_userinfo_model.h"
//#import "Global.h"

@implementation WeiboShare

@synthesize sinaWeibo;
@synthesize delegate;

- (void)sinaWeiboShareImage:(UIImage *)image text:(NSString *)text
{
    if (image == nil && text.length == 0) {
        return;
    }
//    int userId = [[Global sharedGlobal].user_id intValue];
//    weibo_userinfo_model *weiboMod = [[weibo_userinfo_model alloc] init];
//    
//    weiboMod.where = [NSString stringWithFormat:@"userId = %d and loginType = %d",userId,SINA];
//
//    NSArray *weiboArray = [weiboMod getList];
//   
//    [weiboMod release], weiboMod = nil;
//    
//    if (weiboArray != nil && [weiboArray count] > 0) {
//        
//        NSDictionary *dict = [weiboArray objectAtIndex:0];
//        sinaWeibo = [[SinaWeibo alloc] initWithAppKey:SinaAppKey appSecret:SinaAppSecret appRedirectURI:redirectUrl andDelegate:self];
//        sinaWeibo.userID = [dict objectForKey:@"uniqueKey"];
//        sinaWeibo.accessToken = [dict objectForKey:@"accessToken"];
//        sinaWeibo.expirationDate = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"expiresTime"] doubleValue]];
//        
//        if (image == nil) {
//            [sinaWeibo requestWithURL:@"statuses/update.json"
//                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:text, @"status", nil]
//                           httpMethod:@"POST"
//                             delegate:self];
//        } else {
//            [sinaWeibo requestWithURL:@"statuses/upload.json"
//                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:text, @"status",image, @"pic", nil]
//                           httpMethod:@"POST"
//                             delegate:self];
//        }
//    }
}

- (void)tencentWeiboShareImage:(UIImage *)image text:(NSString *)text
{
    if (image == nil && text.length == 0) {
        return;
    }
    // https://open.t.qq.com/api/t/add
    
//    int userId = [[Global sharedGlobal].user_id intValue];
//    weibo_userinfo_model *weiboMod = [[weibo_userinfo_model alloc] init];
//    
//    weiboMod.where = [NSString stringWithFormat:@"userId = %d and loginType = %d",userId,TENCENT];
//    
//    NSArray *weiboArray = [weiboMod getList];
//    
//    [weiboMod release], weiboMod = nil;
//    
//    if (weiboArray != nil && [weiboArray count] > 0) {
//        
//        NSDictionary *dict = [weiboArray objectAtIndex:0];
//        TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:QQAppKey andSecret:QQAppSecret andRedirectUrl:redirectUrl];
//        engine.openId = [dict objectForKey:@"uniqueKey"];
//        engine.accessToken = [dict objectForKey:@"accessToken"];
//        engine.appKey = QQAppKey;
//        engine.appSecret = QQAppSecret;
////        engine.appKey = [dict objectForKey:@"openKey"];
////        engine.appSecret = [dict objectForKey:@"secret"];
//        engine.expireTime = [[dict objectForKey:@"expiresTime"] intValue];
//        
//        if (image == nil) {
//            [engine postTextTweetWithFormat:@"json"
//                                      content:text
//                                     clientIP:@"183.14.110.186"
//                                    longitude:nil
//                                  andLatitude:nil
//                                  parReserved:nil
//                                     delegate:self
//                                    onSuccess:@selector(successCallBack:)
//                                    onFailure:@selector(failureCallBack:)];
//            
//        } else {
//            NSData *dataImage = UIImageJPEGRepresentation(image, 1.0);
//            [engine postPictureTweetWithFormat:@"json"
//                                       content:text
//                                      clientIP:@"183.14.110.186"
//                                           pic:dataImage
//                                compatibleFlag:@"0"
//                                     longitude:nil
//                                   andLatitude:nil
//                                   parReserved:nil
//                                      delegate:self
//                                     onSuccess:@selector(successCallBack:)
//                                     onFailure:@selector(failureCallBack:)];
//        }
//    }
}

- (void)dealloc
{
    self.sinaWeibo = nil;
}

#pragma mark - SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([delegate respondsToSelector:@selector(WeiboShareResult:)]) {
        [delegate WeiboShareResult:WeiboResultSuccess];
    }
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(WeiboShareResult:)]) {
        [delegate WeiboShareResult:WeiboResultFail];
    }
}

#pragma mark - WeiboRequestDelegate
- (void)successCallBack:(id)result
{
    if ([delegate respondsToSelector:@selector(WeiboShareResult:)]) {
        [delegate WeiboShareResult:WeiboResultSuccess];
    }
}

- (void)failureCallBack:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(WeiboShareResult:)]) {
        [delegate WeiboShareResult:WeiboResultFail];
    }
}

@end
