//
//  GlobalDefine.h
//  CustomNavigationBarDemo
//
//  Created by jimple on 14-1-6.
//  Copyright (c) 2014年 Jimple Chen. All rights reserved.
//

#ifndef CustomNavigationBarDemo_GlobalDefine_h
#define CustomNavigationBarDemo_GlobalDefine_h
//=========================== 请求 URL =================================================
#define sendRouteHttpUrl compUrl(@"?mod=map&act=sendRoute")          //发布路线

#define findDriverHttpUrl compUrl(@"?mod=map&act=findDriver")        //乘客找司机接口

#define findPassengerHttpUrl compUrl(@"?mod=map&act=findPassenger")  //司机找乘客接口

#define userMapShowHttpUrl compUrl(@"?mod=map&act=userMapShow")      //首页获取司机乘客信息

#define userRegisterHttpUrl compUrl(@"?mod=user&act=sendMessage")    //乘客注册流程

// ========================== NSUserDefaults ==========================================
//司机设置出发点
#define SETBeginDepart(Obj) [[NSUserDefaults standardUserDefaults] setObject:Obj forKey:@"SETBeginDepart"]
#define GETBeginDepart [[NSUserDefaults standardUserDefaults] objectForKey:@"SETBeginDepart"]

//司机设置目的地
#define SETDestination(Obj) [[NSUserDefaults standardUserDefaults] setObject:Obj forKey:@"SETDestination"]
#define GETDestination [[NSUserDefaults standardUserDefaults] objectForKey:@"SETDestination"]

//司机设置中转点
#define SETMidPlaceOne(Obj) [[NSUserDefaults standardUserDefaults] setObject:Obj forKey:@"SETMidPlaceOne"]
#define GETMidPlaceOne [[NSUserDefaults standardUserDefaults] objectForKey:@"SETMidPlaceOne"]

#define SETMidPlaceTwo(Obj) [[NSUserDefaults standardUserDefaults] setObject:Obj forKey:@"SETMidPlaceTwo"]
#define GETMidPlaceTwo [[NSUserDefaults standardUserDefaults] objectForKey:@"SETMidPlaceTwo"]

#define SETMidPlaceThere(Obj) [[NSUserDefaults standardUserDefaults] setObject:Obj forKey:@"SETMidPlaceThere"]
#define GETMidPlaceThere [[NSUserDefaults standardUserDefaults] objectForKey:@"SETMidPlaceThere"]


// =========================== 缓存KEY  ================================================

#define kSearchPlace @"kSearchPlace"

#endif
