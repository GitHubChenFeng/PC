//
//  UIViewController+CustomTracker.h
//  PopWallPapers
//
//  Created by sugar chen on 12-10-6.
//  Copyright (c) 2012年 NULL. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomStyleTrackerProtcol <NSObject>

- (void)setTitle:(NSString *)title;
- (UIButton *)createTitleButtonWithImage:(UIImage *)img selectedImage:(UIImage *)selImage selector:(SEL)sel;
- (void)ActionBack:(UIButton *)sender;
- (void)didReceiveMemoryWarning ;
- (void)buildCustomUI;
- (void)setRightBtn:(NSString *)titleStr actionDone:(SEL)selectAction;
@end

@interface UIViewController (CustomTracker)<CustomStyleTrackerProtcol>
//@property (nonatomic) int currentPage;
@end