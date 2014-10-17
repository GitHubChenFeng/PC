//
//  FeedbackViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-28.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>
{
    UITextView *_txtView;
    UILabel *_describeTips;
    
}
@end

@implementation FeedbackViewController

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
    
    self.title = @"意见反馈";
    self.view.backgroundColor = RGB_MainBgColor;
    
    _txtView = [[UITextView alloc]initWithFrame:CGRectMake(10.f, 15, ScreenWidth - 2*10, 200)];
    
    _txtView.layer.borderWidth = 1;
    _txtView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    _txtView.returnKeyType =UIReturnKeyDone;
    _txtView.delegate = self;
    _txtView.font = KSystemFont(16);
    [self.view addSubview:_txtView];
    
    _describeTips = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 260, 30)];
    _describeTips.textColor = [UIColor lightGrayColor];
    _describeTips.text = @"悄悄话，请在这里告诉我们～";
    _describeTips.numberOfLines = 2;
    _describeTips.font = KSystemFont(15);
    _describeTips.backgroundColor = [UIColor clearColor];
    [_txtView addSubview:_describeTips];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setFrame:CGRectMake(10.f, 230.f, ScreenWidth - 20, 45)];
    [sendBtn setTitle:@"发  送" forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:RGB_MainAppColor];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
}

- (void)sendClick{
     [_txtView resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_txtView resignFirstResponder];
   
}

#pragma mark - UITextViewDelegate
- (void)handleTextViewChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        
        if ([_describeTips superview]==nil) {
            [_txtView addSubview:_describeTips];
        }
        
        _describeTips.text =  @"悄悄话，请在这里告诉我们～";
    }else{
        if ([_describeTips superview]!=nil) {
            [_describeTips removeFromSuperview];
        }
        _describeTips.text = @"";
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if(_txtView == textView){
        [self handleTextViewChange:textView];
    }
    
}
- (void)textViewDidChange:(UITextView *)textView{
    if(_txtView == textView){
        [self handleTextViewChange:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        //检测到“完成”
        [textView resignFirstResponder];//释放键盘

        return NO;
    }
    
    return YES;
}


@end
