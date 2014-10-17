//
//  CFViewController.m
//  PC
//
//  Created by MacBook Pro on 14-8-31.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "CFViewController.h"
//#import "MapAnnotation.h"
#import "WGS84TOGCJ02.h"
#import "UIImage+Blur.h"
#import "UIImage+Screenshot.h"
#import "UINavigationBar+setBgImage.h"
#import "CustomNavigationController.h"

@interface CFViewController ()
{
    UIButton *_driverRelease;
    UIButton *_passengerRelease;
}
@end

@implementation CFViewController
@synthesize selectIndex;
@synthesize annotationForRemove;


#define kLeftMargin 15.f
#define kLocationButtonWH 35.f

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"同城拼车";
    selectIndex = 0;

    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.zoomLevel = 15;
    [self.view addSubview:_mapView];
    
    [self addMainShowInMapView];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    NSLog(@"%@", _locService.userLocation.location);
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
//    if ([CLLocationManager locationServicesEnabled]) {
//        //获取经纬度
//        if (!_latAndLon) {
//            _latAndLon = [[GetLatitudeAndLongitude alloc] init];
//            _latAndLon.delegate = self;
//        }
//        [_latAndLon starGetCurlocation];
//    }

    [self createData];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    
    _nearPointArry = [[NSMutableArray alloc]initWithCapacity:0];
    
    
}

- (void)createData{
    
    _driverArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"南头",@"begin",@"科技园",@"end",@"22.568608",@"latitude",@"113.928660",@"longitude", nil];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"桃园地铁站",@"begin",@"平洲地铁站",@"end",@"22.548658",@"latitude",@"113.935660",@"longitude", nil];
    
    [_driverArray addObject:dic1];
    [_driverArray addObject:dic2];
    
    [self showAnnotaions];
}

- (void)showAnnotaions{
    for (int i = 0; i < [self.driverArray count]; i++) {
        NSDictionary *dic = [self.driverArray objectAtIndex:i];
        NSString *title = [dic objectForKey:@"begin"];
        double lon = 0.0;
        double lat = 0.0;
        if ([dic objectForKey:@"latitude"] != nil) {
            lon = [[dic objectForKey:@"longitude"] doubleValue];
            lat = [[dic objectForKey:@"latitude"] doubleValue];
        }
        
        CLLocationCoordinate2D coordate = {lat,lon};

        
        CurrentLocationAnnotation *annotation = [[CurrentLocationAnnotation alloc] initWithCoordinate:coordate andTitle:title andSubtitle:@"My subtitle" andImage:[dic objectForKey:@"manager_portrait"]];
        annotation.index = i;
        annotation.imgaeUrl = [dic objectForKey:@"manager_portrait"];
        
        BMKAnnotationView *annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationPin"];

        
        //添加司机位置标注
        [_mapView addAnnotation:annotation];
        
    }
}


