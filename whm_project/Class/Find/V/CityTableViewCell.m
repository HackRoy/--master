//
//  CityTableViewCell.m
//  NavigationMap
//
//  Created by 李帅 on 16/11/23.
//  Copyright © 2016年 李帅. All rights reserved.
//

#import "CityTableViewCell.h"

@implementation CityTableViewCell



-(UILabel *)titLab
{
    if (_titLab == nil)
    {
        self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 41)];
        self.titLab.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titLab];
    }
    return _titLab;
}









- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
