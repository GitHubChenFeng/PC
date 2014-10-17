//
//  ReleasePahtModel.h
//  PC
//
//  Created by MacBook Pro on 14-9-21.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReleasePahtModel : NSObject

@property (nonatomic ,strong) NSString *type;
@property (nonatomic ,strong) NSString *start_time;
@property (nonatomic ,strong) NSString *start_addr;
@property (nonatomic ,strong) NSString *start_lng;
@property (nonatomic ,strong) NSString *start_lat;
@property (nonatomic ,strong) NSString *end_addr;
@property (nonatomic ,strong) NSString *end_lng;
@property (nonatomic ,strong) NSString *end_lat;
@property (nonatomic ,strong) NSString *remark;
@property (nonatomic ,strong) NSString *route_type;
@property (nonatomic ,strong) NSString *user_id;
@property (nonatomic ,strong) NSArray *posMidArr;

@end
