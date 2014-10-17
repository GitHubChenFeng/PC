//
//  SearchResultCell.m
//  PC
//
//  Created by MacBook Pro on 14-9-20.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, 15.f, 25.f, 20.f)];
        [self.contentView addSubview:_iconImg];
        
        _titileL = [[UILabel alloc]initWithFrame:CGRectMake(40.f, 5.f, 280.f, 30)];
        _titileL.textColor = RGB_TextLightDark;
        [self.contentView addSubview:_titileL];
        
        _detailTitleL = [[UILabel alloc]initWithFrame:CGRectMake(40.f, 30.f, 280.f, 25)];
        _detailTitleL.textColor = RGB_TextDarkGray;
        _detailTitleL.font = KSystemFont(14);
        [self.contentView addSubview:_detailTitleL];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
