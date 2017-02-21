//
//  WHnearAgentTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHnearAgentTableViewCell.h"
#import "MacroUtility.h"
#import <UIImageView+WebCache.h>


@implementation WHnearAgentTableViewCell

-(UIButton *)myImage
{
    if (_myImage == nil)
    {
        self.myImage = [[UIButton alloc]init];
        self.myImage.frame = CGRectMake(10,10,kScreenWitdh * 0.20 , kScreenWitdh * 0.20);
        self.myImage.layer.masksToBounds = YES;
        self.myImage.layer.cornerRadius = kScreenWitdh * 0.10;
        
        [self.contentView addSubview:_myImage];
        
    }
    return _myImage;
}

-(UILabel *)nameLaber
{
    if (_nameLaber == nil)
    {
        self.nameLaber = [[UILabel alloc]init];
        self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.myImage.frame)+10, 10, kScreenWitdh *0.15, 30);
        self.nameLaber.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_nameLaber];
    }
    return _nameLaber;
}

-(UIImageView * )sexImg
{
    if (_sexImg == nil) {
        self.sexImg = [[UIImageView alloc]init];
        self.sexImg.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+2, CGRectGetMinY(self.nameLaber.frame)+6, 20, 20);
        [self.contentView addSubview:_sexImg];
    }
    return _sexImg;
}


-(UILabel *)companyLaber
{
    if (_companyLaber == nil) {
        self.companyLaber = [[UILabel alloc]init];
        self.companyLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImg.frame)+5, CGRectGetMinY(self.sexImg.frame), kScreenWitdh * 0.25, 20);
        self.companyLaber.textColor = [UIColor grayColor];
        self.companyLaber.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_companyLaber];
    }
    return _companyLaber;
}


-(UIImageView *)mapImg
{
    if (_mapImg == nil) {
        self.mapImg = [[UIImageView alloc]init];
        self.mapImg.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame)+2, 20, 20);
        self.mapImg.image = [UIImage imageNamed:@"maple"];
        [self.contentView addSubview:_mapImg];

    }
    return _mapImg;
}
-(UILabel *)mapLaber
{
    if (_mapLaber == nil) {
        self.mapLaber = [[UILabel alloc]init];
        self.mapLaber.frame = CGRectMake(CGRectGetMaxX(self.mapImg.frame)+5, CGRectGetMinY(self.mapImg.frame), kScreenWitdh * 0.15+10, CGRectGetHeight(self.mapImg.frame));
        self.mapLaber.textColor = [UIColor greenColor];
        self.mapLaber.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:_mapLaber];
    }
    return _mapLaber;
}

-(UIImageView *)telImg
{
    if (_telImg == nil) {
        self.telImg =  [[UIImageView alloc]init];
        self.telImg.frame = CGRectMake(CGRectGetMaxX(self.mapLaber.frame)+3, CGRectGetMinY(self.mapImg.frame), CGRectGetWidth(self.mapImg.frame), CGRectGetHeight(self.mapImg.frame));
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
        self.telLaber.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:_telLaber];
    }
    return _telLaber;
}

-(UILabel *)addressLaber
{
    if (_addressLaber == nil) {
        self.addressLaber = [[UILabel alloc]init];
        self.addressLaber.frame = CGRectMake(CGRectGetMinX(self.mapImg.frame), CGRectGetMaxY(self.mapImg.frame)+5, kScreenWitdh * 0.7, 20);
        self.addressLaber.textColor = [UIColor grayColor];
        self.addressLaber.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:_addressLaber];

    }
    return _addressLaber;
}

-(UIButton *)telBut
{
    if (_telBut == nil) {
        self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.telBut.frame = CGRectMake(kScreenWitdh * 0.85, CGRectGetMidY(self.nameLaber.frame), 40, 40);
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
