//
//  WHhospitalTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/12/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHhospitalTableViewCell.h"
#import "MacroUtility.h"
@implementation WHhospitalTableViewCell

-(UILabel *)titLaber
{
    if (_titLaber == nil) {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(10, 10, kScreenWitdh * 0.65, 30);
        self.titLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_titLaber];
    }
    return _titLaber;
}

-(UILabel *)addressLaber
{
    if (_addressLaber == nil) {
        self.addressLaber = [[UILabel alloc]init];
        self.addressLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+3, kScreenWitdh * 0.7, 20);
        self.addressLaber.textColor = [UIColor grayColor];
        self.addressLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_addressLaber];
    }
    return _addressLaber;
}

-(UIImageView *)mapImg
{
    if (_mapImg == nil) {
        self.mapImg = [[UIImageView alloc]init];
        self.mapImg.frame = CGRectMake(CGRectGetMinX(self.addressLaber.frame), CGRectGetMaxY(self.addressLaber.frame)+2, 20, 20);
        self.mapImg.image = [UIImage imageNamed:@"maple"];
        [self.contentView addSubview:_mapImg];
    }
    return _mapImg;
}

-(UILabel *)mapLaber
{
    if (_mapLaber ==  nil) {
        self.mapLaber = [[UILabel alloc]init];
        self.mapLaber.frame = CGRectMake(CGRectGetMaxX(self.mapImg.frame)+5, CGRectGetMinY(self.mapImg.frame), kScreenWitdh * 0.20, CGRectGetHeight(self.mapImg.frame));
        self.mapLaber.textColor = [UIColor greenColor];
        self.mapLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_mapLaber];
    }
    return _mapLaber;
}

-(UIImageView *)telImg
{
    if (_telImg == nil) {
        self.telImg =  [[UIImageView alloc]init];
        self.telImg.frame = CGRectMake(CGRectGetMaxX(self.mapLaber.frame)+10, CGRectGetMinY(self.mapImg.frame), CGRectGetWidth(self.mapImg.frame), CGRectGetHeight(self.mapImg.frame));
        self.telImg.image = [UIImage imageNamed:@"tel"];
        [self.contentView addSubview:_telImg];
    }
    return _telImg;
}

-(UILabel *)telLaber
{
    if (_telLaber == nil) {
        self.telLaber = [[UILabel alloc]init];
        self.telLaber.frame = CGRectMake(CGRectGetMaxX(self.telImg.frame)+5, CGRectGetMinY(self.telImg.frame), kScreenWitdh * 0.4, CGRectGetHeight(self.telImg.frame));
        self.telLaber.textColor = [UIColor blueColor];
        self.telLaber.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_telLaber];
    }
    return _telLaber;
}

-(UIButton *)telBut
{
    if (_telBut == nil)
    {
        self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.telBut.frame = CGRectMake(kScreenWitdh * 0.8, (self.bounds.size.height - kScreenWitdh * 0.15)/2, kScreenWitdh * 0.15, kScreenWitdh * 0.15);
        self.telBut.layer.masksToBounds = YES;
        self.telBut.layer.cornerRadius = kScreenWitdh * 0.075;
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
