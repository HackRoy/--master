//
//  WHcompanyCollectTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/12/5.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHcompanyCollectTableViewCell.h"
#import "MacroUtility.h"

@implementation WHcompanyCollectTableViewCell
-(UIImageView *)myLogo
{
    if (_myLogo == nil) {
        self.myLogo = [[UIImageView alloc]init];
        self.myLogo.frame = CGRectMake(10, 10, 30, 30);
        [self.contentView addSubview:_myLogo];
    }
    return _myLogo;
}

-(UILabel *)myTitlaber
{
    if (_myTitlaber == nil) {
        self.myTitlaber = [[UILabel alloc]init];
        self.myTitlaber.frame = CGRectMake(CGRectGetMaxX(self.myLogo.frame)+10, CGRectGetMinY(self.myLogo.frame), kScreenWitdh * 0.4, CGRectGetHeight(self.myLogo.frame));
        self.myTitlaber.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_myTitlaber];
    }
    return _myTitlaber;
}

-(UILabel *)timeLaber
{
    if (_timeLaber == nil) {
        self.timeLaber = [[UILabel alloc]init];
        self.timeLaber.frame = CGRectMake(kScreenWitdh * 0.7, CGRectGetMinY(self.myTitlaber.frame), kScreenWitdh * 0.25, 20);
        self.timeLaber.textColor = [UIColor grayColor];
        self.timeLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_timeLaber];
    }
    return _timeLaber;
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
