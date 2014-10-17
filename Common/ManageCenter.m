//
//  ManageCenter.m
//  PC
//
//  Created by MacBook Pro on 14-9-2.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "ManageCenter.h"

@implementation ManageCenter

+ (ManageCenter *)shareManager{
    static dispatch_once_t  onceToken;
    static ManageCenter * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[ManageCenter alloc] init];
        
    });
    return sSharedInstance;
}


@end
