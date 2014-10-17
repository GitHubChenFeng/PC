//
//  PathDetailCell.m
//  PC
//
//  Created by MacBook Pro on 14-10-9.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "PathDetailCell.h"

@implementation PathDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 5.f, 80.f, 30.f)];
        _titleLabel.textColor = RGB_TextDarkGray;
        [self.contentView addSubview:_titleLabel];
        
        _titleDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(100.f, 5.f, 200.f, 30.f)];
        _titleDetailLabel.textColor = RGB_TextDarkGray;
        [self.contentView addSubview:_titleDetailLabel];
        
        _mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mapButton setFrame:CGRectMake(ScreenWidth - 45.f, 10.f, 25.f, 25.f)];
        [self.contentView addSubview:_mapButton];
        
//        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10.f, self.contentView.frame.size.height - 1, ScreenWidth, 1)];
//        line.backgroundColor = RGB_TextLineLightGray;
//        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
