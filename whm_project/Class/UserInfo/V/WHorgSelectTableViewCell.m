//
//  WHorgSelectTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/12/15.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHorgSelectTableViewCell.h"

@implementation WHorgSelectTableViewCell

-(UILabel *)myTitLaber
{
    if (_myTitLaber == nil) {
        self.myTitLaber = [[UILabel alloc]init];
        self.myTitLaber.frame = CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 46);
        self.myTitLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_myTitLaber];
    }
    return _myTitLaber;
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
