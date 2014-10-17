//
//  PopShareView.m
//  ShareDemo
//
//  Created by yunlai on 13-7-11.
//  Copyright (c) 2013年 ios. All rights reserved.
//

#import "PopShareView.h"
#import "ShareAPIAction.h"
//#import "AppDelegate.h"
//#import "Common.h"

#define ButHegiht       60.f    // 图标按钮的高度
#define LabelHeight     25.f    // 图标字体的高度

#define UpHeight        20.f    // 图标与上边距的高度
#define DownHeight      20.f    // 图标与下边距的高度
#define LeftWidth       15.f    // 图标与左边距的宽度

#define SpaceWidth      15.f    // 图标与图标的宽度
#define DownBtnHeight   40.f    // 取消按钮的高度

static PopShareView *popup = nil;

@implementation PopShareView

@synthesize bgView;
@synthesize butArrayText;
@synthesize butArrayImage;
@synthesize share;
@synthesize delegatePop;
@synthesize navController;

- (id)init
{
    self = [super initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight + 20.f)];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.f];

        bgView = [[UIView alloc]initWithFrame:CGRectZero];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
       
    }
    return self;
}

// 单例模式搞起
+ (PopShareView *)defaultExample
{
    @synchronized(self) {
        if (popup == nil) {
            popup = [[PopShareView alloc]init];
        }
    }
    return popup;
}

// 创建弹出框
- (void)createPopupView:(ShareType)type
{
    if (bgView.subviews.count == 0)
    {
        
        switch (type) {
            case ShareTypeThree:
            {
                butArrayText = @[@"微信",@"新浪",@"朋友圈",@"短信"];
                butArrayImage = @[@"weixin_friend",@"sina_share.png",@"weixin_share",@"info_share.png"];
            }
                break;
            case ShareTypeAll:
            {
                butArrayText = [NSArray arrayWithObjects:@"新浪微博",@"微信",@"朋友圈",@"腾讯微博",@"短信", nil];
                butArrayImage = [NSArray arrayWithObjects:
                                 @"share_sinaweibo_store.png",
                                 @"share_txmicro_store.png",
                                 @"share_txcircle_store.png",
                                 @"share_txweibo_store.png",
                                 @"share_sms_store.png", nil];
            }
                break;
            default:
                break;
        }
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToClose)];
        [self addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        int row = butArrayText.count%4 == 0 ? butArrayText.count/4 : butArrayText.count/4 + 1;
        int count = 0;
        int rowCount = 0;
        
//        UILabel *sharelabel = [[UILabel alloc]initWithFrame:CGRectMake(25.f, 15.f, 60.f, 20.f)];
//        sharelabel.backgroundColor = [UIColor clearColor];
////        sharelabel.textColor = [[ThemeManager shareInstance] getColorWithName:@"COLOR_GRAY"];
//        sharelabel.text = @"分享到";
//        sharelabel.font = KSystemFont(15);
//        sharelabel.textAlignment = NSTextAlignmentCenter;
//        [bgView addSubview:sharelabel];
//        [sharelabel release], sharelabel = nil;
        
        //关闭按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15,100.f,
                               ScreenWidth - 30.f , 40.f);
        [btn setTitle:@"取 消" forState:UIControlStateNormal];
        [btn setTitleColor:RGB_MainAppColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = ShareMax;
        btn.layer.borderWidth = 0.8;
        btn.layer.borderColor = RGB_MainAppColor.CGColor;
        [bgView addSubview:btn];
        
        //横线
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(btn.frame) + 15.0f, ScreenWidth, 1.f)];
////        line.backgroundColor = [[ThemeManager shareInstance] getColorWithName:@"COLOR_LINE"];
//        [bgView addSubview:line];
//        [line release], line = nil;
        
        for (int i = 0; i < butArrayText.count; i++) {
            if (i % 4 == 0) {
                count = 0;
                rowCount++;
            } else {
                count++;
            }
            
            // 图标按钮开始创建
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(count*(ButHegiht+SpaceWidth) + LeftWidth,
                                      rowCount*UpHeight + (rowCount-1)*(ButHegiht + LabelHeight),
                                      ButHegiht, ButHegiht);
            [button setBackgroundImage:[UIImage imageNamed:[butArrayImage objectAtIndex:i]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i;
            [bgView addSubview:button];
            
            // 图标字体开始创建
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(button.frame.origin.x,
//                                                                      button.frame.origin.y + button.frame.size.height,
//                                                                      button.frame.size.width, LabelHeight)];
//            label.font = [UIFont systemFontOfSize:12.f];
//            label.textAlignment = NSTextAlignmentCenter;
//            label.text = [butArrayText objectAtIndex:i];
//            label.tag = i + 100;
//            [bgView addSubview:label];
//            [label release], label = nil;
        }
        
        CGFloat height = row * (ButHegiht + LabelHeight + UpHeight) + UpHeight + 60.f;
        
        bgViewHeight = height;
    } 
}

//点背景关闭
-(void)tapToClose
{
    [UIView animateWithDuration:0.23f animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.0f];
        bgView.frame = CGRectMake(0.f, self.frame.size.height, self.frame.size.width, bgViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 显示弹窗
- (void)showPopupView:(UINavigationController *)viewController delegate:(id)adelegate shareType:(ShareType)type
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    self.delegatePop = adelegate;
    self.navController = viewController;

    [self createPopupView:type];
    
    bgView.frame = CGRectMake(0.f, self.frame.size.height, self.frame.size.width, bgViewHeight);
    
    // 动画弹窗向上弹出，且背景色由透明变半透明
    [UIView animateWithDuration:0.23f animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        bgView.frame = CGRectMake(0.f, self.frame.size.height - bgViewHeight, self.frame.size.width, bgViewHeight);
    }];
}

// 按钮事件
- (void)buttonClick:(UIButton *)btn
{
    // 动画弹窗向下消失，且背景色由半透明变透明
    [UIView animateWithDuration:0.23f animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.0f];
        bgView.frame = CGRectMake(0.f, self.frame.size.height, self.frame.size.width, bgViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    if (btn.tag != ShareMax)
    {
        ShareAPIAction *shareA = [[ShareAPIAction alloc]init];
        shareA.navController = self.navController;
        self.share = shareA;
        [shareA release];
        
        [share startShare:self.delegatePop shareEnum:btn.tag];
    }
}

- (void)dealloc
{
    [bgView release], bgView = nil;
    [butArrayText release], butArrayText = nil;
    [butArrayImage release], butArrayImage = nil;
    self.share = nil;
    self.navController = nil;
    
    [super dealloc];
}

@end
