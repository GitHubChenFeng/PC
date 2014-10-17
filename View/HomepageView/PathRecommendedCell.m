//
//  PathRecommendedCell.m
//  PC
//
//  Created by MacBook Pro on 14-10-16.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "PathRecommendedCell.h"

@implementation PathRecommendedCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, 20.f, 60.f, 60.f)];
        _headerImage.backgroundColor = [UIColor redColor];
        _headerImage.layer.cornerRadius = 30;
        _headerImage.clipsToBounds = YES;
        [self.contentView addSubview:_headerImage];
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(80.f, 12.f, 20.f, 20.f)];
        icon.image = IMG(@"path_icon");
        [self.contentView addSubview:icon];
        
        _pathTime = [[UILabel alloc]initWithFrame:CGRectMake(110.f, 10.f, 80.f, 25.f)];
        _pathTime.text = @"上午8：40";
        _pathTime.textColor = RGB_TextDarkGray;
        _pathTime.font = KSystemFont(15);
        [self.contentView addSubview:_pathTime];
        
        _pathRange = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 50.f, 10.f, 80.f, 25.f)];
        _pathRange.text = @"12km";
        _pathRange.textColor = RGB_TextDarkGray;
        _pathRange.font = KSystemFont(12);
        [self.contentView addSubview:_pathRange];
        
        _pathType = [[UILabel alloc]initWithFrame:CGRectMake(190.f, 10.f, 40.f, 20.f)];
        _pathType.text = @"上班";
        _pathType.font = KSystemFont(15);
        _pathType.textAlignment = NSTextAlignmentCenter;
        _pathType.textColor = [UIColor whiteColor];
        _pathType.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_pathType];
        
        UIImageView *beginIcon = [[UIImageView alloc]initWithFrame:CGRectMake(80.f, 45.f, 20.f, 45.f)];
        beginIcon.image = IMG(@"begin_end_path");
        [self.contentView addSubview:beginIcon];
        
        _pathBegin = [[UILabel alloc]initWithFrame:CGRectMake(110.f, 40.f, 250.f, 25.f)];
        _pathBegin.text = @"出发地:白石龙地铁站";
        _pathBegin.font = KSystemFont(15);
        _pathBegin.textColor = RGB_TextDarkGray;
        [self.contentView addSubview:_pathBegin];
        
        _pathEnd = [[UILabel alloc]initWithFrame:CGRectMake(110.f, 70.f, 250.f, 25.f)];
        _pathEnd.text = @"目的地:创维大厦";
        _pathEnd.textColor = RGB_TextDarkGray;
        _pathEnd.font = KSystemFont(15);
        [self.contentView addSubview:_pathEnd];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
