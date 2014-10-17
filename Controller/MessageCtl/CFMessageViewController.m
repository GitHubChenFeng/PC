//
//  CFMessageViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-7.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "CFMessageViewController.h"
#import "CFReleaseDirverRouteController.h"
#import "UINavigationBar+setBgImage.h"

@interface CFMessageViewController ()

@end

@implementation CFMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"消息";
   
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initLeftBarButton];
    
    
    [self requestInfo];
    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setFrame:CGRectMake(100, 70, 125, 25)];
//    
//    [backBtn setImage:IMG(@"dirver_release_bg") forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backBtn];
}

- (void)initLeftBarButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 7, 25, 25)];
    
    [backBtn setImage:IMG(@"back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

- (void)backBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)click{
    CFReleaseDirverRouteController *messageView = [[CFReleaseDirverRouteController alloc]init];
    
//    UINavigationController *navBar = [[UINavigationController alloc]initWithRootViewController:messageView];
    
    [self.navigationController pushViewController:messageView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestInfo
{
    if (!_request.isExecuting) {
    
        NSString *url = [CommonMethod requestServiceUrl:sendRouteHttpUrl];
        
        _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
      
        [_request setPostValue:@"1" forKey:@"type"];
        [_request setPostValue:@"10" forKey:@"start_time"];
        [_request setPostValue:@"南头" forKey:@"start_addr"];
        [_request setPostValue:@"113.925629" forKey:@"start_lng"];
        [_request setPostValue:@"22.548345" forKey:@"start_lat"];
        [_request setPostValue:@"科技园" forKey:@"end_addr"];
        [_request setPostValue:@"133.925629" forKey:@"end_lng"];
        [_request setPostValue:@"24.548345" forKey:@"end_lat"];
        [_request setPostValue:@"ios接口调试" forKey:@"remark"];
//        [_request setPostValue: forKey:@"pos"];
        [_request setPostValue:@"1" forKey:@"route_type"];
        [_request setPostValue:@"1" forKey:@"user_id"];
        
        _request.delegate = self;
        _request.timeOutSeconds = 30;
        [_request startAsynchronous];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{

    NSDictionary *dict1 = [request responseString];

}

- (void)requestFailed:(ASIHTTPRequest *)request
{

}
@end
