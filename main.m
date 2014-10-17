//
//  main.m
//  PC
//
//  Created by MacBook Pro on 14-8-31.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CFAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([CFAppDelegate class]));
        }
        @catch (NSException *exception) {
            NSLog(@"%@\n%@",[exception reason],[exception callStackSymbols]);
        }
        @finally {
            
        }
        
    }
}
