//
//  SignatureViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-28.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "SignatureViewController.h"

@interface SignatureViewController ()<UITextViewDelegate>
{
    UITextView *_txtView;
}
@end

@implementation SignatureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"个性签名";
    self.view.backgroundColor = RGB_MainBgColor;
    
    _txtView = [[UITextView alloc]initWithFrame:CGRectMake(10.f, 15, ScreenWidth - 2*10, 140)];
    
    _txtView.layer.borderWidth = 1;
    _txtView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    _txtView.returnKeyType =UIReturnKeyDone;
    _txtView.delegate = self;
    _txtView.font = KSystemFont(16);
    [self.view addSubview:_txtView];

    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setFrame:CGRectMake(10.f, 180.f, ScreenWidth - 20, 45)];
    [saveBtn setTitle:@"保 存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:RGB_MainAppColor];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

- (void)saveBtnClick{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_txtView resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