// 地图上的UI
- (void)addMainShowInMapView{
    
    UIImageView *searchIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 48.f, 40.f)];
    searchIcon.image = IMG(@"search_icon");
    // 搜索框
    _searchFeild = [[UITextField alloc]initWithFrame:CGRectMake(kLeftMargin, 40.f, ScreenWidth - 2*kLeftMargin, 44.f)];
    _searchFeild.placeholder = @"搜索";
    _searchFeild.backgroundColor = [UIColor whiteColor];
    _searchFeild.alpha = 0.8;
    _searchFeild.delegate = self;
    _searchFeild.leftView = searchIcon;
    _searchFeild.leftViewMode = UITextFieldViewModeAlways;
    _searchFeild.layer.borderWidth = 0.5;
    _searchFeild.layer.borderColor = RGB_TextLightGray.CGColor;
    
    [self.view addSubview:_searchFeild];
    
    // 司机和乘客切换
    _transitionDirverButton = [[CheckDriverOrPassengerView alloc]initWithFrame:Rect(ScreenWidth - 100.f, ViewY(_searchFeild) + 70.f, 80.f, 55.f) whitIcon:nil whitTitle:@"" delegate:self];//IMG(@"member_icon")
    [_transitionDirverButton setImage:IMG(@"check_dirver") forState:UIControlStateNormal];
    
    _transitionPassengerButton = [[CheckDriverOrPassengerView alloc]initWithFrame:Rect(ScreenWidth - 100.f, ViewY(_searchFeild) + 70.f, 80.f, 55.f) whitIcon:nil whitTitle:@"" delegate:self];
    //IMG(@"member_icon")
    
    [_transitionPassengerButton setImage:IMG(@"check_passenger") forState:UIControlStateNormal];
    
    _coinView = [[CMSCoinView alloc]initWithPrimaryView:_transitionDirverButton andSecondaryView:_transitionPassengerButton inFrame:Rect(ScreenWidth - 98.f, ViewY(_searchFeild) + 70.f, 80.f, 55.f)];
    _coinView.delegate = self;
    [_coinView setSpinTime:0.8];
    
    [self.view addSubview:_coinView];
    
    // 定位
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setFrame:CGRectMake(kLeftMargin,  ScreenHeight - 120.f, kLocationButtonWH, kLocationButtonWH)];
    [locationButton setImage:IMG(@"again_location") forState:UIControlStateNormal];
    locationButton.contentEdgeInsets = UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f);
    locationButton.backgroundColor = [UIColor whiteColor];
    locationButton.alpha = 0.85;
    [locationButton addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationButton];
    
    // 下bar菜单
    NSArray *arr = [NSArray arrayWithObjects:@"发布路线",@"消息",@"我的", nil];
    NSArray *iconArr = [NSArray arrayWithObjects:@"release_path.png",@"my_message.png",@"member_icon.png", nil];
    _bottomView = [[HomePageBottomView alloc]initWithFrame:CGRectMake(kLeftMargin, ScreenHeight - 65.f, 290.f, 40.f) buttonTitleArr:arr whitIcon:iconArr delegate:self];
    
    
    [self.view addSubview:_bottomView];
}

- (void)locationClick{
    
    
}


