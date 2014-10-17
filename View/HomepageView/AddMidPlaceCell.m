//
//  AddMidPlaceCell.m
//  PC
//
//  Created by MacBook Pro on 14-9-18.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "AddMidPlaceCell.h"

#define kLeftMargin 15.f

@implementation AddMidPlaceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _midPointButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_midPointButton setFrame:CGRectMake(15.f, 5, ScreenWidth - 2*kLeftMargin, 44.f)];
        _midPointButton.layer.borderWidth = 1;
        _midPointButton.layer.borderColor = RGB_TextLineLightGray.CGColor;
        
        _midPointButton.contentEdgeInsets = UIEdgeInsetsMake(0.f, 48.f, 0.f, 0.);
        _midPointButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_midPointButton setTitleColor:RGB_TextDarkGray forState:UIControlStateNormal];
        [self.contentView addSubview:_midPointButton];
        
        UIImageView *MidIconRight = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 2*kLeftMargin - 35, 5.f, 35.f, 35.f)];
        [MidIconRight setImage:IMG(@"btn_right_arrow")];
        [_midPointButton addSubview:MidIconRight];
        
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconButton setFrame:CGRectMake(3.f, 5.f, 40.f, 35.f)];
        [_midPointButton addSubview:_iconButton];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(40.f, 5.f, 1, 33.f)];
        line.backgroundColor = RGB_TextLineLightGray;
        [_midPointButton addSubview:line];
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
