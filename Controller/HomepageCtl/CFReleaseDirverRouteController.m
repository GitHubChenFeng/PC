//
//  CFReleaseDirverRouteController.m
//  PC
//
//  Created by MacBook Pro on 14-9-9.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "CFReleaseDirverRouteController.h"
#import "AddMidPlaceCell.h"
#import "ReleasePahtModel.h"

#define kLeftMargin 15.f

@interface CFReleaseDirverRouteController ()<UITableViewDataSource,UITableViewDelegate,BMKGeoCodeSearchDelegate>
{
    UILabel *_describeTips;
    RMDateSelectionViewController *dateSelectionVC;
    
    UISegmentedControl  *segmentView;
    
    UIButton *beginPlaceButton;
    UIButton *endPointButton;
    
    UIButton *leftBeginTimeButton;
    UIButton *rightBeginTimeButton;
    NSMutableArray *_midPlaceArr;
    NSMutableArray *_midPlaceTitleArr;
    
    BMKGeoCodeSearch* _geocodesearchBegain;

    ReleasePahtModel *_pathModel;
}

@property (nonatomic ,strong) UITableView *releaseTableView;

@end

@implementation CFReleaseDirverRouteController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"发布路线";
    [self initReleaseRouteView];
    
    [self initLeftBarButton];
    
    _nearPointArr = [[NSMutableArray alloc]initWithCapacity:0];
    _midPlaceTitleArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    _geocodesearchBegain = [[BMKGeoCodeSearch alloc]init];
    _geocodesearchBegain.delegate = self;
    
    _pathModel = [[ReleasePahtModel alloc]init];
    
    MLOG(@"%@",GETBeginDepart);
   
}

- (void)viewWillAppear:(BOOL)animated{
    [beginPlaceButton setTitle:GETBeginDepart forState:UIControlStateNormal];
    
    [self checkGeocodeSearchOption:GETBeginDepart whthBMKGeoCodeSearch:_geocodesearchBegain];
    
    if (![GETDestination isEqualToString:@""]) {
        [endPointButton setTitle:GETDestination forState:UIControlStateNormal];
        [endPointButton setTitleColor:RGB_TextDark forState:UIControlStateNormal];

    }else{
        [endPointButton setTitle:@"选择你的目的地" forState:UIControlStateNormal];
        [endPointButton setTitleColor:RGB_TextLightGray forState:UIControlStateNormal];
        
    }
    
    MLOG(@"%@",GETMidPlaceOne);
    if (![GETMidPlaceOne isEqualToString:@""]) {
        [_midPlaceArr replaceObjectAtIndex:0 withObject:GETMidPlaceOne];
        
    }
    if (![GETMidPlaceTwo isEqualToString:@""]) {
        [_midPlaceArr replaceObjectAtIndex:1 withObject:GETMidPlaceTwo];
    }
    if (![GETMidPlaceThere isEqualToString:@""]) {
        [_midPlaceArr replaceObjectAtIndex:2 withObject:GETMidPlaceThere];
    }
    [_releaseTableView reloadData];
}

