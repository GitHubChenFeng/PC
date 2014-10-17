//
//  TencentWeiboViewController.m
//  yunPai
//
//  Created by yunlai on 13-7-17.
//
//

#import "TencentWeiboViewController.h"
//#import "Common.h"
#import "JSONKit.h"
//#import "weibo_userinfo_model.h"
#import "WeiboApi.h"

#define TOKEN                   @"token"
#define RESPONSE_TYPE           @"response_type"
#define CLIENT_ID               @"client_id"
#define REDIRECT_URI            @"redirect_uri"
#define kWBAuthorizeURL         @"https://open.t.qq.com/cgi-bin/oauth2/authorize/ios"

@interface TencentWeiboViewController ()

@property (retain, nonatomic) NSString *accessToken;
@property (retain, nonatomic) NSString *userID;
@property (retain, nonatomic) NSString *appkey;
@property (retain, nonatomic) NSString *appsecret;
@property (assign, nonatomic) int expiresTime;
@property (retain, nonatomic) NSString *userName;

@property (retain, nonatomic) UIWebView *webView;
@property (nonatomic, retain) NSString  *returnCode;
@property (retain, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation TencentWeiboViewController

@synthesize accessToken;
@synthesize userID;
@synthesize appkey;
@synthesize appsecret;
@synthesize expiresTime;
@synthesize userName;
@synthesize delegate;
@synthesize isRequest=_isRequest;
@synthesize webView = _webView;
@synthesize returnCode;
@synthesize indicatorView;
@synthesize wbapi;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"腾讯微博";
    
    CFAppDelegate *appdelegate = ApplicationDelegate;
    appdelegate.delegate = self;
    
    
    BOOL bRet = NO;
    
    NSLog(@"设置是否安装了微博客户端：%d",[WBApi isWeiboAppSupport]);
    
    if( (bRet = [WBApi isWeiboAppSupport]))
    {
//        NSDictionary *infoDict =[[NSBundle mainBundle] infoDictionary];
//        NSLog(@"infoDict = %@",infoDict);
//        NSArray *arr = [infoDict objectForKey:@"CFBundleURLTypes"];
//        if (arr.count > 0) {
//            NSDictionary *dict = [arr objectAtIndex:0];
//            NSArray *arra = [dict objectForKey:@"CFBundleURLSchemes"];
//            for (NSString *str in arra) {
//                if ([str isEqualToString:@"2222"]) {
//                    bRet = YES;
//                }
//            }
//        }
        
//        if (!bRet) {
        bRet = [WBApi loginApp:QQAppKey secret:QQAppSecret reserver:TENCENTredirectUrl];
//        } else {
//            bRet = NO;
//        }
    }

    if(bRet == YES)
    {
        NSLog(@"sso auth suc!");
        return;
    }
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight)];
    _webView.scalesPageToFit = YES;
    _webView.userInteractionEnabled = YES;
    _webView.delegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_webView];
    
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:QQAppKey,CLIENT_ID,
                            TOKEN, RESPONSE_TYPE,
                            TENCENTredirectUrl,REDIRECT_URI,
                            @"ios",@"appfrom",
                            [NSNumber numberWithInt:1],@"htmlVersion",
                            nil];
    NSString *urlString = [self serializeURL:kWBAuthorizeURL
                                      params:params
                                  httpMethod:@"GET"];
    
    [params release], params = nil;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                        timeoutInterval:60.0];
    [_webView loadRequest:request];
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setCenter:CGPointMake(160, 200)];
    [self.view addSubview:indicatorView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [accessToken release], accessToken = nil;
    [userID release], userID = nil;
    [appkey release], appkey = nil;
    [appsecret release], appsecret = nil;
    [userName release], userName = nil;
    
    self.webView = nil;
    self.returnCode = nil;
    self.indicatorView = nil;
    
    [super dealloc];
}

