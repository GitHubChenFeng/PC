//
//  PfShare.h
//  cw
//
//  Created by yunlai on 13-9-30.
//
//

#import <Foundation/Foundation.h>
//#import "PopPfShareView.h"
//#import "HttpRequest.h"

//@class PopPfShareFail;

@interface PfShare : NSObject //<HttpRequestDelegate>//<PopPfShareViewDelegate,HttpRequestDelegate>
{
//    PopPfShareView *shareView;
//    PopPfShareFail *pfshare;
}

+ (PfShare *)defaultSingle;

- (void)pfShareRequest;

@end
