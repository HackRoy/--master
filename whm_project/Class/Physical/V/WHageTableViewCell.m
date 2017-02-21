//
//  WHageTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/12.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHageTableViewCell.h"

@implementation WHageTableViewCell
-(UILabel *)ageLaber
{
    if (_ageLaber == nil) {
        self.ageLaber = [[UILabel alloc]init];
        self.ageLaber.frame = CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, 30);
        [self.contentView addSubview:_ageLaber];
    }
    return _ageLaber;
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