// 底部选项卡
- (void)bottomBarSelectClick:(UIButton *)btn{
    NSLog(@"%d",btn.tag);
    switch (btn.tag) {
        case 0://发布路线
        {
            [self releaseRoute];
        }
            break;
        case 1://消息
        {
            LoginViewController *messageView = [[LoginViewController alloc]init];
            
            CustomNavigationController *navBar = [[CustomNavigationController alloc]initWithRootViewController:messageView];
            if ([navBar.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
                [navBar.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_Narbar"] forBarMetrics:UIBarMetricsDefault];
                [navBar.navigationBar setBackgroundColor:RGB_MainAppColor];
            }
            [self presentViewController:navBar animated:YES completion:nil];
            
            
        }
            break;
        case 2://我的
        {
            MyInfoViewController *myView = [[MyInfoViewController alloc]init];
            
            CustomNavigationController *navBar = [[CustomNavigationController alloc]initWithRootViewController:myView];
            if ([navBar.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
                [navBar.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_Narbar"] forBarMetrics:UIBarMetricsDefault];
                [navBar.navigationBar setBackgroundColor:RGB_MainAppColor];
            }
            [self presentViewController:navBar animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

/**
 *  发布路线浮层
 */
- (void)releaseRoute{

    if (_releasePathBgView == nil) {
        _releasePathBgView = [[UIImageView alloc]initWithFrame:ScreenRect];
        
        _releasePathBgView.userInteractionEnabled = YES;
        
        int index = [[SharedApplication keyWindow].subviews count];
        
        [[SharedApplication keyWindow] insertSubview:_releasePathBgView atIndex:index];
        
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_releasePathBgView addGestureRecognizer:gesture];
        
        UIImage *screenshot = [UIImage screenshot];
        NSData *imageData = UIImageJPEGRepresentation(screenshot, .01);
        UIImage *blurredSnapshot = [[UIImage imageWithData:imageData] blurredImage:0.4];
        
        _releasePathBgView.image = blurredSnapshot;
        _releasePathBgView.hidden = YES;
        //    _releasePathBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }

    
    [UIView animateWithDuration:0.3 animations:^{
        _releasePathBgView.hidden = NO;
        _releasePathBgView.alpha = 1;
        
    } completion:^(BOOL finished) {
        _driverRelease = [UIButton buttonWithType:UIButtonTypeCustom];
        [_driverRelease setFrame:CGRectMake(30, 200, 120, 100)];
        [_driverRelease setReleaseRoutePath:IMG(@"dirver_release_header") whitTitle:@"我是车主" withDetail:@"有空位的爷～"];
        [_driverRelease setBackgroundImage:[UIImage imageNamed:@"dirver_release_bg"] forState:UIControlStateNormal];
        [_driverRelease addTarget:self action:@selector(driverRouteClick) forControlEvents:UIControlEventTouchUpInside];
        [_releasePathBgView addSubview:_driverRelease];
        
        _passengerRelease = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passengerRelease setFrame:CGRectMake(180, 200, 120, 100)];
        [_passengerRelease setReleaseRoutePath:IMG(@"passenger_release_header") whitTitle:@"我是乘客" withDetail:@"翻天滚地求座位··"];
        [_passengerRelease setBackgroundImage:[UIImage imageNamed:@"passenger_release_bg"] forState:UIControlStateNormal];
        [_passengerRelease addTarget:self action:@selector(passengerRouteClick) forControlEvents:UIControlEventTouchUpInside];
        [_releasePathBgView addSubview:_passengerRelease];
        
        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        scaleAnimation.duration = 0.5;
        scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
        scaleAnimation.calculationMode = kCAAnimationLinear;
        scaleAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:1.0f]];
        _driverRelease.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
        [_driverRelease.layer addAnimation:scaleAnimation forKey:@"buttonAppear"];
        
        CAKeyframeAnimation *scaleAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        scaleAnimation2.duration = 0.5;
        scaleAnimation2.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
        scaleAnimation2.calculationMode = kCAAnimationLinear;
        scaleAnimation2.keyTimes = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:1.0f]];
        _passengerRelease.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
        [_passengerRelease.layer addAnimation:scaleAnimation2 forKey:@"buttonAppear2"];
        
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.5 animations:^{
        _releasePathBgView.alpha = 0;
       
    } completion:^(BOOL finished) {
        if (finished) {
            
             _releasePathBgView.hidden = YES;
            [_driverRelease removeFromSuperview];
            [_passengerRelease removeFromSuperview];
        }
    }];
}

// 发布车主路线
- (void)driverRouteClick{
    [self hide];
    
    CFReleaseDirverRouteController *releaseDirver = [[CFReleaseDirverRouteController alloc]init];
    releaseDirver.nearPointArr = _nearPointArry;
    CustomNavigationController *MsgNavBar = [[CustomNavigationController alloc]initWithRootViewController:releaseDirver];
    if ([MsgNavBar.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        [MsgNavBar.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_Narbar"] forBarMetrics:UIBarMetricsDefault];
        [MsgNavBar.navigationBar setBackgroundColor:RGB_MainAppColor];
    }
    [self presentViewController:MsgNavBar animated:YES completion:nil];
    
}

// 发布乘客路线
- (void)passengerRouteClick{
    [self hide];
    
    ReleasePassengerViewController *releasePassenger = [[ReleasePassengerViewController alloc]init];
    
    CustomNavigationController *MsgNavBar = [[CustomNavigationController alloc]initWithRootViewController:releasePassenger];
    
    if ([MsgNavBar.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        [MsgNavBar.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_Narbar"] forBarMetrics:UIBarMetricsDefault];
        [MsgNavBar.navigationBar setBackgroundColor:RGB_MainAppColor];
    }

    [self presentViewController:MsgNavBar animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated {
   
    _mapView.delegate = self;
    _locService.delegate = self;
    [_mapView viewWillAppear];
    
    SETDestination(@"");
    SETMidPlaceOne(@"");
    SETMidPlaceTwo(@"");
    SETMidPlaceThere(@"");
    
}


-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CMSCoinViewDelegate
- (void)clickCoinViewHandle:(UIView *)view{
    NSLog(@"clickCoinViewHandle==%ld",(long)view.tag);
}

#pragma mark - CLLocationManager
- (void)getCityInfo:(NSDictionary*)aDiCityInfo
{
    //设置定位城市
    NSString *localCity = [aDiCityInfo objectForKey:@"City"];
    [[ManageCenter shareManager] setLocatCity:localCity];
    
    NSLog(@"定位城市1=%@",localCity);
    
}

- (void)getLatAndLon:(CLLocationCoordinate2D)aLatAndLon{
    
    [[ManageCenter shareManager]setKlongtitude:aLatAndLon.longitude];

    [[ManageCenter shareManager] setKlatitude:aLatAndLon.latitude];
    
    NSLog(@"aLatAndLon.longitude=%f,aLatAndLon.latitude=%f",aLatAndLon.longitude,aLatAndLon.latitude);
   
    
    CLLocationCoordinate2D cll ;
   
    //判断是不是属于国内范围
    if (![WGS84TOGCJ02 isLocationOutOfChina:aLatAndLon]) {
        //转换后的coord
        cll = [WGS84TOGCJ02 transformFromWGSToGCJ:aLatAndLon];
    }
    
    NSLog(@"%f", cll.latitude);
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
	annotation.coordinate = cll ;
	
//    MapAnnotation *annotation = [[MapAnnotation alloc] initWithLatitude:cll.latitude andLongitude:cll.longitude andTitle:[ManageCenter shareManager].locatCity];
    
	[_mapView addAnnotation:annotation];

    BMKCoordinateRegion region = BMKCoordinateRegionMake(cll, BMKCoordinateSpanMake(0.05, 0.05));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
    
    
    [_mapView setRegion:adjustedRegion animated:YES];
   
   
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [_searchFeild resignFirstResponder];
    
    NYSearchDoctorViewController *searchView = [[NYSearchDoctorViewController alloc] init];

    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:searchView];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    [self presentViewController:nav animated:NO completion:nil];

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
     [_searchFeild resignFirstResponder];
}

#pragma mark - CustomNaviBarSearchControllerDelegate
- (void)naviBarSearchCtrl:(CustomNaviBarSearchController *)ctrl searchKeyword:(NSString *)strKeyword
{
    [_ctrlSearchBar removeSearchCtrl];
//    if (strKeyword && strKeyword.length > 0)
//    {
//        _labelKeyword.text = strKeyword;
//    }
//    else
//    {
//        _labelKeyword.text = @"";
//    }
}

- (void)naviBarSearchCtrlCancel:(CustomNaviBarSearchController *)ctrl
{
    [_ctrlSearchBar removeSearchCtrl];
//    _labelKeyword.text = @"";
}

#pragma mark - PopoverViewDelegate Methods
// 点击头像弹窗的代理
- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    
    [popoverView showImage:[UIImage imageNamed:@"success"] withMessage:@"ok"];
    
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
}

- (void)popoverViewDidDismiss:(PopoverView *)popoverView {
    [self.annotationForRemove setSelected:NO];
}

#pragma mark - BMKMapViewDelegate

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    
    [[ManageCenter shareManager]setKlongtitude:userLocation.location.coordinate.longitude];
    
    [[ManageCenter shareManager] setKlatitude:userLocation.location.coordinate.latitude];

    if (userLocation.location.coordinate.latitude > 0) {
        [_locService stopUserLocationService];
        
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        MLOG(@"longitude===%f",pt.longitude);
        
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
    }
    
}


//开始定位
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView{
    
    NSLog(@"开始定位");
    
}

//更新坐标

-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    
    NSLog(@"更新坐标");
    
    //    [mapView setShowsUserLocation:NO];
    

    
    //加个当前坐标的小气泡
//    [_search reverseGeocode:userLocation.location.coordinate];
    _mapView.showsUserLocation = YES;
    
}

//定位失败

-(void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    NSLog(@"定位错误%@",error);
    
    [mapView setShowsUserLocation:NO];
    
}

//定位停止

-(void)mapViewDidStopLocatingUser:(BMKMapView *)mapView{
    
    NSLog(@"定位停止");
}

#pragma mark-
#pragma mark 区域改变

/**
 *地图区域即将改变时会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"地图区域即将改变");
}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"地图区域改变完成");
}

#pragma mark-
#pragma mark 标注

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    NSLog(@"生成标注");
    if ([annotation isKindOfClass:[CurrentLocationAnnotation class]]) {
        
        BMKAnnotationView *annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationPin"];
        annotationView.canShowCallout               = NO;
        annotationView.clipsToBounds                = YES;
        annotationView.layer.cornerRadius           = 29;
        annotationView.userInteractionEnabled       = YES;
        annotationView.frame=CGRectMake(0, 0, 60, 60);
        
        CurrentLocationAnnotation *currannotation   = annotation;
        
        bgView=[[UIImageView alloc]initWithFrame:CGRectZero];
        bgView.backgroundColor          = [UIColor clearColor];
        bgView.center                   = annotationView.center;
        bgView.layer.cornerRadius       = 29;
        bgView.clipsToBounds            = YES;
        bgView.userInteractionEnabled   = YES;
        
        NSString *picUrl= currannotation.imgaeUrl;
        
        NSLog(@"imgaeUrl===%@------%@",picUrl,currannotation.title);
        // 合成分店头像
        UIImage *headImg = [self compoundImage:bgView andUrl:picUrl];
        bgView.layer.cornerRadius       = 16;
        bgView.frame = CGRectMake(14.5, 14.5, 31, 31);
        
        
        // 设置分店头像
        if (currannotation.imgaeUrl.length!=0) {
            // 解决第一次显示头像问题
            [annotationView addSubview:bgView];
            annotationView.image = headImg;
  
        }else{
            annotationView.image = IMG(@"manager_default_home.png");
            
        }
        selectIndex = currannotation.index;
        
//        if (_spaceCoordinate.latitude == currannotation.coordinate.latitude && _spaceCoordinate.longitude == currannotation.coordinate.longitude) {
//            selectIndex = currannotation.index;
//            if (firstPop == NO) {
//                firstPop = YES;
//                targetCoordate = currannotation.coordinate;
//                self.annotationForRemove = annotationView;
//            }
//        }
        
        return annotationView;
        
    }else if ([annotation isKindOfClass:[MapAnnotation class]]){//自己的位置标注
        NSString *identifier=@"mapID";
        
//        annotiView=(MapAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//        if (nil==annotiView) {
//            annotiView=[[[MapAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier]autorelease];
//        }
//        
//        
//        return annotiView;
        
    }else {
        return nil;
    }
    return nil;
}

/**
 *当mapView新添加annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 新添加的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
//    LogRed(@"添加多个标注");
}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{

    if (!view.canShowCallout && [view.annotation isKindOfClass:[CurrentLocationAnnotation class]]) {
        
        if ([view.annotation isKindOfClass:[CurrentLocationAnnotation class]]) {
            self.annotationForRemove        = view;
            CurrentLocationAnnotation *atn  = (CurrentLocationAnnotation*)(view.annotation);
            NSLog(@"currentLocation.index%d:",atn.index);
            selectIndex                     = atn.index;
//            targetCoordate                  = view.annotation.coordinate;
            
//            NSLog(@"targetCoordate=%f-%f",targetCoordate.latitude,targetCoordate.longitude);
        }
       
       
        [self annotationViewBMK:view];
        
        
    }else {
        //显示自己的位置地址
//        MapAnnotation *atn  = (MapAnnotation*)(view.annotation);
//        atn.title = self.addr;
        
    }

}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 取消选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    LogRed(@"取消选中标注");
}

#pragma mark  - 地理编码和反地理编码

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        NSArray *poiArr = result.poiList;//地址周边POI信息
    
        NSLog(@"==%@=",result.address);
        
        [ManageCenter shareManager].city = result.address;
        
        SETBeginDepart([result.address substringFromIndex:6]);
        
        for (int i =0; i< poiArr.count; i++) {
            BMKPoiInfo *poiInfo = [poiArr objectAtIndex:i];
            MLOG(@"%@--%@",poiInfo.city,poiInfo.address);
            
            [ManageCenter shareManager].locatCity = poiInfo.city;
            
            [_nearPointArry addObject:[poiInfo.address substringFromIndex:6]];
        }
	}
}


#pragma mark - fun
-(void)cleanMap
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    
//    for (MapPointAnnotion* ann in array) {
//        [_mapView removeAnnotation:ann];
//    }
}

#pragma mark - private
// 合成视图和图片方法
- (UIImage *)compoundImage:(UIImageView *)view andUrl:(NSString *)picUrl{
    
//    [view setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"portrait_member.png"]];
    
    view.frame = CGRectMake(30, 30, 60, 60);
    // UIImageView转换为UIImage
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, view.layer.contentsScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imgView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *defaultHead= IMG(@"manager_default_home.png");
    
    
    CGRect rect1=CGRectMake(0, 0, 120, 120);
    CGRect rect2=CGRectMake(30, 30, 60, 60);
    
    // 两张图片合成头像
    CGSize size = CGSizeMake(rect1.size.width, rect1.size.height);
    UIGraphicsBeginImageContext(size);
    [defaultHead drawInRect:rect1];
    [imgView drawInRect:rect2];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
// 选中头像弹窗视图
- (void)annotationViewBMK:(BMKAnnotationView *)view
{
    //将地图的经纬度坐标转换成所在视图的坐标
    CGPoint viewpoint1 = [_mapView convertCoordinate:view.annotation.coordinate toPointToView:self.view];
    
    CGPoint poppoint = CGPointMake(0.f, 0.f);
    
    if ([UIScreen mainScreen].applicationFrame.size.height > 500) {
        poppoint = CGPointMake(viewpoint1.x, viewpoint1.y);
    } else {
        poppoint = CGPointMake(viewpoint1.x, viewpoint1.y);
    }
    
    CGFloat totalHeight = 80.f;
    CGFloat totalwidth = 160.f;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, totalwidth, totalHeight)];
    containerView.backgroundColor = RGB_MainAppColor;
  
    if ([self.driverArray count]!=0) {
        NSLog(@"count=%d=count=%d",[self.driverArray count],selectIndex);
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15.f, 15.f, 24.f, 56.f)];
        iconImg.image = IMG(@"popueIcon_bg");
        [containerView addSubview:iconImg];
        
        NSDictionary *ay = [self.driverArray objectAtIndex:selectIndex];
       
        UILabel *shopname = [[UILabel alloc] initWithFrame:CGRectMake(60.f, 10.f, totalwidth-75.f, 30.f)];
        shopname.font = [UIFont systemFontOfSize:14.f];
        shopname.numberOfLines=0;
        shopname.lineBreakMode=NSLineBreakByWordWrapping;
        shopname.backgroundColor = [UIColor clearColor];
        
        if (selectIndex < 1000) {
            shopname.text = [ay objectForKey:@"begin"];
        }
        shopname.textColor = [UIColor whiteColor];
        [containerView addSubview:shopname];
      
        
        UILabel *managername = [[UILabel alloc] initWithFrame:CGRectMake(60.f, 45.f, totalwidth-40.f, 30.f)];
        managername.font = [UIFont systemFontOfSize:14.f];
        managername.backgroundColor = [UIColor clearColor];
        
        if (selectIndex < 1000) {
            managername.text = [ay objectForKey:@"end"];
        }
        managername.textColor = [UIColor whiteColor];
        [containerView addSubview:managername];
       
    }
    
    containerView.frame = CGRectMake(containerView.frame.origin.x, containerView.frame.origin.y, containerView.frame.size.width, totalHeight+10.f);
    
    if (selectIndex >= 0) {
        self.popverView = [PopoverView showPopoverAtPoint:poppoint inView:self.view withTitle:nil withContentView:containerView delegate:self];
//        self.popverView.isSetBuleColor = YES;
        
    }
  
}

@end
