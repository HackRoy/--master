//
//  WHslipListTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHslipListTableViewCell.h"
#import "MacroUtility.h"

@implementation WHslipListTableViewCell

-(UIButton *)selectBut
{
    if (_selectBut == nil) {
        self.selectBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.selectBut.frame = CGRectMake(10, 30, 30, 30);
        [self.contentView addSubview:_selectBut];
    
    }
    return _selectBut;
}

-(UILabel *)titLaber
{
    if (_titLaber == nil) {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.selectBut.frame)+5, 10, kScreenWitdh * 0.6, 30);
        self.titLaber.textColor = [UIColor grayColor];
        self.titLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_titLaber];
    }
    return _titLaber;
}

-(UILabel *)baoeLaber
{
    if (_baoeLaber == nil) {
        self.baoeLaber = [[UILabel alloc]init];
        self.baoeLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5 , 40, 20);
        self.baoeLaber.textColor = [UIColor grayColor];
        self.baoeLaber.font = [UIFont systemFontOfSize:13.0];
        self.baoeLaber.text = @"保额:";
        [self.contentView addSubview:_baoeLaber];
    }
    return _baoeLaber ;
}
-(UILabel *)insured
{
    if (_insured == nil) {
        self.insured = [[UILabel alloc]init];
        self.insured.frame = CGRectMake(CGRectGetMaxX(self.baoeLaber.frame)+3, CGRectGetMinY(self.baoeLaber.frame), CGRectGetWidth(self.baoeLaber.frame)*1.4, CGRectGetHeight(self.baoeLaber.frame));
        self.insured.textColor = [UIColor grayColor];
        self.insured.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_insured];
    }
    return _insured;
}

-(UILabel *)baofeiLaber
{
    if (_baofeiLaber == nil) {
        self.baofeiLaber = [[UILabel alloc]init];
        self.baofeiLaber.frame = CGRectMake(CGRectGetMaxX(self.insured.frame)+3, CGRectGetMinY(self.insured.frame), CGRectGetWidth(self.baoeLaber.frame), CGRectGetHeight(self.baoeLaber.frame));
        self.baofeiLaber.textColor = [UIColor grayColor];
        self.baofeiLaber.font = [UIFont systemFontOfSize:13.0];
        self.baofeiLaber.text = @"保费:";
        [self.contentView addSubview:_baofeiLaber];
    }
    return _baofeiLaber;
}

-(UILabel *)rate
{
    if (_rate == nil) {
        self.rate = [[UILabel alloc]init];
        self.rate.frame = CGRectMake(CGRectGetMaxX(self.baofeiLaber.frame)+5, CGRectGetMinY(self.baofeiLaber.frame), CGRectGetWidth(self.insured.frame), CGRectGetHeight(self.baofeiLaber.frame));
        self.rate.textColor = [UIColor grayColor];
        self.rate.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_rate];
    }
    return _rate;
}

-(UILabel *)scoreLaber
{
    if (_scoreLaber  == nil) {
        self.scoreLaber = [[UILabel alloc]init];
        self.scoreLaber.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.8, CGRectGetMaxY(self.titLaber.frame), kScreenWitdh * 0.2, 30);
        self.scoreLaber.textColor = [UIColor redColor];
        self.scoreLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_scoreLaber];
        
    }
    return _scoreLaber;
}

-(UIView *)lineView1
{
    if (_lineView1 == nil) {
        self.lineView1 = [[UIView alloc]init];
        self.lineView1.frame = CGRectMake(0, CGRectGetMaxY(self.baoeLaber.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds), 1);
       // self.lineView1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_lineView1];
    }
    return _lineView1;
}
-(UIImageView *)img1
{
    if (_img1 == nil) {
        self.img1 = [[UIImageView alloc]init];
        self.img1.frame = CGRectMake(10, CGRectGetMaxY(self.baoeLaber.frame)+20, 20, 20);
        
      //  self.img1.image = [UIImage imageNamed:@"del"];
        [self.contentView addSubview:_img1];
        
    }
    return _img1;
}

-(UIButton *)delBut
{
    if (_delBut == nil) {
        self.delBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.delBut.frame = CGRectMake(CGRectGetMaxX(self.img1.frame), CGRectGetMinY(self.img1.frame), kScreenWitdh * 0.15, 20);
        [self.delBut setTintColor:[UIColor grayColor]];
        self.delBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [self.delBut setTitle:@"删除" forState:(UIControlStateNormal)];
        [self.contentView addSubview:_delBut];
    }
    return _delBut;
}

-(UIImageView *)img2
{
    if (_img2 == nil) {
        self.img2 = [[UIImageView alloc]init];
        self.img2.frame = CGRectMake(kScreenWitdh *0.34 , CGRectGetMinY(self.img1.frame), CGRectGetWidth(self.img1.frame), CGRectGetHeight(self.img1.frame));
        self.img2.image = [UIImage imageNamed:@"wanshan"];
        [self.contentView addSubview:_img2];
    }
    return _img2;
    
}
-(UIButton *)pefBut
{
    if (_pefBut == nil) {
        self.pefBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.pefBut.frame = CGRectMake(CGRectGetMaxX(self.img2.frame)+3, CGRectGetMinY(self.img2.frame), CGRectGetWidth(self.delBut.frame)*1.2, CGRectGetHeight(self.delBut.frame));
        [self.pefBut setTintColor:[UIColor grayColor]];
        self.pefBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [self.pefBut setTitle:@"完善保单" forState:(UIControlStateNormal)];
        [self.contentView addSubview:_pefBut];
    }
    return _pefBut;
}

-(UIImageView *)img3
{
    if (_img3 == nil) {
        self.img3 = [[UIImageView alloc]init];
        self.img3.frame = CGRectMake(kScreenWitdh * 0.67, CGRectGetMinY(self.img2.frame), CGRectGetWidth(self.img2.frame), CGRectGetHeight(self.img2.frame));
        self.img3.image = [UIImage imageNamed:@"chakan"];
        [self.contentView addSubview:_img3];
    }
    return _img3;
}

-(UIButton *)lookBut
{
    if (_lookBut == nil) {
        self.lookBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.lookBut.frame = CGRectMake(CGRectGetMaxX(self.img3.frame)+3, CGRectGetMinY(self.img3.frame), CGRectGetWidth(self.delBut.frame)*1.4, CGRectGetHeight(self.delBut.frame));
        [self.lookBut setTintColor:[UIColor grayColor]];
//        [self.lookBut setTitle:@"查看报告" forState:(UIControlStateNormal)];
        [self.contentView addSubview:_lookBut];
    }
    return _lookBut;
}

-(UIView *)lineView2
{
    if (_lineView2 == nil) {
        self.lineView2 = [[UIView alloc]init];
        self.lineView2.frame = CGRectMake(0, CGRectGetMaxY(self.delBut.frame)+8, kScreenWitdh , 1);
        [self.contentView addSubview:_lineView2];
        
    }
    return _lineView2;
}

-(UIView *)line3
{
    if (_line3 == nil) {
        self.line3 = [[UIView alloc]init];
        self.line3.frame = CGRectMake(kScreenWitdh *0.32 , CGRectGetMinY(self.lineView1.frame), 1, 38);
        [self.contentView addSubview:_line3];
    }
    return _line3;
}

-(UIView *)line4
{
    if (_line4 == nil) {
        self.line4 = [[UIView alloc]init];
        self.line4.frame = CGRectMake(kScreenWitdh *0.63 , CGRectGetMinY(self.lineView1.frame), 1, 38);
        [self.contentView addSubview:_line4];
    }
    return _line4;
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
