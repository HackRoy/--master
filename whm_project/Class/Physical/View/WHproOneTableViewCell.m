//
//  WHproOneTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 17/1/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHproOneTableViewCell.h"
#import "MacroUtility.h"
@implementation WHproOneTableViewCell

-(UIImageView *)mainImg
{
    if (_mainImg == nil) {
        self.mainImg = [[UIImageView alloc]init];
        self.mainImg.frame = CGRectMake(10, 10, 30, 30);
        self.mainImg.layer.masksToBounds = YES;
        self.mainImg.layer.cornerRadius = 15;
        [self.contentView addSubview:_mainImg];
    }
    return _mainImg;
}

-(UILabel *)myTit
{
    if (_myTit == nil) {
        self.myTit = [[UILabel alloc]init];
        self.myTit.frame = CGRectMake(CGRectGetMaxX(self.mainImg.frame)+10, 10, kScreenWitdh * 0.6, 30);
        self.myTit.textColor = [UIColor greenColor];
        self.myTit.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_myTit];
    }
    return _myTit;
}

-(UILabel *)baoXian
{
    if (_baoXian == nil) {
        self.baoXian = [[UILabel alloc]init];
        self.baoXian.frame = CGRectMake(20, CGRectGetMaxY(self.mainImg.frame)+10, kScreenWitdh * 0.2, 30);
        self.baoXian.text = @"保险期间";
        self.baoXian.font =[ UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_baoXian];
    }
    return _baoXian;
}
-(UILabel *)baoLaber
{
    if (_baoLaber == nil) {
        self.baoLaber = [[UILabel alloc]init];
        self.baoLaber.frame = CGRectMake(20, CGRectGetMaxY(self.baoXian.frame)+2, CGRectGetWidth(self.baoXian.frame), 50);
        [self.contentView addSubview:_baoLaber];
        self.baoLaber.text = @"终身";
    }
    return _baoLaber;
}

-(UILabel *)jiaofei
{
    if (_jiaofei == nil) {
        self.jiaofei = [[UILabel alloc]init];
        self.jiaofei.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMinY(self.baoXian.frame), CGRectGetWidth(self.baoXian.frame), 30);
        self.jiaofei.text = @"缴费期间";
        self.jiaofei.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_jiaofei];
    }
    return _jiaofei;
}

-(UILabel *)jiaoLaber
{
    if (_jiaoLaber == nil) {
        self.jiaoLaber = [[UILabel alloc]init];
        self.jiaoLaber.frame = CGRectMake(CGRectGetMinX(self.jiaofei.frame), CGRectGetMinY(self.baoLaber.frame), CGRectGetWidth(self.jiaofei.frame), CGRectGetHeight(self.baoLaber.frame));
        self.jiaoLaber.text = @"20年80%";
        [self.contentView addSubview:_jiaoLaber];
    }
    
    return _jiaoLaber;
}

-(UILabel *)beat
{
    if (_beat == nil) {
        self.beat = [[UILabel alloc]init];
        self.beat.frame = CGRectMake(CGRectGetMinX(self.baoLaber.frame), CGRectGetMaxY(self.baoLaber.frame)+20, CGRectGetWidth(self.baoLaber.frame), CGRectGetHeight(self.baoLaber.frame));
        self.beat.text = @"年交保费";
        self.beat.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_beat];
    }
    return _beat;
}

-(UILabel *)beatLaber
{
    if (_beatLaber == nil) {
        self.beatLaber = [[UILabel alloc]init];
        self.beatLaber.frame = CGRectMake(CGRectGetMinX(self.beat.frame), CGRectGetMaxY(self.beat.frame)+2, CGRectGetWidth(self.beat.frame), CGRectGetHeight(self.baoLaber.frame));
        self.beatLaber.text = @"5260";
        [self.contentView addSubview:_beatLaber];
    }
    return _beatLaber;
}

-(UILabel *)baoe
{
    if (_baoe == nil) {
        self.baoe = [[UILabel alloc]init];
        self.baoe.frame = CGRectMake(CGRectGetMinX(self.jiaofei.frame), CGRectGetMinY(self.beat.frame), CGRectGetWidth(self.beat.frame), CGRectGetHeight(self.beat.frame));
        self.baoe.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_baoe];
    }
    return _baoe;
}

-(UILabel*)baoeLaber
{
    if (_baoeLaber == nil) {
        self.baoeLaber = [[UILabel alloc]init];
        self.baoeLaber.frame = CGRectMake(CGRectGetMinX(self.baoe.frame), CGRectGetMinY(self.beatLaber.frame), CGRectGetWidth(self.baoe.frame), CGRectGetHeight(self.beatLaber.frame));
        self.baoeLaber.text = @"5260";
        [self.contentView addSubview:_baoeLaber];
    }
    return _baoeLaber;
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