- (void)initReleaseRouteView{
    
    _midPlaceArr = [[NSMutableArray alloc]initWithArray:0];
    [_midPlaceArr addObject:@""];
    
    _releaseTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _releaseTableView.delegate = self;
    _releaseTableView.dataSource = self;
    _releaseTableView.separatorStyle = 0;

    [self.view addSubview:_releaseTableView];
    
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth,ScreenHeight-200)];
    self.releaseTableView.tableHeaderView = mainView;
    
    UILabel *chooseTips = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, 10.f, 200.f, 30.f)];
    chooseTips.text = @"请选择拼车类型";
    chooseTips.font = KSystemFont(17);
    chooseTips.textColor = RGB_TextLightDark2;
    [mainView addSubview:chooseTips];
    
    segmentView = [[UISegmentedControl  alloc] initWithItems:[NSArray  arrayWithObjects:@"单次", @"上班", @"下班", nil]];
    segmentView.frame = CGRectMake(kLeftMargin, 65.f, ScreenWidth - 2*kLeftMargin, 35.f);
    segmentView.center = CGPointMake(160, 65);
    segmentView.selectedSegmentIndex = 0;//设置默认选择项索引
    [segmentView addTarget:self action:@selector(changeBeginTime:) forControlEvents:UIControlEventValueChanged];

    segmentView.tintColor = RGB_MainAppColor;
    segmentView.segmentedControlStyle = UISegmentedControlStyleBar;
    [mainView  addSubview:segmentView];

    
    UILabel *beginTips = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, 90.f, 200.f, 30.f)];
    beginTips.text = @"出发时间";
    beginTips.font = KSystemFont(17);
    beginTips.textColor = RGB_TextLightDark2;
    [mainView addSubview:beginTips];
    
    NSArray *currentTime = [[self handleDateFormatter:[NSDate date]] componentsSeparatedByString:@"="];
    
    leftBeginTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBeginTimeButton setTitle:[currentTime objectAtIndex:0] forState:UIControlStateNormal];
    [leftBeginTimeButton setFrame:CGRectMake(kLeftMargin, 125.f, (ScreenWidth - 2*kLeftMargin )/2, 44.f)];

    [leftBeginTimeButton setTitleColor:RGB_TextLightDark forState:UIControlStateNormal];
    leftBeginTimeButton.layer.borderWidth = 1;
    leftBeginTimeButton.layer.borderColor = RGB_TextLineLightGray.CGColor;
    [leftBeginTimeButton addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:leftBeginTimeButton];
    
    NSString *rightTime = [NSString stringWithFormat:@"%@%@",[currentTime objectAtIndex:1],[currentTime objectAtIndex:2]];
    rightBeginTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBeginTimeButton setTitle:rightTime forState:UIControlStateNormal];
    [rightBeginTimeButton setFrame:CGRectMake( 290/2 + kLeftMargin -1, 125.f, (ScreenWidth - 2*kLeftMargin)/2 + 1, 44.f)];
    rightBeginTimeButton.layer.borderWidth = 1;
    rightBeginTimeButton.layer.borderColor = RGB_TextLineLightGray.CGColor;
    [rightBeginTimeButton setTitleColor:RGB_TextLightDark forState:UIControlStateNormal];
    [rightBeginTimeButton addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:rightBeginTimeButton];
    
    
    UILabel *beginPlace = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, ViewY(leftBeginTimeButton) + ViewHeight(leftBeginTimeButton) + 5, 200.f, 30.f)];
    beginPlace.text = @"出发地";
    beginPlace.textColor = RGB_TextLightDark2;
    beginPlace.font = KSystemFont(17);
    [mainView addSubview:beginPlace];
    
    beginPlaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [beginPlaceButton setTitle:GETBeginDepart forState:UIControlStateNormal];
    [beginPlaceButton setFrame:CGRectMake(kLeftMargin, ViewY(beginPlace) + ViewHeight(beginPlace) + 5, ScreenWidth - 2*kLeftMargin, 44.f)];

    beginPlaceButton.layer.borderWidth = 1;
    beginPlaceButton.layer.borderColor = RGB_TextLineLightGray.CGColor;
    beginPlaceButton.titleEdgeInsets = UIEdgeInsetsMake(0.f, 10.f, 0., 0.);
    [beginPlaceButton setTitleColor:RGB_TextLightDark2 forState:UIControlStateNormal];
    beginPlaceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [beginPlaceButton addTarget:self action:@selector(beginPlaceClick) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:beginPlaceButton];
    
    UIImageView *iconRight = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 2*kLeftMargin - 35, 5.f, 35.f, 35.f)];
    [iconRight setImage:IMG(@"btn_right_arrow")];
    [beginPlaceButton addSubview:iconRight];
    
    UILabel *endPointTips = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, ViewY(beginPlaceButton) + ViewHeight(beginPlaceButton) + 5, 200.f, 30.f)];
    endPointTips.text = @"目的地";
    endPointTips.textColor = RGB_TextLightDark2;
    endPointTips.font = KSystemFont(17);
    [mainView addSubview:endPointTips];
    
    endPointButton = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [endPointButton setFrame:CGRectMake(kLeftMargin, ViewY(endPointTips) + ViewHeight(endPointTips) + 5, ScreenWidth - 2*kLeftMargin, 44.f)];
    if (GETDestination!=nil) {
        [endPointButton setTitle:GETBeginDepart forState:UIControlStateNormal];
        [endPointButton setTitleColor:RGB_TextDark forState:UIControlStateNormal];
    }else{
        [endPointButton setTitle:@"选择你的目的地" forState:UIControlStateNormal];
        [endPointButton setTitleColor:RGB_TextLightGray forState:UIControlStateNormal];
    }
    
    endPointButton.layer.borderWidth = 1;
    endPointButton.layer.borderColor = RGB_TextLineLightGray.CGColor;
    endPointButton.titleEdgeInsets = UIEdgeInsetsMake(0.f, 10.f, 0., 0.);
    endPointButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [endPointButton addTarget:self action:@selector(endPointClick) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:endPointButton];
    
    UIImageView *endIconRight = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 2*kLeftMargin - 35, 5.f, 35.f, 35.f)];
    [endIconRight setImage:IMG(@"btn_right_arrow")];
    [endPointButton addSubview:endIconRight];
    
    UILabel *midPointTips = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, ViewY(endPointButton) + ViewHeight(endPointButton) + 5, 200.f, 30.f)];
    midPointTips.text = @"中转点";
    midPointTips.textColor = RGB_TextLightDark2;
    midPointTips.font = KSystemFont(17);
    [mainView addSubview:midPointTips];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 200)];
    self.releaseTableView.tableFooterView = footView;
    
    UILabel *messageTips = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, 5, 200.f, 30.f)];
    messageTips.text = @"留言（可选）";
    messageTips.textColor = RGB_TextLightDark2;
    messageTips.font = KSystemFont(17);
    [footView addSubview:messageTips];
    
    _txtView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftMargin, ViewY(messageTips) + ViewHeight(messageTips) + 5, ScreenWidth - 2*kLeftMargin, 90)];

    _txtView.layer.borderWidth = 1;
    _txtView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    _txtView.returnKeyType =UIReturnKeyDone;
    _txtView.delegate = self;
    _txtView.font = KSystemFont(16);
    [footView addSubview:_txtView];
    
    _describeTips = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 260, 50)];
    _describeTips.textColor = [UIColor lightGrayColor];
    _describeTips.text = @"请写下你对乘客的期望或者你的拼车宣言！（仅限30字）";
    _describeTips.numberOfLines = 2;
    _describeTips.font = KSystemFont(15);
    _describeTips.backgroundColor = [UIColor clearColor];
    [_txtView addSubview:_describeTips];
    
    
    UIButton *previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previewButton setTitle:@"预览路线" forState:UIControlStateNormal];
    [previewButton setFrame:CGRectMake(kLeftMargin * 3, ViewY(_txtView) + ViewHeight(_txtView) + 15, ScreenWidth - 6*kLeftMargin, 44.f)];
    [previewButton setBackgroundColor:RGB_MainAppColor];
    [previewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [previewButton addTarget:self action:@selector(previewClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:previewButton];
    
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

// 选择拼车类型
-(void)changeBeginTime:(UISegmentedControl *)Seg{
    NSInteger segIndex = Seg.selectedSegmentIndex;
    NSString *currLeftTimeStr;
    NSString *currRightTimeStr;
    NSArray *currentTime = [[self handleDateFormatter:[NSDate date]] componentsSeparatedByString:@"="];
    
    if (segIndex == 0) {

        currLeftTimeStr = [currentTime objectAtIndex:0];
        currRightTimeStr = [NSString stringWithFormat:@"%@%@",[currentTime objectAtIndex:1],[currentTime objectAtIndex:2]];
        
    }else {
     
        currLeftTimeStr = [currentTime objectAtIndex:1];
        currRightTimeStr = [currentTime objectAtIndex:2];
    }
    
    [leftBeginTimeButton setTitle:currLeftTimeStr forState:UIControlStateNormal];
    [rightBeginTimeButton setTitle:currRightTimeStr forState:UIControlStateNormal];
}

// 选择时间
- (void)selectTime{

    dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    [dateSelectionVC showFromViewController:self];
    
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    dateSelectionVC.datePicker.minuteInterval = 5;
    dateSelectionVC.datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    
}

// 出发地
- (void)beginPlaceClick{
    SelectStartPointViewController *selectCtl = [[SelectStartPointViewController alloc]init];
    selectCtl.nearPointArr = self.nearPointArr;
    [self.navigationController pushViewController:selectCtl animated:YES];

}

// 目的地
- (void)endPointClick{
    SelectEndPointViewController *selectCtl = [[SelectEndPointViewController alloc]init];
    selectCtl.searchType = SearchSkipTypeEndPointPlace;

    [self.navigationController pushViewController:selectCtl animated:YES];
}

// 中转点
- (void)midPointClick:(UIButton *)sender{
    //新增中转点
    if (sender.tag == 0) {
        [_midPlaceArr addObject:@""];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:sender.tag + 1 inSection:0];
        
        NSArray *insertIndexPaths = [NSArray arrayWithObjects:index,nil];
        
        [_releaseTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }else{
    //删除中转点
        [_midPlaceArr removeObjectAtIndex:sender.tag];
        NSIndexPath *index = [NSIndexPath indexPathForRow:sender.tag inSection:0];
        NSArray *indexPaths = [NSArray arrayWithObject:index];
        [_releaseTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
  
}

- (void)midPointPushNext:(UIButton *)btn{
    SelectEndPointViewController *selectCtl = [[SelectEndPointViewController alloc]init];
    selectCtl.searchType = SearchSkipTypeMidPointPlace;
    selectCtl.midIndex = btn.tag;
    [self.navigationController pushViewController:selectCtl animated:YES];
}

// 预览路线
- (void)previewClick{
    [_txtView resignFirstResponder];//释放键盘
    
//    [self resumeView];

    _pathModel.type = [NSString stringWithFormat:@"%d",segmentView.selectedSegmentIndex];
    _pathModel.start_time = [NSString stringWithFormat:@"%@  %@",leftBeginTimeButton.titleLabel.text,rightBeginTimeButton.titleLabel.text];
    _pathModel.start_addr = beginPlaceButton.titleLabel.text;
   
    _pathModel.end_addr = endPointButton.titleLabel.text;
    _pathModel.remark = _txtView.text;
    _pathModel.route_type = @"1";
    _pathModel.user_id =  @"2";
    _pathModel.posMidArr = _midPlaceArr;
    
    MLOG(@"_pathModel%@＝＝%@",_pathModel.start_addr,_midPlaceArr);

    if (_pathModel.start_addr.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"您还没选择出发地点" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alert show];
        
    }else if ([_pathModel.end_addr isEqualToString:@"选择你的目的地"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"您还没选择目的地" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alert show];
    }else{
        
        PreviewPathViewController *preViewCtl = [[PreviewPathViewController alloc]init];
        preViewCtl.pModel = _pathModel;
        
        [self.navigationController pushViewController:preViewCtl animated:YES];
    }
}

- (NSString *)handleDateFormatter:(NSDate *)adate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd=HH点=mm分"];
    NSString *currentDateStr = [dateFormatter stringFromDate:adate];
    return currentDateStr;
    
}

- (void)checkGeocodeSearchOption:(NSString *)address whthBMKGeoCodeSearch:(BMKGeoCodeSearch *)geocodesearch{
    
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= [ManageCenter shareManager].locatCity;
   
    geocodeSearchOption.address = GETBeginDepart;

    BOOL flag = [geocodesearch geoCode:geocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleKeyboard{
    
    NSTimeInterval animationDuration=0.23f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    _releaseTableView.contentSize = CGSizeMake(ScreenWidth, 780 + _midPlaceArr.count * 55);
    _releaseTableView.contentOffset = CGPointMake(0.f, 350 + _midPlaceArr.count * 55);
    
    [UIView commitAnimations];
}

//恢复原始视图位置
- (void)resumeView
{
    NSTimeInterval animationDuration=0.23f;
    [UIView beginAnimations:@"ResizeForKeyboards" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    _releaseTableView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight + 60 + _midPlaceArr.count * 55);
    _releaseTableView.contentOffset = CGPointMake(0.f, 0.f + _midPlaceArr.count * 55);
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_txtView resignFirstResponder];
    [dateSelectionVC dismiss];
}

#pragma mark - BMKGeoCodeSearch
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{

    _pathModel.start_lat = [NSString stringWithFormat:@"%f",result.location.latitude];
    _pathModel.start_lng = [NSString stringWithFormat:@"%f",result.location.longitude];
    
}
#pragma mark - UITextViewDelegate
- (void)handleTextViewChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        
        if ([_describeTips superview]==nil) {
            [_txtView addSubview:_describeTips];
        }
        
        _describeTips.text =  @"请写下你对乘客的期望或者你的拼车宣言！（仅限30字）";
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
        [self handleKeyboard];
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
        
        [self resumeView];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - RMDAteSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    NSLog(@"Successfully selected date: %@", aDate);
  
    NSLog(@"1111date: %@", [self handleDateFormatter:aDate]);
   
    NSString *currLeftTimeStr;
    NSString *currRightTimeStr;
    NSArray *currentTime = [[self handleDateFormatter:aDate] componentsSeparatedByString:@"="];

    if (segmentView.selectedSegmentIndex == 0) {
        currLeftTimeStr = [currentTime objectAtIndex:0];
        currRightTimeStr = [NSString stringWithFormat:@"%@%@",[currentTime objectAtIndex:1],[currentTime objectAtIndex:2]];
        
    }else{
        currLeftTimeStr = [currentTime objectAtIndex:1];
        currRightTimeStr = [currentTime objectAtIndex:2];
    }

    
    [leftBeginTimeButton setTitle:currLeftTimeStr forState:UIControlStateNormal];
    [rightBeginTimeButton setTitle:currRightTimeStr forState:UIControlStateNormal];
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"Date selection was canceled");
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _midPlaceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indexCell = @"cell";
    AddMidPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:indexCell];
    if (nil == cell) {
        cell = [[AddMidPlaceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.midPointButton setTag:indexPath.row];
    [cell.iconButton setTag:indexPath.row];
    
    [cell.iconButton addTarget:self action:@selector(midPointClick:) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row == 0) {
        [cell.iconButton setImage:IMG(@"btn_add_icon") forState:UIControlStateNormal];
    }else{
        [cell.iconButton setImage:IMG(@"passenger_release_bg") forState:UIControlStateNormal];
    }
    
    [cell.midPointButton addTarget:self action:@selector(midPointPushNext:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.midPointButton setTitle:[_midPlaceArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    return cell;
}


@end
