//
//  TencentWeiboViewController.h
//  yunPai
//
//  Created by yunlai on 13-7-17.
//
//

#import <UIKit/UIKit.h>
#import "CFAppDelegate.h"
#import "WBApi.h"
#import "WeiboApi.h"

@protocol OauthTencentWeiSuccessDelegate <NSObject>

@required
- (void)oauthTencentSuccessIsFail:(BOOL)isSuccess;

@end

@interface TencentWeiboViewController : UIViewController <WBApiDelegate,APPlicationDelegate,UIWebViewDelegate>
{
    id <OauthTencentWeiSuccessDelegate> delegate;
    BOOL _isRequest;
}

// 授权成功会调用此委托
@property (assign, nonatomic) id <OauthTencentWeiSuccessDelegate> delegate;
@property (nonatomic ,assign) BOOL isRequest;
@property (nonatomic , retain) WeiboApi    *wbapi;

@end
