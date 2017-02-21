//
//  WHmyfollowListTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/12/2.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmyfollowListTableViewCell.h"

#import "MacroUtility.h"
@implementation WHmyfollowListTableViewCell

-(UIImageView * )myImg
{
    if (_myImg == nil) {
        self.myImg = [[UIImageView alloc]init];
        self.myImg.frame = CGRectMake(10, 10,  kScreenWitdh * 0.15,kScreenWitdh * 0.15);
        self.myImg.layer.masksToBounds = YES;
        self.myImg.layer.cornerRadius = kScreenWitdh * 0.075;
        [self.contentView addSubview:_myImg];

    }
    return _myImg;
}

-(UILabel *)nameLaber
{
    if (_nameLaber == nil) {
        self.nameLaber = [[UILabel alloc]init];
        self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.myImg.frame)+3, CGRectGetMinY(self.myImg.frame), kScreenWitdh * 0.15, 30);
        self.nameLaber.textColor = [UIColor grayColor];
        self.nameLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_nameLaber];
    }
    return _nameLaber;
}

-(UIImageView *)sexImg
{
    if (_sexImg == nil) {
        self.sexImg = [[UIImageView alloc]init];
        self.sexImg.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+2, CGRectGetMinY(self.nameLaber.frame)+6, 20, 20);
        [self.contentView addSubview:_sexImg];
    }
    return _sexImg;
}

-(UILabel *)ageLaber
{
    if (_ageLaber == nil) {
        self.ageLaber = [[UILabel alloc]init];
        self.ageLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImg.frame)+3, CGRectGetMinY(self.sexImg.frame), kScreenWitdh * 0.15, 20);
        self.ageLaber.textColor = [UIColor grayColor];
        self.ageLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_ageLaber];
    }
    return _ageLaber;
}

-(UILabel *)myLaber
{
    if (_myLaber == nil) {
        self.myLaber = [[UILabel alloc]init];
        self.myLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame)+5, kScreenWitdh * 0.5, 20);
        self.myLaber.textColor = [UIColor grayColor];
        self.myLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView  addSubview:_myLaber];
    }
    return _myLaber;
}

-(UIButton *)mesBut
{
    if (_mesBut == nil) {
        self.mesBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.mesBut.frame = CGRectMake(kScreenWitdh * 0.7, 10, kScreenWitdh * 0.1, kScreenWitdh * 0.1);
       
        [self.contentView addSubview:_mesBut];

    }
    return _mesBut;
}

-(UIButton *)telBut
{
    if (_telBut == nil) {
        self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.telBut.frame = CGRectMake(CGRectGetMaxX(self.mesBut.frame)+5, CGRectGetMinY(self.mesBut.frame), kScreenWitdh * 0.1, CGRectGetHeight(self.mesBut.frame));
        [self.contentView addSubview:_telBut];
    }
    return _telBut;
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
