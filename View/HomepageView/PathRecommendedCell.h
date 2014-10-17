//
//  PathRecommendedCell.h
//  PC
//
//  Created by MacBook Pro on 14-10-16.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathRecommendedCell : UITableViewCell

@property (nonatomic ,strong) UIImageView *headerImage;
@property (nonatomic ,strong) UILabel *pathTime;
@property (nonatomic ,strong) UILabel *pathType;
@property (nonatomic ,strong) UILabel *pathBegin;
@property (nonatomic ,strong) UILabel *pathEnd;
@property (nonatomic ,strong) UILabel *pathRange;
@end
