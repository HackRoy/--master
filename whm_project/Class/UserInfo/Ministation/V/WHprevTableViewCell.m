//
//  WHprevTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/2.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHprevTableViewCell.h"
#import "MacroUtility.h"
#import <UIImageView+WebCache.h>

@implementation WHprevTableViewCell

-(UIImageView *)myImage
{
    if (_myImage == nil) {
        self.myImage = [[UIImageView alloc]init];
        self.myImage.frame = CGRectMake(10, 10,kScreenWitdh * 0.3 , kScreenWitdh * 0.3);
        [self.contentView addSubview:_myImage];
    }
    return _myImage;
}
-(UILabel *)titLaber
{
    if (_titLaber == nil) {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.myImage.frame)+10, CGRectGetMinY(self.myImage.frame)+ 10, kScreenWitdh * 0.5, 30);
        self.titLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_titLaber];
    }
    return _titLaber;
}
-(UILabel *)ageTit
{
    if (_ageTit == nil) {
        self.ageTit =[[ UILabel alloc]init];
        self.ageTit.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5, kScreenWitdh * 0.2, 20);
        self.ageTit.font = [UIFont systemFontOfSize:13.0];
        self.ageTit.textColor = [UIColor grayColor];
        self.ageTit.text = @"投保年龄:";
        [self.contentView addSubview:_ageTit];
    }
    return _ageTit;
}
-(UILabel *)ageLaber
{
    if (_ageLaber == nil) {
        self.ageLaber = [[UILabel alloc]init];
        self.ageLaber.frame = CGRectMake(CGRectGetMaxX(self.ageTit.frame)+3, CGRectGetMinY(self.ageTit.frame), CGRectGetWidth(self.ageTit.frame), CGRectGetHeight(self.ageTit.frame));
        self.ageLaber.font = [UIFont systemFontOfSize:13.0];
        self.ageLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_ageLaber];
    }
    return _ageLaber;
}
-(UILabel *)styTit
{
    if (_styTit == nil) {
        self.styTit =[[UILabel alloc]init];
        self.styTit.frame = CGRectMake(CGRectGetMinX(self.ageTit.frame), CGRectGetMaxY(self.ageTit.frame)+5, CGRectGetWidth(self.ageTit.frame), CGRectGetHeight(self.ageTit.frame));
        self.styTit.textColor = [UIColor grayColor];
        self.styTit.font = [UIFont systemFontOfSize:13.0];
        self.styTit.text = @"产品类型:";
        [self.contentView addSubview:_styTit];
    }
    return _styTit;
}

-(UILabel *)styLaber
{
    if (_styLaber == nil) {
        self.styLaber = [[UILabel alloc]init];
        self.styLaber.frame = CGRectMake(CGRectGetMinX(self.ageLaber.frame), CGRectGetMinY(self.styTit.frame), CGRectGetWidth(self.ageLaber.frame), CGRectGetHeight(self.ageLaber.frame));
        self.styLaber.textColor = [UIColor grayColor];
        self.styLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_styLaber];
    }
    return _styLaber;
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
