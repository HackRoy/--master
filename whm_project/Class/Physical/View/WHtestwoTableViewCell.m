//
//  WHtestwoTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/16.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHtestwoTableViewCell.h"

@implementation WHtestwoTableViewCell
-(UILabel *)myLaber
{
    if (_myLaber == nil) {
        self.myLaber = [[UILabel alloc]init];
        self.myLaber.frame = CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds)*0.4, 30) ;
        self.myLaber.textColor = [UIColor grayColor];
        self.myLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_myLaber];
        
        
    }
    return _myLaber;
}

-(UIImageView *)phoImage
{
    if (_phoImage == nil) {
        self.phoImage = [[UIImageView alloc]init];
        self.phoImage.frame = CGRectMake(CGRectGetMaxX(self.myLaber.frame)+10, CGRectGetMinY(self.myLaber.frame), 30, 30);
        //self.phoImage.image = [UIImage imageNamed:@"wenhao"];
        self.phoImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_phoImage];
        
    }
    return _phoImage;
}

-(UILabel *)moneyLaber
{
    if (_moneyLaber == nil) {
        self.moneyLaber = [[UILabel alloc]init];
        self.moneyLaber.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.75, CGRectGetMinY(self.myLaber.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.18, CGRectGetHeight(self.myLaber.frame));
        self.moneyLaber.textColor = [UIColor redColor];
        self.moneyLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_moneyLaber];
    }
    return _moneyLaber;
}


-(UIButton *)myBut
{
    if (_myBut == nil) {
        self.myBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.myBut.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.93,CGRectGetMinY(self.moneyLaber.frame)+2, 20, 20);
        
        [self.contentView addSubview:_myBut];
        
    }
    return _myBut;
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
