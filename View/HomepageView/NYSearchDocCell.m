//
//  NYSearchDocCell.m
//  就医160
//
//  Created by MacBook Pro on 14-7-21.
//  Copyright (c) 2014年 meng. All rights reserved.
//

#import "NYSearchDocCell.h"

@implementation NYSearchDocCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 0.f, ScreenWidth - 10.f, 1.f)];
        _line.backgroundColor = RGB_TextLineLightGray;
        [self addSubview:_line];
        
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 16, 38, 48)];
        _avatar.tag = 'i';
        [self addSubview:_avatar];
        
        _d_name = [[UILabel alloc] initWithFrame:CGRectMake(65, 16, 200, 20)];
        _d_name.textColor = RGB(41, 183, 237);
        _d_name.tag = 'd';
        
        [self addSubview:_d_name];
        
        _k_name = [[UILabel alloc] initWithFrame:CGRectMake(65, 35, 225, 20)];
        //k_name.textColor = [UIColor lightGrayColor];
        _k_name.font = [UIFont fontWithName:@"Arial" size:12];
        _k_name.tag = 'k';
        [self addSubview:_k_name];
        
        _h_name = [[UILabel alloc] initWithFrame:CGRectMake(125, 17, 75, 20)];
        _h_name.textColor = [UIColor lightGrayColor];
        _h_name.tag = 'h';
        _h_name.font = [UIFont fontWithName:@"Arial" size:12];
        [self addSubview:_h_name];
        
        _expert = [[UILabel alloc] initWithFrame:CGRectMake(65, 50, 235, 20)];
        _expert.textColor = [UIColor lightGrayColor];
        _expert.tag = 's';
        _expert.lineBreakMode = NSLineBreakByTruncatingTail;
        _expert.font = [UIFont fontWithName:@"Arial" size:12];
        [self addSubview:_expert];
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
