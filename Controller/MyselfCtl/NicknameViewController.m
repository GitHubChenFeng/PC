//
//  NicknameViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-28.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "NicknameViewController.h"

@interface NicknameViewController ()
{
    UITextField *_txtField;
}
@end

@implementation NicknameViewController

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
    
    self.title = @"昵称";
    self.view.backgroundColor = RGB_MainBgColor;
    
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 10.f, ScreenWidth, 44.f)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    
    _txtField = [[UITextField alloc]initWithFrame:CGRectMake(10.f, 0.f, ScreenWidth, 44.f)];
    [_txtField becomeFirstResponder];
    [mainView addSubview:_txtField];
    
    UILabel *tips = [[UILabel alloc]initWithFrame:CGRectMake(10.f, CGRectGetMaxY(mainView.frame) + 5, 300.f, 30.f)];
    tips.text = @"好名字可以让朋友们更容易记住你哦～";
    tips.textColor = RGB_TextLightGray;
    tips.font = KSystemFont(15);
    [self.view addSubview:tips];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(20.f, 100.f, 130.f, 45)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.borderColor = RGB_MainAppColor.CGColor;
    cancelBtn.layer.borderWidth = 1;
    [self.view addSubview:cancelBtn];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setFrame:CGRectMake(170.f, 100.f, 130.f, 45)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:RGB_MainAppColor];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

- (void)cancelClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveBtnClick{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_txtField resignFirstResponder];
    
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