- (void)writeDataToDB
{
    NSDictionary *weiboDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              TENCENT,@"weiboType",
                              self.userID,@"uid",
                              self.userName,@"userName",
                              self.accessToken,@"accessToken",
                              [NSNumber numberWithInt:expiresTime],@"expiresTime",
                              self.appsecret,@"secret",
                              self.appkey,@"openKey",
                              nil];
//    weibo_userinfo_model *weiboMod = [[weibo_userinfo_model alloc] init];
//    
//    weiboMod.where = [NSString stringWithFormat:@"weiboType = '%@'",TENCENT];
//    [weiboMod deleteDBdata];
//    
//    [weiboMod insertDB:weiboDic];
//    
//    NSArray *weiboArray = [weiboMod getList];
//    
//    [weiboMod release], weiboMod = nil;
//    
//    NSLog(@"sinaWeiboShareImage weiboArray = %@",weiboArray);
    
    if (delegate != nil && [delegate respondsToSelector:@selector(oauthTencentSuccessIsFail:)]) {
        [delegate oauthTencentSuccessIsFail:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getStr:(NSString *)str code:(NSString *)codeStr
{
    NSString *code = nil;
    NSRange range = [codeStr rangeOfString:str];
    if (range.location != NSNotFound) {
        code = [codeStr substringFromIndex:range.location + range.length];
    }
    return code;
}
- (void)getArrData:(NSArray *)codeArr
{
    for (NSString *str in codeArr) {
        if ([str rangeOfString:@"="].location != NSNotFound) {

            NSRange range = [str rangeOfString:@"="];
            NSString *code = [str substringToIndex:range.location];
            
            if ([code isEqualToString:@"access_token"]) {
                self.accessToken = [self getStr:@"access_token=" code:str];
            } else if ([code isEqualToString:@"openid"]) {
                self.userID = [self getStr:@"openid=" code:str];
            } else if ([code isEqualToString:@"expires_in"]) {
                self.expiresTime = [[self getStr:@"expires_in=" code:str] intValue];
            } else if ([code isEqualToString:@"openkey"]) {
                self.appkey = QQAppKey;
            } else if ([code isEqualToString:@"nick"]) {
                NSString *name = [self getStr:@"nick=" code:str];
                // utf-8 转为 GBK
                self.userName = [name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            } else {
                self.appsecret = QQAppSecret;
            }
        }
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"urlString = %@",urlString);
    NSRange range = [urlString rangeOfString:@"access_token="];
    if (range.location != NSNotFound){
        NSRange scope = [urlString rangeOfString:@"#"];
        NSString *code = [urlString substringFromIndex:scope.location + scope.length];
        NSArray *arr = [code componentsSeparatedByString:@"&"];
        [self getArrData:arr];
        
        [self writeDataToDB];
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [indicatorView stopAnimating];
    if (delegate != nil && [delegate respondsToSelector:@selector(oauthTencentSuccessIsFail:)]) {
        [delegate oauthTencentSuccessIsFail:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark APPlicationDelegate
- (BOOL)tencentHandleCallBack:(NSDictionary*)param
{
    NSURL *url = [param objectForKey:@"url"];

    return [WBApi handleOpenURL:url delegate:self];

}

#pragma mark - WBApiDelegate
-(void)onLoginFailed:(WBErrCode)errCode msg:(NSString*)msg
{
    if (delegate != nil && [delegate respondsToSelector:@selector(oauthTencentSuccessIsFail:)]) {
        [delegate oauthTencentSuccessIsFail:NO];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)onLoginSuccessed:(NSString*)name token:(WBToken*)token
{
    self.accessToken = token.accessToken;
    self.userID = token.openid;
    self.expiresTime = token.expires;
    self.appsecret = QQAppSecret;
    self.appkey = QQAppKey;
    self.userName = name;
    
    [self writeDataToDB];
}

//生成url链接
- (NSString *)stringFromDictionary:(NSDictionary *)dict{
    NSMutableArray *pairs = [NSMutableArray array];
	for (NSString *key in [dict keyEnumerator]){
		if (!([[dict valueForKey:key] isKindOfClass:[NSString class]])){
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [dict objectForKey:key]]];
		}
        else{
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [[dict objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
	}
	
	return [pairs componentsJoinedByString:@"&"];
}

//生成url请求链接
- (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params httpMethod:(NSString *)httpMethod{
    if (![httpMethod isEqualToString:@"GET"]){
        return baseURL;
    }
    NSURL *parsedURL = [NSURL URLWithString:baseURL];
	NSString *queryPrefix = parsedURL.query ? @"&" : @"?";
	NSString *query = [self stringFromDictionary:params];
	
	return [NSString stringWithFormat:@"%@%@%@", baseURL, queryPrefix, query];
}

//
//#pragma mark - WeiboAuthDelegate---IOS7
//
///**
// * @brief   重刷授权成功后的回调
// * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
// * @return  无返回
// */
//- (void)DidAuthRefreshed:(WeiboApiObject *)wbobj
//{
//    
//    
//    //UISwitch
//    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r openid = %@\r appkey=%@ \r appsecret=%@\r",wbobj.accessToken, wbobj.openid, wbobj.appKey, wbobj.appSecret];
//    
//    NSLog(@"result = %@",str);
//    
////    self.accessToken = wbobj.accessToken;
////    self.userID = wbobj.openid;
////    self.expiresTime = wbobj.expires;
////    self.appsecret = QQAppSecret;
////    self.appkey = QQAppKey;
////    self.userName = wbobj.userName;
////    
////    [self writeDataToDB];
//    
//    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//    });
//    [str release];
//    
//}
//
///**
// * @brief   重刷授权失败后的回调
// * @param   INPUT   error   标准出错信息
// * @return  无返回
// */
//- (void)DidAuthRefreshFail:(NSError *)error
//{
//    NSString *str = [[NSString alloc] initWithFormat:@"refresh token error, errcode = %@",error.userInfo];
//    
//    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//
//    });
//    [str release];
//}
//
///**
// * @brief   授权成功后的回调
// * @param   INPUT   wbapi 成功后返回的WeiboApi对象，accesstoken,openid,refreshtoken,expires 等授权信息都在此处返回
// * @return  无返回
// */
//- (void)DidAuthFinished:(WeiboApiObject *)wbobj
//{
//    NSString *str = [[NSString alloc]initWithFormat:@"accesstoken = %@\r\n openid = %@\r\n appkey=%@ \r\n appsecret=%@ \r\n refreshtoken=%@ ", wbobj.accessToken, wbobj.openid, wbobj.appKey, wbobj.appSecret, wbobj.refreshToken];
//    
//    NSLog(@"result = %@",str);
//    
//    
//    
//    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        
//    });
//    
//    
//    // NSLog(@"after add pic");
//    [str release];
//}
//
///**
// * @brief   授权成功后的回调
// * @param   INPUT   wbapi   weiboapi 对象，取消授权后，授权信息会被清空
// * @return  无返回
// */
//- (void)DidAuthCanceled:(WeiboApi *)wbapi_
//{
//    
//}
//
///**
// * @brief   授权成功后的回调
// * @param   INPUT   error   标准出错信息
// * @return  无返回
// */
//- (void)DidAuthFailWithError:(NSError *)error
//{
//    NSString *str = [[NSString alloc] initWithFormat:@"get token error, errcode = %@",error.userInfo];
//    
//    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        
//    });
//    [str release];
//}
//
///**
// * @brief   授权成功后的回调
// * @param   INPUT   error   标准出错信息
// * @return  无返回
// */
//-(void)didCheckAuthValid:(BOOL)bResult suggest:(NSString *)strSuggestion
//{
//    NSString *str = [[NSString alloc] initWithFormat:@"ret=%d, suggestion = %@", bResult, strSuggestion];
//    //注意回到主线程，有些回调并不在主线程中，所以这里必须回到主线程
//    dispatch_async(dispatch_get_main_queue(), ^{
//    
//    });
//    [str release];
//}

@end
