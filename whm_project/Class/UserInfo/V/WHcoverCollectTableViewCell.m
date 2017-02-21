//
//  WHcoverCollectTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/12/5.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHcoverCollectTableViewCell.h"
#import "MacroUtility.h"
@implementation WHcoverCollectTableViewCell
-(UIImageView *)companyImage
{
    if (_companyImage == nil)
    {
        self.companyImage = [[UIImageView alloc] init];
        self.companyImage.frame = CGRectMake(10, 10, 70, 70);
        
        [self.contentView addSubview:_companyImage];
    }
    return _companyImage;
}

-(UILabel*)titLaber
{
    if (_titLaber == nil)
    {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.companyImage.frame)+10, 10, kScreenWitdh*0.6, 30);
        self.titLaber.font = [UIFont systemFontOfSize:14];
        self.titLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_titLaber];
    }
    return _titLaber;
}

-(UIImageView *)myImg
{
    if (_myImg == nil) {
        self.myImg = [[UIImageView alloc]init];
        self.myImg.frame = CGRectMake(wScreenW - 30-10, CGRectGetMinY(self.titLaber.frame), 30, 30);
        self.myImg.frame = CGRectMake(kScreenWitdh -30, CGRectGetMinY(self.titLaber.frame), 30, 30);
        [self.contentView addSubview:_myImg];
        
    }
    return _myImg;
}
-(UILabel *)ageLaber
{
    if (_ageLaber == nil) {
        self.ageLaber = [[UILabel alloc]init];
        self.ageLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5, 120, 20);
        self.ageLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+3, kScreenWitdh*0.13, 20);
        self.ageLaber.textColor = [UIColor grayColor];
        self.ageLaber.font = [UIFont systemFontOfSize:8.0];
        [self.contentView addSubview:_ageLaber];

    }
    return _ageLaber;
}

//-(UILabel *)ageTitle
//{
//    if (_ageTitle == nil) {
//        self.ageTitle = [[UILabel alloc]init];
//        self.ageTitle.frame = CGRectMake(CGRectGetMaxX(self.ageLaber.frame)+2, CGRectGetMinY(self.ageLaber.frame), CGRectGetWidth(self.ageLaber.frame), CGRectGetHeight(self.ageLaber.frame));
//        self.ageTitle.textColor = [UIColor grayColor];
//        self.ageTitle.font = [UIFont systemFontOfSize:12.0];
//        [self.contentView addSubview:_ageTitle];
//    }
//    return _ageTitle;
//}
-(UILabel *)ageTitle
{
    if (_ageTitle == nil) {
        self.ageTitle = [[UILabel alloc]init];
        self.ageTitle.frame = CGRectMake(CGRectGetMaxX(self.ageLaber.frame), CGRectGetMinY(self.ageLaber.frame), CGRectGetWidth(self.ageLaber.frame), CGRectGetHeight(self.ageLaber.frame));
        self.ageTitle.textColor = [UIColor grayColor];
        self.ageTitle.font = [UIFont systemFontOfSize:8.0];
        [self.contentView addSubview:_ageTitle];
    }
    return _ageTitle;
}

-(UILabel *)styLaber
{
    if (_styLaber == nil) {
        self.styLaber = [[UILabel alloc]init];
        self.styLaber.frame = CGRectMake(wScreenW - 120-20, CGRectGetMinY(self.ageLaber.frame), 120, 20);
        self.styLaber.textColor = [UIColor grayColor];
        self.styLaber.font = [UIFont systemFontOfSize:12.0];
        self.styLaber.textAlignment = 2;
        self.styLaber.font = [UIFont systemFontOfSize:8.0];
        self.styLaber.text = @"产品类型:";
        [self.contentView addSubview:_styLaber];
        
    }
    
    return _styLaber;
}

//-(UILabel *)seyTitle
//{
//    if (_seyTitle == nil)
//    {
//        self.seyTitle = [[UILabel alloc]init];
//        self.seyTitle.frame = CGRectMake(CGRectGetMaxX(self.styLaber.frame)+4, CGRectGetMinY(self.styLaber.frame), CGRectGetWidth(self.styLaber.frame), CGRectGetHeight(self.styLaber.frame));
//        
//        self.seyTitle.textColor = [UIColor grayColor];
//        self.seyTitle.font = [UIFont systemFontOfSize:12.0];
//        [self.contentView addSubview:_seyTitle];
//        
//    }
//    return _seyTitle;
//}
-(UILabel *)seyTitle
{
    if (_seyTitle == nil) {
        self.seyTitle = [[UILabel alloc]init];
        self.seyTitle.frame = CGRectMake(CGRectGetMaxX(self.styLaber.frame)+4, CGRectGetMinY(self.styLaber.frame), CGRectGetWidth(self.styLaber.frame), CGRectGetHeight(self.styLaber.frame));
        self.seyTitle.textColor = [UIColor grayColor];
        self.seyTitle.font = [UIFont systemFontOfSize:8.0];
        [self.contentView addSubview:_seyTitle];
        
    }
    return _seyTitle;
}

-(UILabel *)timeLaber
{
    if (_timeLaber == nil)
    {
        self.timeLaber = [[UILabel alloc]init];
        self.timeLaber.frame = CGRectMake(CGRectGetMinX(self.ageLaber.frame), CGRectGetMaxY(self.ageLaber.frame)+5, kScreenWitdh * 0.5, 20);
        self.timeLaber.font = [UIFont systemFontOfSize:8.0];
        self.timeLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_timeLaber];
        
    }
    return _timeLaber;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
