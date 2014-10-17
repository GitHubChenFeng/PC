//
//  PfShare.m
//  cw
//
//  Created by yunlai on 13-9-30.
//
//

#import "PfShare.h"
//#import "Global.h"
//#import "promotion_model.h"
//#import "PopPfShareFail.h"
//#import "CustomTabBar.h"
//#import "LoginViewController.h"
//#import "CouponsViewController.h"

static PfShare *share = nil;

@implementation PfShare

+ (PfShare *)defaultSingle
{
    @synchronized(self) {
        if (share == nil) {
            share = [[PfShare alloc]init];
        }
    }
    return share;
}

- (void)pfShareRequest
{
//    if ([[Global sharedGlobal].user_id intValue] > 0)
//    {
//        [self accessSharePfService];
//    }
}

#pragma mark - PopPfShareViewDelegate
- (void)popPfShareViewClick
{
//    UINavigationController *navController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
//    CouponsViewController *couponCtl = [[CouponsViewController alloc]init];
//    couponCtl.cwStatusType = StatusTypeMemberChoosePf;
//    [navController pushViewController:couponCtl animated:YES];
//    [couponCtl release], couponCtl = nil;
    
//    NSArray *arrayViewControllers = navController.viewControllers;
//    
//    if ([[arrayViewControllers objectAtIndex:0] isKindOfClass:[CustomTabBar class]]) {
//
//        CustomTabBar *tabViewController = [arrayViewControllers objectAtIndex:0];
//        [navController popToViewController:tabViewController animated:YES];
//        tabViewController.selectedIndex = 3;
//        
//        UIButton *btn = (UIButton *)[tabViewController.view viewWithTag:90003];
//        [tabViewController selectedTab:btn];
//        
//        if ([Global sharedGlobal].isLogin) {
//            LoginViewController *login = [[tabViewController viewControllers] objectAtIndex:3];
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
//            [login.memberCenter.tableView.delegate tableView:login.memberCenter.tableView didSelectRowAtIndexPath:indexPath];
//            
//        }
//    }
}

// 分享加积分
- (void)accessSharePfService
{
//    NSString *reqUrl = @"receiveprivilege.do?param=";
	
//    NSMutableDictionary *requestDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                       [Global sharedGlobal].shop_id,@"shop_id",
//                                       [Global sharedGlobal].info_id,@"info_id",
//                                       [Global sharedGlobal].user_id,@"user_id",
//                                       nil];
    
//    [[NetManager sharedManager] accessService:requestDic data:nil command:SHARE_GET_COMMAND_ID accessAdress:reqUrl delegate:self withParam:nil];
}

// 分享获取
- (void)shareGet:(NSMutableArray*)resultArray
{
    NSLog(@"resultArray = %@",resultArray);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([[resultArray lastObject] intValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self success];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self fail];
            });
        }
    });
}

// 分享获取成功
- (void)success
{
//    promotion_model *pMod = [[promotion_model alloc]init];
//    NSArray *arr = [pMod getList];
//    [pMod release], pMod = nil;
//    
//    NSDictionary *dict = nil;
//    if (arr.count > 0) {
//        dict = [arr lastObject];
//    }
//    if (shareView == nil) {
//        shareView = [[PopPfShareView alloc]init];
//    }
//    shareView.delegate = self;
//    
//    [shareView addPopupSubview:dict];
}

// 分享获取失败
- (void)fail
{
//    if (pfshare == nil) {
//        pfshare = [[PopPfShareFail alloc]init];
//    }
//    [pfshare addPopupSubview];
}

- (void)didFinishCommand:(NSMutableArray*)resultArray cmd:(int)commandid withVersion:(int)ver
{
//    switch(commandid) {
//        case SHARE_GET_COMMAND_ID:      // 分享获取
//        {
//            [self shareGet:resultArray];
//        }
//            break;
//        default:
//            break;
//    }
}

- (void)dealloc
{

}

@end
